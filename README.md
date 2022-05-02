
<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/Benwagrez/AWS-200-Bootcamp/blob/main/Bootcamp%20Setup/images/wmlogo.jfif">
    <img src="images/logo.png" alt="Logo" width="80" height="80">
  </a>
</div>
<h1> AWS 200 Bootcamp </h1>

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
        <li><a href="#how-to-lab">How to Lab</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Contact</a>
    </li>
  </ol>
</details>

## Getting Started

Welcome to the AWS 200 bootcamp lab component. 

### Prerequisites

Before taking this course the following Prerequisites are recommended:
* AWS 100 
* Terraform 100 

### Installation

 First, you will have to set up your lab environment, the following installs are required (you may choose your own IDE in place of VS code):

Tools needed:
* <a href="https://code.visualstudio.com/"><strong>Visual Studio Code</strong></a>
* <a href="https://www.terraform.io/downloads"><strong>Terraform</strong></a> * follow Appendix A for a guide
* <a href="https://git-scm.com/downloads"><strong>Git</strong></a> or <a href="https://desktop.github.com/"><strong>GitHub Desktop</strong></a>
* <a href="https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html"><strong>AWS CLI</strong></a> * follow Appendix B for a guide

Once these programs have been installed. This guide will help you set up your lab environment.


### How to Lab

Now that your lab environment is set up, let's talk about how this lab is designed to be executed. This lab is designed to be cloned and ready to execute. The folders listed above include the scripts and templates necessary for that section (e.g., networking lab corresponse with the networking portion of the bootcamp). For the code simplicity, we have kept main.tf and variables.tf in the parent directory. This means that terraform executions have to be performed at this level. 

The terraform scripts corresponding to each lab section are pulled into main.tf through Terraform modules. These modules are referenced to pull from pre-made templates online to be downloaded by the Terraform environment, or reference a local address to pull terraform code. In this case, the module is referencing the terrform code in the child directories. During this lab you will only have to include one module at a time, referencing only one of the lab folders. 

## Contact

For issues, contact bwagrez@westmonroe.com


## Appendix A: Installing Terraform

To install Terraform on a Windows system, download the appropriate package from the Terraform web site.

<ol>
    <li>Go to https://www.terraform.io/downloads.html.</li>
    <li>Download the applicable package to your local system.</li>
    <li>Extract the package to the folder C:\Program Files (x86).</li>
   This path is used as an example. However, you can also put the Terraform executable to any other location in your local system.
    <li>Update the path environment variable to include the folder where your Terraform executable is located.
        <ol type-"a">
            <li>Go to the Control Panel.</li>
            <li>Click System.</li>
            <li>On a Windows 10 system, click Advanced system settings. This option might vary in different versions of Windows.
                The Advanced tab of the System Properties window is displayed.</li>
            <li>Click Environment Variables near the bottom of the window.
                The Environment Variables window is displayed.</li>
            <li>In the System variables pane, click Path and then click Edit.</li>
            <li>Click New. Add the path to the folder where your Terraform executable is located.
                (e.g., C:\Terraform\terraform.exe)</li>
            <li>Click OK to save your changes and then click OK to exit the Environment Variables windows. Then click OK again to exit the System Properties window.</li>
        </ol>
    </li>
    <li>To verify your installation and check the version, launch Windows PowerShell and enter: terraform -version.
    You’ll see the Terraform version displayed in the output. For example: Terraform v0.11.8</li>
<ol>

## Appendix B: Installing AWS CLI

To install Terraform on a Windows system, download the appropriate package from the Terraform web site.

<ol>
    <li>Go to https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html.</li>
    <li>Download the applicable package to your local system.</li>
    <li>Extract the package to the folder C:\Program Files.</li>
   This path is used as an example. However, you can also put the AWS CLI content to any other location in your local system. 
    <li>Update the path environment variable to include the folder where your AWS CLI folder is located.
        <ol type-"a">
            <li>Go to the Control Panel.</li>
            <li>Click System.</li>
            <li>On a Windows 10 system, click Advanced system settings. This option might vary in different versions of Windows.
                The Advanced tab of the System Properties window is displayed.</li>
            <li>Click Environment Variables near the bottom of the window.
                The Environment Variables window is displayed.</li>
            <li>In the System variables pane, click Path and then click Edit.</li>
            <li>Click New. Add the path to the folder where your AWS CLI folder is located.
                (e.g., C:\Program Files\Amazon\AWSCLIV2\)</li>
            <li>Click OK to save your changes and then click OK to exit the Environment Variables windows. Then click OK again to exit the System Properties window.</li>
        </ol>
    </li>
    <li>To verify your installation and check the version, launch Windows PowerShell and enter: aws --version.
    You’ll see the AWS version displayed in the output. For example: aws-cli/2.6.1</li>
<ol>