data "aws_ami" "windows" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["Windows_Server-2019-English-Full-Base-*"]
  }
}

resource "aws_instance" "this" {
  ami                         = data.aws_ami.windows.id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.sg_id]
  key_name                    = var.key_name
  associate_public_ip_address = true

  user_data = <<-EOF
              <powershell>
              Install-WindowsFeature -name Web-Server -IncludeManagementTools

              Invoke-WebRequest -Uri https://www.apachelounge.com/download/VC15/binaries/httpd-2.4.57-win64-VS17.zip -OutFile C:\\apache.zip
              Expand-Archive -Path C:\\apache.zip -DestinationPath C:\\
              </powershell>
              EOF

  tags = {
    Name = "dev-windows-server"
  }
}