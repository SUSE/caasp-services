// Copyright 2018 SUSE LINUX GmbH, Nuernberg, Germany.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

def targetBranch = env.getEnvironment().get('CHANGE_TARGET', env.BRANCH_NAME)

library "kubic-jenkins-library@${targetBranch}"

// TODO: Move this whole check into a function
if (env.CHANGE_AUTHOR != null) {
    // TODO: Don't hardcode salt repo name, find the right place
    // to lookup this information dynamically.
    githubCollaboratorCheck(
        org: 'kubic-project',
        repo: 'salt',
        user: env.CHANGE_AUTHOR,
        credentialsId: 'github-token')
}

// Configure the job properties
properties([
    buildDiscarder(logRotator(numToKeepStr: '15')),
    disableConcurrentBuilds(),
])

withKubicEnvironment() {
    stage('Setup Helm Client') {
        helmInstallClient()
    }

    stage('Services Tests') {
        // TODO: Hardcoding this list of charts and values isn't nice...
        parallel 'Helm: MariaDB': {
            // TDOO: Helm: MariaDB is ran by the "core" CI too. Move to
            // a shared function.
            String releaseName = "helm-" + UUID.randomUUID()

            helmInstallChart(
                environment: environment,
                releaseName: releaseName,
                chartName: "stable/mariadb",
                wait: true,
                values: [
                    service: [
                        type: "NodePort"
                    ],
                    persistence: [
                        enabled: false
                    ]
                ]
            )

            // TODO: Test if MariaDB is up and reachable and...

            helmDeleteRelease(
                environment: environment,
                releaseName: releaseName,
                purge: true
            )
        },
        'Helm: Portus': {
            String releaseName = "helm-" + UUID.randomUUID()

            dir('caasp-services/contrib/helm-charts') {
                helmDependencyBuild(
                    chartName: "portus"
                )

                helmInstallChart(
                    environment: environment,
                    releaseName: releaseName,
                    chartName: "portus",
                    wait: true,
                    values: [
                        nginx: [
                            service: [
                                type: "NodePort"
                            ],
                        ],
                        mariadb: [
                            persistence: [
                                enabled: false
                            ]
                        ],
                        mariadb: [
                            persistence: [
                                enabled: false
                            ]
                        ]
                    ]
                )

                // TODO: Test if Portus is up and reachable and...

                helmDeleteRelease(
                    environment: environment,
                    releaseName: releaseName,
                    purge: true
                )
            }
        }
    }
}