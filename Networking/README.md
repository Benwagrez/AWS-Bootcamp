<!-- PROJECT LOGO -->
<br />
<div align="left">
  <a href="https://github.com/Benwagrez/AWS-200-Bootcamp/">
    <img src="../Setup/images/wmlogo.png" alt="Logo" width="540" height="100">
  </a>
</div>
<h1> AWS 200 Networking Lab </h1>

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#lab-overview">Lab Overview</a>
      <ul>
        <li><a href="#business-case">Business Case</a></li>
        <li><a href="#object-creation-overview">Object Creation Overview</a></li>
        <li><a href="#guide">Guide</a></li>
      </ul>
    </li>
  </ol>
</details>

## Lab Overview

Welcome to the Networking lab. 

### Business Case
West Monroe needs to spin up two VPCs for reasons.

### Object Creation Overview

In this lab we will create the following:
* VPC, VPC peering, AWS Transit Gateway
* One VPC will be created (in code), they will have to fill in for another VPC and for the AWS transit gateway
* Possibly explore VPC peering as an alternative

A diagram is included below for convenience:
maybe I'll make a diagram, maybe not

### Guide

Follow this guide to complete the networking lab portion of the AWS-200-bootcamp 


make sure your console view is on the correct region as well

 Initialise the configuration
terraform init -input=false
terraform fmt
terraform validate
 Plan and deploy
terraform plan -input=false -var=hostname=geekbench -var=plan=5USD -out=tfplan
terraform apply tfplan

Terraform will run the above script to benchmark the server
Find your results in the Terraform output

 Once finished, destroy the server
terraform plan -destroy -out=tfdestroy
terraform apply tfdestroy

talk about IPAM addressing for VPCs
talk about availability zones/regions

Set variable values in tfvars