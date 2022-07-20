################################################
# The default region that has to be used  - Default region is Mumbai
# Add description as well
################################################

variable "aws_region" {
    type = string 
    default = "ap-south-1" 
}

variable "availability_zone" {
  type = string
  default = "ap-south-1b"
}

################################################
# App tags for consistence resource tagging
################################################
variable "tag_app_name" {
    type = string
    default = "REASinataraApp"
}

variable "tag_app_iac_version" {
    type = string
    default = "v1.0"
}

variable "tag_app_platform" {
    type = string
    default = "ruby"
}

variable "tag_app_environment" {
    type = string
    default = "staging"
}


################################################
# Resource specific variables
################################################

################################################
# The CIDR block for VPC 
################################################

variable "vpc_cidr_block" {
  type = string
  default = "172.32.0.0/16"
}


variable "subnet_cidr_block" {
  type = string
  default = "172.32.1.0/28"
}


variable "rt_cidr_block_ipv4" {
  type = string
  # Let us route all traffic
  default = "0.0.0.0/0"
}

variable "rt_cidr_block_ipv6" {
  type = string
  # Let us route all traffic
  default = "::/0"
}


################################################
# Traffic filtering
################################################

# Which clients should be able to access usign ssh
variable "ssh_client_cidr" {
    type = list(string)
    default = ["0.0.0.0/0"]
  
}

# Which clients should be able to access usign https
variable "https_client_cidr" {
    type = list(string)
    default = ["0.0.0.0/0"]
  
}

# Which clients should be able to access usign http
variable "http_client_cidr" {
    type = list(string)
    default = ["0.0.0.0/0"]
  
}

################################################
# Type of EC2 Instance to be used -  use t2.micro - Just to use the free tier
################################################
variable "ec2_instance_type" {
    type = string 
    default = "t2.micro" 
}

variable "ami" {
    type = string
    default = "ami-006d3995d3a6b963b"
  
}

# To do  - list
variable "ec2_private_ip" {
    type = list(string)
    default = ["172.32.1.5"]
  
}

# To do - fix the key 
variable "ssh_key" {
    type = string
    default = "main"
}
