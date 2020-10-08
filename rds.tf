provider "aws" {
  region     = "ap-south-1"
  profile    = "mansi"
}

resource "aws_db_instance" "default" {
  allocated_storage    = 5
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "myrdsdb"
  username             = "mansi22dadheech"
  password             = "Mansi1234dadheech"
  parameter_group_name = "default.mysql5.7"
  publicly_accessible  = true
  skip_final_snapshot  = true
  tags = {
  Name = "myrdsdb"
  }
}