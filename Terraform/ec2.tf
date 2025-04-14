resource "aws_security_group" "ec2_ssh_sg" {
    name = var.ssh_security_group
    description = "Allow SSH Traffic"
    ingress {
        from_port   = 22 
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "ec2_http_sg" {
    name = var.http_security_group
    description = "Allow HTTP Traffic"
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "jenkins_ec2" {
    ami                    = var.ami
    instance_type          = var.instance_type
    key_name               = var.key_file
    vpc_security_group_ids = [aws_security_group.ec2_ssh_sg.id, aws_security_group.ec2_http_sg]
    associate_public_ip_address = var.associate_public_ip_address

    tags = {
        Name = var.instance_name
    }
}
