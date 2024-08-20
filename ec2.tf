resource "aws_instance" "server_A" {
  ami                    = "ami-04a81a99f5ec58529"    # AMI ubuntu
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.subnet_public_A.id
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh_http_https_icmp_A.id]

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y apache2
              systemctl start apache2
              systemctl enable apache2
            EOF

  tags = {
    Name = "Server-A"
  }
}

resource "aws_instance" "server_B" {
  ami                    = "ami-04a81a99f5ec58529"    # AMI Amazon ubuntu
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.subnet_public_B.id
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh_http_https_icmp_B.id]

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y apache2
              systemctl start apache2
              systemctl enable apache2
            EOF

  tags = {
    Name = "Server-B"
  }
}

resource "aws_security_group" "allow_ssh_http_https_icmp_A" {
  name        = "allow_ssh_http_https_icmp_A"
  description = "Allow SSH, HTTP, HTTPS, and ICMP traffic"
  vpc_id      = aws_vpc.VPCA.id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow ICMP"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh_http_https_icmp_A"
  }
}

resource "aws_security_group" "allow_ssh_http_https_icmp_B" {
  name        = "allow_ssh_http_https_icmp_B"
  description = "Allow SSH, HTTP, HTTPS, and ICMP traffic"
  vpc_id      = aws_vpc.VPCB.id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow ICMP"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh_http_https_icmp_B"
  }
}
