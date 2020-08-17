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
		STATUS_AUTH = ''
		STATUS_CONVERT = ''
    }
	
    stages {
        stage('build'){
            steps{
				echo "environments" 
				echo "jwt -> ${USERNAME}"
				echo "dev -> ${HOST}"
				echo "host -> ${JWT_KEY_CRED_ID}"
				echo "key -> ${APP_KEY}"
				echo "deploy to ->  ${DEPLOY_TO}"
            }
        }
	    
		stage('authorization'){
			steps{
				withCredentials([file(credentialsId: JWT_KEY_CRED_ID, variable: 'jwt_key_file')]){
					script{
						STATUS_AUTH = bat(returnStatus: true, script: "sfdx force:auth:jwt:grant --clientid ${APP_KEY} --username ${USERNAME} --jwtkeyfile ./server.key --instanceurl ${HOST}") 

						if(STATUS_AUTH == 1){
							error('Error en la autorización de la organización.')
						}
					}
					echo "status -> ${STATUS_AUTH}" 
				}
			}   
		}

		stage('deploy-to-develop'){
			when{ expression { STATUS_AUTH == 0 && DEPLOY_TO == 'DEVELOP' }  }
			steps{
				echo 'develop'
			}	
		}
			
		stage('deploy-to-qa'){
			when{ expression { STATUS_AUTH == 0 && DEPLOY_TO == 'TEST' } }
			steps{
				echo 'test'
				script{
					STATUS_CONVERT = bat(returnStatus: true, script: "sfdx force:source:convert -d ./src") 
				

				}
				echo "status convert -> ${STATUS_CONVERT}"  
			}
		}
			
		stage('deploy-to-prod'){
			when{ expression { STATUS_AUTH == 0 && DEPLOY_TO == 'PROD' } }
			steps{
				echo 'prod'
			}
		}
    }
}