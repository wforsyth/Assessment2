pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    def dockerfilePath = './Dockerfile'

                    def dockerImageName = 'assessment2:1.0'

                    docker.build(dockerImageName, '-f ' + dockerfilePath + ' .')
                }
            }
        }

        stage('Run Container Test') {
            steps {
                sh 'docker container run --detach --publish 80:80 --name assessment2 wforsyth/assessment2:1.0'
                sh 'docker container ls'
                echo "Container running. Test complete."
                sh 'docker container stop assessment2'
                sh 'docker container rm assessment2'
             }
         }

        stage('Push Docker Image') {   
            environment {
                DOCKER_COMMON_CREDS = credentials('dockerHub') 
            }
            steps {
                
                sh 'docker login -u ${DOCKER_COMMON_CREDS_USR} -p ${DOCKER_COMMON_CREDS_PSW}'
                sh 'docker push wforsyth/assessment2:1.0'
            }
        }
        
        stage('Deploy to Kubernetes') {
            steps {
                sshagent(['privatekey']) {

                    sh '''
                    ssh ubuntu@52.91.147.217 '/usr/bin/kubectl rollout restart deployments/assessment2'
                    '''

                }
            }
        }
    }
}
