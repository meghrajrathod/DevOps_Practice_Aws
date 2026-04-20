resource "aws_lb" "nlb" {
  name = "main-nlb"
  load_balancer_type = "network"
  subnets = var.subnets
}

resource "aws_lb_target_group" "tg" {
  port = 80
  protocol = "TCP"
  vpc_id = var.vpc_id
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.nlb.arn
  port = 80
  protocol = "TCP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}