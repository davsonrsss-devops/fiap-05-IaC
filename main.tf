module "region" {
  source = "./modules/region"
  
  aws_region   = var.aws_region
  environment  = var.region_role == "passive" ? "${var.environment}-dr" : var.environment
  cluster_name = var.region_role == "passive" ? "${var.cluster_name}-dr" : var.cluster_name
  vpc_cidr     = var.vpc_cidr
  
  is_dr                   = var.region_role == "passive" ? true : false
  primary_ngo_db_arn      = var.primary_ngo_db_arn
  primary_donation_db_arn = var.primary_donation_db_arn
}

# Previne que o cluster existente (primary_region) seja destruído ao mudar o nome do módulo
moved {
  from = module.primary_region
  to   = module.region
}
