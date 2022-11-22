pipeline {
    agent any

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
                 app = docker.build("jenkins-docker")
                }
            }
        }

        stage('Push image to Docker HUB') {
            steps {
                script {
                    docker.withRegistry('', 'docker-hub') {
                        app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
                    }
                }
            }
        }
    }
}
