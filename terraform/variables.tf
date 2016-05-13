variable "public_key_path" {
  description = <<DESCRIPTION
Path to the SSH public key to be used for authentication.
Ensure this keypair is added to your local SSH agent so provisioners can
connect.

Example: ~/.ssh/boshtutorial.pub
DESCRIPTION
}

variable "key_name" {
  description = "Desired name of AWS key pair"
}

variable "aws_region" {
  description = "AWS region to launch servers."
  default = "us-east-1"
}

# bosh-lite AMI
variable "aws_amis" {
  default = {
    ap-northeast-1 = "ami-3b83645a"
    ap-southeast-1 = "ami-26a57345"
    ap-southeast-2 = "ami-74b89417"
    eu-west-1 = "ami-bb5fd5c8"
    sa-east-1 = "ami-9dc54df1"
    us-east-1 = "ami-41d5392c"
    us-west-1 = "ami-f2fe8792"
    us-west-2 = "ami-c52fd2a5"
  }
}

