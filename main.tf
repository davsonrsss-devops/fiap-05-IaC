module "primary_region" {
  source = "./modules/region"
  
  aws_region   = "us-east-1"
  environment  = var.environment
  cluster_name = var.cluster_name
  vpc_cidr     = "10.0.0.0/16"
}

module "secondary_dr_region" {
  source = "./modules/region"
  
  aws_region   = "us-west-2"
  environment  = "${var.environment}-dr"
  cluster_name = "${var.cluster_name}-dr"
  vpc_cidr     = "10.1.0.0/16"
}
