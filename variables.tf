variable "aws_region" {
  description = "Região da AWS onde os recursos serão provisionados"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Ambiente (ex: Production, Staging, Dev)"
  type        = string
  default     = "Production"
}

variable "cluster_name" {
  description = "Nome do cluster EKS"
  type        = string
  default     = "solidarytech-cluster"
}

variable "vpc_cidr" {
  description = "CIDR block para a VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "region_role" {
  description = "Papel desta região no DR (active ou passive)"
  type        = string
  default     = "active"
}

variable "primary_ngo_db_arn" {
  type    = string
  default = null
}

variable "primary_donation_db_arn" {
  type    = string
  default = null
}
