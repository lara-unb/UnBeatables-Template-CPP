#!/bin/bash

sudo apt update

# ----------------------------------------------
#
# CRIAÇÃO DO AMBIENTE
#
# ----------------------------------------------

cd ~/
mkdir UnBeatables

# ----------------------------------------------
#
# INSTALAÇÃO DO NAOqi PYTHON
#
# ----------------------------------------------

if ! command -v curl &>/dev/null; then
  echo "Instalando curl..."
  sudo apt update && sudo apt install -y curl
fi
echo "Curl instalado com sucesso: $(curl --version | awk '{print $2; exit}')"

if ! command -v python3 &>/dev/null; then
  echo "Instalando Python3..."
  sudo apt install -y python3 python3-pip
fi
echo "Python3 instalado com sucesso: $(python3 --version)"

if ! command -v git &>/dev/null; then
  echo "Instalando Git..."
  sudo apt install -y git
fi
echo "Git instalado com sucesso: $(git --version)"


if ! command -v node &>/dev/null; then
  echo "Instalando Node..."
  sudo apt install -y nodejs
fi
echo "Node instalado com sucesso: $(node --version)"

if ! command -v pyenv &>/dev/null; then
  echo "Instalando e configurando pyenv..."
  sudo apt update && sudo apt install -y \
        make build-essential libssl-dev zlib1g-dev \
        libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
        libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
  curl https://pyenv.run | bash
  # shellcheck disable=SC2016
  # shellcheck disable=SC2129
  echo 'PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
  # shellcheck disable=SC2016
  echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
  # shellcheck disable=SC2016
  echo 'eval "$(pyenv init --path)"' >> ~/.bashrc
  # shellcheck disable=SC2016
  echo 'eval "$(pyenv init -)"' >> ~/.bashrc
  # shellcheck disable=SC2016
  echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc
  # shellcheck disable=SC1090
  source ~/.bashrc

  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi
echo "Pyenv instalado com sucesso: $(pyenv --version)"

if ! pyenv versions | grep -q "2.7.18"; then
  echo "Instalando Python 2.7.18..."
  pyenv install 2.7.18
fi
echo "Versões do Python disponíveis: $(pyenv versions)"

if ! pyenv virtualenvs | grep -q "UnBeatables"; then
  echo "Criando virtualenv 'UnBeatables'..."
  pyenv virtualenv 2.7.18 UnBeatables

  # shellcheck disable=SC1090
  source ~/.bashrc
fi
echo "Ambientes virtuais disponíveis: $(pyenv virtualenvs)"

# shellcheck disable=SC2164
cd UnBeatables
if [ ! -d "$HOME/UnBeatables/pynaoqi-python2.7-2.8.6.23-linux64-20191127_152327" ]; then
  echo "Instalando e extraindo NAOqi Python..."
  wget "https://community-static.aldebaran.com/resources/2.8.6/pynaoqi-python2.7-2.8.6.23-linux64-20191127_152327.tar.gz"
  tar -xvzf pynaoqi-python2.7-2.8.6.23-linux64-20191127_152327.tar.gz
  rm -rf pynaoqi-python2.7-2.8.6.23-linux64-20191127_152327.tar.gz
  # shellcheck disable=SC2016
  echo 'export PYTHONPATH=${PYTHONPATH}:$HOME/UnBeatables/pynaoqi-python2.7-2.8.6.23-linux64-20191127_152327/lib/python2.7/site-packages' >> ~/.bashrc
  echo 'alias naopy="PYENV_VERSION=UnBeatables python -u"' >> ~/.bashrc
  # shellcheck disable=SC1090
  source ~/.bashrc
fi

# ----------------------------------------------
#
# INSTALAÇÃO DO NAOqi C++
#
# ----------------------------------------------

sudo apt-get install build-essential

if ! command -v cmake &>/dev/null; then
  echo "Instalando cmake..."
  sudo apt-get install -y cmake
fi
echo "Cmake instalado com sucesso: $(cmake --version)"

if [ ! -d "$HOME/UnBeatables/naoqi-sdk-2.8.5.10-linux64" ]; then
  echo "Instalando e extraindo NAOqi C++..."
  wget "https://community-static.aldebaran.com/resources/2.8.5/naoqi-sdk-2.8.5.10-linux64.tar.gz"
  tar -xvzf naoqi-sdk-2.8.5.10-linux64.tar.gz
  rm -rf naoqi-sdk-2.8.5.10-linux64.tar.gz
fi

# ----------------------------------------------
#
# INSTALAÇÃO DO CHOREGRAPHE
#
# ----------------------------------------------

if [ ! -d "$HOME/UnBeatables/choregraphe-2.8.8-ubuntu2204" ]; then
  echo "Baixando e extraindo Choregraphe..."
  wget "https://community-static.aldebaran.com/resources/2.8.8/choregraphe-2.8.8-ubuntu2204-standalone.tar.gz"
  tar -xvzf choregraphe-2.8.8-ubuntu2204-standalone.tar.gz
  rm -rf choregraphe-2.8.8-ubuntu2204-standalone.tar.gz
fi

# ----------------------------------------------
#
# INSTALAÇÃO JETBRAINS TOOLBOX
#
# ----------------------------------------------

if [ ! -d "$HOME/UnBeatables/jetbrains-toolbox-2.6.3.43718" ]; then
  echo "Baixando e extraindo Choregraphe..."
  wget "https://download-cdn.jetbrains.com/toolbox/jetbrains-toolbox-2.6.3.43718.tar.gz"
  tar -xvzf jetbrains-toolbox-2.6.3.43718.tar.gz
  rm -rf jetbrains-toolbox-2.6.3.43718.tar.gz
fi

# ----------------------------------------------
#
# CLONAGEM DO TEMPLATE CPP
#
# ----------------------------------------------

if [ ! -d "$HOME/UnBeatables/UnBeatables-Template-CPP" ]; then
  git clone https://github.com/lara-unb/UnBeatables-Template-CPP.git
fi
