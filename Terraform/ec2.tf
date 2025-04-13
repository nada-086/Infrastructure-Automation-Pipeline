provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "example" {
    ami                    = "ami-0c15e602d3d6c6c4a"
    instance_type          = "t2.micro"
    associate_public_ip_address = true

    tags = {
        Name = "Terraform-EC2"
    }
}
