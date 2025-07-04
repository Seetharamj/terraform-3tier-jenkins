pipeline {
    agent any

    environment {
        TF_VAR_access_key = credentials('aws-access-key')     // 👈 TF_VAR_ prefix required
        TF_VAR_secret_key = credentials('aws-secret-key')
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init/Validate') {
            steps {
                sh '''
                    terraform init
                    terraform validate
                '''
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan'
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve'
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: '**/*.tf', fingerprint: true
            cleanWs()
        }
    }
}
