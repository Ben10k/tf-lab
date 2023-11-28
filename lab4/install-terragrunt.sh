#!/bin/bash

mkdir -p ~/.local/bin

wget -O ~/.local/bin/terragrunt \
 https://github.com/gruntwork-io/terragrunt/releases/download/v0.53.8/terragrunt_linux_amd64


chmod +x ~/.local/bin/terragrunt