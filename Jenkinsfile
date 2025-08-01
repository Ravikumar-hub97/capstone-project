pipeline {
    agent any

    environment {
        DOCKERHUB_USERNAME = 'ravikumar1997'
        DOCKERHUB_CREDENTIALS_ID = 'dockerhub-credentials-id'
    }

    stages {
        stage('Checkout Code') {
            steps {
                script {
                    // Dynamically determine the branch name (fallback to 'dev')
                    def branch = env.GIT_BRANCH?.replaceFirst(/^origin\//, '') ?: 'dev'
                    env.ACTUAL_BRANCH = branch

                    git branch: branch, url: 'https://github.com/Ravikumar-hub97/capstone-project.git'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image and assign to global variable
                    env.IMAGE_TAG = "${DOCKERHUB_USERNAME}/${env.ACTUAL_BRANCH}"
                    dockerImage = docker.build(env.IMAGE_TAG)
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKERHUB_CREDENTIALS_ID) {
                        dockerImage.push()
                    }
                }
            }
        }

        stage('Deploy Locally') {
            steps {
                script {
                    sh """
                        docker stop react-app || true
                        docker rm react-app || true
                        docker run -d -p 80:80 --name react-app ${env.IMAGE_TAG}
                    """
                }
            }
        }
    }
}
