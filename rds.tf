resource "aws_db_instance" "trfrds" {
  allocated_storage    = 20
  max_allocated_storage = 30
  db_name              = "phonebook"
  engine               = "mysql"
  engine_version       = "8.0.28"
  instance_class       = "db.t2.micro"
  username             = "admin"
  password             = "Clarusway"
  port = 3306
  allow_major_version_upgrade = false
  auto_minor_version_upgrade = true 
  backup_retention_period = 0
  # parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  publicly_accessible = false
  identifier = "trfphonebook"
  multi_az = false
  monitoring_interval = 0
  vpc_security_group_ids = [ aws_security_group.rds-sec-gr.id ]
 
}