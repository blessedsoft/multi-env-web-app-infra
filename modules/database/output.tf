output "db_endpoint" {
  description = "Database endpoint address."
  value       = aws_db_instance.db.address
}
output "db_name" {
  description = "Database name."
  value       = aws_db_instance.db.db_name
}
output "db_username" {
  description = "Database master username."
  value       = aws_db_instance.db.username
  sensitive   = true
}
output "db_security_group_id" {
  description = "Database security group ID."
  value       = aws_security_group.db.id
}
