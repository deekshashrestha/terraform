output "public_ip" {
  value = aws_instance.web.public_ip
}

output "cloudfront_domain" {
  value = aws_cloudfront_distribution.web_distribution.domain_name
}

output "private_key_pem" {
  value     = tls_private_key.web.private_key_pem
  sensitive = true
}

