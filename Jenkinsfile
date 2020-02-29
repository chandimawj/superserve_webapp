pipeline {
    agent any

    stages {
        stage('Sonarqube Analysis') {
            steps {
                echo 'Perform Sonarqube analysis...'
		        sh './gradlew sonarqube \
                    -Dsonar.host.url=http://172.31.52.76:9000 \
                    -Dsonar.login=b024f9f0d3715775cd9085c5d4e046c7d94e9a2d'
            }
        }
        stage('Build') {
            steps {
                echo 'Execute Gradle build...'
		        sh './gradlew build'
            }
        }
        stage('Run Docker image') {
            steps {
                echo 'Build Docker Image using Dockerfile...'
                echo 'Execute container...'
            }
        }
        stage('Test') {	   
            steps {
                echo 'Execute selenium tests...'
            }
        }
        stage ('Clean up Docker'){
            steps {
                echo 'Destroy container...'
            }	
        }
        stage('Publish Image') {
            steps{
                echo 'Publish image to dockerhub...'
            }
        }
        stage('Clean up') {
            steps {
                echo 'Clean up workspace...' 
                cleanWs()
            }
        }
    }
}
