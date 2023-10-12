##############
# KEY PAIR   #
##############

resource "aws_key_pair" "aws-ds-kp" {
  key_name   = "aws-ds-keypair"
  public_key = file("~/.ssh/mtckey.pub")
}

#################
#  SSM DOCUMENT #
#################

resource "aws_ssm_document" "ad_join_domain" {
  name          = "ad-join-domain"
  document_type = "Command"
  content = jsonencode(
    {
      "schemaVersion" = "2.2"
      "description"   = "aws:domainJoin"
      "mainSteps" = [
        {
          "action" = "aws:domainJoin",
          "name"   = "domainJoin",
          "inputs" = {
            "directoryId" : aws_directory_service_directory.AD.id,
            "directoryName" : aws_directory_service_directory.AD.name
            "dnsIpAddresses" : aws_directory_service_directory.AD.dns_ip_addresses
          }
        }
      ]
    }
  )
}

resource "aws_ssm_association" "windows_server" {
  name = aws_ssm_document.ad_join_domain.name
  targets {
    key    = "tag:Name"
    values = ["EC2-Test-lab-instance"]
  }
}


#####################
##  IAM ROLES      #
####################

resource "aws_iam_role" "ad_autojoin" {
  name = "ad-autojoin"
  assume_role_policy = jsonencode(
    {
      Statement = [
        {
          Action = "sts:AssumeRole"
          Effect = "Allow"
          Principal = {
            Service = "ec2.amazonaws.com"
          }
        },
      ]
      Version = "2012-10-17"
    }
  )
}

resource "aws_iam_role_policy_attachment" "ssm-instance" {
  role       = aws_iam_role.ad_autojoin.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# required it seems
resource "aws_iam_role_policy_attachment" "ssm-ad" {
  role       = aws_iam_role.ad_autojoin.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMDirectoryServiceAccess"
}

resource "aws_iam_instance_profile" "ad_autojoin" {
  name = "ad-autojoin"
  role = aws_iam_role.ad_autojoin.name
}


###################
# SECURITY GROUPS #
###################

resource "aws_security_group" "ds-test-lab-security-group" {
  name        = "AWS-DS-Test-Lab-Security-Group"
  description = "AWS DS Test Lab Security Group"
  vpc_id      = aws_vpc.dc-vpc.id

  #Incoming traffic
  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    description = "Allow RDP connection"
    cidr_blocks = ["0.0.0.0/0"] # UPDATE BY USER MUST CHANGE THAT WITH OWN THE IP ADDRESS
  }

  #Incoming traffic
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "icmp"
    description = "icmp protocol for commands"
    cidr_blocks = ["0.0.0.0/0"]
  }


  #Incoming traffic
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    description = "All protocol - Range - MyIP = 10.0.0.0/16"
    cidr_blocks = [aws_vpc.dc-vpc.cidr_block]
  }

  #Outgoing traffic
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_security_group" "onprem-test-lab-security-group" {
  name        = "AWS-OnPrem-Test-Lab-Security-Group"
  description = "AWS OnPrem Test Lab Security Group"
  vpc_id      = aws_vpc.onprem-vpc.id

  #Incoming traffic
  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    description = "Allow RDP connection"
    cidr_blocks = ["0.0.0.0/0"] # USER MUST CHANGE THAT WITH OWN THE IP ADDRESS
  }

  #Incoming traffic
  ingress {
    from_port   = 53
    to_port     = 53
    protocol    = "tcp"
    description = "DNS"
    cidr_blocks = [aws_vpc.dc-vpc.cidr_block]
  }
  #
  #  #Incoming traffic
  #  ingress {
  #    from_port   = 88
  #    to_port     = 88
  #    protocol    = "tcp"
  #    description = "Kerberos"
  #    cidr_blocks = [aws_vpc.dc-vpc.cidr_block]
  #  }
  #
  #  #Incoming traffic
  #  ingress {
  #    from_port   = 389
  #    to_port     = 389
  #    protocol    = "tcp"
  #    description = "LDAP"
  #    cidr_blocks = [aws_vpc.dc-vpc.cidr_block]
  #  }
  #
  #  #Incoming traffic
  #  ingress {
  #    from_port   = 464
  #    to_port     = 464
  #    protocol    = "tcp"
  #    description = "Kerberos change / set password"
  #    cidr_blocks = [aws_vpc.dc-vpc.cidr_block]
  #  }
  #
  #  #Incoming traffic
  #  ingress {
  #    from_port   = 445
  #    to_port     = 445
  #    protocol    = "tcp"
  #    description = "SMB / CIFS"
  #    cidr_blocks = [aws_vpc.dc-vpc.cidr_block]
  #  }
  #
  #  #Incoming traffic
  #  ingress {
  #    from_port   = 135
  #    to_port     = 135
  #    protocol    = "tcp"
  #    description = "Replication"
  #    cidr_blocks = [aws_vpc.dc-vpc.cidr_block]
  #  }
  #
  #  #Incoming traffic
  #  ingress {
  #    from_port   = 636
  #    to_port     = 636
  #    protocol    = "tcp"
  #    description = "ldap ssl"
  #    cidr_blocks = [aws_vpc.dc-vpc.cidr_block]
  #  }
  #
  #  #  #Incoming traffic
  #  #  ingress {
  #  #    from_port   = 49152 - 65535
  #  #    to_port     = 49152 - 65535
  #  #    protocol    = "tcp"
  #  #    description = "RPC"
  #  #    cidr_blocks = [aws_vpc.aws-dc-vpc01.cidr_block]
  #  #  }
  #  #
  #  #  #Incoming traffic
  #  #  ingress {
  #  #    from_port   = 3268 - 3269
  #  #    to_port     = 3268 - 3269
  #  #    protocol    = "tcp"
  #  #    description = "LDAP GC & LDAP GC SSL"
  #  #    cidr_blocks = [aws_vpc.aws-dc-vpc01.cidr_block]
  #  #  }
  #
  #  #Incoming traffic
  #  ingress {
  #    from_port   = 123
  #    to_port     = 123
  #    protocol    = "udp"
  #    description = "windows time"
  #    cidr_blocks = [aws_vpc.dc-vpc.cidr_block]
  #  }
  #
  #  #Incoming traffic
  #  ingress {
  #    from_port   = 53
  #    to_port     = 53
  #    protocol    = "udp"
  #    description = "DNS"
  #    cidr_blocks = [aws_vpc.dc-vpc.cidr_block]
  #  }
  #
  #  #Incoming traffic
  #  ingress {
  #    from_port   = 88
  #    to_port     = 88
  #    protocol    = "udp"
  #    description = "Kerberos"
  #    cidr_blocks = [aws_vpc.dc-vpc.cidr_block]
  #  }
  #
  #  #Incoming traffic
  #  ingress {
  #    from_port   = 389
  #    to_port     = 389
  #    protocol    = "udp"
  #    description = "LDAP"
  #    cidr_blocks = [aws_vpc.dc-vpc.cidr_block]
  #  }
  #
  #  #Incoming traffic
  #  ingress {
  #    from_port   = 464
  #    to_port     = 464
  #    protocol    = "udp"
  #    description = "Kerberos change / set password"
  #    cidr_blocks = [aws_vpc.dc-vpc.cidr_block]
  #  }
  #
  #  #Incoming traffic
  #  ingress {
  #    from_port   = 0
  #    protocol    = "-1"
  #    to_port     = 0
  #    cidr_blocks = [aws_vpc.onprem-vpc.cidr_block]
  #  }

  #Outgoing traffic
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#---------------------------------------------------------------------------

