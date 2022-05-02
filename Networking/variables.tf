# use this file to call parent variables into the child module
variable "region" {
} 
# Since region is initialized here and pushed to the module in main.tf
# this child directory/module can use this variable