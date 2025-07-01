pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-1'
        TF_LOG     = 'INFO'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout([
                    $class: 'GitSCM',
                    branches: [[name: 'main']],
                    userRemoteConfigs: [[
                        url: 'https://github.com/Seetharamj/terraform-3tier-jenkins.git'
                    ]],
                    extensions: [[
                        $class: 'CleanBeforeCheckout'
                    ]]
                ])
            }
        }

        stage('Terraform Init') {
            steps {
                withCredentials([[
                    $class: 'UsernamePasswordMultiBinding',
                    credentialsId: 'AWS_CREDS',
                    usernameVariable: 'AWS_ACCESS_KEY_ID',
                    passwordVariable: 'AWS_SECRET_ACCESS_KEY'
                ]]) {
                    sh '''
                        terraform init -no-color -input=false
                    '''
                }
            }
        }

        stage('Destroy Infrastructure') {
            steps {
                input message: "⚠️ WARNING: This will permanently delete all AWS resources. Continue?"
                withCredentials([[
                    $class: 'UsernamePasswordMultiBinding',
                    credentialsId: 'AWS_CREDS',
                    usernameVariable: 'AWS_ACCESS_KEY_ID',
                    passwordVariable: 'AWS_SECRET_ACCESS_KEY'
                ]]) {
                    sh '''
                        terraform destroy -auto-approve -no-color
                    '''
                }
            }
        }
    }

    post {
        always {
            echo "Cleaning up workspace"
            cleanWs()
        }
    }
}
