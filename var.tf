# Create a Varibale for instance type

variable "instance_type_t2micro" {
  description = "EC2 Instance Type"
  type        = string
  default     = "t2.micro"
}

# Create a Varibale for AWS Region

variable "aws_region_us_west_2" {
  description = "Region in which AWS Resources to be created"
  type        = string
  default     = "us-west-2"
}

# Create Variable for AWS Availability Zone

variable "aws_availability_zone_a" {
  description = "Availability Zone in which AWS Resources to be created"
  type        = string
  default     = "us-west-2a"
}

# Create Variable for AWS Availability Zone

variable "aws_availability_zone_b" {
  description = "Availability Zone in which AWS Resources to be created"
  type        = string
  default     = "us-west-2b"
}

