provider "azurerm"{
features{}
}
resource "azurerm_resource_group" "HLSAccelerator" {
  name     = ""
  location = ""
}

locals {

  
  csv_data = csvdecode(file("C:/Users/abrar/Downloads/HLSAccelerator"))
}

#Define the Azure Policy 
#resource "azurerm_policy_definition" "example" {
 # name                = "my-policy-definition"
  #policy_type         = "Custom"
  #mode                = "All"
  #display_name        = "my-policy-definition"
  #management_group_id = azurerm_management_group.example.group_id

  #Variable count 
#management groups needed to be deployed ahead of time 

#Assign the azure policy to the scope 

#test
resource "azurerm_policy_assignment" "policy_assignment" {
  name                 = "Cis-Benchmar-Policyset"
  scope                = "d41c4640-a37e-431b-9788-609668213f2f" 
  policy_definition_id = "/providers/Microsoft.Authorization/policySetDefinitions/c3f5c4d9-9a1d-4a99-85c0-7f93e384d5c5"

  description          = "enforcing compliance CIS Benchmark auditing"
  display_name         = "enforcing compliance CIS Benchmark auditing"

}
# for each 
#variables with more details 


## Parameters 
#parameters = <<PARAMETERS
#{
 # "effect-aa633080-8b72-40c4-a2d7-d00c03e80bed":{
  #  "value": "AuditIfNotExists"
  #}
#}
#PARAMETERS

# 



## Separate the CSV with list of inititives that we deploy 