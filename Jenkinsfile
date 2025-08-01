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
                script {
                    // Determine the branch name dynamically
                    def branch = env.GIT_BRANCH?.replaceFirst(/^origin\//, '') ?: 'dev'
                    env.ACTUAL_BRANCH = branch

                    git branch: branch, url: 'https://github.com/Ravikumar-hub97/capstone-project.git'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('', 'dockerhub-credentials-id') {
			dockerImage.push("${env.ACTUAL_BRANCH}")

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
                        docker run -d -p 80:80 --name react-app ${DOCKERHUB_USERNAME}/${ACTUAL_BRANCH}
                    '''
                }
            }
        }
    }
}
