# Variables
variable "region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "172.16.0.0/16"
}

variable "enable_dns_support" {
  default = "true"
}

variable "enable_dns_hostnames" {
  default = "true"
}

# Provider
provider "aws" {
  region = var.region
}

# Data source for Availability Zones Dynamically
data "aws_availability_zones" "available" {
  state = "available"
}

# Create VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
}

# Create Public Subnets using Count of Availability Zones
resource "aws_subnet" "public" {
  count                    =  length(data.aws_availability_zones.available.names)
  vpc_id                   = aws_vpc.main.id
  cidr_block               = cidrsubnet(var.vpc_cidr, 4, 
  count.index)
  map_public_ip_on_launch  = true
  availability_zone      = data.aws_availability_zones.available.names[count.index]
  
}