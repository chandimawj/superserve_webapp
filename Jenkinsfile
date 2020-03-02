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
                withSonarQubeEnv('Sonarqube') { 
                    sh './gradlew --stacktrace --info sonarqube'
                }
            }
        }
	stage('Run Docker image') {
            steps {
                echo 'Build Docker Image using Dockerfile...'
                sh 'sudo docker build -t chandimawj/superserve .'
                echo 'Execute container...'
                sh 'sudo docker run -d -p 3333:8888 chandimawj/superserve'
            }
        }
        stage('Test') {	   
            steps {
                echo 'Execute selenium tests...'
		build 'superserve-selenium'
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
