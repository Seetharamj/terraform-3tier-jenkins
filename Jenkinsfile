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

    stage('Terraform Init') {
      steps {
        withCredentials([usernamePassword(
          credentialsId: 'aws-creds',
          usernameVariable: 'TF_AWS_ACCESS_KEY_ID',
          passwordVariable: 'TF_AWS_SECRET_ACCESS_KEY'
        )]) {
          sh '''
            export AWS_ACCESS_KEY_ID=$TF_AWS_ACCESS_KEY_ID
            export AWS_SECRET_ACCESS_KEY=$TF_AWS_SECRET_ACCESS_KEY
            terraform init
          '''
        }
      }
    }

    stage('Terraform Plan') {
      steps {
        withCredentials([usernamePassword(
          credentialsId: 'aws-creds',
          usernameVariable: 'TF_AWS_ACCESS_KEY_ID',
          passwordVariable: 'TF_AWS_SECRET_ACCESS_KEY'
        )]) {
          sh '''
            export AWS_ACCESS_KEY_ID=$TF_AWS_ACCESS_KEY_ID
            export AWS_SECRET_ACCESS_KEY=$TF_AWS_SECRET_ACCESS_KEY
            terraform plan -out=tfplan
          '''
        }
      }
    }

    stage('Terraform Apply') {
      steps {
        withCredentials([usernamePassword(
          credentialsId: 'aws-creds',
          usernameVariable: 'TF_AWS_ACCESS_KEY_ID',
          passwordVariable: 'TF_AWS_SECRET_ACCESS_KEY'
        )]) {
          sh '''
            export AWS_ACCESS_KEY_ID=$TF_AWS_ACCESS_KEY_ID
            export AWS_SECRET_ACCESS_KEY=$TF_AWS_SECRET_ACCESS_KEY
            terraform apply -auto-approve tfplan
          '''
        }
      }
    }
  }

  post {
    always {
      archiveArtifacts artifacts: '**/*.tf', fingerprint: true
    }
  }
}
