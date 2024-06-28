# # Purpose: Create Launch Template for EC2 instances
# data "template_file" "user_data" {
#   template = file("userdata.sh")
# }

# # Create Launch Template
# resource "aws_launch_template" "launch_template" {
#   name                   = "deham14-launch-template"
#   image_id               = data.aws_ami.amazon_linux_2.id
#   instance_type          = "t2.micro"
#   user_data              = filebase64("userdata.sh")
#   key_name               = "vockey"
#   vpc_security_group_ids = [aws_security_group.webserver_sg.id]
# }

# # Create Auto Scaling Group
# resource "aws_autoscaling_group" "autoscaling_group" {
#   name             = "deham14-autoscaling-group"
#   max_size         = 3
#   min_size         = 1
#   desired_capacity = 1
#   launch_template {
#     id = aws_launch_template.launch_template.id
#   }
#   vpc_zone_identifier       = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
#   target_group_arns         = [aws_lb_target_group.target_group.arn]
#   health_check_type         = "ELB"
#   health_check_grace_period = 300
#   termination_policies      = ["OldestInstance"]
#   tag {
#     key                 = "Name"
#     # Create an individual tag for each instance
#     value               = "deham14-instance-${count.index}"
#     propagate_at_launch = true
#   }
# }

# # Create Auto Scaling Policy
# resource "aws_autoscaling_policy" "autoscaling_policy" {
#   name                   = "deham14-autoscaling-policy"
#   autoscaling_group_name = aws_autoscaling_group.autoscaling_group.name
#   policy_type            = "TargetTrackingScaling"
#   target_tracking_configuration {
#     predefined_metric_specification {
#       predefined_metric_type = "ASGAverageCPUUtilization"
#     }
#     target_value = 75.0
#   }
# }

# # Autoscaling Group Attachment
# resource "aws_autoscaling_attachment" "asg_attachment" {
#   autoscaling_group_name = aws_autoscaling_group.autoscaling_group.name
#   lb_target_group_arn    = aws_lb_target_group.target_group.arn
# }
