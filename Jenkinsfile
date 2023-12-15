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
}
