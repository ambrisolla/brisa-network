variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "Name tag for the VPC"
  type        = string
}

variable "project_name" {
  description = "Nome do projeto"
  type        = string
}

variable "environment" {
  description = "Ambiente (ex: dev, staging, prod)"
  type        = string
}


variable "public_subnet_cidrs" {
  description = "Lista de CIDRs para sub-redes públicas"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "Lista de CIDRs para sub-redes privadas"
  type        = list(string)
}

variable "azs" {
  description = "Lista de zonas de disponibilidade"
  type        = list(string)
}

variable "enable_nat_gateway" {
  description = "Habilitar NAT Gateway"
  type        = bool
  default     = true
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}