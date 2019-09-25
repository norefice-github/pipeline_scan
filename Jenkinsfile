pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                sh 'mvn package'
            }
        }
		stage('SCA') {
			steps {
				// echo 'ts'
				sh 'curl -sSL https://download.sourceclear.com/ci.sh | sh'
			}
		}
		stage('Veracode DevOps Scan') {
            steps {
                sh 'curl -O https://downloads.veracode.com/securityscan/devops-scanner-java-LATEST.zip'
                sh 'unzip -o devops-scanner-java-LATEST.zip devops-scanner-java.jar'
                sh 'java -jar devops-scanner-java.jar \
                    --api_id "${VERACODE_API_ID}" \
                    --api_secret_key "${VERACODE_API_SECRET}" \
                    --project_name "verademo" \
                    -j target/verademo.war'
			}
		}
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
	post {
	    always {
	      archiveArtifacts artifacts: 'results.json', fingerprint: true
	    }
	}
}
