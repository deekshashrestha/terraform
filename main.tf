provider "aws" {
  region = "ap-south-1"
}

resource "aws_key_pair" "web_key" {
  key_name   = "web-key"
  public_key = file("C:/Users/diksha.Shrestha/.ssh/id_rsa.pub")
}

resource "aws_instance" "web" {
  ami           = "ami-0e53db6c5f29a338b"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.web_key.key_name
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = file("user-data.sh")

  tags = {
    Name = "SimpleWebServer"
  }
}

resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Allow HTTP and SSH"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
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
