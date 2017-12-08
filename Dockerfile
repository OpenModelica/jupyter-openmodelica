FROM ubuntu:14.04
RUN apt-get update

RUN apt-get install -y wget
RUN for deb in deb deb-src; do echo "$deb http://build.openmodelica.org/apt `lsb_release -cs` stable"; done | sudo tee /etc/apt/sources.list.d/openmodelica.list
RUN wget -q http://build.openmodelica.org/apt/openmodelica.asc -O- | sudo apt-key add - 

# Update index (again)
RUN apt-get update

# Install minimal OpenModelica Components
RUN apt-get install -y omc omlib-modelica-3.2.2

# Install Python components
RUN apt-get install -y python-pip python-dev build-essential 
RUN apt-get install -y git

# Install Jupyter notebook, always upgrade pip
RUN pip install --upgrade pip
RUN pip install jupyter

# Install OMPython and jupyter-openmodelica kernel
RUN pip install -U git+git://github.com/OpenModelica/OMPython.git
RUN pip install -U git+git://github.com/OpenModelica/jupyter-openmodelica.git

# Create a user profile "openmodelicausers" inside the docker container as we should run the docker container as non-root users
RUN useradd -m -s /bin/bash openmodelicausers

# Copy the kernel from root location to non root location so that jupyter notebook when started as non-root can find openmodelica kernel
RUN cp -R /root/.local/share/jupyter/kernels/OpenModelica /usr/local/share/jupyter/kernels/

# Change the container to non-root "openmodelicauser" and set the env 
USER openmodelicausers
ENV HOME /home/openmodelicausers
ENV USER openmodelicausers
WORKDIR $HOME


EXPOSE 8888

CMD ["jupyter", "notebook", "--port=8888", "--ip=0.0.0.0", "--allow-root"]




