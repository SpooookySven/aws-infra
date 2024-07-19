resource "aws_lb" "magrathea" {
  name               = "magrathea-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.magrathea_lb.id]
  subnets            = "${data.terraform_remote_state.vpc-network.outputs.public_subnet_ids}"

  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_listener" "magrathea_https" {
  load_balancer_arn = aws_lb.magrathea.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = data.aws_acm_certificate.sven-herrmann-lb.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.magrathea_tg.arn
  }
}

resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = aws_lb_target_group.magrathea_tg.arn
  target_id        = aws_instance.magrathea.id
  port             = 80
}

resource "aws_lb_target_group" "magrathea_tg" {
  name     = "magrathea-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.terraform_remote_state.vpc-network.outputs.vpc_id
}
