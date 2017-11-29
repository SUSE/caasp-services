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

## SSH Keys

To run Portus you'll need an SSL key and certificate that cover the domain names `portus.service.name`,
`registry.service.name` and `nginx.service.name`. For your convenience, this chart provides
a default key `portus.key` and certificate `portus.cert`, but it is recommended that you generate
your own key and certificate.

```console
TODO
```

And update the `values.yaml` file with the generated keys:

## Configuration

The following tables lists the configurable parameters of the portus chart and their default values.

| Parameter                            | Description                                | Default                                                    |
| ------------------------------------ | ------------------------------------------ | ---------------------------------------------------------- |
| `portus.replicas`                    | Portus deployment replica count            | `1`                                                        |
| `portus.image.repository`            | Portus image repository name               | `opensuse/portus`                                          |
| `portus.image.tag`                   | Portus image tag name                      | `head`                                                     |
| `portus.image.pullPolicy`            | Portus image pull policy                   | `IfNotPresent`                                             |
| `portus.service.name`                | Portus service name                        | `portus`                                                   |
| `portus.service.port`                | Portus service port                        | `3000`                                                     |
| `portus.resources.requests.memory`   | Portus deployment memory resources         | `512Mi`                                                    |
| `portus.resources.requests.cpu`      | Portus deployment cpu resources            | `300m`                                                     |
| `portus.productionDatabase`          | Name of database Portus will use           | `portus`                                                   |
| `portus.productionUsername`          | Name of database user Portus will use      | `portus`                                                   |
| `portus.productionHost`              | Name of host providing database            | `nil`                                                      |
| `portus.productionPassword`          | Password to connect to database            | `nil`                                                      |
| `portus.password`                    | Password used for background job user      | _random 10 character long alphanumeric string_             |
| `portus.secretKeyBase`               | Ruby on Rails secret app key               | _random 128 character long alphanumeric string_            |
| `portus.key`                         | SSL key used between services              | _generated example key_                                    |
| `portus.cert`                        | SSL certificate used between services      | _self signed example certificate_                          |
| `crono.replicas`                     | Crono deployment replica count             | `1`                                                        |
| `crono.image.repository`             | Crono image repository name                | `opensuse/portus`                                          |
| `crono.image.tag`                    | Crono image tag name                       | `head`                                                     |
| `crono.image.pullPolicy`             | Crono image pull policy                    | `IfNotPresent`                                             |
| `crono.resources.requests.memory`    | Crono deployment memory resources          | `512Mi`                                                    |
| `crono.resources.requests.cpu`       | Crono deployment cpu resources             | `300m`                                                     |
| `registry.replicas`                  | Docker registry deployment replica count   | `1`                                                        |
| `registry.mountPath`                 | Path uploaded images are stored at         | `/storage`                                                 |
| `registry.persistence.enabled`       | Docker registry use persistent storage     | `true`                                                     |
| `registry.persistence.accessMode`    | Docker registry persistence access mode    | `ReadWriteOnce`                                            |
| `registry.persistence.capacity`      | Docker registry persistence capacity       | `10Gi`                                                     |
| `registry.image.repository`          | Docker registry image repository name      | `library/registry`                                         |
| `registry.image.tag`                 | Docker registry image tag name             | `latest`                                                   |
| `registry.image.pullPolicy`          | Docker registry image pull policy          | `IfNotPresent`                                             |
| `registry.service.port`              | Docker registry API port                   | `5000`                                                     |
| `registry.service.debugPort`         | Docker registry debug port                 | `5001`                                                     |
| `registry.resources.requests.memory` | Registry deployment memory resources       | `512Mi`                                                    |
| `registry.resources.requests.cpu`    | Registry deployment cpu resources          | `300m`                                                     |
| `nginx.replicas`                     | Nginx deployment replica count             | `1`                                                        |
| `nginx.image.repository`             | Nginx image repository name                | `library/nginx`                                            |
| `nginx.image.tag`                    | Nginx image tag name                       | `alpine`                                                   |
| `nginx.image.pullPolicy`             | Nginx registry image pull policy           | `IfNotPresent`                                             |
| `nginx.host`                         | Domain name nginx proxy should use         | `portus-test.us.to`                                        |
| `nginx.service.name`                 | Nginx service name                         | `nginx`                                                    |
| `nginx.service.type`                 | Nginx service type                         | `NodePort`                                                 |
| `nginx.service.nodePort`             | Nginx proxy external port                  | `32123`                                                    |
| `nginx.service.port`                 | Nginx proxy internal port                  | `443`                                                      |
| `nginx.ingress.enabled`              | Determines if nginx proxy uses ingress     | `false`                                                    |
| `nginx.ingress.annotations`          | Nginx ingress annotations                  | `{}`                                                       |
| `nginx.ingress.tls`                  | Nginx TLS configuration                    | `[]`                                                       |
| `nginx.resources.requests.memory`    | Nginx deployment memory resources          | `512Mi`                                                    |
| `nginx.resources.requests.cpu`       | Nginx deployment cpu resources             | `300m`                                                     |
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

## Ingress

This chart provides support for ingress resources. If you have an
ingress controller installed on your cluster, such as [nginx-ingress](https://kubeapps.com/charts/stable/nginx-ingress)
or [traefik](https://kubeapps.com/charts/stable/traefik) you can utilize
the ingress controller to service your Portus application.

To enable ingress set `portus.ingress.enabled` to `true`.

### Host
The host set in `portus.ingress.host` will be set as the host associated with the nginx proxy, which is the
entrypoint into both the Portus application, and the Docker registry.

### Annotations
For annotations, please see [this document](https://github.com/kubernetes/ingress-nginx/blob/master/docs/annotations.md).
Not all annotations are supported by all ingress controllers, but this
document does a good job of indicating which annotation is supported by
many popular ingress controllers.

### TLS Secrets
If your cluster allows automatic creation/retrieval of TLS certificates (e.g. [kube-lego](https://github.com/jetstack/kube-lego)), please refer to the documentation for that mechanism.

To manually configure TLS, first create/retrieve a key & certificate pair for the address you wish to protect. Then create a TLS secret in the namespace:

```console
kubectl create secret tls portus-tls --cert=path/to/tls.cert --key=path/to/tls.key
```

Include the secret's name, along with the desired hostnames, in the `nginx.ingress.tls` section of your custom `values.yaml` file.

## MariaDB

By default, this chart will use a MariaDB database deployed as a chart dependency. You can also bring your own MariaDB. To do so
set `mariadb.enabled` to `false`, and set `portus.productionHost` to the address of the host providing the MariaDB that you
would like to use, and `portus.productionPassword` to the password of the database you would like to use.
