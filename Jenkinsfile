pipeline {
    agent any
    environment {
        TF_DIR = 'Terraform'
    }
    stages {
        stage('Provision') {
            steps {
                echo "INFO: Provisioning Started"
                withCredentials([usernamePassword(
                    credentialsId: 'aws_config',
                    usernameVariable: 'AWS_ACCESS_KEY_ID',
                    passwordVariable: 'AWS_SECRET_ACCESS_KEY'
                )]) {
                    dir("${TF_DIR}") {
                        sh '''
                            export TF_VAR_access_key=$AWS_ACCESS_KEY_ID
                            export TF_VAR_secret_key=$AWS_SECRET_ACCESS_KEY

                            terraform init
                            terraform apply -auto-approve
                        '''
                    }
                }
                echo "INFO: Provisioning Finished"
            }
        }

        stage('Fetch EC2 Public IP') {
            steps {
                echo "INFO: Fetching EC2 Public IP"
                script {
                    def output = sh(
                        script: "terraform -chdir=${TF_DIR} output -raw ec2_public_ip",
                        returnStdout: true
                    ).trim()
                    env.EC2_PUBLIC_IP = output
                }
                echo "EC2 Public IP: $EC2_PUBLIC_IP"
            }
        }

        stage('SSH Configuration') {
            steps {
                echo "INFO: SSH Configuration Started"
                writeFile file: 'Ansible/inventory', text: """
[web]
webserver ansible_host=${env.EC2_PUBLIC_IP} ansible_user=ec2-user ansible_ssh_private_key_file=~/.ssh/jenkins-practice.pem
                """
                echo "INFO: SSH Configuration Finished"
            }
        }

        stage('Ansible Configuration') {
            steps {
                echo "INFO: Ansible Configuration Started"
                dir('Ansible') {
                    sh '''
                        ansible-playbook -i inventory httpd.yml
                    '''
                }
                echo "INFO: Ansible Configuration Finished"
            }
        }

        stage('Destruction') {
            steps {
                dir("${TF_DIR}") {
                    echo "Destruction"
                    // sh 'terraform destroy -auto-approve'
                }
            }
        }
    }
}