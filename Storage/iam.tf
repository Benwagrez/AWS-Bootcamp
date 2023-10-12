
###### IAM policy role - to grant or give permitions to the user account ################

resource "aws_iam_role" "s3-role" {
  assume_role_policy = jsonencode(
    {
      Statement = [
        {
          Action    = "sts:AssumeRole"
          Effect    = "Allow"
          Principal = {
            Service = "s3.amazonaws.com"
          }
        },
      ]
      Version = "2012-10-17"
    }
  )

  # USER UPDATE
  managed_policy_arns   = [
#    #"arn:aws:iam::aws:policy/AmazonS3FullAccess",
#    "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess",
#    "arn:aws:iam::aws:policy/AmazonS3OutpostsFullAccess",
#    "arn:aws:iam::aws:policy/service-role/AmazonS3ObjectLambdaExecutionRolePolicy",
#    "arn:aws:iam::aws:policy/AmazonS3OutpostsReadOnlyAccess",

  ]
}

#### Inline policy generator ########
resource "aws_s3_bucket_policy" "s3_bucket_policy" {
  bucket = aws_s3_bucket.s3_bucket_storage_lab.id
  policy = data.aws_iam_policy_document.s3_bucket_policy.json
}

data "aws_iam_policy_document" "s3_bucket_policy" {
  statement {
    principals {
      type = "AWS"
      identifiers = ["*"]
    }

    # USER UPDATE
    actions = [
      #"s3:GetObject",
      #"s3:Get*",
      #"s3:ListBucket",
    ]

    resources = [
      aws_s3_bucket.s3_bucket_storage_lab.arn,
      "${aws_s3_bucket.s3_bucket_storage_lab.arn}/*",
    ]
  }
}