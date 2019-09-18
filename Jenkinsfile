pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
				sh 'ls -a'
                echo 'Building..'
                sh 'mvn package'
            }
        }
		stage('SCA') {
			steps {
				sh 'curl -sSL https://download.sourceclear.com/ci.sh | sh'
			}
		}
		stage('Veracode DevOps Scan') {
            steps {
				sh 'ls -a'
				sh 'whoami'
                // sh 'curl https://downloads.veracode.com/securityscan/devops-scanner-java-LATEST.zip'
				sh 'ls -a'
                // sh 'unzip devops-scanner-java-LATEST.zip devops-scanner-java.jar'
				// sh 'ls -a'
                sh 'java -jar devops-scanner-java.jar \
                    --api_id "${VERACODE_API_ID}" \
                    --api_secret_key "${VERACODE_API_SECRET}" \
                    --project_name "verademo" \
                    -j target/veradeom.war'
			}
		}
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
	// post {
	//     always {
	//       archiveArtifacts artifacts: 'results.json', fingerprint: true
	//     }
	// }
}
