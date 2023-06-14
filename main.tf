# Provider - AWS?
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.22"
    }
  }
}

provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["~/.aws/credentials"]
}

variable "mojang_server_url" {
  type    = string
  default = "https://launcher.mojang.com/v1/objects/e00c4052dac1d59a1188b2aa9d5a87113aaf1122/server.jar"
}

# Security
resource "aws_security_group" "minecraft" {
  ingress {
    description = "Minecraft port"
    from_port   = 25565
    to_port     = 25565
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "default port"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Send Anywhere"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Minecraft Security Group"
  }
}

# EC2 Instance
resource "aws_instance" "minecraft" {
  ami                         = "ami-09988af04120b3591"
  instance_type               = "t2.medium"
  vpc_security_group_ids      = [aws_security_group.minecraft.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.key_pair.key_name
  root_block_device {
    volume_size = 30
  }

  tags = {
    Name = "Minecraft Server"
  }

  user_data = <<EOT
#!/bin/bash
sudo yum -y update;
sudo rpm --import https://yum.corretto.aws/corretto.key;
sudo curl -L -o /etc/yum.repos.d/corretto.repo https://yum.corretto.aws/corretto.repo;
sudo yum install -y java-17-amazon-corretto-devel.x86_64;
sudo mkdir /usr/local/minecraft/;
sudo wget -O /usr/local/minecraft/server.jar https://launcher.mojang.com/v1/objects/e00c4052dac1d59a1188b2aa9d5a87113aaf1122/server.jar;
sudo chown ec2-user /usr/local/minecraft/;
cd /usr/local/minecraft/;
echo "eula=true" > eula.txt;
java -Xmx1024M -Xms1024M -jar server.jar nogui;

EOT

}

output "instance_ip_addr" {
  value = aws_instance.minecraft.public_ip
}
output "instance_public_dns" {
  value = aws_instance.minecraft.public_dns
}
