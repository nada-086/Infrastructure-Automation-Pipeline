pipeline {
    agent any
    stages {
        stage ('Provision') {
            steps {
                dir('Terraform/') {
                    sh "terraform plan"
                    sh "terraform apply -auto-approve"
                }
            }
        }

        stage('Fetch EC2 Public IP') {
            steps {
                script {
                    def output = sh(
                        script: 'terraform -chdir=terraform output -raw ec2_public_ip',
                        returnStdout: true
                    ).trim()
                    env.EC2_PUBLIC_IP = output
                }
            }
        }

        stage ('SSH Configuration') {
            steps {
                writeFile file: 'ansible/inventory', text: """
                [web]
                ${env.EC2_PUBLIC_IP} ansible_user=ec2-user ansible_ssh_private_key_file=~/.ssh/jenkins-practice.pem
                """
            }
        }

        stage ('Configuration') {
            steps {
                dir('Ansible/') {
                    sh '''
                        cd ansible
                        ansible-playbook -i inventory playbook.yml
                    '''
                }
            }
        }

        stage ('Destruction') {
            steps {
                dir('Terraform/') {
                    echo "Destruction"
                    // sh "terraform destroy"
                }
            }
        }
    }
}