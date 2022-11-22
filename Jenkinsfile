pipeline {
    agent any

    environment {
        dockerImageName = 'eosadchiy/jenkins-docker'
        dockerRegistryCredentials = 'docker-hub'
        sshServerConfigName = 'web-srv'
    }

    stages {
        stage('Clone repository') {
            steps {
                script{
                    checkout scm
                }
            }
        }

        stage('Build image') {
            steps {
                script {
                 app = docker.build(dockerImageName)
                }
            }
        }

        stage('Push image to Docker HUB') {
            steps {
                script {
                    docker.withRegistry('', dockerRegistryCredentials) {
                        app.push("${env.BUILD_NUMBER}")
                        app.push('latest')
                    }
                }
            }
        }

        stage('Deploy to the Web Server') {
            steps {
                script {
                    sshPublisher(
                        continueOnError: false,
                        failOnError: true,
                        publishers: [
                            sshPublisherDesc(
                                configName: sshServerConfigName,
                                transfers: [
                                    sshTransfer(
                                        execCommand: '''if [ "$(docker ps -q -f name=jenkins-docker)" ]
                                        then
                                            docker rm -f $(docker ps -aq -f name=jenkins-docker)
                                        fi
                                        docker run -d --name jenkins-docker -p 8081:80 --pull always ${dockerImageName}:latest
                                        '''
                                    )
                                ],
                                verbose: true
                            )
                        ]
                    )
                }
            }
        }
    }
}
