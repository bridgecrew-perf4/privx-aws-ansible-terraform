# Create SG for LB, only TCP/80,TCP/443 and outbound access
resource "aws_security_group" "lb-sg" {
  name        = "lb-sg"
  description = "Allow 443 and traffic to Jenkins SG"
  vpc_id      = aws_default_vpc.default.id
  ingress {
    from_port   = var.webserver-port
    to_port     = var.webserver-port
    protocol    = "tcp"
    description = "Allow 443 from anywhere"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    description = "Allow 80 from anywhere"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "privx-db" {
  vpc_id = aws_default_vpc.default.id

  ingress {
    cidr_blocks = [aws_default_vpc.default.cidr_block]
    from_port   = 5432
    protocol    = "tcp"
    to_port     = 5432
  }
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name      = "PRIVXDB"
    Terraform = "True"
  }
}

resource "aws_security_group" "privx-redis" {
  vpc_id = aws_default_vpc.default.id

  ingress {
    cidr_blocks = [aws_default_vpc.default.cidr_block]
    from_port   = 6379
    protocol    = "tcp"
    to_port     = 6379
  }
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name      = "PRIVXREDIS"
    Terraform = "True"
  }
}

resource "aws_security_group" "privx" {
  vpc_id = aws_default_vpc.default.id

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
  }
  ingress {
    from_port       = var.webserver-port
    protocol        = "tcp"
    to_port         = var.webserver-port
    security_groups = [aws_security_group.lb-sg.id]
  }
  ingress {
    cidr_blocks = [aws_default_vpc.default.cidr_block]
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
  }
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name      = "PRIVX"
    Terraform = "True"
  }
}
