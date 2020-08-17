pipeline {
    agent any
    tools {
		nodejs "node"
    }
	
    environment {
    	USERNAME = 'test.qa@independent.com.qa'
    	HOST = 'https://test.salesforce.com'
    	JWT_KEY_CRED_ID = '	2bf2a624-7cc1-4f62-b584-6eaf9f65ac1c'
    	APP_KEY = '3MVG9c1ghSpUbLl_IxBNYH.gK6tuc6I01uwv00pBt8_jo0wr8qs343M.DfWVghj2yj4VATte8rnu2xL1p2Y52'
		STATUS = '' 
    }
	
    stages {
        stage('build'){
            steps {
				echo "environments" 
				echo "jwt -> ${USERNAME}"
				echo "dev -> ${HOST}"
				echo "host -> ${JWT_KEY_CRED_ID}"
				echo "key -> ${APP_KEY}"
				echo "stage ->  ${STAGE}"
				echo "deploy to ->  ${DEPLOY_TO}"
            }
        }
	    
		stage('authorization'){
			steps {
				withCredentials([file(credentialsId: JWT_KEY_CRED_ID, variable: 'jwt_key_file')]) {
					script {
						STATUS = bat(returnStatus: true, script: "sfdx force:auth:jwt:grant --clientid ${APP_KEY} --username ${USERNAME} --jwtkeyfile ./server.key --instanceurl ${HOST}") 
					}
					echo "status -> ${STATUS}" 
				}
			}   
		}

		stage('develop'){
			when { expression { STATUS == 0 && STAGE == 'DEVELOP' }  }
			steps {
				echo 'develop'
			}	
		}
			
		stage('test'){
			when { expression { STATUS == 0 && STAGE == 'TEST' } }
			steps {
				echo 'test'
			}
		}
			
		stage('prod'){
			when { expression { STATUS == 0 && STAGE == 'PROD' } }
			steps {
				echo 'prod'
			}
		}
    }
}