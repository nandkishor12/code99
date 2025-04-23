pipeline {
    agent any

    environment {
        AWS_REGION = 'ap-south-1'
        BUCKET1 = 'Nandkishor'  // Make this globally unique!
        BUCKET2 = 'vijay wankhede'
        FILE_NAME = 'test.txt'
        AWS_ACCESS_KEY_ID = 'AKIA45Y2RSG5BIZE6XER'
        AWS_SECRET_ACCESS_KEY= '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'
    }

    stages {
        stage('Create Buckets') {
            steps {
                script {
                    sh """
                    echo "Creating Bucket1 if not exists: $BUCKET1"
                    aws s3api head-bucket --bucket $BUCKET1 2>/dev/null || \
                    aws s3api create-bucket --bucket $BUCKET1 --region $AWS_REGION \
                        --create-bucket-configuration LocationConstraint=$AWS_REGION

                    echo "Creating Bucket2 if not exists: $BUCKET2"
                    aws s3api head-bucket --bucket $BUCKET2 2>/dev/null || \
                    aws s3api create-bucket --bucket $BUCKET2 --region $AWS_REGION \
                        --create-bucket-configuration LocationConstraint=$AWS_REGION
                    """
                }
            }
        }

        stage('Create Sample File') {
            steps {
                sh 'echo "This is a test file" > $FILE_NAME'
            }
        }

        stage('Upload File to Bucket1') {
            steps {
                sh 'aws s3 cp $FILE_NAME s3://$BUCKET1/'
            }
        }

        stage('Sync nw-test1 to nw-test2') {
            steps {
                sh 'aws s3 sync s3://$BUCKET1 s3://$BUCKET2'
            }
        }

        stage('Verify Sync') {
            steps {
                sh '''
                echo "Contents of $BUCKET1:"
                aws s3 ls s3://$BUCKET1/

                echo "Contents of $BUCKET2:"
                aws s3 ls s3://$BUCKET2/
                '''
            }
        }
    }

    post {
        failure {
            echo "Pipeline failed. Check previous steps for errors."
        }
    }
}
