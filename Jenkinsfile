pipeline {

    agent { label 'dev' }

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
        // 2. Scan File (Security)
        // =========================
        stage('Trivy File Scan') {
            steps {
                echo 'Scanning files for vulnerabilities...'
                sh 'trivy fs . --output results.json'
            }
        }

        // =========================
        // 3. Build Docker Image
        // =========================
        stage('Build') {
            steps {
                echo 'Building Docker Image'
                sh 'docker build -t expenses-tracker-app .'
            }
        }

        // =========================
        // 4. Test
        // =========================
        stage('Test') {
            steps {
                echo 'Testing the application'
                // Add real tests here later
            }
        }

        // =========================
        // 5. Login + Push to Docker Hub
        // =========================
        stage('Push to Docker Hub') {
            steps {
                
                withCredentials([
                    usernamePassword(
                        credentialsId: "DockerHub_Credentials",
                        usernameVariable: "DockerHub_USER",
                        passwordVariable: "DockerHub_PASS"
                    )
                ]) {

                    echo 'Logging in to Docker Hub'
                    sh 'echo "$DockerHub_PASS" | docker login -u "$DockerHub_USER" --password-stdin'

                    echo 'Tagging Docker image'
                    sh 'docker image tag expenses-tracker-app:latest "$DockerHub_USER"/expenses-tracker:latest'

                    echo 'Pushing Docker image'
                    sh 'docker push "$DockerHub_USER"/expenses-tracker:latest'
                }
            }
        }

        // =========================
        // 6. Deploy
        // =========================
        stage('Deploy') {
            steps {
                echo 'Deploying application'
                sh 'docker compose up -d --build'
            }
        }
    }
}
