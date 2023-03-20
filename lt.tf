resource "aws_launch_template" "trf_lt_phonebook" {
  name = "lion_phonebook"
  image_id = data.aws_ami.amazon-linux-2.id
  instance_initiated_shutdown_behavior = "terminate"
  instance_type = var.instance_type
  key_name = var.key_name
  vpc_security_group_ids = [ aws_security_group.ec2-sec-gr.id ]
#   placement {
#     availability_zone = "us-west-2a"
#   }
#   vpc_security_group_ids = ["sg-12345678"]

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "Web Server of Phonebook App"
    }
  }
  user_data = "${base64encode(data.template_file.userdata.rendered)}"
  # user_data = filebase64("${path.module}/userdata.sh")

  depends_on = [
    # github_repository_file.dbendpoint,
    aws_db_instance.trfrds
  ]
}

# resource "github_repository_file" "dbendpoint" {
#   content             = aws_db_instance.trfrds.address
#   file                = "dbserver.endpoint"
#   repository          = "terraform_phonebook"
#   overwrite_on_create = true
#   branch              = "main"
# }
