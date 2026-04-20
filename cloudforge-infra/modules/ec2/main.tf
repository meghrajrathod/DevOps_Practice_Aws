resource "aws_instance" "bastion" {
  ami                    = "ami-01a15dfc48279bf55"
  instance_type          = "c7i-flex.large"
  subnet_id              = var.public_subnet
  vpc_security_group_ids = [var.sg_bastion]
  key_name               = "terraform-project"

  tags = {
    Name        = "DevOps-Bastion-Windows"
    Environment = "Production"
    Project     = "AWS-3Tier-Architecture"
  }
}