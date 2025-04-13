pipeline {
    agent any
    stages {
        stage ('Provision') {
            steps {
                sh "terraform plan"
                sh "terraform apply -auto-approve"
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