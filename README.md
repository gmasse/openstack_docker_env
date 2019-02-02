# Deploy a Linux (Ubuntu) development environment based on OVH Public Cloud and Terraform

- git clone ...
- mv to the directory
- copy your openrc.sh
- source openrc.sh
- terraform init
- terraform apply -auto-approve -var zone=iac.ovh
- ssh -o "UserKnownHostsFile=/dev/null" -o "StrictHostKeyChecking=no" ubuntu@IP.IP.IP.IP
- have fun :metal:
- terraform destroy -auto-approve -var zone=iac.ovh
