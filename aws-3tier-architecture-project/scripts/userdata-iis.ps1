<powershell>

# Install IIS (Web Server)

Install-WindowsFeature -name Web-Server -IncludeManagementTools

# Start IIS Service

Start-Service W3SVC

# Allow HTTP (Port 80) in Windows Firewall

New-NetFirewallRule -DisplayName "Allow HTTP Port 80" -Direction Inbound -Protocol TCP -LocalPort 80 -Action Allow

# Create Custom HTML Page

$html = @"

<!DOCTYPE html>

<html>
<head>
    <title>My AWS App Server</title>
    <style>
        body {
            background-color: #0f172a;
            color: #22c55e;
            text-align: center;
            font-family: Arial;
            margin-top: 100px;
        }
        h1 {
            font-size: 50px;
        }
        p {
            font-size: 20px;
        }
    </style>
</head>
<body>
    <h1>🚀 App Server Running</h1>
    <p>This is a private EC2 behind Load Balancer</p>
</body>
</html>
"@

# Replace Default IIS Page

Set-Content -Path "C:\inetpub\wwwroot\index.html" -Value $html

# Restart IIS to apply changes

iisreset

</powershell>
