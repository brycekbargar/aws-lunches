resource "random_password" "wordpress" {
  length  = 31
  special = true
}

resource "aws_security_group" "wordpress" {
}

resource "aws_security_group_rule" "web_rds" {
  for_each          = toset(["ingress", "egress"])
  security_group_id = aws_security_group.wordpress.id

  type      = each.key
  from_port = 3306
  to_port   = 3306
  protocol  = "tcp"

  source_security_group_id = aws_security_group.web.id
}


resource "aws_db_instance" "wordpress" {
  engine            = "mysql"
  instance_class    = "db.t3.micro"
  allocated_storage = 5

  db_name  = "wordpress"
  username = "svc_wordpress"
  password = random_password.wordpress.result

  backup_retention_period = 0
  skip_final_snapshot     = true

  vpc_security_group_ids = [aws_security_group.wordpress.id]
}
