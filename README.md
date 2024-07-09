# aws-multiple-networks
Terraform to bootstrap 3 master nodes with muliple network interfaces on same subnet

## Overview
Some sample terraform that creates 3 EC2 instances that have multiple network NICs.
Additionally master1 has a 3rd NIC that has a specific IP address assigned.

I've tested that this IP can be moved manually to the 2nd NIC on that host and can
be pinged from master(2,3) so is associated with the node not the interface.

## Configuration
The terraform uses `./tf/terraform.tfvars` (see `./tf/terraform.tfvars.example` to copy)

You will need a route53 domain and hosted zone for the subdomain and DNS entries to 
be created in, update the `route53_zone_id` and `route53_domain` variables accordingly.

## Installation
```
cd tf
terraform init
terraform plan

terraform apply -auto-approve
```

## Clean up
```
cd tf
terraform destroy -auto-approve
```

