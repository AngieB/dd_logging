provider "aws" {
  region = "us-west-1"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "all" {
  vpc_id = "${data.aws_vpc.default.id}"
}

data "aws_security_group" "home_ssh" {
  filter {
    name = "group-name"

    values = [
      "angie-ssh",
    ]
  }
}

data "aws_ami" "packer_ubuntu" {
  most_recent = true

  filter {
    name = "name"

    values = [
      "packer-ubuntu-*",
    ]
  }
}

module "ec2_cluster" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name  = "wp-cluster"
  count = 5
  user_data              = "${file("${path.module}/user_data.sh")}"
  ami                    = "${data.aws_ami.packer_ubuntu.id}"
  instance_type          = "t2.micro"
  key_name               = "${var.key_name}"
  monitoring             = false
  vpc_security_group_ids = ["${data.aws_security_group.home_ssh.id}"]
  subnet_id              = "${var.subnet_id}"
  associate_public_ip_address = "true"
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
