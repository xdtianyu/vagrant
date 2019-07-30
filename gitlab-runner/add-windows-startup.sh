#!/bin/bash

set -x

DIR=$(pwd -W)

echo """
@echo off

echo "Starting GitLab Runner ..."

cd /D "$DIR"

vagrant up --provision

::pause
""" > gitlab-runner.bat

mv gitlab-runner.bat "$HOME/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/StartUp"
