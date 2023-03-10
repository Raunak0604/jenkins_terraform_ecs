pipeline {

    parameters {
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
    } 
    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

   agent  any
    stages {
         stage('ecr push') {
            steps {     
		sh 'aws ecr get-login-password --region ap-south-1 | sudo docker login --username AWS --password-stdin 879580385544.dkr.ecr.ap-south-1.amazonaws.com'
	        sh 'sudo docker build -t jenkins-ecr:v${BUILD_NUMBER} .'
	        sh 'sudo docker tag jenkins-ecr:v${BUILD_NUMBER} 879580385544.dkr.ecr.ap-south-1.amazonaws.com/jenkins-ecr:v${BUILD_NUMBER}'
	        sh 'sudo docker push 879580385544.dkr.ecr.ap-south-1.amazonaws.com/jenkins-ecr:v${BUILD_NUMBER}'
            }
        }
        stage('Plan') {
            steps {
                sh 'terraform init -verify-plugins=false'
                sh "terraform plan"
            }
        }
       stage ('Deploy To Prod'){
  	input{
   		 message "Do you want to proceed for production deployment?"
  	}
    	steps {
                sh 'terraform apply -auto-approve'

              }
        }
    }

  }
