# Create Aurora Cluster in Private Subnet 1

# resource "aws_rds_cluster" "aurora_cluster" {
#   cluster_identifier      = "wordpress-aurora-cluster"
#   engine                  = "aurora-mysql"
#   engine_version          = "5.7.mysql_aurora.2.03.2"
#   availability_zones      = ["eu-north-1a", "eu-north-1b"]
#   database_name           = "wordpress"
#   master_username         = "masteruser"
#   master_password         = "master1234!"
#   vpc_security_group_ids = ["needs to be created"]
#   db_subnet_group_name   =  "needs to be created"

#   lifecycle {
#     ignore_changes = [
#       database_name,
#       master_password,
#       engine_version,
#     ]
#   }

#   tags = {
#     Name = "WordpressAuroraCluster"
#     }
# } 

# resource "aws_rds_cluster_instance" "wordpress_instance" {
#   cluster_identifier = aws_rds_cluster.aurora_cluster.id
#   instance_class     = "db.t3.small"
#   engine             = "aurora-mysql"
#   engine_version     = "5.7.mysql_aurora.2.03.2"
#   identifier         = "wordpress-aurora-cluster"
#   publicly_accessible = true
#   tags = {
#     Name = "WordpressAuroraInstance"
#   }
  
# }


