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

## Diagram

![image](https://github.com/mcconnco/CS312-Final-Project/assets/46498418/31d62f32-eb02-4763-ba4f-d63b91a2a7ba)
<br>
In the diagram above, we start with our User Data, which is found in `user_data.sh`, and our minecraft service file, `minecraft.service`. These files are specified in out GitHub repo and are visibly separate of our `main.tf` and our `build.sh`. These files contain all of the information that our server is going to need in order to launch and restart after a crash. These files are then passed into our `main.tf` file, which is our Terraform file. This happens when we run our Terraform file which we will get into in our `Execution` section. The Terraform file then sends the User Data and minecraft service file to the EC2 server which then uses the data to create a minecraft server. 

## Execution

## How to Connect
