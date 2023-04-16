pipeline {
    agent any
    
    environment {
        REHO = "ssh -o StrictHostKeyChecking=no ubuntu@52.91.254.29"
    }

    stages {
        stage('Git Clone') {
            steps {
                sshagent(['ubuntu']) {
                sh ' $REHO sudo rm -rf backup-repo'
                sh ' $REHO sudo git clone https://github.com/fancystuff4/backup-repo.git'
             }
            }
        } 
        stage('Create backup ') {
            steps {
                sshagent(['ubuntu']) {
                sh ' $REHO sudo ls backup-repo'
                sh ' $REHO sudo sh backup-repo/CreateBackup.sh'
             }
            }
        }
        stage('Delete Old Backups ') {
            steps {
                sshagent(['ubuntu']) {
                sh ' $REHO sudo sh backup-repo/DeleteBackup.sh'
             }
            }
        }
        
        
        
    }
}