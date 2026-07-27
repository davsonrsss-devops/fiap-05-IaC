resource "aws_db_subnet_group" "solidarytech_db_subnet_group" {
  name       = "solidarytech-db-subnet-group"
  subnet_ids = module.vpc.private_subnets

  tags = {
    Name = "SolidaryTech DB Subnet Group"
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "solidarytech-rds-sg"
  description = "Allow inbound traffic from EKS"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr] # Permitir da VPC
  }

  tags = {
    Name = "solidarytech-rds-sg"
  }
}

# Banco de dados para NGO Service
resource "aws_db_instance" "ngo_db" {
  identifier             = "ngo-db"
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "postgres"
  engine_version         = "15.4"
  instance_class         = "db.t3.micro"
  db_name                = "ngo_db"
  username               = "admin_ngo"
  password               = "solidarytech2024" # Idealmente usar AWS Secrets Manager
  parameter_group_name   = "default.postgres15"
  skip_final_snapshot    = true
  publicly_accessible    = false
  db_subnet_group_name   = aws_db_subnet_group.solidarytech_db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
}

# Banco de dados para Donation Service
resource "aws_db_instance" "donation_db" {
  identifier             = "donation-db"
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "postgres"
  engine_version         = "15.4"
  instance_class         = "db.t3.micro"
  db_name                = "donation_db"
  username               = "admin_donation"
  password               = "solidarytech2024" # Idealmente usar AWS Secrets Manager
  parameter_group_name   = "default.postgres15"
  skip_final_snapshot    = true
  publicly_accessible    = false
  db_subnet_group_name   = aws_db_subnet_group.solidarytech_db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
}
