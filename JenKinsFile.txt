pipeline {
    agent any

    environment {
        // Folder where your deployed static site will live
        DEPLOY_DIR = 'C:\\Deploy\\BigBasketSite'
    }

    stages {
        stage('Prepare Deploy Folder') {
            steps {
                // Clean or create deploy folder on Windows
                bat '''
                if exist "C:\\Deploy\\BigBasketSite" (
                  echo Cleaning deploy folder...
                  del /Q "C:\\Deploy\\BigBasketSite\\*" 2>nul
                  for /d %%D in ("C:\\Deploy\\BigBasketSite\\*") do rd /S /Q "%%D"
                ) else (
                  echo Creating deploy folder...
                  mkdir "C:\\Deploy\\BigBasketSite"
                )
                '''
            }
        }

        stage('Deploy Static Files') {
            steps {
                // Jenkins has already checked out the repo to %WORKSPACE%
                // Copy all files (HTML/CSS/JS) to deploy folder
                bat '''
                echo Copying files to %DEPLOY_DIR% ...
                xcopy "%WORKSPACE%\\*" "%DEPLOY_DIR%\\" /E /I /Y
                '''
            }
        }
    }

    post {
        success {
            echo "✅ Deployment complete!"
            echo "Open: C:\\Deploy\\BigBasketSite\\index.html"
        }
        failure {
            echo "❌ Deployment failed. Check console output in Jenkins."
        }
    }
}
