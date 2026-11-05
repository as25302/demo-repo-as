// Jenkinsfile for DevOps Scripts (Lab 04, Exercise 4)
// Adapted: scripts live at the repo root, deploy dir is under the Jenkins home
pipeline {
    agent any

    environment {
        SERVER_REGION = 'eu-west-1'
        BUILD_ENV = 'development'
        DEPLOY_DIR = '/var/lib/jenkins/bootcamp-labs/scripts'
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
                            bash -n "$script" && echo "OK: $script syntax valid"
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

                    if [ -f "system-info.sh" ]; then
                        echo "Testing system info script..."
                        ./system-info.sh
                    fi

                    if [ -f "health-check.sh" ]; then
                        echo "Testing health check script..."
                        ./health-check.sh
                    fi
                '''
            }
        }

        stage('Deploy Scripts') {
            when {
                expression { env.GIT_BRANCH == null || env.GIT_BRANCH.endsWith('main') }
            }
            steps {
                echo "Deploying scripts to ${DEPLOY_DIR}"
                sh '''
                    echo "=== Deploying Bootcamp Scripts ==="
                    mkdir -p "$DEPLOY_DIR"
                    cp *.sh "$DEPLOY_DIR"/
                    chmod +x "$DEPLOY_DIR"/*.sh
                    echo "Deployment completed successfully"
                    ls -la "$DEPLOY_DIR"
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
