pipeline {
    agent any

    environment {
        // Spécifiez directement le nom d'utilisateur et le mot de passe Docker Hub
        DOCKERHUB_USERNAME = 'houssem1988'
        DOCKERHUB_PASSWORD = 'dckr_pat__o7UwyM3sqq65CusO3adbSx8qTQ'
    }

    stages {
        stage('Docker Login') {
            steps {
                script {
                    // Connexion à Docker Hub en utilisant les informations d'identification fournies
                    sh "echo '${DOCKERHUB_PASSWORD}' | docker login -u '${DOCKERHUB_USERNAME}' --password-stdin"
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                // Construction de l'image Docker
                sh 'docker build -t houssem1988/automatisation-cypress .'
            }
        }

        stage('Push Docker Image') {
            steps {
                // Pousser l'image Docker sur Docker Hub
                sh 'docker push houssem1988/automatisation-cypress'
            }
        }

        stage('Deploy Docker Container') {
            steps {
                script {
                    // Arrêter et supprimer le conteneur existant s'il existe
                    sh 'docker stop web-container || true'
                    sh 'docker rm web-container || true'
                    
                    // Exécuter le nouveau conteneur
                    sh 'docker run -d --name web-container -p 5001:80 houssem1988/automatisation-cypress'
                }
            }
        }
    }
}
