# # Get the latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux_2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

#Get latest ami ID of Amazon Linux - values = ["al2023-ami-2023*x86_64"]
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*x86_64"]
  }
}

# Create Web Server Instance in Public Subnet 1
resource "aws_instance" "web" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = "t3.micro"
  availability_zone      = "eu-north-1a"
  vpc_security_group_ids = [aws_security_group.webserver_sg.id]
  subnet_id              = aws_subnet.public_subnet_1.id
  key_name               = "WordpressDeham14"
  user_data              = file("userdata.sh")
  tags = {
    Name = "WordpressWebServer1"
  }
}

# # Create Web Server Instance in Public Subnet 2
# resource "aws_instance" "web2" {
#   ami                    = "ami-0f76a278bc3380848" # Amazon Linux 2
#   instance_type          = "t3.micro"
#   availability_zone      = "eu-north-1b"
#   vpc_security_group_ids = [aws_security_group.webserver_sg.id]
#   subnet_id              = aws_subnet.public_subnet_2.id
#   key_name               = "WordpressDeham14"
#   user_data              = file("userdata.sh")
#   tags = {
#     Name = "WordpressWebServer2"
#   }
# }