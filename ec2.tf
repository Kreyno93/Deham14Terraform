# Get the latest AMI ID for Amazon Linux 2

data "aws_ami" "amz2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"]
}

# Identify how many availability zones are in your region

data "aws_availability_zones" "available" {}

module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  # Generate Instance Name with Availability Zone
  name = "my-ec2-instance-${data.aws_availability_zones.available.names[count.index]}"

  # Set count to as many availability zones as you have in your region
  count                       = 3
  ami                         = data.aws_ami.amz2.id
  instance_type               = "t2.micro"
  key_name                    = "vockey"
  monitoring                  = true
  vpc_security_group_ids      = [module.web_server_sg.security_group_id]
  subnet_id                   = element(module.vpc.public_subnets, count.index)
  associate_public_ip_address = true
  user_data                   = file("userdata.sh")

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}