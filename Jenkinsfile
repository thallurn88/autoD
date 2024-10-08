pipeline {
    agent any

    parameters {
        booleanParam(name: 'autoapprove', defaultValue: false, description: "Apply the changes once the plan is completed?")
    }

    environment {
        
        AWS_ACCESS_KEY_ID = credentials("access_key_ID")
        AWS_SECRET_ACCESS_KEY = credentials("secret_key_ID")
    }

    stages {
        stage("Checkout the Terraform config") {
            steps {
                git 'https://github.com/thallurn88/autoD.git'
            }
        }

        stage("Plan") {
            steps {
                sh 'terraform init'
                sh 'terraform plan -out=tfplan'
                sh 'terraform show -no-color tfplan > tfplan.txt'
            }
        }

        stage("Approve") {
            when {
                not {
                    equals expected: true, actual: params.autoapprove
                }
            }
            steps {
                script {
                    def plan = readFile('tfplan.txt')
                    input message: "Do you want to apply the changes?", 
                          parameters: [text(name: 'Plan Review', defaultValue: plan, description: "Please review the plan")]
                }
            }
        }

        stage("Apply") {
            steps {
                sh "terraform apply -input=false tfplan"
            }
        }

        stage("Destroy") {
            steps {
                sh "terraform destroy -auto-approve"
            }
        }
         
    }
}
