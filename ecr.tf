resource "aws_ecr_repository" "ngo_service" {
  name                 = "solidarytech/ngo-service"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "ngo-service-repo"
  }
}

resource "aws_ecr_repository" "donation_service" {
  name                 = "solidarytech/donation-service"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "donation-service-repo"
  }
}

resource "aws_ecr_repository" "volunteer_service" {
  name                 = "solidarytech/volunteer-service"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "volunteer-service-repo"
  }
}

resource "aws_ecr_repository" "frontend_service" {
  name                 = "solidarytech/frontend"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "frontend-service-repo"
  }
}

resource "aws_ecr_replication_configuration" "main" {
  replication_configuration {
    rule {
      destination {
        region      = "us-west-2"
        registry_id = data.aws_caller_identity.current.account_id
      }
    }
  }
}

data "aws_caller_identity" "current" {}
