resource "aws_dynamodb_table" "volunteers_table" {
  count            = var.is_dr ? 0 : 1
  name             = "SolidaryTechVolunteers"
  billing_mode     = "PAY_PER_REQUEST"
  hash_key         = "volunteer_id"
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

  attribute {
    name = "volunteer_id"
    type = "S"
  }

  replica {
    region_name = "us-west-2"
  }

  tags = {
    Name = "SolidaryTechVolunteers"
  }
}
