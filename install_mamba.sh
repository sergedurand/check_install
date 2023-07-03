#!/bin/bash
wget micro.mamba.pm/install.sh
yes | bash install.sh
#echo $MAMBA_ROOT_PREFIX
#echo $MAMBA_EXE
#source "${HOME}/conda/etc/profile.d/conda.sh"
#source "${HOME}/conda/etc/profile.d/mamba.sh"
source ${HOME}/.bashrc
