pipeline {
    agent any

    stages {
        stage("code from github") {
            steps {
                git branch: 'main', url: 'https://github.com/sinku29/new_project.git'
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
                    def dockerrun = 'docker run -p 8000:80 -itd --name cicd sinku29/new_project:latest'
                    def dockerrm = 'docker container rm -f cicd'
                    def dockerimgrm = 'docker image rmi sinku29/new_project'
                    sshagent(['dkr']) {
                        sh "ssh -o StrictHostKeyChecking=no ec2-user@15.207.116.127 ${dockerrm}"
                        sh "ssh -o StrictHostKeyChecking=no ec2-user@15.207.116.127 ${dockerimgrm}"
                        sh "ssh -o StrictHostKeyChecking=no vagrant@192.168.11.11 ${dockerrun}"
                    }
                }
            }
        }
    }
}
