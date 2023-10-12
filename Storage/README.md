#Storage lab

prerequisites:

<u>Terraform:</u>

windows: https://www.youtube.com/watch?v=Cn6xYf0QJME

macOS: https://www.youtube.com/watch?v=q4WNdNtsuyE


<u>AWS cli:</u>

windows: https://www.youtube.com/watch?v=jCHOsMPbcV0

macOS: https://www.youtube.com/watch?v=vefyYGn9C00


<u>VSCode (feel free to use any editor that you would like):</u>

windows: https://www.youtube.com/watch?v=MlIzFUI1QGA

macOs: https://www.youtube.com/watch?v=tCfbi5PF1y0



<u>The terraform commands that we will use are:</u>

terraform fmt ; to format the files
terraform validate ; to validate the files
terraform init ; to initialize-config files
terraform plan ; to see what the deployment is going to look like (take a look of the implementation)
terraform apply ; to apply changes and deploy

1) navigate to directory where you have the .tf files, and at the terminal type "aws configure". 
2) enter information:
    AWS Access Key ID [****************YPHZ]: "your own AK" 
    AWS Secret Access Key [****************YXo2]: "your own SK" 
    Location: "enter location - region" 
    JSON: EMPTY (press enter)

3) open and modify everything that has the "# USER UPDATE"
    At the resource:aws_iam_role.s3-role -> managed_policy_arns[] ; you can uncomment each-all of the policy and deploy them. (you can play around with them)
    At the data:aws_iam_policy_document.s3_bucket_policy -> actions[] ; you can add <b>100+</b> inline policies and deplay. Note that we can use wildcharacters such as "", to get all policies that start with "Delete"


