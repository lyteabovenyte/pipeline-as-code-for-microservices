resource "aws_instance" "sonarqube" {
    ami = data.aws_ami.sonarqube.id
    instance_type = var.sonarqube_instance_type
    key_name = var.key_name
    vpc_security_group_ids = [aws_security_group.sonarqube_sg.id]
    subnet_id = element(var.private_subnets, 0)

    root_block_device {
        volume_size = 30
        volume_type = "gp2"
        delete_on_termination = false
    }

    tags = {
        Name = "sonarqube"
        Author = var.author
    }
}