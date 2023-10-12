/* For Admin password, type the password you want to use for this account and type the password again in Confirm password. This Admin account 
is automatically created during the directory creation process. The password cannot include the word admin. The directory administrator password is case 
sensitive and must be between 8 and 64 characters in length, inclusive. It must also contain at least one character from three of the following four categories:
Lowercase letters (a-z)
Uppercase letters (A-Z)
Numbers (0-9)
Non-alphanumeric characters (~!@#$%^&*_-+=`|\(){}[]:;"'<>,.?/) */

variable "ad_password" {
  type        = string
  default     = ""  # UPDATE THIS
  description = "password ad"

}

variable "region" {
  type    = string
  default = "us-east-1"
}

#################
# VPC variables #
#################
variable "aws_ds_cidr_block" {
  type        = string
  description = "cidr block for the AWS-DS-VPC01"
  default     = "10.0.0.0/16"
}

variable "aws_onprem_cidr_block" {
  type        = string
  description = "cidr block for the AWS-ObPrem-VPC01"
  default     = "10.100.0.0/16"
}

###############################
# ACTIVE DIRECTORY variables  #
###############################

variable "active_directory_name" {
  type = string
  default = "corp.example.com"
  description = "active directory name"
}

########################
# VPC subnet variables #
########################

variable "aws_dc_sub1_cidr_block" {
  type        = string
  description = "cidr block for the AWS-DS-VPC01-Subnet01"
  default     = "10.0.0.0/24"
}

variable "aws_dc_sub02_cidr_block" {
  type        = string
  description = "cidr block for the AWS-DS-VPC01-Subnet02"
  default     = "10.0.1.0/24"
}

variable "aws_onprem_sub1_cidr_block" {
  type        = string
  description = "cidr block for the AWS-OnPrem-VPC01-Subnet01"
  default     = "10.100.0.0/24"
}

variable "aws_onprem_sub2_cidr_block" {
  type        = string
  description = "cidr block for the AWS-OnPrem-VPC01-Subnet02"
  default     = "10.100.1.0/24"
}


