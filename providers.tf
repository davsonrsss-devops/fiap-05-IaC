terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.23"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.11"
    }
  }

  # backend remoto S3 para estado compartilhado (necessário para o GitHub Actions)
  backend "s3" {
    bucket         = "solidarytech-terraform-state-bucket" # Substitua por um bucket real que você deve criar na AWS
    key            = "solidarytech/hackathon/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    # dynamodb_table = "terraform-state-lock" # Opcional, mas recomendado para lock de estado
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "SolidaryTech"
      Environment = var.environment
      CostCenter  = "NGO-Core"
      ManagedBy   = "Terraform"
    }
  }
}
