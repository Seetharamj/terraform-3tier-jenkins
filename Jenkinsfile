pipeline {
    agent any
    
    environment {
        AWS_REGION = 'us-east-1'
        TF_LOG = 'DEBUG'
    }
    
    stages {
        stage('Checkout Code') {
            steps {
                script {
                    echo "DEBUG: Starting checkout from ${env.BUILD_URL}"
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
                    sh 'ls -la'
                }
            }
        }
        
        stage('Terraform Init/Validate') {
            steps {
                script {
                    withCredentials([[
                        $class: 'UsernamePasswordMultiBinding',
                        credentialsId: 'AWS_CREDS',
                        usernameVariable: 'AWS_ACCESS_KEY_ID',
                        passwordVariable: 'AWS_SECRET_ACCESS_KEY'
                    ]]) {
                        sh '''
                            echo "=== TERRAFORM INIT ==="
                            terraform init -no-color -input=false
                            
                            echo "=== VALIDATION ==="
                            terraform validate
                        '''
                    }
                }
            }
        }
        
        stage('Terraform Plan') {
            when {
                expression { currentBuild.result == null || currentBuild.result == 'SUCCESS' }
            }
            steps {
                script {
                    withCredentials([[
                        $class: 'UsernamePasswordMultiBinding',
                        credentialsId: 'AWS_CREDS',
                        usernameVariable: 'AWS_ACCESS_KEY_ID',
                        passwordVariable: 'AWS_SECRET_ACCESS_KEY'
                    ]]) {
                        sh '''
                            echo "=== GENERATING PLAN ==="
                            terraform plan -out=tfplan -no-color -input=false
                            ls -la tfplan
                        '''
                    }
                }
            }
        }
        
        stage('Terraform Apply') {
            when {
                expression { currentBuild.result == null || currentBuild.result == 'SUCCESS' }
            }
            steps {
                script {
                    withCredentials([[
                        $class: 'UsernamePasswordMultiBinding',
                        credentialsId: 'AWS_CREDS',
                        usernameVariable: 'AWS_ACCESS_KEY_ID',
                        passwordVariable: 'AWS_SECRET_ACCESS_KEY'
                    ]]) {
                        sh '''
                            echo "=== APPLYING CHANGES ==="
                            terraform apply -auto-approve -no-color -input=false tfplan
                        '''
                    }
                }
            }
        }
    }
    
    post {
        always {
            archiveArtifacts artifacts: '**/*.tf', allowEmptyArchive: true
            cleanWs()
        }
        failure {
            script {
                try {
                    sh 'terraform validate -no-color'
                    sh 'terraform state list || echo "No state exists yet - this is normal for first runs"'
                } catch (Exception e) {
                    echo "Debugging failed: ${e}"
                }
            }
        }
    }
}
