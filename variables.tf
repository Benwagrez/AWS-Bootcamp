# Change varialbe values in terraform.tfvars > better practice in-case multiple users are using the same terraform files
variable "region" {
  default = "us-west-2"
}

variable "default_tags" { 
  type = map(string)
  default = { 
    project     = "test",
    env         = "test",
    owner       = "YourLastName/AA"
    Key         = "DoNotChangeThis"
  } 
}