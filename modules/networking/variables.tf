variable "name" {
  description = "Name prefix for networking resources."
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "vpc_cidr must be a valid IPv4 CIDR block."
  }
}

variable "public_subnets" {
  description = "CIDR blocks for public subnets."
  type        = list(string)
  validation {
    condition     = length(var.public_subnets) > 0 && alltrue([for cidr in var.public_subnets : can(cidrhost(cidr, 0))])
    error_message = "public_subnets must contain at least one valid IPv4 CIDR block."
  }
}

variable "private_subnets" {
  description = "CIDR blocks for private subnets."
  type        = list(string)
  validation {
    condition     = length(var.private_subnets) > 0 && alltrue([for cidr in var.private_subnets : can(cidrhost(cidr, 0))])
    error_message = "private_subnets must contain at least one valid IPv4 CIDR block."
  }
}

variable "azs" {
  description = "Availability zones used by the subnets."
  type        = list(string)
  validation {
    condition     = length(var.azs) >= length(var.public_subnets) && length(var.azs) >= length(var.private_subnets)
    error_message = "azs must include an entry for every subnet."
  }
}

variable "tags" {
  description = "Common tags applied to networking resources."
  type        = map(string)
}
