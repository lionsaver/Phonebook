resource "aws_lb" "pnbalb" {
  name               = "phonebook-tf-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb-sec-gr.id]
  subnets = [for s in data.aws_subnet.subnet_value: s.id]

  tags = {
    Environment = "freetier"
  }
}


resource "aws_lb_target_group" "trgt" {
  name        = "tf-example-lb-alb-tg"
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  depends_on = [aws_lb.pnbalb]
}

 


resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.pnbalb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.trgt.arn
  }
}

resource "aws_autoscaling_group" "phnbook" {
#   availability_zones = ["us-east-1a"]
  name                      = "trfm-phonebook"
  max_size                  = 3
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 2
  force_delete              = true
  vpc_zone_identifier = [for s in data.aws_subnet.subnet_value: s.id]


  launch_template {
    id      = aws_launch_template.trf_lt_phonebook.id
    version = "$Latest"
  }
}

# Create a new ALB Target Group attachment
resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = aws_autoscaling_group.phnbook.id
  lb_target_group_arn    = aws_lb_target_group.trgt.arn
}
