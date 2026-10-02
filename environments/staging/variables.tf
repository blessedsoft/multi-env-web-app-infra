variable "name" {
  description = "Environment name prefix."
  type        = string
  default     = "staging"
}
variable "region" {
  description = "AWS region for this environment."
  type        = string
  default     = "us-east-1"
}
variable "vpc_cidr" {
  description = "CIDR block for the environment VPC."
  type        = string
  default     = "10.20.0.0/16"
}
variable "public_subnets" {
  description = "Public subnet CIDR blocks."
  type        = list(string)
  default     = ["10.20.1.0/24", "10.20.2.0/24"]
}
variable "private_subnets" {
  description = "Private subnet CIDR blocks."
  type        = list(string)
  default     = ["10.20.3.0/24", "10.20.4.0/24"]
}
variable "azs" {
  description = "Availability zones for the environment."
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}
variable "ami_id" {
  description = "AMI ID for application instances. Set this for the target AWS region."
  type        = string
}
variable "instance_type" {
  description = "EC2 instance type."
  type        = string
  default     = "t2.micro"
}
variable "asg_desired_capacity" {
  description = "Desired ASG capacity."
  type        = number
  default     = 1
}
variable "asg_min_size" {
  description = "Minimum ASG capacity."
  type        = number
  default     = 1
}
variable "asg_max_size" {
  description = "Maximum ASG capacity."
  type        = number
  default     = 2
}
variable "db_name" {
  description = "Initial database name."
  type        = string
  default     = "webapp"
}
variable "db_username" {
  description = "Database master username."
  type        = string
  sensitive   = true
}
variable "db_password" {
  description = "Database master password."
  type        = string
  sensitive   = true
}
variable "db_instance_class" {
  description = "RDS instance class."
  type        = string
  default     = "db.t3.micro"
}
variable "allocated_storage" {
  description = "RDS allocated storage in GiB."
  type        = number
  default     = 20
}
variable "engine_version" {
  description = "MySQL engine version."
  type        = string
  default     = "8.0"
}
variable "backup_retention_period" {
  description = "Automated backup retention in days."
  type        = number
  default     = 1
}
variable "tags" {
  description = "Tags applied to all resources."
  type        = map(string)
  default = {
    Project     = "caps-project"
    Environment = "staging"
    ManagedBy   = "terraform"
  }
}
