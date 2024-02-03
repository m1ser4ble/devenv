FROM ubuntu:24.04
#RUN echo 'APT::Install-Suggests "0";' >> /etc/apt/apt.conf.d/00-docker
#RUN echo 'APT::Install-Recommends "0";' >> /etc/apt/apt.conf.d/00-docker
#RUN DEBIAN_FRONTEND=noninteractive \
#  apt-get update \
#  && apt-get install -y python3 \
#  && rm -rf /var/lib/apt/lists/*
#RUN useradd -ms /bin/bash apprunner
#USER apprunner


RUN apt-get update && apt-get install -y git fish curl vim gdb binutils g++
RUN git clone https://github.com/m1ser4ble/devenv.git

RUN chsh -s /usr/bin/fish
#RUN curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
RUN curl -L https://get.oh-my.fish > install_omf
RUN fish install_omf --noninteractive
RUN fish -c "omf install ays"

RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
   	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

RUN mv devenv/* ~


