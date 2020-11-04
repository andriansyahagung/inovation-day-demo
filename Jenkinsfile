pipeline {
   agent any

   environment {


     SERVICE_NAME = "php-pipeline-inovationday"
     REPOSITORY_TAG="${YOUR_DOCKERHUB_USERNAME}/${ORGANIZATION_NAME}-${SERVICE_NAME}:${BUILD_ID}"
   }

   stages {
      stage('Preparation') {
         steps {
            cleanWs()
            git credentialsId: 'github-repo', url: "https://github.com/andriansyahagung/inovation-day-demo.git"
            sh 'git pull origin master'
         }
      }
      stage('Build') {
         steps {
            sh 'echo No build required'
         }
      }
      stage('Build Image and Push Image to DockerHUB') {
         steps {
            withCredentials([string(credentialsId: 'docker-hub-cred', variable: 'cred')]) {
               sh 'docker login -u andriansyahagung -p ${cred}'
               sh 'docker image build -t ${REPOSITORY_TAG} .'
               sh 'docker push ${REPOSITORY_TAG}'
            }

         }
      }
      stage('Deploy to Kubernetes Cluster') {
          steps {
            withKubeConfig(caCertificate: '', clusterName: '', contextName: '', credentialsId: 'kube-local', namespace: 'dev', serverUrl: '') {
               sh 'envsubst < ${WORKSPACE}/deploy.yaml | kubectl apply -f -'
            }
          }
      }
      stage('Deploy to ACI') {
          steps {
            sh 'ansible-playbook -i inventory.yaml create_aci_component.yaml'
          }
      }
   }
}
