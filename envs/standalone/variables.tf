variable "region" {
  default = "ap-northeast-1"
}

variable "public_key_path" {
  default = "~/.ssh/id_rsa.pub"
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
