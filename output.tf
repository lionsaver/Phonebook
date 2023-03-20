# output "vpc_id" {
#   value = aws_vpc.main.id
# }

# output "vpc_tags" {
#   value = aws_vpc.main.id
# }

output "RDS-endpoint" {
  value = aws_db_instance.trfrds.address
}

output "alb_dns_name" {
  value = aws_lb.pnbalb.dns_name
}

output "subnet_cidr_blocks1" {
  value = [for s in data.aws_subnet.subnet_value : s.id]
}