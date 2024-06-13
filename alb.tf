module "alb" {
  source = "terraform-aws-modules/alb/aws"

  name   = "my-alb"
  vpc_id = module.vpc.vpc_id
  subnets = [
    module.vpc.public_subnets[0],
    module.vpc.public_subnets[1],
    module.vpc.public_subnets[2]
  ]
  enable_deletion_protection = false

  # Security Group
  security_group_ingress_rules = {
    all_http = {
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"
      description = "HTTP web traffic"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }
  security_group_egress_rules = {
    all = {
      ip_protocol = "-1"
      cidr_ipv4   = "10.0.0.0/16"
    }
  }

  listeners = {
    ex-http = {
      port     = 80
      protocol = "HTTP"
    }
  }

  target_groups = {
    ex-instance = {
      name_prefix = "h1"
      protocol    = "HTTP"
      port        = 80
      target_type = "alb"
      target_id   = module.ec2_instance[0].id
    }
  }

  tags = {
    Environment = "Development"
    Project     = "Example"
  }
}

# Attach multiple ec2 instances to the target group

# resource "aws_lb_target_group_attachment" "example" {
#   count           = 3
#   target_group_arn = module.alb.target_groups["ex-instance"]["arn"]
#   target_id       = module.ec2_instance[count.index].id
#   port            = 80
# }

#Attach autoscaling group to the target group
# resource "aws_autoscaling_attachment" "autoscaling_group_attachment" {
#   autoscaling_group_name = module.asg.autoscaling_group_name
#   lb_target_group_arn    = module.alb.arn
# }