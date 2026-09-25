pipeline {

    agent any

    stages {
        
        // =========================
        // 1. Clone Source Code
        // =========================
        stage('Code Clone') {
            steps {
                echo 'Cloning code from GitHub'
                git branch: 'main',
                    url: 'https://github.com/ankittripathidevs/Expenses-Tracker-WebApp.git'
            }
        }

        // =========================
        // 2. Build Docker Image
        // =========================
        stage('Build') {
            steps {
                echo 'Building Docker image'
                sh 'docker build -t expenses-tracker-app .'
            }
        }

        // =========================
        // 3. Test
        // =========================
        stage('Test') {
            steps {
                echo 'Testing the application'
                // Add real tests here later
            }
        }

        // =========================
        // 4. Login + Push to Docker Hub
        // =========================
        stage('Push to Docker Hub') {
            steps {
                
                withCredentials([
                    usernamePassword(
                        credentialsId: "DockerHub_Credentials",
                        usernameVariable: "DockerHub_User",
                        passwordVariable: "DockerHub_Pass"
                    )
                ]) {

                    echo 'Logging in to Docker Hub'
                    sh 'echo "$DockerHub_Pass" | docker login -u "$DockerHub_User" --password-stdin'

                    echo 'Tagging Docker image'
                    sh 'docker image tag expenses-tracker-app:latest "$DockerHub_User"/expenses-tracker:latest'

                    echo 'Pushing Docker image'
                    sh 'docker push "$DockerHub_User"/expenses-tracker:latest'
                }
            }
        }

        // =========================
        // 5. Deploy
        // =========================
        stage('Deploy') {
            steps {
                echo 'Deploying application'
                sh 'docker compose up -d --build'
            }
        }
    }
}
