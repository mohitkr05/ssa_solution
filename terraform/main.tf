
##############################################
### Resources that are need to be created ####
##############################################
# 1. VPC
# 2. Internet Gateway
# 3. Route table (Lock all the resources)
# 4. Subnet
# 5. Associate subnet with RT
# 6. Security group - allow 22/tcp (ssh) & 80/tcp (http) (not 443 as it is not required)
# 7. Network interface
# 8. Create ubuntu server with git installed
# 9. Download the code from github 
# 10. Configure the ubuntu server to work with it 
# 11. Perform the security verification 
# 12. Patch any vulnerabilities
# 13. Set up monitoring 


# Let us roll  :)

###############################################################################
## VPC  ## First we are going to create a VPC with a CIDR block 10.10.0.0/16
###############################################################################

resource "aws_vpc" "rea" {
  cidr_block = var.vpc_cidr_block
  enable_dns_hostnames = true
  tags = {
    appName = var.tag_app_name
    iacVersion = var.tag_app_iac_version
    appPlatform = var.tag_app_platform
    appEnvironment = var.tag_app_environment
  }
}

###############################################################################
## Internet gateway - Simple definition for internet gateway
###############################################################################

resource "aws_internet_gateway" "reagw" {
  vpc_id = aws_vpc.rea.id

  tags = {
    appName = var.tag_app_name
    iacVersion = var.tag_app_iac_version
    appPlatform = var.tag_app_platform
    appEnvironment = var.tag_app_environment
  }
}


##############################################################################################
## Route tables
###############################################################################################


resource "aws_route_table" "reart" {
  vpc_id = aws_vpc.rea.id

  route {
    cidr_block = var.rt_cidr_block_ipv4
    gateway_id = aws_internet_gateway.reagw.id
  }

  route {
    ipv6_cidr_block = var.rt_cidr_block_ipv6
    gateway_id = aws_internet_gateway.reagw.id
  }

  
  tags = {
    appName = var.tag_app_name
    iacVersion = var.tag_app_iac_version
    appPlatform = var.tag_app_platform
    appEnvironment = var.tag_app_environment
  }
}

##############################################################################################
## Subnet - Next in this VPC we are going to declare a subnet for our EC2 Instance
###############################################################################################

resource "aws_subnet" "rea-subnet-1" {
  vpc_id     = aws_vpc.rea.id
  cidr_block = var.subnet_cidr_block
  availability_zone = var.availability_zone
  map_public_ip_on_launch = true

  depends_on = [aws_internet_gateway.reagw]

  tags = {
    appName = var.tag_app_name
    iacVersion = var.tag_app_iac_version
    appPlatform = var.tag_app_platform
    appEnvironment = var.tag_app_environment
  }
}

##############################################################################################
## Associate subnet with the route table - Route table association
###############################################################################################

resource "aws_route_table_association" "reartprod" {
  subnet_id      = aws_subnet.rea-subnet-1.id
  route_table_id = aws_route_table.reart.id
}

##############################################################################################
## Security Group
###############################################################################################


resource "aws_security_group" "allow_http_ssh" {
  name        = "allow_http_ssh"
  description = "Allow only http & ssh (bidirectional)"
  vpc_id      = aws_vpc.rea.id

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = var.http_client_cidr
  }

    ingress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = var.https_client_cidr
  }

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = var.ssh_client_cidr
  }

  egress {
    # All all outgoing traffic
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    appName = var.tag_app_name
    iacVersion = var.tag_app_iac_version
    appPlatform = var.tag_app_platform
    appEnvironment = var.tag_app_environment
  }
}

##############################################################################################
## Network interface
###############################################################################################

resource "aws_network_interface" "nwint" {
  subnet_id   = aws_subnet.rea-subnet-1.id
  private_ips = var.ec2_private_ip
  security_groups = [aws_security_group.allow_http_ssh.id]
  

  tags = {
    appName = var.tag_app_name
    iacVersion = var.tag_app_iac_version
    appPlatform = var.tag_app_platform
    appEnvironment = var.tag_app_environment
  }
}
 
resource "aws_instance" "appserver" {

  ami           = var.ami

  instance_type = var.ec2_instance_type
  availability_zone = var.availability_zone
  key_name = var.ssh_key


  network_interface {
    device_index = 0
    network_interface_id = aws_network_interface.nwint.id

  }

  tags = {
    appName = var.tag_app_name
    iacVersion = var.tag_app_iac_version
    appPlatform = var.tag_app_platform
    appEnvironment = var.tag_app_environment
  }

  user_data = <<-EOF
                #!/bin/bash
                sudo apt update -y
                sudo apt install -y git
                git clone https://github.com/mohitkr05/simple-sinatra-app
                sudo bash simple-sinatra-app/deploy.sh
                EOF
             
}
