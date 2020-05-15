pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                sh 'mvn package'
            }
        }
	stage('Veracode Pipeline Scan') {
            steps {
                sh 'curl -O https://downloads.veracode.com/securityscan/pipeline-scan-LATEST.zip'
                sh 'unzip -o pipeline-scan-LATEST.zip pipeline-scan.jar'
                sh 'java -jar pipeline-scan.jar \
                    --veracode_api_id "${VERACODE_API_ID}" \
                    --veracode_api_key "${VERACODE_API_SECRET}" \
                    --project_name "verademo" \
                    --file target/verademo.war \
                    --json_output_file="baseline.json"'

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
