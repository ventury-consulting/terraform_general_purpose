locals {
   name = "standalone"
}

provider "aws" {
  region  = "${var.region}"
  profile = "${var.profile}"
}

data "aws_availability_zones" "available" {}

data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name = "name"
    values = [
      "amzn-ami-hvm-*-x86_64-gp2",
    ]
  }

  filter {
    name = "owner-alias"
    values = [
      "amazon",
    ]
  }
}

resource "aws_key_pair" "key_pair" {
  key_name   = "key_pair-${terraform.workspace}-${local.name}"
  public_key = "${file(var.public_key_path)}"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "1.60.0"

  name = "vpc-${terraform.workspace}-${local.name}"
  cidr = "10.0.0.0/16"
  azs  = "${data.aws_availability_zones.available.names}"

  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  tags = {
    Terraform = "true"
    Environment = "${local.name}"
    Workspace = "${terraform.workspace}"
  }
}

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "2.7.0"

  name        = "example"
  description = "Security group for example usage with EC2 instance"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["all-icmp", "ssh-tcp"]
  egress_rules        = ["all-all"]

  tags = {
    Terraform = "true"
    Environment = "${local.name}"
    Workspace = "${terraform.workspace}"
  }
}

module "ec2" {
  source                      = "terraform-aws-modules/ec2-instance/aws"
  version                     = "1.21.0"
  name                        = "ec2-${terraform.workspace}-${local.name}"
  instance_count              = "${var.instance_count}"
  ami                         = "${data.aws_ami.amazon_linux.id}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${aws_key_pair.key_pair.key_name}"
  monitoring                  = true
  vpc_security_group_ids      = ["${module.security_group.this_security_group_id}"]
  subnet_id                   = "${element(module.vpc.public_subnets, 0)}"
  associate_public_ip_address = true

  root_block_device = [{
    volume_type = "gp2"
    volume_size = "${var.root_volume_size}"
    delete_on_termination = true
  }]

  tags = {
    Terraform = "true"
    Environment = "${local.name}"
    Workspace = "${terraform.workspace}"
  }
}
