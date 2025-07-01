pipeline {
  agent any

  environment {
    AWS_REGION = 'us-east-1'
  }

  stages {
    stage('Checkout') {
      steps {
        git 'https://github.com/your-username/terraform-3tier-jenkins.git'
      }
    }

    stage('Init') {
      steps {
        sh 'terraform init'
      }
    }

    stage('Plan') {
      steps {
        sh 'terraform plan -out=tfplan'
      }
    }

    stage('Apply') {
      steps {
        sh 'terraform apply -auto-approve tfplan'
      }
    }
  }

  post {
    always {
      archiveArtifacts artifacts: '**/*.tf', fingerprint: true
    }
  }
}
