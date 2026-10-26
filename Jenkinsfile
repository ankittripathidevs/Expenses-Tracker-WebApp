@Library("Shared") _

pipeline {
    agent { label 'dev' }

    stages {
        // =========================
        // 1. Clone Source Code
        // =========================
        stage('Code Clone') {
            steps {
                script {
                    clone(
                        'https://github.com/ankittripathidevs/Expenses-Tracker-WebApp.git',
                        'main'
                    )
                }
            }
        }
        
        // =========================
        // 2. Resolve Dependencies
        // =========================
        stage('Resolve Maven Dependencies') {
            steps {
                sh 'chmod +x mvnw'
                sh './mvnw -B dependency:resolve'
            }
        }
        
        // =========================
        // 3. Scan File (Security)
        // =========================
        stage('Trivy File System Scan') {
            steps {
                trivy_scan()
            }
        }
        
        // =========================
        // 4. Build Docker Image
        // =========================
        stage('Build') {
            steps {
                docker_build('expenses-tracker-app', 'latest')
            }
        }
        
        // =========================
        // 5. Login + Push to Docker Hub
        // =========================
        stage('Push to Docker Hub') {
            steps {
                docker_push('expenses-tracker-app', 'expenses-tracker')
            }
        }
        
        // =========================
        // 6. Deploy
        // =========================
        stage('Deploy') {
            steps {
                docker_compose()
            }
        }
    }
    
    // =============================================
    // 7. Post-Build Actions and Email Notifications
    // =============================================
    post {
        success {
            echo 'Deployment pipeline completed successfully'
            email_notification()
        }
        
        failure {
            echo 'Deployment pipeline failed'
            email_notification()
        }
    }
}
