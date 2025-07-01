pipeline {
    agent any
    
    environment {
        AWS_REGION = 'us-east-1'
    }
    
    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', 
                url: 'https://github.com/Seetharamj/terraform-3tier-jenkins.git'
            }
        }
        
        stage('Terraform Init/Plan/Apply') {
            steps {
                withCredentials([[
                    $class: 'UsernamePasswordMultiBinding',
                    credentialsId: 'AWS_CREDS',
                    usernameVariable: 'AWS_ACCESS_KEY_ID',
                    passwordVariable: 'AWS_SECRET_ACCESS_KEY'
                ]]) {
                    sh '''
                        echo "✅ AWS Credentials Loaded"
                        export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
                        export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
                        export AWS_REGION=us-east-1
                        
                        terraform init -no-color
                        terraform validate
                        terraform plan -out=tfplan -no-color
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
    }
}
