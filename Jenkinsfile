pipeline {
    agent any

    environment {
        TF_VAR_access_key = credentials('aws-access-key')
        TF_VAR_secret_key = credentials('aws-secret-key')
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo 'Checking out code...'
                checkout scm
                sh 'ls -la'
            }
        }

        stage('Terraform Init/Validate') {
            steps {
                script {
                    sh '''
                        export AWS_ACCESS_KEY_ID=$TF_VAR_access_key
                        export AWS_SECRET_ACCESS_KEY=$TF_VAR_secret_key
                        terraform init
                        terraform validate
                    '''
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan -var="access_key=$TF_VAR_access_key" -var="secret_key=$TF_VAR_secret_key"'
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve -var="access_key=$TF_VAR_access_key" -var="secret_key=$TF_VAR_secret_key"'
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
