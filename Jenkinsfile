// Uses Declarative syntax to run commands inside a container.
pipeline {
    agent {
        kubernetes {
            yaml '''
apiVersion: v1
kind: Pod
spec:
  containers:
  - name: shell
    image: alpine
    command:
    - sleep
    args:
    - infinity
    volumeMounts:
    - mountPath: /var/run/docker.sock
      name: docker-sock
    securityContext:
      # ubuntu runs as root by default, it is recommended or even mandatory in some environments (such as pod security admission "restricted") to run as a non-root user.
      #runAsUser: 1000
  volumes:
  - name: docker-sock
    hostPath:
      path: /var/run/docker.sock
      type: Socket
'''
            // Can also wrap individual steps:
            // container('shell') {
            //     sh 'hostname'
            // }
            defaultContainer 'shell'
            retries 2
        }
    }
    stages {
        stage('Prepare') {
            steps {
                checkout scmGit(branches: [[name: '*']],
                    extensions: [], userRemoteConfigs:
                    [[url: 'https://github.com/mturnaviotov/k8s-pdns.git']])
                sh 'apk add --no-cache helm github-cli'
                sh 'git config --global --add safe.directory "*"'
            }
        }
        stage('Run Builds') {
            parallel {
                stage('Build') {
                    steps {
                        withCredentials([usernamePassword(credentialsId: 'github_pat', passwordVariable: 'GITHUB_TOKEN', usernameVariable: 'reguser')]) {
                            sh '''
                                version=`git tag --points-at HEAD`
                                echo $version
                                helm package ./charts/pdns
                                gh release create $version ./pdns-$version.tgz -R mturnaviotov/k8s-pdns --title $version --generate-notes
                            '''
                        }
                    }
                    post {
                        always {
                            sh 'echo PowerDNS Helm package build finished. tests can be pushed here'
                        }
                    }
                }
            }
        }
    }
}
