pipeline {
    agent any

    environment {
        dockerImageName = 'eosadchiy/jenkins-docker'
        dockerRegistryCredentials = 'docker-hub'
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
    }
}
