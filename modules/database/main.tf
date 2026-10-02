resource "aws_security_group" "db" {
  name        = "${var.name}-db-sg"
  description = "Allow database traffic from the application tier."
  vpc_id      = var.vpc_id
  ingress {
    description     = "MySQL from the application tier."
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [var.app_security_group_id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(var.tags, { Name = "${var.name}-db-sg" })
}

resource "aws_db_subnet_group" "db" {
  name       = "${var.name}-db-subnet-group"
  subnet_ids = var.private_subnets
  tags       = merge(var.tags, { Name = "${var.name}-db-subnet-group" })
}

resource "aws_db_instance" "db" {
  identifier              = "${var.name}-db"
  allocated_storage       = var.allocated_storage
  engine                  = "mysql"
  engine_version          = var.engine_version
  instance_class          = var.db_instance_class
  db_name                 = var.db_name
  username                = var.db_username
  password                = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.db.name
  vpc_security_group_ids  = [aws_security_group.db.id]
  backup_retention_period = var.backup_retention_period
  publicly_accessible     = false
  skip_final_snapshot     = true
  tags                    = merge(var.tags, { Name = "${var.name}-db" })
}
