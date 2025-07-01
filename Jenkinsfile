pipeline {
    agent any
    environment {
        AWS_REGION = 'us-east-1'
    }
    stages {
        stage('Checkout Code') {
            steps {
                git url: 'https://github.com/Seetharamj/terraform-3tier-jenkins.git', branch: 'main'
            }
        }
        stage('Terraform Init/Plan/Apply') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'AWS_CREDS',  // Replace with your Jenkins credential ID
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                ]]) {
                    sh '''
                        terraform init
                        terraform plan -out=tfplan
                        terraform apply -auto-approve tfplan
                    '''
                }
            }
        }
    }
    post {
        always {
            archiveArtifacts artifacts: '**/*.tfplan', allowEmptyArchive: true
        }
    }
}
