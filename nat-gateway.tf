# Resource: aws_nat_gateway
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway

resource "aws_nat_gateway" "gw1" {
  # Allocation ID of the Elastic IP address for the gateway
  allocation_id = aws_eip.nat1.id

  # Subnet ID of the subnet in which to place the internet-gateway
  subnet_id = aws_subnet.public_1.id

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.main]

  # Tags to assign to the resource
  tags = {
    Name = "NAT 1"
  }
}

resource "aws_nat_gateway" "gw2" {
  # Allocation ID of the Elastic IP address for the gateway
  allocation_id = aws_eip.nat2.id

  # Subnet ID of the subnet in which to place the internet-gateway
  subnet_id = aws_subnet.public_2.id

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.main]

  # Tags to assign to the resource
  tags = {
    Name = "NAT 2"
  }
}