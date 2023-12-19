pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    def dockerfilePath = './Dockerfile'

                    def dockerImageName = 'assessment2:latest'

                    docker.build(dockerImageName, '-f ' + dockerfilePath + ' .')
                }
            }
        }

        stage('Run Container Test') {
            steps {
                sh 'docker container run --detach --publish 80:80 --name assessment2 wforsyth/assessment2:latest'
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
                sh 'docker push wforsyth/assessment2:latest'
            }
        }
        
        stage('Deploy to Kubernetes') {
            steps {
                sshagent(['privatekey']) {

                    sh '''
                    ssh ubuntu@54.157.168.45 '/usr/bin/kubectl set image deployments/assessment2 assessment2=wforsyth/assessment2:latest'
                    '''

                }
            }
        }
    }
}
