resource "aws_vpc" "VPC" {
  cidr_block= var.vpccidr 
  tags = {
    Name = "Terraformvpc"
  }
}
data "aws_availability_zones" "available" {
  state = "available"
}
resource "aws_subnet" "PublicSubnetA" {
  vpc_id = aws_vpc.VPC.id
  cidr_block= var.public1
  availability_zone = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true
  
  tags = {
    Name = "Terraformpublic 1"
  }
}
resource "aws_subnet" "PublicSubnetB" {
  vpc_id = aws_vpc.VPC.id
  cidr_block= var.public2
  availability_zone = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true
  tags = {
    Name = "Terraformpublic 2"
  }
}

resource "aws_subnet" "PublicSubnetC" {
  vpc_id = aws_vpc.VPC.id
  cidr_block= var.public3
  availability_zone = data.aws_availability_zones.available.names[2]
  map_public_ip_on_launch = true
  tags = {
    Name = "Terraformpublic 3"
  }
}


resource "aws_subnet" "PrivateSubnetA" {
  vpc_id = aws_vpc.VPC.id
  cidr_block= var.private1
  availability_zone = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = false
  tags = {
    Name = "Terraformprivate 1"
  }
}


resource "aws_subnet" "PrivateSubnetB" {
 vpc_id = aws_vpc.VPC.id
  cidr_block= var.private2
  availability_zone = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = false
  tags = {
    Name = "Terraformprivate 2"
  }
}

resource "aws_subnet" "PrivateSubnetC" {
  vpc_id = aws_vpc.VPC.id
  cidr_block= var.private3
  availability_zone = data.aws_availability_zones.available.names[2]
  map_public_ip_on_launch = false
  tags = {
    Name = "Terraformprivate 3"
  }
}
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.VPC.id

  tags = {
    Name = "TerraformapplicationIGW"
  }
}
resource "aws_route_table" "PublicRoute" {
  vpc_id = aws_vpc.VPC.id
  
  tags = {
    Name = "Terraformdefaultapplication"
  }

}







