pipeline {
    
    agent any
    
    environment {
        DOCKER_HUB = credentials('dockerHubCreds')
    }

    stages {
        stage("Code Clone") {
            steps {
                echo "Cloning code from Github"
                git branch: "main",
                    url: "https://github.com/ankittripathidevs/Expenses-Tracker-WebApp.git"
            }
        }
        
        stage("Build") {
            steps {
                echo "Building Docker Image"
                sh "docker build -t expenses-tracker-app ."
            }
        }
        
        stage("Test") {
            steps {
                echo "Testing the Application"
            }
        }
        
        stage("Login to Docker") {
            steps {
                echo "Login to Docker"
                sh 'echo $DOCKER_HUB_PSW | docker login -u $DOCKER_HUB_USR --password-stdin'
            }
        }
        
        stage("Push to Docker Hub") {
            steps {
                echo "Push Docker Image to Docker Hub"
                sh "docker image tag expenses-tracker-app:latest  $DOCKER_HUB_USR/expenses-tracker:latest"
                sh "docker push $DOCKER_HUB_USR/expenses-tracker:latest"
            }
        }
        
        stage("Deploy") {
            steps {
                echo "Deploy the Application"
                sh "docker compose up -d --build"
            }
        }
    }
}
