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
                 app = docker.build("eosadchiy/jenkins-docker")
                }
            }
        }

        stage('Push image to Docker HUB') {
            steps {
                script {
                    docker.withRegistry('', 'docker-hub') {
                        app.push("latest")
                    }
                }
            }
        }
    }
}
