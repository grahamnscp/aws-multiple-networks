# vpc.tf

# VPC
resource "aws_vpc" "dc-vpc" {
  cidr_block           = "${var.vpcCIDRblock}"
  instance_tenancy     = "${var.instanceTenancy}"
  enable_dns_support   = "${var.dnsSupport}"
  enable_dns_hostnames = "${var.dnsHostNames}"

  tags = {
    Name = "${var.prefix}_vpc_${random_string.suffix.result}"
  }
}

# Subnet
resource "aws_subnet" "dc-subnet" {
  vpc_id                  = "${aws_vpc.dc-vpc.id}"
  cidr_block              = "${var.subnetCIDRblock}"
  map_public_ip_on_launch = "${var.mapPublicIP}"

  availability_zone = "${var.availability_zone}"

  tags = {
    Name = "${var.prefix}_subnet_${random_string.suffix.result}"
  }
}

# Gateway
resource "aws_internet_gateway" "dc-gateway" {
  vpc_id = "${aws_vpc.dc-vpc.id}"

  tags = {
    Name = "${var.prefix}_gateway_${random_string.suffix.result}"
  }
}

# Route
resource "aws_route_table" "dc-route" {
  vpc_id = "${aws_vpc.dc-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.dc-gateway.id}"
  }

  tags = {
    Name = "${var.prefix}_route_${random_string.suffix.result}"
  }
}

# Associate Route to Subnet
resource "aws_route_table_association" "dc-subnet-route" {
  subnet_id      = "${aws_subnet.dc-subnet.id}"
  route_table_id = "${aws_route_table.dc-route.id}"
}
