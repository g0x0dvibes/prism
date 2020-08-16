provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "prism_c2" {
  ami                    = var.ami_id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.main_mgmt_sg.id,]
  key_name = var.key_name
  associate_public_ip_address = true

  root_block_device {
      volume_size = 10
  }

}

resource "aws_security_group" "main_mgmt_sg" {
  name        = "c2_allow_mgmt"
  description = "Allow C2 Management inbound traffic"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["71.229.254.230/32"]
  }

  ingress {
    description = "Empire"
    from_port   = 1337
    to_port     = 1337
    protocol    = "tcp"
    cidr_blocks = ["71.229.254.230/32"]
  }

  ingress {
    description = "Covenant"
    from_port   = 7443
    to_port     = 7443
    protocol    = "tcp"
    cidr_blocks = ["71.229.254.230/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "c2_allow_mgmt"
  }
}