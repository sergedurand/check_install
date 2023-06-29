#!/bin/bash
curl micro.mamba.pm/install.sh | bash
# Linux/bash:
./bin/micromamba shell init -s bash -p ~/micromamba  # this writes to your .bashrc file
# sourcing the bashrc file incorporates the changes into the running session.
# better yet, restart your terminal!
source ~/.bashrc
micromamba activate  # this activates the base environment
micromamba install python=3.10
python --version
