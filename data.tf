data "aws_ami" "amazon-linux-2" {
  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm*"]
  }
}

data "aws_vpc" "selected" {
    default = true
}

data "aws_subnets" "subnet" {
  filter {
    name = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
#     filter {
#     name = "tag:Name"
#     values = ["default*"]
#   }
}

# data "aws_subnets" "subnet" {
#   filter {
#     name = "vpc-id"
#     values = [var.vpc_id]
#   }
# }
 
data "aws_subnet" "subnet_value" {
  for_each = toset(data.aws_subnets.subnet.ids)
  id       = each.value
}

data "template_file" "userdata" {
  template = file("${abspath(path.module)}/userdata.sh")
  vars = {
    db_endpoint = aws_db_instance.trfrds.address
  }
}

data "aws_acm_certificate" "amazon_issued" {
  domain      = "liondevops.click"
  types       = ["AMAZON_ISSUED"]
  most_recent = true
}