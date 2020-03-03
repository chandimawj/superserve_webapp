pipeline {
	
    environment {
        registry = "chandimawj/superserve"
        registryCredential = 'dockerhub'
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
                sh "docker build -t $registry:$BUILD_NUMBER ."
                echo 'Execute container...'
                sh "docker run -d -p 3333:8888 $registry:$BUILD_NUMBER"
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
                        sh "docker push $registry:$BUILD_NUMBER"
                    }
                }
		echo 'Destroy container...'
		sh "docker stop ${docker ps -a -q}"
		sh "docker rm ${docker ps -a -q}"
		echo 'Remove image...'
		sh "docker rmi $registry:$BUILD_NUMBER"
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
