#!/usr/bin/bash

###########################################
# Author: @2bitsend0xdea
# Date: 15 JUN 2021
# Usage: sudo ./volatility_install.sh
# Req: Written for Ubuntu Linux
############################################

install_volatility () {

  sudo add-apt-repository universe
  sudo apt update

  sudo apt install pcregrep libpcre++-dev python2-dev python-setuptools build-essential yara zip git -y

  echo "Time to install PIP for Python2"
  curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py

  sudo python2 get-pip.py
  sudo rm -f get-pip.py

  echo "Clone the volatility repo"
  git clone https://github.com/volatilityfoundation/volatility.git

  echo "Installing pip packages required for volatility"

  sudo python2 -m pip install distorm3==3.4.4 pycrypto pytz yara openpyxl ujson

  # This is VERY important, volatility will BREAK under Ubuntu 19 or greater
  sudo ln -s /usr/local/lib/python2.7/dist-packages/usr/lib/libyara.so /usr/lib/libyara.so

  echo "Volatility pre-req's have been met, time to install volatility (/usr/loca/bin)"

  cd volatility
  sudo python2.7 setup.py install
  
  sudo rm -rf ../volatility

  echo "Thank you for playing 'Install Volatility for 1000', lets rip some memory apart!"
}


main () {

  echo -e "Lets install some volatility and forensicate!"

  if [ $(egrep '^(NAME)=' /etc/os-release | cut -d '=' -f2 | xargs) == "Ubuntu" ]; then
     echo "We're on Ubuntu, lets install volatility!"
     install_volatility
  else
     echo "We're on something else and I'm not about that life!"
  fi

}

# Call main() to run the script!
main
