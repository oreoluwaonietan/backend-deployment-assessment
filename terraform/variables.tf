variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "my_ip" {
  description = "Your current public IP address for SSH access (format: x.x.x.x/32)"
  type        = string
}

variable "ami_id" {
  description = "Amazon Linux 2 AMI ID"
  type        = string
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
  default     = "startuptech-key"
}
