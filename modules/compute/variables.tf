variable "name" {
  description = "Name prefix for compute resources."
  type        = string
}
variable "vpc_id" {
  description = "ID of the application VPC."
  type        = string
}
variable "public_subnets" {
  description = "Public subnet IDs for the load balancer."
  type        = list(string)
}
variable "private_subnets" {
  description = "Private subnet IDs for application instances."
  type        = list(string)
}
variable "ami_id" {
  description = "AMI ID used by the application launch template."
  type        = string
}
variable "instance_type" {
  description = "EC2 instance type for application instances."
  type        = string
}
variable "asg_desired_capacity" {
  description = "Desired number of application instances."
  type        = number
  validation {
    condition     = var.asg_desired_capacity >= 0
    error_message = "asg_desired_capacity must be zero or greater."
  }
}
variable "asg_min_size" {
  description = "Minimum number of application instances."
  type        = number
  validation {
    condition     = var.asg_min_size >= 0
    error_message = "asg_min_size must be zero or greater."
  }
}
variable "asg_max_size" {
  description = "Maximum number of application instances."
  type        = number
  validation {
    condition     = var.asg_max_size >= var.asg_min_size
    error_message = "asg_max_size must be greater than or equal to asg_min_size."
  }
}
variable "tags" {
  description = "Common tags applied to compute resources."
  type        = map(string)
}
