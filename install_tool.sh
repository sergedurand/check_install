#!/bin/bash
curl micro.mamba.pm/install.sh | bash
source "${HOME}/conda/etc/profile.d/conda.sh"
source "${HOME}/conda/etc/profile.d/mamba.sh"
micromamba activate
source ~/.bashrc
micromamba create -f pyrat_env.yml
micromamba activate temp_pyrat
python --version
python pyrat.pyc -h
export PYTHONPATH=$PYTHONPATH:$PWD