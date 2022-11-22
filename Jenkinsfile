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
                                        execCommand: '''docker ps -q -f name=jenkins-docker'''
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
