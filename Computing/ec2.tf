#################
# EC2 INSTANCE  #
#################

resource "aws_instance" "ec2_instance_windows_workstation" {
  ami                  = "ami-05912b6333beaa478"
  instance_type        = "t2.micro"
  key_name             = aws_key_pair.aws-ds-kp.key_name
  iam_instance_profile = aws_iam_instance_profile.ad_autojoin.name
  security_groups      = [aws_security_group.ds-test-lab-security-group.id]
  subnet_id            = aws_subnet.aws-ds-vpc01-subnet01.id

  associate_public_ip_address = true
  tags = {
    Name = "EC2-Test-lab-instance"
  }
}
