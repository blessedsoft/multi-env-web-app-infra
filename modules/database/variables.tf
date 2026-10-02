variable "name" {
  description = "Name prefix for database resources."
  type        = string
}
variable "vpc_id" {
  description = "ID of the application VPC."
  type        = string
}
variable "private_subnets" {
  description = "Private subnet IDs for the database subnet group."
  type        = list(string)
}
variable "app_security_group_id" {
  description = "Security group ID allowed to connect to the database."
  type        = string
}
variable "db_name" {
  description = "Initial database name."
  type        = string
  validation {
    condition     = can(regex("^[A-Za-z][A-Za-z0-9_]*$", var.db_name))
    error_message = "db_name must start with a letter and contain only letters, numbers, and underscores."
  }
}
variable "db_username" {
  description = "Master username for the database."
  type        = string
  sensitive   = true
}
variable "db_password" {
  description = "Master password for the database."
  type        = string
  sensitive   = true
  validation {
    condition     = length(var.db_password) >= 8
    error_message = "db_password must be at least 8 characters long."
  }
}
variable "db_instance_class" {
  description = "RDS instance class."
  type        = string
}
variable "allocated_storage" {
  description = "Allocated database storage in GiB."
  type        = number
  validation {
    condition     = var.allocated_storage >= 20
    error_message = "allocated_storage must be at least 20 GiB."
  }
}
variable "engine_version" {
  description = "MySQL engine version."
  type        = string
}
variable "backup_retention_period" {
  description = "Number of days to retain automated backups."
  type        = number
  validation {
    condition     = var.backup_retention_period >= 0 && var.backup_retention_period <= 35
    error_message = "backup_retention_period must be between 0 and 35 days."
  }
}
variable "tags" {
  description = "Common tags applied to database resources."
  type        = map(string)
}
