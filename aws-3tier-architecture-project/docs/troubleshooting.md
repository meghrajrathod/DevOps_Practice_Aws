# 🛠️ Troubleshooting Guide

## 1. Target Group Unhealthy

### Cause:

* IIS not installed
* Port 80 blocked

### Fix:

* Install IIS
* Allow HTTP in SG and Windows Firewall

---

## 2. Cannot Access EC2

### Cause:

* Wrong subnet
* SG misconfiguration

### Fix:

* Use Bastion host
* Check RDP rules

---

## 3. ALB Not Working

### Cause:

* Target group misconfigured

### Fix:

* Check health check path `/`
* Verify instance registration

---

## 4. Cannot Connect to RDS

### Cause:

* DB SG blocking access

### Fix:

* Allow MySQL (3306) from App SG

---

## 5. MySQL Command Not Found

### Cause:

* PATH not set

### Fix:

* Add MySQL bin to environment variables

---

## 6. NAT Gateway Issues

### Cause:

* Wrong route table

### Fix:

* Ensure private subnet uses NAT route

---

## 7. General Debug Tips

* Use curl for testing
* Check logs
* Validate security groups carefully
