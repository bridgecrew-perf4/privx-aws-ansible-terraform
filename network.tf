resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_default_subnet" "subnet_1" {
  availability_zone = join("", [var.region, "a"])
}

resource "aws_default_subnet" "subnet_2" {
  availability_zone = join("", [var.region, "b"])
}
