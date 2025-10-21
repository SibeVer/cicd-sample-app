pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building sample app...'
                sh 'bash ./sample-app.sh'
            }
        }

        stage('Test') {
            steps {
                script {
                    // Replace APP_IP and JENKINS_IP with the actual IPs
                    def APP_IP = '172.17.0.3'
                    def JENKINS_IP = '172.17.0.2'
                    sh "curl http://${APP_IP}:5050/ | grep 'You are calling me from ${JENKINS_IP}'"
                }
            }
        }
    }
}
