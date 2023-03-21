variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "key_name" {
  type = string
  default = "first-key"
}

variable "num_of_instance" {
  type = number
  default = 1
}

variable "tag" {
  type = string
  default = "Lion_phonebook"
}

variable "ec2-instance-ports" {
  type = list(number)
  description = "ec2-instance-sec-gr-inbound-rules"
  default = [80, 443]
}

variable "aws_region" {
    type = string
    description = "aws region"
    default = "us-east-1"  
}

variable "vpc_id" {
  default = "vpc-0dd50cabd4ed57343"  
}

variable "domain_name" {
  default = "liondevops.click"
  description = "domain name"
  type = string
}

variable "record_name" {
  default = "www"
  description = "sub domain name"
  type = string
}