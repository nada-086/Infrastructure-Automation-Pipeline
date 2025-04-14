resource "aws_instance" "jenkins_ec2" {
    ami                    = var.ami
    instance_type          = var.instance_type
    key_name               = var.key_file
    associate_public_ip_address = var.associate_public_ip_address

    tags = {
        Name = var.instance_name
    }
}
