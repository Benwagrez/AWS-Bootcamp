#Compute lab

<b>This lab creates a EC2 instance with an Active directory attached</b>

<b>Portal implementation: https://docs.aws.amazon.com/directoryservice/latest/admin-guide/ms_ad_tutorial_test_lab_base.html</b>

<b>Terraform implementation and deployment</b>

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

4) run the terraform commands above

5) after deployment, go and verify that the resources have been deployed 

6) at the portal, open the ec2 instance and click "connect"

7) at the tab "Session Manager" at the 2. click the "AWS System Manager Quick setup" and follow instructions

8) after setting up Session manager, click connect to open the terminal

9) enter the command net user Administrator "Password"

10) close terminal afte the command has been successfull 

11) Go at the second tab "RDP client"

12) click "Download remote desktop file"

13) Run file you downloaded -> enter the password that you created on the terminal -> connect to the instance 

