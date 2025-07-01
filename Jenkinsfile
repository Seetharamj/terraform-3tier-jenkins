pipeline {
  agent any

  environment {
    TF_LOG = "ERROR"
  }

  stages {
    stage('Checkout Code') {
      steps {
        git branch: 'main', url: 'https://github.com/Seetharamj/terraform-3tier-jenkins.git'
      }
    }

    // ✅ OPTIONAL: Safe AWS Credential Check
    stage('Debug AWS Credentials') {
      steps {
        withCredentials([usernamePassword(
          credentialsId: 'aws-creds',
          usernameVariable: 'AWS_ACCESS_KEY_ID',
          passwordVariable: 'AWS_SECRET_ACCESS_KEY'
        )]) {
          sh '''
            echo "✅ AWS credentials loaded"
            echo "Access Key: $AWS_ACCESS_KEY_ID"
            echo "Secret Key: [HIDDEN FOR SECURITY]"
          '''
        }
      }
    }

    stage('Terraform Init') {
      steps {
        withCredentials([usernamePassword(
          credentialsId: 'aws-creds',
          usernameVariable: 'AWS_ACCESS_KEY_ID',
          passwordVariable: 'AWS_SECRET_ACCESS_KEY'
        )]) {
          sh '''
            export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
            export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
            terraform init
          '''
        }
      }
    }

    stage('Terraform Plan') {
      steps {
        withCredentials([usernamePassword(
          credentialsId: 'aws-creds',
          usernameVariable: 'AWS_ACCESS_KEY_ID',
          passwordVariable: 'AWS_SECRET_ACCESS_KEY'
        )]) {
         sh '''
       export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
       export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
       terraform plan -out=tfplan
            '''

        }
      }
    }

    stage('Terraform Apply') {
      steps {
        withCredentials([usernamePassword(
          credentialsId: 'aws-creds',
          usernameVariable: 'AWS_ACCESS_KEY_ID',
          passwordVariable: 'AWS_SECRET_ACCESS_KEY'
        )]) {
          sh '''
            export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
            export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
            terraform apply -auto-approve tfplan
          '''
        }
      }
    }
  }

  post {
    success {
      echo '✅ Terraform apply succeeded.'
    }
    failure {
      echo '❌ Terraform pipeline failed. Check logs above.'
    }
    always {
      archiveArtifacts artifacts: '**/*.tf', fingerprint: true
    }
  }
}
