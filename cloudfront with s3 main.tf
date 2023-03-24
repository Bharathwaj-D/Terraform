resource "aws_s3_bucket" "b" {
  bucket = "my-terraform-cf"
}

resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = "statichosting"
  description                       = "oac"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}
resource "aws_cloudfront_distribution" "s3_distribution" {
  
  origin {
    domain_name              = "my-terraform-cf.s3.amazonaws.com"
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
    origin_id                = "staticweb-hosting"
  }
  enabled             = true  
  default_root_object = "index.html"
  aliases = ["bharathwaj.pestinew.cf"]
  viewer_certificate {
    acm_certificate_arn      = "arn:aws:acm:us-east-1:928920371678:certificate/cfff7dd9-571b-4a6a-a8b6-48fe38744d4f"  
    minimum_protocol_version = "TLSv1.2_2021"
    ssl_support_method       =  "sni-only"
  }
  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "staticweb-hosting"
    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
    viewer_protocol_policy = "redirect-to-https"
  }
    restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }
}
resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = aws_s3_bucket.b.id
  policy = jsonencode({
        "Version": "2008-10-17",
        "Id": "PolicyForCloudFrontPrivateContent",
        "Statement": [
            {
                "Sid": "AllowCloudFrontServicePrincipal",
                "Effect": "Allow",
                "Principal": {
                    "Service": "cloudfront.amazonaws.com"
                },
                "Action": "s3:GetObject",
                "Resource": "arn:aws:s3:::my-terraform-cf/*",
                "Condition": {
                    "StringEquals": {
                      "AWS:SourceArn": "arn:aws:cloudfront::928920371678:distribution/E1U0CQ394MBS9U"
                    }
                }
            }
        ]
      })
}
resource "aws_route53_record" "bharath" {
  zone_id = "Z06074781UJ6UA4IN1XOU"
  name    = "bharathwaj.pestinew.cf"
  type    = "CNAME"
  ttl     = 300
  records = [aws_cloudfront_distribution.s3_distribution.domain_name]
}
  
    