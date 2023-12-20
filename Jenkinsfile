pipeline {
    agent {
        docker {
            image 'node:20.10.0-alpine3.18' 
            args '-p 3000:3000' 
        }
    }
    stages {
        stage('Install & Build') { 
            steps {
                sh 'npm install' 
                sh 'npm run build' 
            }
        }
        stage('build & push docker image') {
	         steps {
              withDockerRegistry(credentialsId: 'DOCKER_HUB_LOGIN', url: 'https://index.docker.io/v1/') {
                    sh script: 'cd  $WORKSPACE'
                    sh script: 'docker build --file Dockerfile --tag docker.io/ganesh01devops/firstReactApp:$BUILD_NUMBER .'
                    sh script: 'docker push docker.io/ganesh01devops/firstReactApp:$BUILD_NUMBER'
              }	
           }		
        }
        stage('deploy-QA') {
	         steps {
                    sh script: 'ansible-playbook --inventory /tmp/inv $WORKSPACE/deploy-kube.yml --extra-vars "env=qa build=$BUILD_NUMBER"'
           }		
        }
    }
}