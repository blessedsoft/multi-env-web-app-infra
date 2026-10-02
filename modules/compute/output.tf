output "alb_dns_name" {
  description = "DNS name of the application load balancer."
  value       = aws_lb.app.dns_name
}
output "alb_arn" {
  description = "ARN of the application load balancer."
  value       = aws_lb.app.arn
}
output "target_group_arn" {
  description = "ARN of the application target group."
  value       = aws_lb_target_group.app.arn
}
output "autoscaling_group_name" {
  description = "Name of the application Auto Scaling group."
  value       = aws_autoscaling_group.app.name
}
output "app_security_group_id" {
  description = "Security group ID used by the application tier."
  value       = aws_security_group.app.id
}
