// Jenkinsfile for DevOps Scripts
pipeline {
    agent any

    environment {
        SERVER_REGION = 'eu-west-1'
        BUILD_ENV = 'development'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
                echo "Checked out bootcamp scripts from Git"
                echo "Branch: ${env.GIT_BRANCH}"
            }
        }

        stage('Script Validation') {
            steps {
                echo "Validating scripts..."
                sh '''
                    echo "=== Script Validation ==="
                    for script in *.sh; do
                        if [ -f "$script" ]; then
                            echo "Checking syntax: $script"
                            bash -n "$script" && echo "✓ $script syntax OK"
                        fi
                    done
                '''
            }
        }

        stage('Test Scripts') {
            steps {
                echo "Testing bootcamp scripts..."
                sh '''
                    echo "=== Testing Scripts ==="
                    chmod +x *.sh

                    if [ -f "health-check.sh" ]; then
                        echo "Testing health check script..."
                        ./health-check.sh
                    fi
                '''
            }
        }

        stage('Deploy Scripts') {
            when {
                expression { env.GIT_BRANCH == 'origin/main' }
            }
            steps {
                echo "Deploying scripts to /var/lib/jenkins/bootcamp-labs"
                sh '''
                    echo "=== Deploying Bootcamp Scripts ==="
                    mkdir -p /var/lib/jenkins/bootcamp-labs/scripts
                    cp *.sh /var/lib/jenkins/bootcamp-labs/scripts/
                    chmod +x /var/lib/jenkins/bootcamp-labs/scripts/*.sh
                    echo "Deployment completed successfully"
                    ls -la /var/lib/jenkins/bootcamp-labs/scripts/
                '''
            }
        }
    }

    post {
        always {
            echo "Bootcamp Pipeline completed"
            archiveArtifacts artifacts: '*.sh', allowEmptyArchive: true
        }
        success {
            echo "Bootcamp Pipeline succeeded!"
        }
        failure {
            echo "Bootcamp Pipeline failed!"
        }
    }
}
