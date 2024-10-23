# create the bucket
resource "aws_s3_bucket" "bucket" {
  bucket = "${local.prefix}-bucket"
}

resource "aws_s3_bucket_website_configuration" "bucket" {
  bucket = aws_s3_bucket.bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# Upload website content to S3
resource "aws_s3_object" "website_files" {
  for_each = fileset("../website", "*")

  bucket = aws_s3_bucket.bucket.id
  key    = each.value
  content_type = lookup({
    "html" = "text/html",
    "css"  = "text/css",
    "js"   = "application/javascript",
    "png"  = "image/png",
    "jpg"  = "image/jpeg",
    "jpeg" = "image/jpeg",
    "gif"  = "image/gif",
    "svg"  = "image/svg+xml"
  }, split(".", each.value)[length(split(".", each.value)) - 1], "binary/octet-stream")

  # Use this to pass in the api url env var
  content = each.value == "script.js" ? templatefile("../website/script.js.tftpl", {
    api_url = aws_api_gateway_deployment.myapi.invoke_url
  }) : file("../website/${each.value}")
  # need this to detect changes
  etag = each.value == "script.js" ? md5(templatefile("../website/script.js.tftpl", {
    api_url = aws_api_gateway_deployment.myapi.invoke_url
  })) : filemd5("../website/${each.value}")
}

# Configure bucket for static website hosting
resource "aws_s3_bucket_website_configuration" "bucket" {
  bucket = aws_s3_bucket.bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# Make bucket public
resource "aws_s3_bucket_public_access_block" "bucket" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Bucket policy to allow public read access
resource "aws_s3_bucket_policy" "bucket" {
  bucket = aws_s3_bucket.bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.bucket.arn}/*"
      },
    ]
  })

  depends_on = [aws_s3_bucket_public_access_block.bucket]
}

# Output the website URL
output "website_url" {
  value       = aws_s3_bucket_website_configuration.bucket.website_endpoint
  description = "S3 Static Website URL"
}

