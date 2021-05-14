resource "aws_lb" "application-lb" {
  name               = "privx-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb-sg.id]
  subnets            = [aws_default_subnet.subnet_1.id, aws_default_subnet.subnet_2.id]
  tags = {
    Name = "PrivX-LB"
  }
}

resource "aws_lb_target_group" "app-lb-tg" {
  name        = "privx-lb-tg"
  port        = var.webserver-port
  target_type = "instance"
  vpc_id      = aws_default_vpc.default.id
  protocol    = "HTTPS"
  stickiness {
    type = "lb_cookie"
    cookie_duration = "28800"
  }
  health_check {
    enabled  = true
    interval = 30
    path     = "/role-store/api/v1/status"
    port     = var.webserver-port
    protocol = "HTTPS"
    matcher  = "200-299"
  }
  tags = {
    Name = "privx-target-group"
  }
}

resource "aws_alb_listener" "privx-listener-http" {
  load_balancer_arn = aws_lb.application-lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "redirect"
    redirect {
      port        = var.webserver-port
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_alb_listener" "privx-listener-https" {
  load_balancer_arn = aws_lb.application-lb.arn
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  port              = var.webserver-port
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate.privx-acm.arn
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app-lb-tg.arn
  }
}

resource "aws_lb_target_group_attachment" "privx-attach" {
  target_group_arn = aws_lb_target_group.app-lb-tg.arn
  target_id        = aws_instance.privx.id
  port             = var.webserver-port
}

resource "aws_lb_target_group_attachment" "privx-attach-additional" {
  count            = var.additional_privx_instance_count
  target_group_arn = aws_lb_target_group.app-lb-tg.arn
  port             = var.webserver-port
  target_id        = aws_instance.privx_1[count.index].id
}
