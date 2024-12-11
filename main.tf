provider "aws" {
  region = "us-east-1" # Replace with the AWS region you want
}

resource "aws_instance" "wordpress" {
  ami           = "ami-0166fe664262f664c" # Replace with the appropriate AMI for your region
  instance_type = "t2.micro"             # Choose an instance type
  
  key_name      = "new-key-pair-ec2"   # Replace with your existing key pair name
  
  user_data = file("userdata.sh")
  
  tags = {
    Name = "WordPress-Instance"
  }

  security_groups = [aws_security_group.wordpress_sg.name]
}

resource "aws_security_group" "wordpress_sg" {
  name        = "wordpress-sg1"
  description = "Allow HTTP, HTTPS, and SSH traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
