resource "aws_lb" "load_balancer" {
  name                       = "deham14-alb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.load_balancer_sg.id]
  subnets                    = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
  enable_deletion_protection = false

  tags = {
    Name = "deham14_alb"
  }
}

resource "aws_lb_target_group" "target_group" {
  name        = "deham14-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.deham14.id
  target_type = "instance"

  health_check {
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    matcher             = "200-399"
    timeout             = 5
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "deham14-target-group"
  }
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}

resource "aws_alb_target_group_attachment" "target_group_attachment" {
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = aws_instance.web.id
  port             = 80
}

resource "aws_alb_target_group_attachment" "target_group_attachment2" {
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = aws_instance.web2.id
  port             = 80
}

# Autoscaling Group Attachment
resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.autoscaling_group.name
  lb_target_group_arn    = aws_lb_target_group.target_group.arn
}
