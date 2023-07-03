#!/bin/bash
curl micro.mamba.pm/install.sh | bash
source "${HOME}/conda/etc/profile.d/conda.sh"
source "${HOME}/conda/etc/profile.d/mamba.sh"
micromamba activate
source ~/.bashrc
micromamba create -f pyrat_env.yml
micromamba activate temp_pyrat
python --version
python3 --version
python310 --version
python pyrat.pyc -h
python3 pyrat.pyc -h
python310 pyrat.pyc -h
export PYTHONPATH=$PYTHONPATH:$PWD