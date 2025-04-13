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
                sh "echo Destruction"
            }
        }

        stage ('Destruction') {
            sh "echo Destruction"
        }
    }
}