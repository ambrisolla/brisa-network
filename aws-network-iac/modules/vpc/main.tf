resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "${var.vpc_name}-${var.environment}-vpc"
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "aws_subnet" "public" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.vpc_name}-${var.environment}-public-subnet-${count.index + 1}"
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "aws_subnet" "private" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]

  tags = {
    Name        = "${var.vpc_name}-${var.environment}-private-subnet-${count.index + 1}"
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name        = "${var.vpc_name}-${var.environment}-igw"
    Environment = var.environment
    Project     = var.project_name
  }
}

//resource "aws_nat_gateway" "this" {
//  count         = var.enable_nat_gateway ? length(var.public_subnet_cidrs) : 0
//  allocation_id = aws_eip.nat[count.index].id
//  subnet_id     = aws_subnet.public[count.index].id
//
//  tags = {
//    Name        = "${var.vpc_name}-${var.environment}-nat-${count.index + 1}"
//    Environment = var.environment
//    Project     = var.project_name
//  }
//}

resource "aws_eip" "nat" {
  count      = var.enable_nat_gateway ? length(var.public_subnet_cidrs) : 0

  tags = {
    Name        = "${var.vpc_name}-${var.environment}-eip-${count.index + 1}"
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name        = "${var.vpc_name}-${var.environment}-public-rt"
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  count  = length(aws_subnet.private)
  vpc_id = aws_vpc.this.id

  tags = {
    Name        = "${var.vpc_name}-${var.environment}-private-rt-${count.index + 1}"
    Environment = var.environment
    Project     = var.project_name
  }
}

//resource "aws_route" "private_nat_gateway" {
//  count                  = var.enable_nat_gateway ? length(aws_route_table.private) : 0
//  route_table_id         = aws_route_table.private[count.index].id
//  destination_cidr_block = "0.0.0.0/0"
//  nat_gateway_id         = aws_nat_gateway.this[count.index].id
//}

resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}
