pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Execute Gradle build...'
		sh './gradlew build'
            }
        }
        stage('SonarQube analysis') {
            steps {
                echo 'Perform code analysis...'
                withSonarQubeEnv() { 
                    sh './gradlew sonarqube'
                }
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
        stage ('Clean up container'){
            steps {
                echo 'Destroy container...'
            }	
        }
        stage('Publish image') {
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
