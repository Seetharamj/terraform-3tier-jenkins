pipeline {
  agent any

  environment {
    TF_LOG = "ERROR"
    AWS_REGION = "us-east-1"  // Set your preferred region here
  }

  stages {
    stage('Checkout Code') {
      steps {
        git branch: 'main', url: 'https://github.com/Seetharamj/terraform-3tier-jenkins.git'
      }
    }

    stage('Verify AWS Credentials') {
      steps {
        withCredentials([[
          $class: 'AmazonWebServicesCredentialsBinding',
          credentialsId: 'aws-creds',
          accessKeyVariable: 'AWS_ACCESS_KEY_ID',
          secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
        ]]) {
          sh '''
            echo "✅ Verifying AWS credentials..."
            aws sts get-caller-identity || exit 1
            echo "✅ AWS credentials are valid"
          '''
        }
      }
    }

    stage('Terraform Init') {
      steps {
        withCredentials([[
          $class: 'AmazonWebServicesCredentialsBinding',
          credentialsId: 'aws-creds',
          accessKeyVariable: 'AWS_ACCESS_KEY_ID',
          secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
        ]]) {
          sh '''
            terraform init
          '''
        }
      }
    }

    stage('Terraform Plan') {
      steps {
        withCredentials([[
          $class: 'AmazonWebServicesCredentialsBinding',
          credentialsId: 'aws-creds',
          accessKeyVariable: 'AWS_ACCESS_KEY_ID',
          secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
        ]]) {
          sh '''
            terraform plan -out=tfplan
          '''
        }
      }
    }

    stage('Terraform Apply') {
      steps {
        withCredentials([[
          $class: 'AmazonWebServicesCredentialsBinding',
          credentialsId: 'aws-creds',
          accessKeyVariable: 'AWS_ACCESS_KEY_ID',
          secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
        ]]) {
          sh '''
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
