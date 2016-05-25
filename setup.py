from distutils.core import setup
from distutils.command.install import install
import json
import os.path
import sys

kernel_json = {"argv":[sys.executable,"-m", "openmodelica_kernel", "-f", "{connection_file}"],
 "display_name": "OpenModelica",
 "language": "OpenModelica"
}

class install_with_kernelspec(install):
	def run(self):
            #Regular installation
            install.run(self)

            #Now write the kernelspec
            try:
               from jupyter_client.kernelspec import KernelSpecManager
            except ImportError:
               from IPython.kernel.kernelspec import KernelSpecManager		
            
            #from IPython.kernel.kernelspec import KernelSpecManager
            from IPython.utils.path import ensure_dir_exists
            destdir = os.path.join(KernelSpecManager().user_kernel_dir, "OpenModelica")
            ensure_dir_exists(destdir)
            with open(os.path.join(destdir, 'kernel.json'), 'w') as f:
                json.dump(kernel_json, f, sort_keys=True)
		

svem_flag = '--single-version-externally-managed'
if svem_flag in sys.argv:
	# Die, setuptools, die.
	sys.argv.remove(svem_flag)

setup(name = "openmodelica_kernel",
	  version = "1.0",
	  description= "A OpenModelica wrapper Kernel for jupyter notebook",
	  author='ArunKumar Palanisamy',
	  author_email='arunkumar.palanisamy@liu,se',
	  packages=["openmodelica_kernel"],
      package_data={'openmodelica_kernel' : ['dygraph-combined.js']},
	  cmdclass={'install': install_with_kernelspec},
)