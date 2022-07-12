pipeline {
    agent any
    environment {
        AWS_DEFAULT_REGION="us-east-1"
    }
    stages {
        stage('Build'){
            steps {
                // cleanWs()

                sh """
                    ls
                    pwd
                """
                withCredentials([aws(
                    credentialsId: 'private',
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                )]) {
                    sh '''
                        terraform init
                        terraform validate
                        terraform plan
                        terraform apply -auto-approve
                        aws lambda invoke --function-name lambda-nice-devops-interview-moshe response.json
                        cat response.json
                        current_time=$(date "+%Y.%m.%d-%H.%M.%S")
                        aws s3 cp parse_me.txt s3://nice-devops-interview-moshe/${current_time}-parse_me.txt
                        aws s3 cp response.json s3://nice-devops-interview-moshe/${current_time}-parse_output.json
                    '''
                }

            }
        }

    }
}
