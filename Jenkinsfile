pipeline {
    agent any

    stages {
        stage("code from github") {
            steps {
                git branch: 'main', url: 'https://github.com/sinku29/new_project.git'
            }
        }

        
        stage('Code Quality Analysis') {
            environment {
              scannerHome = tool 'SonarQube'
            }
            steps {
               withSonarQubeEnv('SonarQube') {
                  sh "${scannerHome}/bin/sonar-scanner"
                }
                
            }
        }

    

        stage("Build docker image") {
            steps {
                sh 'docker image build  -t $JOB_NAME:v1.$BUILD_ID .'
                sh 'docker image tag $JOB_NAME:v1.$BUILD_ID sinku29/$JOB_NAME:v1.$BUILD_ID'
                sh 'docker image tag $JOB_NAME:v1.$BUILD_ID sinku29/$JOB_NAME:latest'
            }
        }

        stage("Push image to docker hub") {
            steps {
                withCredentials([string(credentialsId: 'docker_pass', variable: 'dockerhpass')]) {
                    sh 'docker login -u sinku29 -p ${dockerhpass}'
                    sh 'docker image push sinku29/$JOB_NAME:v1.$BUILD_ID'
                    sh 'docker image push sinku29/$JOB_NAME:latest'
                    sh 'docker image rmi $JOB_NAME:v1.$BUILD_ID sinku29/$JOB_NAME:v1.$BUILD_ID sinku29/$JOB_NAME:latest'
                }
            }
        }

        stage("Deploy docker container") {
            steps {
                script {
                    // Run the Docker container
                    def imageName = 'sinku29/new_project:latest'
                    def containerName = 'cicd'

                    sh "docker run -p 8000:80 -itd --name $containerName $imageName"
                }
            }
        }
    }
}
