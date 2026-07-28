resource "aws_db_subnet_group" "solidarytech_db_subnet_group" {
  name       = "solidarytech-db-subnet-group-${var.environment}"
  subnet_ids = module.vpc.private_subnets

  tags = {
    Name = "SolidaryTech DB Subnet Group"
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "solidarytech-rds-sg-${var.environment}"
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

# Banco de dados para NGO Service (Primário)
resource "aws_db_instance" "ngo_db" {
  count                  = var.is_dr ? 0 : 1
  identifier             = "ngo-db"
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "postgres"
  engine_version         = "16.3"
  instance_class         = "db.t3.micro"
  db_name                = "ngo_db"
  username               = "admin_ngo"
  password               = "solidarytech2024" # Idealmente usar AWS Secrets Manager
  parameter_group_name   = "default.postgres16"
  skip_final_snapshot    = true
  publicly_accessible    = false
  db_subnet_group_name   = aws_db_subnet_group.solidarytech_db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  backup_retention_period = 7 # Necessário para read replicas
}

# Banco de dados para NGO Service (Replica)
resource "aws_db_instance" "ngo_db_replica" {
  count                  = var.is_dr ? 1 : 0
  identifier             = "ngo-db-dr"
  replicate_source_db    = var.primary_ngo_db_arn
  instance_class         = "db.t3.micro"
  skip_final_snapshot    = true
  publicly_accessible    = false
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
}

# Banco de dados para Donation Service (Primário)
resource "aws_db_instance" "donation_db" {
  count                  = var.is_dr ? 0 : 1
  identifier             = "donation-db"
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "postgres"
  engine_version         = "16.3"
  instance_class         = "db.t3.micro"
  db_name                = "donation_db"
  username               = "admin_donation"
  password               = "solidarytech2024" # Idealmente usar AWS Secrets Manager
  parameter_group_name   = "default.postgres16"
  skip_final_snapshot    = true
  publicly_accessible    = false
  db_subnet_group_name   = aws_db_subnet_group.solidarytech_db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  backup_retention_period = 7 # Necessário para read replicas
}

# Banco de dados para Donation Service (Replica)
resource "aws_db_instance" "donation_db_replica" {
  count                  = var.is_dr ? 1 : 0
  identifier             = "donation-db-dr"
  replicate_source_db    = var.primary_donation_db_arn
  instance_class         = "db.t3.micro"
  skip_final_snapshot    = true
  publicly_accessible    = false
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
}

output "ngo_db_arn" {
  value = var.is_dr ? aws_db_instance.ngo_db_replica[0].arn : aws_db_instance.ngo_db[0].arn
}

output "donation_db_arn" {
  value = var.is_dr ? aws_db_instance.donation_db_replica[0].arn : aws_db_instance.donation_db[0].arn
}
