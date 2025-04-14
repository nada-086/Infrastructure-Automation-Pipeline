# Infrastructure Automation Pipeline

## Installing Required Tools
1. [Jenkins](https://www.jenkins.io/doc/book/installing/linux/)
2. Ansible
```bash
sudo yum provides ansible
# Pick the latest version
sudo yum install ansible-x.x.x
```
Or, refer to [Ansible Documentation](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html). 
3. [Terraform](https://developer.hashicorp.com/terraform/install)

## Setting Credentials
- GitHub Token
    - From Account Settings → Developer Settings → Personal Access Tokens
    - Add to Jenkins as "Username with Password" credential
- AWS Configuration
    - Generate an AWS Access Key and Secret
    - Add both to Jenkins as "Username with Password" credential
- SSH Key Configuration
    - Create an AWS Key Pair in .pem (for Linux-Based OS) format
    - Upload it to Jenkins as a "Secret File" credential

![Jenkins Credentials](./Img/jenkins-credentials.png)

## Building the Pipeline in Jenkins
- Build a Project of Pipeline Type
- Choose SCM as Git
- Add the Repository URL
- Adding GitHub Credentials
![Pipeline Configuration](./Img/pipeline-configuration.png)

## How it Works
The Jenkins pipeline orchestrates provisioning and configuration using Terraform and Ansible in multiple stages:

### Pipeline Stages Overview:
1. Provision Infrastructure
    - Jenkins retrieves AWS credentials and runs Terraform to:
        - Set up security groups
        - Launch an EC2 instance
2. Fetch EC2 Public IP
    - Extracts the public IP from Terraform output for use in Ansible inventory

3. Configure EC2 with Ansible
    - Dynamically creates an Ansible inventory using the public IP and SSH key
    - Runs an Ansible playbook to:
        - Install Apache (HTTPD)
        - Enable and start the service
        - Add a basic HTML page

4. Destroy Infrastructure (Optional)
    - Infrastructure can be destroyed by uncommenting the `terraform destroy command`
## Folder Structure
.
├── Ansible/
│   ├── inventory          # Auto-generated inventory file
│   └── httpd.yml          # Apache web server configuration
├── Terraform/
│   ├── main.tf            # Infrastructure resources definition
│   └── variables.tf       # Input variables for the Terraform config
├── Jenkinsfile            # Jenkins pipeline configuration
└── README.md              # Project documentation
