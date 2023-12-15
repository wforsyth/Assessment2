pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Define the Dockerfile location
                    def dockerfilePath = './Dockerfile'

                    // Define the Docker image name and tag
                    def dockerImageName = 'assessment2:1.0'

                    // Build the Docker image
                    docker.build(dockerImageName, '-f ' + dockerfilePath + ' .')
                }
            }
        }

        stage('Run Container Test') {
            steps {
                script {
                    def dockerImageName = 'assessment2:1.0'
                    def containerName = 'test-container'

                    // Run a container based on the built image
                    docker.image(dockerImageName).withRun("--name ${containerName}") {
                        // Add any test commands here
                        echo "Container is running..."
                        // You can add more commands to validate the container behavior
                    }
                }
             }
         }

        stage('Push Docker Image') {   
            environment {
                DOCKER_COMMON_CREDS = credentials('dockerHub') 
            }
            steps {
                
                sh 'docker login -u ${DOCKER_COMMON_CREDS_USR} -p ${DOCKER_COMMON_CREDS_PSW}'
                sh 'docker push okbartz/cw2:1.0'
            }
        }
    }
}
