resource "aws_vpc" "cl_ir_ml_hackathon_vpc" {
  provider = aws.account-585543526779-eu-west-1

  cidr_block         = var.cl_ir_ml_hackathon_vpc_cidr
  instance_tenancy   = var.cl_ir_ml_hackathon_vpc_tenancy
  enable_dns_support = var.cl_ir_ml_hackathon_vpc_dns_enabled
  enable_network_address_usage_metrics = var.cl_ir_ml_hackathon_vpc_network_metrics_enabled
  enable_dns_hostnames = var.cl_ir_ml_hackathon_vpc_dns_hostnames_enabled
  tags = merge(
    local.tags,
    {
      "Name" = format("cl-hackathon-aws-forecast-%s",local.environment[terraform.workspace])
    }
  )
}

resource "aws_subnet" "cl_ir_ml_hackathon_vpc_subnet_public_a" {
  provider = aws.account-585543526779-eu-west-1

  vpc_id     = aws_vpc.cl_ir_ml_hackathon_vpc.id
  cidr_block = var.cl_ir_ml_hackathon_vpc_subet_public_a_cidr

  tags = merge(
    local.tags,
    {
      "Name" = format("cl-hackathon-public-a-%s",local.environment[terraform.workspace])
    }
  )
}

resource "aws_subnet" "cl_ir_ml_hackathon_vpc_subnet_public_b" {
  provider = aws.account-585543526779-eu-west-1

  vpc_id     = aws_vpc.cl_ir_ml_hackathon_vpc.id
  cidr_block = var.cl_ir_ml_hackathon_vpc_subet_public_b_cidr

  tags = merge(
    local.tags,
    {
      "Name" = format("cl-hackathon-public-b-%s",local.environment[terraform.workspace])
    }
  )
}

resource "aws_subnet" "cl_ir_ml_hackathon_vpc_subnet_middleware_a" {
  provider = aws.account-585543526779-eu-west-1

  vpc_id     = aws_vpc.cl_ir_ml_hackathon_vpc.id
  cidr_block = var.cl_ir_ml_hackathon_vpc_subet_middleware_a_cidr

  tags = merge(
    local.tags,
    {
      "Name" = format("cl-hackathon-middleware-a-%s",local.environment[terraform.workspace])
    }
  )
}


resource "aws_subnet" "cl_ir_ml_hackathon_vpc_subnet_middleware_b" {
  provider = aws.account-585543526779-eu-west-1

  vpc_id     = aws_vpc.cl_ir_ml_hackathon_vpc.id
  cidr_block = var.cl_ir_ml_hackathon_vpc_subet_middleware_b_cidr

  tags = merge(
    local.tags,
    {
      "Name" = format("cl-hackathon-middleware-b-%s",local.environment[terraform.workspace])
    }
  )
}

resource "aws_subnet" "cl_ir_ml_hackathon_vpc_subnet_private_a" {
  provider = aws.account-585543526779-eu-west-1

  vpc_id     = aws_vpc.cl_ir_ml_hackathon_vpc.id
  cidr_block = var.cl_ir_ml_hackathon_vpc_subet_private_a_cidr

  tags = merge(
    local.tags,
    {
      "Name" = format("cl-hackathon-private-a-%s",local.environment[terraform.workspace])
    }
  )
}

resource "aws_subnet" "cl_ir_ml_hackathon_vpc_subnet_private_b" {
  provider = aws.account-585543526779-eu-west-1

  vpc_id     = aws_vpc.cl_ir_ml_hackathon_vpc.id
  cidr_block = var.cl_ir_ml_hackathon_vpc_subet_private_b_cidr

  tags = merge(
    local.tags,
    {
      "Name" = format("cl-hackathon-private-b-%s",local.environment[terraform.workspace])
    }
  )
}


resource "aws_eip" "cl_ir_ml_hackathon_vpc_public_natgateway_eip" {
  provider = aws.account-585543526779-eu-west-1

  vpc      = true
  tags = merge(
    local.tags,
    {
      "Name" = format("cl-hackathon-private-natgw-%s",local.environment[terraform.workspace])
    }
  )
}

resource "aws_internet_gateway" "cl_ir_ml_hackathon_vpc_internet_gateway" {
  provider = aws.account-585543526779-eu-west-1

  vpc_id = aws_vpc.cl_ir_ml_hackathon_vpc.id
  tags = merge(
    local.tags,
    {
      "Name" = format("cl-hackathon-igw-%s",local.environment[terraform.workspace])
    }
  )
}

resource "aws_nat_gateway" "cl_ir_ml_hackathon_vpc_public_natgateway" {
  provider = aws.account-585543526779-eu-west-1

  allocation_id = aws_eip.cl_ir_ml_hackathon_vpc_public_natgateway_eip.id
  subnet_id     = aws_subnet.cl_ir_ml_hackathon_vpc_subnet_public_a.id


  tags = merge(
    local.tags,
    {
      "Name" = format("cl-hackathon-private-nat-gateway-%s",local.environment[terraform.workspace])
    }
  )
  depends_on = [aws_internet_gateway.cl_ir_ml_hackathon_vpc_internet_gateway]
}

resource "aws_route_table" "cl_ir_ml_hackathon_vpc_public_route_table" {
  provider = aws.account-585543526779-eu-west-1

  vpc_id = aws_vpc.cl_ir_ml_hackathon_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.cl_ir_ml_hackathon_vpc_internet_gateway.id
  }

  tags = merge(
    local.tags,
    {
      "Name" = format("cl-hackathon-public-%s",local.environment[terraform.workspace])
    }
  )
}

resource "aws_route_table" "cl_ir_ml_hackathon_vpc_private_route_table" {
  provider = aws.account-585543526779-eu-west-1

  vpc_id = aws_vpc.cl_ir_ml_hackathon_vpc.id

  tags = merge(
    local.tags,
    {
      "Name" = format("cl-hackathon-private-%s",local.environment[terraform.workspace])
    }
  )
}

resource "aws_route_table" "cl_ir_ml_hackathon_vpc_middleware_route_table" {
  provider = aws.account-585543526779-eu-west-1

  vpc_id = aws_vpc.cl_ir_ml_hackathon_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.cl_ir_ml_hackathon_vpc_public_natgateway.id
  }

  tags = merge(
    local.tags,
    {
      "Name" = format("cl-hackathon-middleware-%s",local.environment[terraform.workspace])
    }
  )
}

resource "aws_route_table_association" "cl_ir_ml_hackathon_vpc_middleware_a_route_table_association" {
  subnet_id = "subnet-00679a4c859ea878f"
  route_table_id = aws_route_table.cl_ir_ml_hackathon_vpc_middleware_route_table.id
}

resource "aws_route_table_association" "cl_ir_ml_hackathon_vpc_private_a_route_table" {
  subnet_id = "subnet-0569af36b7df0901e"
  route_table_id = aws_route_table.cl_ir_ml_hackathon_vpc_private_route_table.id
}

resource "aws_route_table_association" "cl_ir_ml_hackathon_vpc_public_a_route_table" {
  subnet_id = "subnet-0219d762393daf4c6"
  route_table_id = aws_route_table.cl_ir_ml_hackathon_vpc_public_route_table.id
}

resource "aws_route_table_association" "cl_ir_ml_hackathon_vpc_middleware_b_route_table_association" {
  subnet_id = "subnet-035678a6adbb98300"
  route_table_id = aws_route_table.cl_ir_ml_hackathon_vpc_middleware_route_table.id
}

resource "aws_route_table_association" "cl_ir_ml_hackathon_vpc_private_b_route_table" {
  subnet_id = "subnet-06ae0110002c0c5aa"
  route_table_id = aws_route_table.cl_ir_ml_hackathon_vpc_private_route_table.id
}

resource "aws_route_table_association" "cl_ir_ml_hackathon_vpc_public_b_route_table" {
  subnet_id = "subnet-0219d762393daf4c6"
  route_table_id = aws_route_table.cl_ir_ml_hackathon_vpc_public_route_table.id
}

