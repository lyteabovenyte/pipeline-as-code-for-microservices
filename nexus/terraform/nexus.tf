resource "aws_instance" "nexus" {
  ami                    = data.aws_ami.nexus.id
  instance_type          = var.nexus_instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.nexus_sg.id]
  subnet_id              = element(var.private_subnets, 0)

  root_block_device {
    volume_size           = 50
    volume_type           = "gp2"
    delete_on_termination = false
  }

  tags = {
    Author = var.author
    Name   = "nexus"
  }
}

resource "aws_security_group" "nexus_sg" {
  name        = "nexus_sg"
  description = "Allow traffic on port 8081 & 5000 and enable SSH from bastion host"
  vpc_id      = aws_vpc.management.id

  ingress {
    from_port       = "22"
    to_port         = "22"
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_host.id]
  }

  ingress {
    from_port       = "8081"
    to_port         = "8081"
    protocol        = "tcp"
    security_groups = [aws_security_group.elb_nexus_sg.id]
  }

  ingress {
    from_port       = "5000"
    to_port         = "5000"
    protocol        = "tcp"
    security_groups = [aws_security_group.elb_registry_sg.id]
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name   = "nexus_sg"
    Author = var.author
  }
}
