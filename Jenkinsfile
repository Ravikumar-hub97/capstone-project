pipeline {
    agent any

    environment {
        DOCKERHUB_USERNAME = 'ravikumar1997'
        DEV_REPO = "${DOCKERHUB_USERNAME}/dev"
        PROD_REPO = "${DOCKERHUB_USERNAME}/prod"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: "${env.BRANCH_NAME}", url: 'https://github.com/Ravikumar-hub97/capstone-project.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("react-app:${env.BRANCH_NAME}")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('', 'dockerhub-credentials-id') {
                        if (env.BRANCH_NAME == 'dev') {
                            dockerImage.push("dev")
                        } else if (env.BRANCH_NAME == 'master') {
                            dockerImage.push("prod")
                        }
                    }
                }
            }
        }

        stage('Deploy Locally') {
            steps {
                script {
                    sh '''
                        docker stop react-app || true
                        docker rm react-app || true
                        docker run -d -p 80:80 --name react-app ${DOCKERHUB_USERNAME}/$BRANCH_NAME
                    '''
                }
            }
        }
    }
}
