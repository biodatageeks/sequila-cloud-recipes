data "aws_caller_identity" "current" {}

resource "random_string" "storage_id" {
  keepers = {
    sub_id = data.aws_caller_identity.current.account_id
  }
  length  = 8
  special = false
  lower   = true
}

#tfsec:ignore:aws-s3-enable-bucket-encryption
#tfsec:ignore:aws-s3-enable-bucket-logging
#tfsec:ignore:aws-s3-enable-versioning
#tfsec:ignore:aws-s3-no-public-access-with-acl
#tfsec:ignore:aws-s3-specify-public-access-block
resource "aws_s3_bucket" "bucket" {
  bucket = "sequila${lower(random_string.storage_id.id)}"
  acl    = "public-read"

}