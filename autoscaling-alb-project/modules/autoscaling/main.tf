resource "aws_autoscaling_group" "asg" {
  name = "devops-asg"
  desired_capacity = 3
  max_size = 4
  min_size = 2

  vpc_zone_identifier = var.private_subnets

  launch_template {
    id = var.launch_template_id
    version = "$Latest"
  }

  target_group_arns = [var.target_group_arn]
}