# Jupyter_OpenModelica_Kernel
An OpenModelica Kernel for Jupyter Notebook. All commands are interpreted by OMPython which communicates with OpenModelica
Compiler and the result is presented to user.

This requires [Jupyter Notebook](https://jupyter.readthedocs.org/en/latest/install.html), [OpenModelica] (https://openmodelica.org), and [OMPython](https://github.com/OpenModelica/OMPython)<br>
Make sure the environment variable for OpenModelica is set eg: OPENMODELICAHOME=C:/OpenModelica1.9.4-dev/  

To install:

     1) clone the project
     2) cd Jupyter_OpenModelica_Kernel
     3) python setup.py install

To use it, run:

      jupyter notebook
      # In the notebook interface, select OpenModelica from the 'New' menu

A note about plotting. The plotting is done with the help of Dygraph javascript. If plot does not works, make sure 
the "dygraph-combined.js" is in the current working directory.
