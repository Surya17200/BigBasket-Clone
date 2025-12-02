pipeline {
    agent any

    environment {
        // TODO: change this to your real Tomcat webapps path if different
        TOMCAT_WEBAPPS = 'C:\\Tomcat\\webapps'
        APP_CONTEXT    = 'bigbasket'  // will be available at http://localhost:8080/bigbasket/
        DEPLOY_DIR     = "${TOMCAT_WEBAPPS}\\${APP_CONTEXT}"
    }

    stages {
        stage('Prepare Deploy Folder') {
            steps {
                // Create or clean the Tomcat context folder on Windows
                bat '''
                echo ==== Preparing Tomcat deploy folder ====

                set "TARGET=%DEPLOY_DIR%"

                if not exist "%TARGET%" (
                  echo Creating folder "%TARGET%" ...
                  mkdir "%TARGET%"
                ) else (
                  echo Cleaning folder "%TARGET%" ...
                  del /Q "%TARGET%\\*" 2>nul
                  for /d %%D in ("%TARGET%\\*") do rd /S /Q "%%D"
                )
                '''
            }
        }

        stage('Deploy Static Files') {
            steps {
                // Jenkins has already checked out the repo to %WORKSPACE%
                // Copy all files (HTML/CSS/JS) to Tomcat webapps context folder
                bat '''
                echo ==== Deploying static files to Tomcat ====
                echo Copying files from "%WORKSPACE%" to "%DEPLOY_DIR%" ...

                xcopy "%WORKSPACE%\\*" "%DEPLOY_DIR%\\" /E /I /Y

                echo ✅ Deployment complete!
                echo Application should be available at: http://localhost:8080/%APP_CONTEXT%/
                '''
            }
        }
    }

    post {
        success {
            echo "✅ Deployment to Tomcat succeeded."
            echo "Open: http://localhost:8080/${APP_CONTEXT}/"
        }
        failure {
            echo "❌ Deployment failed. Check console output in Jenkins."
        }
    }
}
