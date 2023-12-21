pipeline {
    agent any
    stages {
        stage('build & push docker image') {
	         steps {
              withDockerRegistry(credentialsId: 'DOCKER_HUB_LOGIN', url: 'https://index.docker.io/v1/') {
                    sh script: 'cd  $WORKSPACE'
                    sh script: 'docker build --file Dockerfile --tag docker.io/ganesh01devops/first-react-app:$BUILD_NUMBER .'
                    sh script: 'docker push docker.io/ganesh01devops/first-react-app:$BUILD_NUMBER'
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