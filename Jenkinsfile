pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                powershell 'mvn package'
            }
        }
	stage('Veracode Pipeline Scan') {
		environment {
			SERVICE_CREDS = credentials('VERACODE_API_ACCOUNT')
			}

		steps {	
			powershell """				
			curl  https://downloads.veracode.com/securityscan/pipeline-scan-LATEST.zip -o pipeline-scan.zip
			Expand-Archive -Force -Path pipeline-scan.zip -DestinationPath veracode_scanner
			java -jar veracode_scanner\\pipeline-scan.jar --veracode_api_id '${SERVICE_CREDS_USR}' \
			--veracode_api_key '${SERVICE_CREDS_PSW}' \
			--file target/verademo.war \
			--json_output_file="baseline.json"
			$LASTEXITCODE = 0
			"""
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
