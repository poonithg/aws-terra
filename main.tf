### S3 BUCKET FOR TERRAFORM STATE FILE ####
resource "aws_s3_bucket" "tf_remote_state" {
  bucket = "terraform-state-demo-001xxx"
  lifecycle {
    prevent_destroy = true
  }
}

# ENABLE VERSIONING
resource "aws_s3_bucket_versioning" "tf_remote_state-versioning" {
  bucket = aws_s3_bucket.tf_remote_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

# ENABLE ENCRYPTION
resource "aws_s3_bucket_server_side_encryption_configuration" "tf_remote_state-encryption" {
  bucket = aws_s3_bucket.tf_remote_state.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

#### DYNAMODB FOR LOCKING THE STATE FILE ####
resource "aws_dynamodb_table" "tf_state_locking" {
  hash_key = "LockID"
  name     = "terraform-state-locking"
  attribute {
    name = "LockID"
    type = "S"
  }
  billing_mode = "PAY_PER_REQUEST"
}
