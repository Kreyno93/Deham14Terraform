# Security Group
resource "aws_security_group" "webserver_sg" {
  vpc_id = aws_vpc.deham14.id

  # Allow SSH inbound traffic
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTP inbound traffic
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "WebServerSG"
    SecurityGroupName = "WebServerSG"
  }
}

output "security_group_id" {
  value = aws_security_group.webserver_sg.id
}

resource "aws_security_group" "load_balancer_sg" {
  vpc_id = aws_vpc.deham14.id

  # Allow HTTP inbound traffic
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "LoadBalancerSG"
    SecurityGroupName = "LoadBalancerSG"
  }
}

# resource "aws_security_group" "rds_sg" {
#   vpc_id = aws_vpc.deham14.id

#   # Allow MySQL/Aurora inbound traffic
#   ingress {
#     from_port   = 3306
#     to_port     = 3306
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   # Allow ssh to the RDS instance
#   ingress = {
#     from_port = 22
#     to_port = 22
#     protocol = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   } 

#    egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }