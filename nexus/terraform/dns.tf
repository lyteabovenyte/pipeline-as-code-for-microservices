resource "aws_route53_record" "nexus" {
    zone_id = var.hosted_zone_id
    name = "nexus.${var.domain_name}"
    type = "A"

    alias {
        name = aws_elb.nexus_elb.dns_name
        zone_id = aws_elb.nexus_elb.zone_id
        evaluate_target_health = true
    }
}

resource "aws_route53_record" "registery" {
    zone_id = var.hosted_zone_id
    name = "registery.${var.domain.name}"
    type = "A"

    alias {
        name = aws_elb.nexus_elb.dns_name
        zone_id = aws_elb.nexus_elb.zone_id
        evaluate_target_health = true
    }
}