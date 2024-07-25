# to the Nexus Dashboard
resource "aws_elb" "nexus_elb" {
    subnets = var.public_subnets
    cross_zone_load_balancing = true
    security_groups = [aws_security_group.elb_nexus_sg.id]
    instances = [aws_instance.nexus]

    listener {
        instance_port = 8081
        instance_protocol = "http"
        lb_port = 443
        lb_protocol = "https"
        ssl_certificate_id = var.ssl_arn
    }

    health_check {
      healthy_threshold = 2
      unhealthy_threshold = 2
      timeout = 3
      target = "TCP:8081"
      interval = 5
    }

    tags = {
        Name = "nexus_elb"
        Author = var.author
    }
}

# this will access the Docker private registery pointing t port 5000 of the hosted repo
# on the Nexus repo manager
resource "aws_elb" "registery_elb" {
    subnets = var.public_subnets
    cross_zone_load_balancing = true
    security_groups = [aws_security_group.elb_registery_sg.id]
    instances = [aws_instance.nexus.id]

    listener {
        instance_port = 5000
        instance_protocol = "http"
        lb_port = 443
        lb_protocol = "https"
        ssl_certificate_id = var.ssl_arn
    }
}

resource "aws_security_group" "elb_nexus_sg" {
    name = "nexus-loadbalancer_sg"
    description = "Allow https on port 443 to the nexus instance"
    vpc_id = aws_vpc.management.id

    ingress {
        from_port = "443"
        to_port = "443"
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = "0"
        to_port = "0"
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    tags = {
        Name = "elb_nexus_sg"
        Author = var.author    
    }
}

resource "aws_security_group" "elb_regitstery_sg" {
    name = "registery-loadbalancer_sg"
    description = "Allow https on port 443 to the registery instance"
    vpc_id = aws_vpc.management.id

    ingress {
        from_port = "443"
        to_port = "443"
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = "0"
        to_port = "0"
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    tags = {
        Name = "elb_registery_sg"
        Author = var.author    
    }
}


