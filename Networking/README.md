# Networking
Follow this guide to complete the networking lab portion of the AWS-200-bootcamp 

VPC, VPC peering, AWS Transit Gateway

One VPC will be created (in code), they will have to fill in for another VPC and for the AWS transit gateway

Possibly explore VPC peering as an alternative

make sure your console view is on the correct region as well

# Initialise the configuration
terraform init -input=false
terraform fmt
terraform validate
# Plan and deploy
terraform plan -input=false -var=hostname=geekbench -var=plan=5USD -out=tfplan
terraform apply tfplan

# Terraform will run the above script to benchmark the server
# Find your results in the Terraform output

# Once finished, destroy the server
terraform plan -destroy -out=tfdestroy
terraform apply tfdestroy

talk about IPAM addressing for VPCs