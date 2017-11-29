# Portus

[Portus](http://port.us.org/) Portus is an open source authorization service and user interface for the next generation Docker Registry.

## TL;DR;

```console
$ helm install incubator/portus
```

## Introduction

This chart bootstraps a [Portus](http://port.us.org/) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

It also packages the [Bitnami MariaDB chart](https://github.com/kubernetes/charts/tree/master/stable/mariadb) which is required for bootstrapping a MariaDB deployment for the database requirements of the Portus application.

## Prerequisites

- Kubernetes 1.4+ with Beta APIs enabled
- PV provisioner support in the underlying infrastructure

## Installing the Chart

To install the chart with the release name `my-release`:

```console
$ helm install --name my-release incubator/portus
```

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
$ helm delete my-release
```

The command removes nearly all the Kubernetes components associated with the
chart and deletes the release.

## Configuration

The following tables lists the configurable parameters of the portus chart and their default values.

| Parameter                            | Description                                | Default                                                    |
| -------------------------------      | -------------------------------            | ---------------------------------------------------------- |
| `portus.name`                        | Name used in portus resource tags          | `portus`                                                   |
| `portus.image.repository`            | Portus image repository name               | `opensuse/portus`                                          |
| `portus.image.tag`                   | Portus image tag name                      | `head`                                                     |
| `portus.image.pullPolicy`            | Portus image pull policy                   | `IfNotPresent`                                             |
| `portus.replicas`                    | Portus deployment replica count            | `1`                                                        |
| `portus.port`                        | Portus service port                        | `3000`                                                     |
| `portus.productionDatabase`          | Name of database Portus will use           | `portus`                                                   |
| `portus.productionUsername`          | Name of database user Portus will use      | `portus`                                                   |
| `portus.productionHost`              | Name of host providing database            | `nil`                                                      |
| `portus.productionPassword`          | Password to connect to database            | `nil`                                                      |
| `portus.railsServeStaticFiles`       | Determines if Portus serves static files   | `true`                                                     |
| `portus.password`                    | Password used for background job user      | _random 10 character long alphanumeric string_             |
| `portus.secretKeyBase`               | Ruby on Rails secret app key               | _random 128 character long alphanumeric string_            |
| `portus.key`                         | SSL key used between services              | _generated example key_                                    |
| `portus.cert`                        | SSL certificate used between services      | _self signed example certificate_                          |
| `crono.name`                         | Name used in crono resource tags           | `crono`                                                    |
| `crono.image.repository`             | Crono image repository name                | `opensuse/portus`                                          |
| `crono.image.tag`                    | Crono image tag name                       | `head`                                                     |
| `crono.image.pullPolicy`             | Crono image pull policy                    | `IfNotPresent`                                             |
| `crono.replicas`                     | Crono deployment replica count             | `1`                                                        |
| `registry.name`                      | Name used in docker registry resource tags | `registry`                                                 |
| `registry.mountPath`                 | Path uploaded images are stored at         | `/storage`                                                 |
| `registry.persistence.enabled`       | Docker registry use persistent storage     | `true`                                                     |
| `registry.persistence.accessMode`    | Docker registry persistence access mode    | `ReadWriteOnce`                                            |
| `registry.persistence.capacity`      | Docker registry persistence capacity       | `10Gi`                                                     | 
| `registry.image.repository`          | Docker registry image repository name      | `library/registry`                                         |
| `registry.image.tag`                 | Docker registry image tag name             | `latest`                                                   |
| `registry.image.pullPolicy`          | Docker registry image pull policy          | `IfNotPresent`                                             |
| `registry.replicas`                  | Docker registry deployment replica count   | `1`                                                        |
| `registry.port`                      | Docker registry API port                   | `5000`                                                     |
| `registry.debugPort`                 | Docker registry debug port                 | `5001`                                                     |
| `nginx.name`                         | Name used in nginx resource tags           | `nginx`                                                    |
| `nginx.image.repository`             | Nginx image repository name                | `library/nginx`                                            |
| `nginx.image.tag`                    | Nginx image tag name                       | `alpine`                                                   |
| `nginx.fqdn`                         | Domain nginx proxy should use              | `portus-test.us.to`                                        |
| `nginx.service.type`                 | Nginx service type                         | `NodePort`                                                 |
| `nginx.service.port`                 | Nginx proxy internal port                  | `443`                                                      |
| `nginx.service.nodePort`             | Nginx proxy external port                  | `32123`                                                    |
| `nginx.ingress.enabled`              | Determines if nginx proxy uses ingress     | `false`                                                    |
| `nginx.ingress.annotations`          | Nginx ingress annotations                  | `{}`                                                       |
| `nginx.ingress.tls`                  | Nginx TLS configuration                    | `[]`                                                       |
| `mariadb.enabled`                    | Mariadb chart should be installed          | `true`                                                     |
| `mariadb.persistence.enabled`        | Mariadb use persistent storage             | `false`                                                    |
| `mariadb.persistence.accessMode`     | Mariadb persistence access mode            | `ReadWriteOnce`                                            |
| `mariadb.persistence.size`           | Mariadb persistence capacity               | `8Gi`                                                      |
| `mariadb.mariadbUser`                | Mariadb user account name                  | `portus`                                                   |
| `mariadb.mariadbDatabase`            | Mariadb database name                      | `portus`                                                   | 

The above parameters map to the env variables defined in [opensuse/portus](https://hub.docker.com/r/opensuse/portus/). For more information please refer to the [opensuse/portus](https://hub.docker.com/r/opensuse/portus/) image documentation.

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```console
$ helm install --name my-release --set portus.replicas=2 incubator/portus
```

The above command will install Portus with a deployment set up to use two replicas.

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart. For example,

```console
$ helm install --name my-release -f values.yaml incubator/portus
```

> **Tip**: You can use the default [values.yaml](values.yaml)

## Persistence

The [Docker Registry](https://hub.docker.com/_/registry/) image stores the image data at the `.Values.registry.persistence.storagePath` path of the container.

Persistent Volume Claims are used to keep the data across deployments. This is known to work in GCE, AWS, and minikube.
See the [Configuration](#configuration) section to configure the PVC or to disable persistence.
