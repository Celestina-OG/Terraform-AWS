# Resource: aws_subnet
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet

resource "aws_subnet" "public_1" {
  # VPC id  
  vpc_id = aws_vpc.main.id

  # CIDR block for the subnet
  cidr_block = "10.0.1.0/24"

  # AZ for the subnet
  availability_zone = "us-east-1a"

  # Required for EKS. Instances launched into subnet should be assigned ip addresses
  map_public_ip_on_launch = true

  # tags to assign to the resource
  tags = {
    Name                        = "public-us-east-1a"
    "kubernetes.io/cluster/eks" = "shared"
    "kubernetes.io/role/elb"    = 1
  }
}

resource "aws_subnet" "public_2" {
  # VPC id  
  vpc_id = aws_vpc.main.id

  # CIDR block for the subnet
  cidr_block = "10.0.2.0/24"

  # AZ for the subnet
  availability_zone = "us-east-1b"

  # Required for EKS. Instances launched into subnet should be assigned ip addresses
  map_public_ip_on_launch = true

  # tags to assign to the resource
  tags = {
    Name                        = "public-us-east-1b"
    "kubernetes.io/cluster/eks" = "shared"
    "kubernetes.io/role/elb"    = 1
  }
}

resource "aws_subnet" "private_1" {
  # VPC id  
  vpc_id = aws_vpc.main.id

  # CIDR block for the subnet
  cidr_block = "10.0.3.0/24"

  # AZ for the subnet
  availability_zone = "us-east-1a"

  # Required for EKS. Instances launched into subnet should be assigned ip addresses
  map_public_ip_on_launch = false

  # tags to assign to the resource
  tags = {
    Name                              = "private-us-east-1a"
    "kubernetes.io/cluster/eks"       = "shared"
    "kubernetes.io/role/internal-elb" = 1
  }
}

resource "aws_subnet" "private_2" {
  # VPC id  
  vpc_id = aws_vpc.main.id

  # CIDR block for the subnet
  cidr_block = "10.0.4.0/24"

  # AZ for the subnet
  availability_zone = "us-east-1b"

  # Required for EKS. Instances launched into subnet should be assigned ip addresses
  map_public_ip_on_launch = false

  # tags to assign to the resource
  tags = {
    Name                              = "private-us-east-1b"
    "kubernetes.io/cluster/eks"       = "shared"
    "kubernetes.io/role/internal-elb" = 1
  }
}