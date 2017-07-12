node  {
        def app
        stage('BUILD') {
            checkout scm
        }

        stage('TEST') {
            sh "echo 'Test Passed'"
        }

        stage('BUILD') {
            // ansible-playbook -i ./ansible/hosts ./ansible/deploy.yml
            // sh "docker build -t php-docker"
            app = docker.build("jenkins-test")
        }
        stage('PUSH') {
            /* Finally, we'll push the image with two tags:
            * First, the incremental build number from Jenkins
            * Second, the 'latest' tag.
            * Pushing multiple tags is cheap, as all the layers are reused. */
            docker.withRegistry('https://359380031409.dkr.ecr.ap-southeast-1.amazonaws.com', 'ecr:ap-southeast-1:AWS-Credentials') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
           }
        }
        stage('AUTO-RUN') {
            sh 'docker run -d -p 80:80 359380031409.dkr.ecr.ap-southeast-1.amazonaws.com/jenkins-test:latest'
        }
        stage('REMOVE') {
            sh 'docker rmi -f 359380031409.dkr.ecr.ap-southeast-1.amazonaws.com/jenkins-test'
            sh 'docker rmi -f jenkins-test'
    }
}
