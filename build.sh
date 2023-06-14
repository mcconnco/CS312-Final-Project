#! /bin/bash

echo beginning Minecraft server build

terraform init
terraform plan
terraform apply
