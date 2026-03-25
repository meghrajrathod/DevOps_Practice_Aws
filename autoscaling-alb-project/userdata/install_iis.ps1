<powershell>
# Install IIS Web Server
Install-WindowsFeature -name Web-Server -IncludeManagementTools

# Get EC2 Private IP from AWS Metadata
$ip = Invoke-RestMethod -Uri http://169.254.169.254/latest/meta-data/local-ipv4

# Create simple HTML page showing which EC2 handled the request
$html = "<h1>Handled by EC2: $ip</h1>"

# Write HTML to IIS default root folder
Set-Content -Path "C:\inetpub\wwwroot\index.html" -Value $html
</powershell>