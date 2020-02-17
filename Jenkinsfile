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
				sh 'curl -sSL https://download.sourceclear.com/ci.sh | sh'
			}
		}
		stage('Veracode Pipeline Scan') {
            steps {
                sh 'curl -O https://downloads.veracode.com/securityscan/pipeline-scanner-java-LATEST.zip'
                sh 'unzip -o pipeline-scanner-java-LATEST.zip pipeline-scanner-java.jar'
                sh 'java -jar pipeline-scanner-java.jar \
                    --api_id "${VERACODE_API_ID}" \
                    --api_secret_key "${VERACODE_API_SECRET}" \
                    --project_name "verademo" \
                    -j target/verademo.war \
                    --fail_on_severity="Very High, High"'

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
