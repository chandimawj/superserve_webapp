pipeline {
	
    environment {
        registry = "chandimawj/superserve"
        registryCredential = 'dockerhub'
        dockerImage = ''
    }
	
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
                script {
                    dockerImage = docker.build registry + ":$BUILD_NUMBER"
                }
                echo 'Execute container...'
                sh "sudo docker run -d -p 3333:8888 $registry:$BUILD_NUMBER"
            }
        }
        stage('Test') {	   
            steps {
                echo 'Execute selenium tests...'
		build 'superserve-selenium'
            }
        }
        stage('Publish image') {
            steps {
                echo 'Publish image to dockerhub...'
		script {
                    docker.withRegistry( '', registryCredential ) {
                        dockerImage.push()
                    }
                }
		echo 'Destroy container...'
		sh "sudo docker stop $(sudo docker ps -a -q)"
		sh "sudo docker rm $(sudo docker ps -a -q)"
		echo 'Remove image...'
		sh "sudo docker rmi $registry:$BUILD_NUMBER"
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
