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
		    sh 'aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 879580385544.dkr.ecr.ap-south-1.amazonaws.com'
	        sh 'sudo docker build -t jenkins-ecr:v${BUILD_NUMBER} .'
	        sh 'sudo docker tag jenkins-ecr:v${BUILD_NUMBER} 879580385544.dkr.ecr.ap-south-1.amazonaws.com/jenkins-ecr:v${BUILD_NUMBER}'
	        sh 'sudo docker push 879580385544.dkr.ecr.ap-south-1.amazonaws.com/jenkins-ecr:latest'
            }
        }
        stage('Plan') {
            steps {
                sh 'terraform init'
                sh "terraform plan -out tfplan"
                sh 'terraform show -no-color tfplan > tfplan.txt'
            }
        }
        stage('Approval') {
           when {
               not {
                   equals expected: true, actual: params.autoApprove
               }
           }

           steps {
               script {
                    def plan = readFile 'tfplan.txt'
                    input message: "Do you want to apply the plan?",
                    parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
               }
           }
       }

        stage('Apply') {
            steps {
                sh "terraform apply -input=false tfplan"
            }
        }
    }

  }
