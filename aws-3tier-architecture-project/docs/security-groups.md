# 🔐 Security Groups Configuration

## ALB Security Group

* HTTP (80) → 0.0.0.0/0

---

## Bastion Security Group

* RDP (3389) → Your IP

---

## App Security Group

* HTTP (80) → ALB SG
* RDP (3389) → Bastion SG

---

## DB Security Group

* MySQL (3306) → App SG

---

## Security Strategy

* No public DB access
* Controlled EC2 access
* Layered security model

---

## Best Practices

* Avoid 0.0.0.0/0 where possible
* Use SG referencing
* Follow least privilege principle
