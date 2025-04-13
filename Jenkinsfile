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

        stage ('Configuration') {
            steps {
                echo "Configuration"
            }
        }

        stage ('Destruction') {
            steps {
                echo "Destruction"
            }
        }
    }
}