resource "aws_directory_service_directory" "AD" {
  name        = var.active_directory_name
  description = "AWS DS Managed"
  password    = var.ad_password
  edition     = "Standard"
  type        = "MicrosoftAD"

  vpc_settings {
    vpc_id     = aws_vpc.dc-vpc.id
    subnet_ids = [aws_subnet.aws-ds-vpc01-subnet01.id, aws_subnet.aws-ds-vpc01-subnet02.id]
  }

  tags = {
    Project = "AD-test"
  }


}
