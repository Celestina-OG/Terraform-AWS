# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc

# Create a VPC
resource "aws_vpc" "main" {

  # CIDR block for VPC.
  cidr_block = "10.0.0.0/16"

  # Makes instances on shared host.
  instance_tenancy = "default"

  # Required for EKS. This enable or disable DNS support in the VPC
  enable_dns_support = true

  # Required for EKS. Enable/disable DNS hostnames in VPC
  enable_dns_hostnames = true

  # Enable/disable IPv6 CIDR block
  assign_generated_ipv6_cidr_block = false

  tags = {
    Name = "main"
  }
}

output "vpc_id" {
  value       = aws_vpc.main.id
  description = "VPC id"
  # Setting an output value as sentitive prevents Terraform from showing its value in plan and apply
  sensitive = false
}
