# Testing VPC creation

resource "aws_vpc" "demoVPC" {
  cidr_block = "200.0.0.0/16"
  tags {
    Name = "ecsDemoVPC" 
  }
}

## gateway for publich subnet
resource "aws_internet_gateway" "demoIG" {
  vpc_id = "${aws_vpc.demoVPC.id}"
  tags {
    Name = "ecsDemoIG"
  }
}

# public subnet
resource "aws_subnet" "demoPubSN0-0" {
  vpc_id = "${aws_vpc.demoVPC.id}"
  cidr_block = "200.0.0.0/24"
  availability_zone = "us-east-1a"
  tags {
    Name = "ecsDemoPubSN0-0"
  }
}

# routing table
resource "aws_route_table" "demoPubSN0-0RT" {
  vpc_id = "${aws_vpc.demoVPC.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.demoIG.id}"
  }

  tags {
    Name = "demoPubSN0-0RT"
  }
}

# associate the routing table to public subnet
resource "aws_route_table_association" "demoPubSN0-0RTAssn" {
  subnet_id = "${aws_subnet.demoPubSN0-0.id}"
  route_table_id = "${aws_route_table.demoPubSN0-0RT.id}"
}
