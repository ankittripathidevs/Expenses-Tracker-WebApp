pipeline {
    
    agent any;
    
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
        
        stage("Deploy") {
            steps {
                echo "Deploy the Application"
                sh "docker compose up -d --build"
            }
        }
    }
}
