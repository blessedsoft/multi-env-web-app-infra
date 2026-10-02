output "alb_dns_name" {
  description = "Application load balancer DNS name."
  value       = module.compute.alb_dns_name
}
output "alb_arn" {
  description = "Application load balancer ARN."
  value       = module.compute.alb_arn
}
output "autoscaling_group_name" {
  description = "Application Auto Scaling group name."
  value       = module.compute.autoscaling_group_name
}
output "db_endpoint" {
  description = "Database endpoint."
  value       = module.database.db_endpoint
}
output "db_security_group_id" {
  description = "Database security group ID."
  value       = module.database.db_security_group_id
}
