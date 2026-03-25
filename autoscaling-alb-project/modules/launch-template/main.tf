data "aws_ami" "windows" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["Windows_Server-2019-English-Full-Base-*"]
  }
}

resource "aws_launch_template" "lt" {
  image_id      = data.aws_ami.windows.id
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [var.ec2_sg_id]

  user_data = base64encode(file("${path.module}/../../userdata/install_iis.ps1"))
}