pipeline {
    agent {
        kubernetes {
                label 'flask-app-agent'
                yaml """
apiVersion: v1
kind: Pod
metadata:
  labels:
    component: ci
spec:
  containers:
  - name: python
    image: python:3.12-slim
    command:
    - cat
    tty: true
"""
        }
    }

    triggers {
        pollSCM('* * * * *')
    }

    stages {
        stage('Test python') {
            steps {
                container('python') {
                    sh "pip install -r requirements.txt"
                    sh "python test.py"
                }
            }
        }
        stage('Build image') {
            steps {
                container('docker') {
                    sh "docker build -t localhost:4000/pythontest:latest ."
                    sh "docker push localhost:4000/pythontest:latest"
                }
            }
        }
    }
}