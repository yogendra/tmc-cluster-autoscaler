pipeline {  
  environment { 
    build_id = "$NODE_NAME-$JOB_NAME-$BUILD_NUMBER-$BUILD_ID"
  }  
  agent any  
  stages {
    
    stage('Build') {
      steps{
        script {
          sh "echo \"$build_id == Hello, World!\""
        }
      }
    }
  }
}
