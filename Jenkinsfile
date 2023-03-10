pipeline {
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
		sh 'export TF_VAR_imageUri=879580385544.dkr.ecr.ap-south-1.amazonaws.com/jenkins-ecr:v${BUILD_NUMBER}'
                sh "terraform plan"
            }
        }
       stage ('Apply infrastructure'){
  	input{
   		 message "Do you want to proceed for applying the resources?"
  	}
    	steps {
                sh 'terraform apply -auto-approve'

              }
        }
	stage ('Destroy infrastructure'){
  	input{
   		 message "Do you want to proceed for destroy the resources?"
  	}
    	steps {
                sh 'terraform destroy -auto-approve'

              }
        }
    }

  }
