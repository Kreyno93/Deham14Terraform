# Get the latest Amazon Linux 2 AMI

data "aws_ami" "amazon_linux_2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  owners = ["137112412989"]
}

# Create Web Server Instance

resource "aws_instance" "web" {
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = "t2.micro"
  availability_zone = "us-west-2a"
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  subnet_id     = aws_subnet.public_subnet_1.id
  key_name      = "vockey"
  tags = {
    Name = "WebServer"
  }
}