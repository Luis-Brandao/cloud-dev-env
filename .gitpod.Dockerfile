FROM gitpod/workspace-base

# Install deps and update
RUN sudo apt install ca-certificates
RUN sudo apt-get -y update
RUN sudo apt-get -y install software-properties-common
RUN sudo apt-get -y update && export DEBIAN_FRONTEND=noninteractive

# Install Terraform
ARG TERRAFORM_VERSION=1.1.4
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
RUN sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
RUN sudo apt install terraform=${TERRAFORM_VERSION}

#Enable bash automcomplete for terraform
RUN touch ~/.bashrc
RUN terraform -install-autocomplete

# Install azure CLI
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

#Install azure functions core tools
RUN sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-$(lsb_release -cs)-prod $(lsb_release -cs) main" > /etc/apt/sources.list.d/dotnetdev.list'
RUN sudo apt-get update
RUN sudo apt-get install azure-functions-core-tools-4

RUN sudo apt update
RUN sudo apt install python3-pip -y
RUN pip install pre-commit

RUN git config --global credential.httpusepath true

# Install go
RUN sudo add-apt-repository ppa:longsleep/golang-backports
RUN sudo apt update
RUN sudo apt install golang-1.17 -y
RUN export PATH=$PATH:/usr/lib/go-1.17/bin/
