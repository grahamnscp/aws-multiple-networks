
output "aws-region" {
  value = "${var.region}"
}

# Domain
output "domainname" {
  value = "${var.route53_subdomain}.${var.route53_domain}"
}

# Instances
output "instance-public-ip" {
  value = ["${aws_instance.master.*.public_ip}"]
}
output "instance-private-ip" {
  value = ["${aws_instance.master.*.private_ip}"]
}
output "instance-public-eip" {
  value = ["${aws_eip.dc-eip.*.public_ip}"]
}

# DNS names
output "instance-name" {
  value = ["${aws_route53_record.master.*.name}"]
}

