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

module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "webserver_deham14"

  ami                         = data.aws_ami.amz2.id
  instance_type               = "t2.micro"
  key_name                    = "vockey"
  monitoring                  = true
  vpc_security_group_ids      = [module.web_server_sg.security_group_id]
  subnet_id                   = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  user_data                   = file("userdata.sh")

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}