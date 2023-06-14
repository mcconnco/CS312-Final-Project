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
`Minecraft`: https://www.minecraft.net/en-us/download <br>

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
Alright, if you've updated your credentials correctly you are now ready to run the program. If you have experience with EC2 instances you may be wondering "What about our key pair? We need to have a key pair in order to ssh into our server". We're gonna stop you right there and remind you of the second file you downloaded: `key-pair-main.tf`. This file does the incredible task of creating a key pair for us when we run our program and linking it to the EC2 instance through `main.tf`. <br>

With that potential issue out of the way, we're gonna jump straight into how you're going to run our program. It's incredibly simple so don't worry too much. We took the extra time to ensure that you only have to run a single line of code in order to make this program work. That single line of code is: <br>

```
bash build.sh
```
<br>

Our build.sh contains 3 lines of code that run and only 2 that are actually important. Those 2 lines are ``terraform init -upgrade`` & ``terraform apply -auto-approve``. These 2 lines create what our terraform needs to run, and then auto runs it so you have to click nothing. Now, we have included an output in our terraform so that when it finishes, it will tell you the public ip address of the instance. Write this down somewhere as it is incredibly important in the next section. <br>

Once the build.sh script is done running, you need to wait a couple of minutes. This is the most prominant downside to the approach we are using. As the User Data is running on the server, it gives no indications of it's run status. So, we ask that you wait for about 3-5 minutes before proceeding to the next step which is verifying that the server is up and running. <br>

Alright, 5 minutes has passed and we're ready to confirm that the server is running. I (the creator of this repo) already know that it worked but you definitely want to see it for yourself. In order to check the servers status from your terminal you will run this line: <br>

```
nmap -sV -Pn -p T:25565 <instance_public_ip>

```
<br>

You remember that public IP I told you to write down? That is what you include in the nmap command. Your command response will look like this on a success:

![image](https://github.com/mcconnco/CS312-Final-Project/assets/46498418/c30162c6-9899-417c-a263-c5f6c703cf8a)

## How to Connect
Alrighty! You've got the server up and running now so now you want to launch a game of Minecraft, create a new world, and connect to the public IP address that you wrote down.

I hope that this program was useful to you and that you have a great rest of your day!
Thank you for reading!
