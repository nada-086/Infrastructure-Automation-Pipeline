# Global Configuration
variable "access_key" {
    description = "Environment Variables - AWS Access Key"
    type = string
}

variable "secret_key" {
    description = "Environment Variables - AWS Secret Key"
    type = string
}

variable "region" {
    description = "The Region Currently Working On"
    type = string
    default = "us-east-1"
}

# EC2 Configuration
output "ec2_public_ip" {
    value = aws_instance.jenkins_ec2.public_ip
}

variable "ami" {
    description = "The ID of the Required AMI"
    type = string
}

variable "instance_type" {
    description = "Instance Type of the EC2 Instance"
    type = string
}

variable "key_file" {
    description = "SSH Key File Path"
    type = string
}

variable "associate_public_ip_address" {
    description = "Associating Public IP Address to the Instance Controller"
    type = bool
}

variable "instance_name" {
    description = "Instance Name Added as Tag"
    type = string
}

variable "ssh_security_group" {
    description = "SSH Traffic Security Group"
    type = string
}

variable "http_security_group" {
    description = "http Traffic Security Group"
    type = string
}