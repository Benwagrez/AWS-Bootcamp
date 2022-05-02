
<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/othneildrew/Best-README-Template">
    <img src="images/logo.png" alt="Logo" width="80" height="80">
  </a>
</div>
# West Monroe AWS 200

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
* Visual Studio Code
* Terraform
* Git or GitHub Desktop
* AWS CLI

Once these programs have been installed. This guide will help you set up your lab environment.


### How to Lab

Now that your lab environment is set up, let's talk about how this lab is designed to be executed. This lab is designed to be cloned and ready to execute. The folders listed above include the scripts and templates necessary for that section (e.g., networking lab corresponse with the networking portion of the bootcamp). For the code simplicity, we have kept main.tf and variables.tf in the parent directory. This means that terraform executions have to be performed at this level. 

The terraform scripts corresponding to each lab section are pulled into main.tf through Terraform modules. These modules are referenced to pull from pre-made templates online to be downloaded by the Terraform environment, or reference a local address to pull terraform code. In this case, the module is referencing the terrform code in the child directories. During this lab you will only have to include one module at a time, referencing only one of the lab folders. 

## Contact

For issues, contact bwagrez@westmonroe.com