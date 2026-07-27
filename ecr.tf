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
