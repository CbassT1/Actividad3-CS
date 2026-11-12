resource "aws_s3_bucket" "b" {
  bucket = "actividad3-seguro-local"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "b_enc" {
  bucket = aws_s3_bucket.b.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "b_block" {
  bucket = aws_s3_bucket.b.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}