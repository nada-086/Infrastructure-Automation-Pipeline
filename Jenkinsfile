pipeline {
    agent any
    environment {
        TF_DIR = 'Terraform'
    }
    stages {
        stage('Provision') {
            steps {
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
            }
        }

        stage('Fetch EC2 Public IP') {
            steps {
                script {
                    def output = sh(
                        script: "terraform -chdir=${TF_DIR} output -raw ec2_public_ip",
                        returnStdout: true
                    ).trim()
                    env.EC2_PUBLIC_IP = output
                }
            }
        }

        stage('SSH Configuration') {
            steps {
                writeFile file: 'Ansible/inventory', text: """
[web]
${env.EC2_PUBLIC_IP} ansible_user=ec2-user ansible_ssh_private_key_file=~/.ssh/jenkins-practice.pem
                """
            }
        }

        stage('Configuration') {
            steps {
                dir('Ansible') {
                    sh '''
                        ansible-playbook -i inventory httpd.yml
                    '''
                }
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