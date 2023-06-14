# CS312-Final-Project

## Background
This repo is a quick way to create a minecraft server. The program is almost entirely automated except for a couple of steps that you need to do yourself. We will walk you through how to do these steps however so no need to fret. We are accomplishing this task through the utilization of the following resources:

* Terraform CLI
* AWS EC2
* Bash
* AWS CLI
* GitHub (This should be obvious)

We will get into the details of how we utilize each of these down in the `Execution` section

## Requirements
Before you can utilize this repo properly, you need to ensure that you have Terraform CLI, AWS CLI, & nmap installed. You can install all of them from the links below: <br>

`Terraform CLI`: https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli <br>
`AWS CLI`: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html <br>
`NMAP`: https://nmap.org/download <br>
<br>

In addition, you will need an AWS account so that we can build our EC2 instance. <br>

## Diagram

![image](https://github.com/mcconnco/CS312-Final-Project/assets/46498418/31d62f32-eb02-4763-ba4f-d63b91a2a7ba)
<br>
In the diagram above, we start with our User Data, which is found in `user_data.sh`, and our minecraft service file, `minecraft.service`. These files are specified in out GitHub repo and are visibly separate of our `main.tf` and our `build.sh`. These files contain all of the information that our server is going to need in order to launch and restart after a crash. These files are then passed into our `main.tf` file, which is our Terraform file. This happens when we run our Terraform file which we will get into in our `Execution` section. The Terraform file then sends the User Data and minecraft service file to the EC2 server which then uses the data to create a minecraft server. 

## Execution
Alright, now we get to what I assume you're here for. How to run this. If this isn't what you're here for, then I'm a bit confused but I hope you enjoy learning how to use this none the less. <br>

First, ensure that you have properly installed all of the dependencies listed above. If you don't have all of them installed, you're gonna have a bad time. Once you have installed all of the dependencies and created your AWS account, we can get started. You will want to start by taking the `main.tf`, `key-pair-main.tf`, `user_data.sh`, and `build.sh` files from this repo and downloading them to your machine. You do NOT need to download the `minecraft.service` file. Once you have those files downloaded and in the same directory, you will need to update your AWS credentials on your `~/.aws/credentials` path. You can do this by finding your AWS Details within your AWS account and then running ```vim ~/.aws/credentials``` on your terminal. Copy the `aws_access_key_id`, `aws_secret_access_key`, & `aws_session_token` into your credentials file on your terminal so that they look similar to this: <br>
```
[default]
aws_access_key_id= *access key*
aws_secret_access_key= *secret access key*
aws_session_token= *session token*
```


## How to Connect
