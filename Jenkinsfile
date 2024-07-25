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

        stage('Build & Push Docker Image') {
            steps {
                // Exécution du playbook Ansible pour construire et pousser l'image Docker
                sh 'ansible-playbook ansible-playbook.yml'
            }
        }
    }
}
