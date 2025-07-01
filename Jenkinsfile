pipeline {
    agent any
    
    environment {
        AWS_REGION = 'us-east-1'
    }
    
    stages {
        stage('Checkout Code') {
            steps {
                checkout([
                    $class: 'GitSCM',
                    branches: [[name: 'main']],
                    userRemoteConfigs: [[
                        url: 'https://github.com/Seetharamj/terraform-3tier-jenkins.git'
                    ]]
                ])
            }
        }
        
        stage('Terraform Init/Validate') {
            steps {
                withCredentials([[
                    $class: 'UsernamePasswordMultiBinding',
                    credentialsId: 'AWS_CREDS',
                    usernameVariable: 'AWS_ACCESS_KEY_ID',
                    passwordVariable: 'AWS_SECRET_ACCESS_KEY'
                ]]) {
                    sh '''
                        terraform init -no-color
                        terraform validate
                    '''
                }
            }
        }
        
        stage('Terraform Plan') {
            steps {
                withCredentials([[
                    $class: 'UsernamePasswordMultiBinding',
                    credentialsId: 'AWS_CREDS',
                    usernameVariable: 'AWS_ACCESS_KEY_ID',
                    passwordVariable: 'AWS_SECRET_ACCESS_KEY'
                ]]) {
                    sh '''
                        terraform plan -out=tfplan -no-color
                    '''
                }
            }
        }
        
        stage('Terraform Apply') {
            steps {
                withCredentials([[
                    $class: 'UsernamePasswordMultiBinding',
                    credentialsId: 'AWS_CREDS',
                    usernameVariable: 'AWS_ACCESS_KEY_ID',
                    passwordVariable: 'AWS_SECRET_ACCESS_KEY'
                ]]) {
                    sh '''
                        terraform apply -auto-approve -no-color tfplan
                    '''
                }
            }
        }
    }
    
    post {
        always {
            archiveArtifacts artifacts: '**/*.tfplan', allowEmptyArchive: true
            cleanWs()
        }
        success {
            echo 'Terraform deployment completed successfully'
        }
        failure {
            echo 'Terraform deployment failed'
        }
    }
}
