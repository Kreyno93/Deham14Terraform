module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "webserver_deham14"

  instance_type               = "t2.micro"
  key_name                    = "vockey"
  monitoring                  = true
  vpc_security_group_ids      = [module.web_server_sg.this_security_group_id]
  subnet_id                   = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  user_data                   = file("userdata.sh")

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}