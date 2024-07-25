output "nexus_elb_dns" {
    value = "https://${aws_route53_record.nexus.name}"
}

output "registery_elb_dns" {
    value = "https://${aws_route53_record.registery.name}"
}