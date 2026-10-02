resource "aws_security_group" "app" {
  name        = "${var.name}-app-sg"
  description = "Allow web traffic to the application tier."
  vpc_id      = var.vpc_id
  ingress {
    description = "HTTP from the internet through the load balancer."
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(var.tags, { Name = "${var.name}-app-sg" })
}

resource "aws_lb" "app" {
  name               = "${var.name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.app.id]
  subnets            = var.public_subnets
  tags               = merge(var.tags, { Name = "${var.name}-alb" })
}

resource "aws_lb_target_group" "app" {
  name     = "${var.name}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {
    path = "/"
  }
  tags = merge(var.tags, { Name = "${var.name}-tg" })
}

resource "aws_lb_listener" "app" {
  load_balancer_arn = aws_lb.app.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}

resource "aws_launch_template" "app" {
  name_prefix   = "${var.name}-app-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [aws_security_group.app.id]
  }
  user_data = base64encode(<<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    echo "Hello from ${var.name}" > /var/www/html/index.html
    systemctl enable --now httpd
  EOF
  )
  tags = merge(var.tags, { Name = "${var.name}-launch-template" })
}

resource "aws_autoscaling_group" "app" {
  desired_capacity    = var.asg_desired_capacity
  max_size            = var.asg_max_size
  min_size            = var.asg_min_size
  vpc_zone_identifier = var.private_subnets
  target_group_arns   = [aws_lb_target_group.app.arn]
  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }
  tag {
    key                 = "Name"
    value               = "${var.name}-app-instance"
    propagate_at_launch = true
  }
}
