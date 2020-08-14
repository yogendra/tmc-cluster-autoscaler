pipeline {  
  environment { 
    build_id = "$NODE_NAME-$JOB_NAME-$BUILD_NUMBER-$BUILD_ID"
  }  
  agent any  
  stages {
    
    stage('Checkout'){
      steps {
        checkout scm
      }
    }
    // stage('Building image') {
    //   steps{
    //     script {
    //       imageName = registry + ":$BUILD_NUMBER"
    //       context = "'./Day 2/Lab 03 - Part 1 - Containerising an App'"
    //       dockerImage = docker.build(imageName, context)
    //     }
    //   }
    // }
    // stage ("Publish"){
    //   steps {
    //     script {
    //       docker.withRegistry( '', registryCredential ) {
    //         dockerImage.push()
    //         dockerImage.push("latest")
    //       }
    //     }
    //   }
    // }
    stage('Deploy') {
      withKubeConfig([credentialsId: 'k8s-cluster-1']){
      steps{
        script {
          sh "kubectl apply -f tmc-cas.yaml"
        }
      }
    }
  }
}
