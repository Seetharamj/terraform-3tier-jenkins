pipeline {
    agent any
    
    environment {
        AWS_REGION = 'us-east-1'
        TF_LOG     = 'DEBUG'  // Enable Terraform debug logging
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
                    sh 'ls -la'  // Debug: Show directory contents
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
                        echo "DEBUG: Initializing Terraform with AWS credentials"
                        sh '''
                            echo "Current workspace:"
                            pwd
                            ls -la
                            
                            echo "Terraform version:"
                            terraform version
                            
                            echo "Initializing Terraform..."
                            terraform init -no-color -input=false
                            
                            echo "DEBUG: Terraform providers"
                            terraform providers
                            
                            echo "Validating configuration..."
                            terraform validate -json | jq '.'  # Pretty-print validation
                        '''
                    }
                }
            }
        }
        
        stage('Terraform Plan') {
            steps {
                script {
                    withCredentials([[
                        $class: 'UsernamePasswordMultiBinding',
                        credentialsId: 'AWS_CREDS',
                        usernameVariable: 'AWS_ACCESS_KEY_ID',
                        passwordVariable: 'AWS_SECRET_ACCESS_KEY'
                    ]]) {
                        echo "DEBUG: Generating Terraform plan"
                        sh '''
                            echo "Current state:"
                            terraform state list
                            
                            echo "Generating plan..."
                            terraform plan -out=tfplan -no-color -input=false -detailed-exitcode
                            PLAN_EXIT_CODE=$?
                            
                            echo "Plan exit code: $PLAN_EXIT_CODE"
                            if [ $PLAN_EXIT_CODE -eq 1 ]; then
                                echo "ERROR: Plan failed"
                                exit 1
                            elif [ $PLAN_EXIT_CODE -eq 2 ]; then
                                echo "INFO: Changes detected"
                            else
                                echo "INFO: No changes"
                            fi
                            
                            echo "Plan file details:"
                            ls -la tfplan
                        '''
                    }
                }
            }
        }
        
        stage('Terraform Apply') {
            steps {
                script {
                    withCredentials([[
                        $class: 'UsernamePasswordMultiBinding',
                        credentialsId: 'AWS_CREDS',
                        usernameVariable: 'AWS_ACCESS_KEY_ID',
                        passwordVariable: 'AWS_SECRET_ACCESS_KEY'
                    ]]) {
                        echo "DEBUG: Applying Terraform changes"
                        sh '''
                            echo "Applying plan..."
                            terraform apply -auto-approve -no-color -input=false tfplan
                            
                            echo "Apply completed. Current resources:"
                            terraform state list
                            
                            echo "Output values:"
                            terraform output -json | jq '.'
                        '''
                    }
                }
            }
        }
    }
    
    post {
        always {
            script {
                echo "DEBUG: Pipeline completed with status ${currentBuild.currentResult}"
                archiveArtifacts artifacts: '**/*.tfplan,**/.terraform/**/*.log', allowEmptyArchive: true
                junit '**/terraform-test-results.xml'  // If you have test results
                
                echo "Collecting debug info..."
                sh '''
                    echo "=== FINAL WORKSPACE CONTENTS ==="
                    ls -laR
                    
                    echo "=== TERRAFORM STATE ==="
                    terraform show -no-color || true
                    
                    echo "=== TF LOGS ==="
                    cat .terraform/*.log || true
                '''
                
                cleanWs()
            }
        }
        success {
            slackSend color: 'good', message: "Terraform deployment succeeded: ${env.BUILD_URL}"
        }
        failure {
            slackSend color: 'danger', message: "Terraform deployment failed: ${env.BUILD_URL}"
            sh '''
                echo "=== ERROR DEBUGGING ==="
                terraform validate -json | jq '.' > validation.json
                cat validation.json
                
                echo "Recent logs:"
                tail -n 100 .terraform/*.log || true
            '''
            archiveArtifacts artifacts: 'validation.json,.terraform/*.log', allowEmptyArchive: true
        }
    }
}
