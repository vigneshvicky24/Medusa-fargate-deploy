# resource "aws_vpc" "main" {
#   cidr_block = "10.0.0.0/16"
# }

# resource "aws_subnet" "public" {
#   count                   = 2
#   cidr_block              = "10.0.${count.index}.0/24"
#   vpc_id                  = aws_vpc.main.id
#   availability_zone       = data.aws_availability_zones.available.names[count.index]
#   map_public_ip_on_launch = true
# }

# resource "aws_internet_gateway" "igw" {
#   vpc_id = aws_vpc.main.id
# }

# data "aws_availability_zones" "available" {}

# resource "aws_vpc" "main" {
#   cidr_block = "10.0.0.0/16"
# }

# resource "aws_subnet" "public" {
#   count                   = 2
#   cidr_block              = "10.0.${count.index}.0/24"
#   vpc_id                  = aws_vpc.main.id
#   availability_zone       = data.aws_availability_zones.available.names[count.index]
#   map_public_ip_on_launch = true
# }

# resource "aws_internet_gateway" "igw" {
#   vpc_id = aws_vpc.main.id
# }




data "aws_availability_zones" "available" {}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public" {
  count                   = 2
  cidr_block              = "10.0.${count.index}.0/24"
  vpc_id                  = aws_vpc.main.id
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}