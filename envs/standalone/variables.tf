variable "region" {
  default = "ap-northeast-1"
}

variable "profile" {
  default = "default"
}

variable "public_key_path" {
  default = "~/.ssh/id_rsa.pub"
}

variable "ami_id" {
  default = "ami-00a5245b4816c38e6"
}

variable "instance_count" {
  default = "1"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "root_volume_size" {
  default = "100"
}
