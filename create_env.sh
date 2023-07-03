#!/bin/bash
micromamba create -f pyrat_env.yml -y -vv
micromamba activate temp_pyrat
python --version
python pyrat.pyc -h
export PYTHONPATH=$PYTHONPATH:$PWD