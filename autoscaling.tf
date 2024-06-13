# module "asg" {
#     source = "terraform-aws-modules/autoscaling/aws"
    
#     name                 = "webserver-asg"
#     launch_configuration = module.ec2_instance.launch_configuration
#     vpc_zone_identifier  = module.vpc.public_subnets
#     min_size             = 1
#     max_size             = 3
#     desired_capacity     = 2
#     health_check_type    = "EC2"
#     health_check_grace_period = 300
#     wait_for_capacity_timeout = "10m"
#     tags = {
#         Terraform   = "true"
#         Environment = "dev"
#     }
# }
module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"

  # Autoscaling group
  name = "webserver-asg"

  min_size                  = 1
  max_size                  = 3
  desired_capacity          = 2
  health_check_type         = "EC2"
  vpc_zone_identifier       = [module.vpc.public_subnets[0], module.vpc.public_subnets[1], module.vpc.public_subnets[2]]

  # Launch template
  launch_template_name        = "webserver-launch-template"
  launch_template_description = "Launch template example"
  update_default_version      = true
  security_groups            = [module.web_server_sg.security_group_id]

  image_id          = data.aws_ami.amz2.id
  instance_type     = "t3.micro"

  tags = {
    name = "webserver-asg"
  }

  scaling_policies = {
    my-policy = {
        policy_type = "TargetTrackingScaling"
        target_tracking_configuration = {
            predefined_metric_specification = {
                predefined_metric_type = "ASGAverageCPUUtilization"
            }
            target_value = 75.0
        }
    }
  }
}