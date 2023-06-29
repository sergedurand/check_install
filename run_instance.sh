#!/bin/bash
curl micro.mamba.pm/install.sh | bash
# Linux/bash:
/root/.local/bin/micromamba shell init -s bash -p ~/micromamba  # this writes to your .bashrc file
# sourcing the bashrc file incorporates the changes into the running session.
# better yet, restart your terminal!
source ~/.bashrc
micromamba create -f pyrat_env.yml -n temp_pyrat -y
micromamba activate temp_pyrat
python --version
python pyrat.pyc -h
export PYTHONPATH=$PYTHONPATH:$PWD