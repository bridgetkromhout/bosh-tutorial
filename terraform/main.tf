# We're using the AWS provider
# https://www.terraform.io/docs/providers/aws/index.html
provider "aws" {
  region = "${var.aws_region}"
}

# Create a VPC to launch our instance into
resource "aws_vpc" "boshtutorial" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
}

# Create an internet gateway to give our subnet access to the outside world
resource "aws_internet_gateway" "boshtutorial" {
  vpc_id = "${aws_vpc.boshtutorial.id}"
}

# Grant the VPC internet access on its main route table
resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.boshtutorial.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.boshtutorial.id}"
}

# Create a subnet to launch our instance into
resource "aws_subnet" "boshtutorial" {
  vpc_id                  = "${aws_vpc.boshtutorial.id}"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

# Our boshtutorial security group to access
# the instance over SSH and HTTP
resource "aws_security_group" "boshtutorial" {
  name        = "terraform_example"
  description = "Used in the terraform"
  vpc_id      = "${aws_vpc.boshtutorial.id}"

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from anywhere
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_key_pair" "auth" {
  key_name   = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}

resource "aws_instance" "boshtutorial" {
  # The connection block tells our provisioner how to
  # communicate with the resource (instance)
  connection {
    # The default username for our AMI
    user = "ubuntu"

    # The connection will use the local SSH agent for authentication.
  }

  # This instance type has enough resources to run this tutorial
  instance_type = "m3.xlarge"

  root_block_device {
    volume_size = "100"
    volume_type = "gp2"
  }

  # Look up the correct AMI based on the region we specified
  ami = "${lookup(var.aws_amis, var.aws_region)}"

  # The name of our SSH keypair we created above.
  key_name = "${aws_key_pair.auth.id}"

  # Our Security group to allow HTTP and SSH access
  vpc_security_group_ids = ["${aws_security_group.boshtutorial.id}"]

  subnet_id = "${aws_subnet.boshtutorial.id}"

}

output "ssh to your instance with this command (replace the IP):\n ssh -o StrictHostKeyChecking=no -i ~/.ssh/boshtutorial ubuntu@IP\n\n"
	{ value = "${aws_instance.boshtutorial.public_ip}" }

