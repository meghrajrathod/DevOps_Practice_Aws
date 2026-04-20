resource "aws_launch_template" "app_lt" {
  name_prefix   = "windows-app-"
  image_id      = "ami-01a15dfc48279bf55"
  instance_type = "t3.micro"
  key_name      = "terraform-project"

user_data = base64encode(<<EOF
<powershell>

Install-WindowsFeature -name Web-Server -IncludeManagementTools

$web = @"
<!DOCTYPE html>
<html>
<head>
<title>Meghraj DevOps AWS Project</title>
<style>
body {
  font-family: Arial;
  background:#0f172a;
  color:white;
  margin:0;
}
header {
  background:#1e293b;
  padding:30px;
  text-align:center;
}
h1 { color:#38bdf8; }
section {
  padding:40px;
}
.card {
  background:#1e293b;
  padding:25px;
  margin:20px 0;
  border-radius:12px;
  box-shadow:0 0 10px rgba(0,0,0,0.4);
}
ul, ol { line-height:1.8; }
footer {
  text-align:center;
  padding:20px;
  background:#020617;
  margin-top:40px;
}
</style>
</head>

<body>

<header>
<h1>🚀 AWS 3-Tier DevOps Project</h1>
<p>Designed & Deployed by Meghraj Rathod</p>
</header>

<section>

<div class="card">
<h2>📌 Project Overview</h2>
<p>
This project demonstrates a real-world production-ready AWS 3-tier architecture
built using Terraform. It includes secure networking, load balancing,
auto scaling, and domain integration.
</p>
</div>

<div class="card">
<h2>🏗 Architecture</h2>
<ul>
<li>VPC with Public & Private Subnets</li>
<li>Bastion Host (Windows)</li>
<li>Auto Scaling Group (Windows EC2)</li>
<li>Network Load Balancer</li>
<li>Route53 Domain Integration</li>
<li>NAT Gateway for private access</li>
</ul>
</div>

<div class="card">
<h2>⚙️ How This Project Works</h2>
<p>
User requests go through the domain → routed to Network Load Balancer →
forwarded to Target Group → handled by Auto Scaling EC2 instances →
served via IIS Web Server.
</p>
</div>

<div class="card">
<h2>📖 Step-by-Step Implementation</h2>
<ol>
<li>Create VPC with CIDR block</li>
<li>Setup Public & Private Subnets (Multi-AZ)</li>
<li>Configure Internet Gateway & NAT Gateway</li>
<li>Create Security Groups</li>
<li>Deploy Bastion Host</li>
<li>Setup Network Load Balancer</li>
<li>Create Target Group</li>
<li>Deploy Auto Scaling Group using Launch Template</li>
<li>Configure Route53 domain</li>
<li>Test high availability & scaling</li>
</ol>
</div>

<div class="card">
<h2>⚡ Key Features</h2>
<ul>
<li>High Availability (Multi-AZ)</li>
<li>Auto Healing (ASG replaces failed instances)</li>
<li>Scalable Infrastructure</li>
<li>Secure Access via Bastion Host</li>
<li>Infrastructure as Code using Terraform</li>
</ul>
</div>

<div class="card">
<h2>🚧 Challenges Faced</h2>
<ul>
<li>Linux vs Windows AMI confusion</li>
<li>NLB health check failures</li>
<li>IIS configuration issues</li>
<li>Terraform module dependency errors</li>
<li>Handling multiple EC2 duplication issues</li>
</ul>
</div>

<div class="card">
<h2>🛠 Tech Stack</h2>
<ul>
<li>AWS (EC2, VPC, NLB, ASG, Route53)</li>
<li>Terraform</li>
<li>Windows Server + IIS</li>
<li>PowerShell (user_data automation)</li>
</ul>
</div>

</section>

<footer>
<p>© Meghraj Rathod | DevOps Project Portfolio</p>
</footer>

</body>
</html>
"@

$web | Out-File -Encoding UTF8 C:\inetpub\wwwroot\index.html

</powershell>
EOF
)

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [var.sg_app]
  }
}

resource "aws_autoscaling_group" "asg" {
  desired_capacity = 2
  min_size         = 2
  max_size         = 4

  vpc_zone_identifier = [
    var.private_subnet_1,
    var.private_subnet_2
  ]

  launch_template {
    id      = aws_launch_template.app_lt.id
    version = "$Latest"
  }

  target_group_arns = [var.target_group_arn]

  health_check_type         = "EC2"
  health_check_grace_period = 120
}