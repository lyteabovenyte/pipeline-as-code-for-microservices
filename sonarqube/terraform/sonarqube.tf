data "aws_ami" "sonarqube" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "name"
    values = ["sonarqube-*"]
  }
}

resource "aws_security_group" "sonarqube_sg" {
  name        = "sonarqube-security-groups"
  description = "allow traffic on port 9000 and allow ssh from bastion host"
  vpc_id      = aws_vpc.management.id

  ingress {
    from_port       = "9000"
    to_port         = "9000"
    protocol        = "tcp"
    security_groups = [aws_security_group.elb_sonarqube_sg.id]
  }

  ingress {
    from_port       = "22"
    to_port         = "22"
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_host.id]
  }

  egress {
    from_port  = "0"
    to_port    = "0"
    protocol   = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name   = "sonarqube_sg"
    Author = var.author
  }
}

resource "aws_instance" "sonarqube" {
  ami                    = data.aws_ami.sonarqube.id
  instance_type          = var.sonarqube_instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.sonarqube_sg.id]
  subnet_id              = element(var.private_subnets, 0)

  root_block_device {
    volume_size           = 30
    volume_type           = "gp2"
    delete_on_termination = false
  }

  tags = {
    Name   = "sonarqube"
    Author = var.author
  }
}