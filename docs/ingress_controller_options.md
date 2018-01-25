# Ingress Controllers

A number of Ingress Controllers have been developed in order to support Ingress resources in 
Kubernetes. [nginx-ingress](https://github.com/kubernetes/ingress-nginx),
[voyager](https://github.com/appscode/voyager),
[traefik](https://github.com/containous/traefik),
[contour](https://github.com/heptio/contour), are are all used by the community.

---

## nginx-ingress

#### Overview

- Created by NGINX.
- Detailed [documentation](https://github.com/kubernetes/ingress-nginx/blob/master/README.md).
- Written in Go.
- Has an official [chart](https://github.com/kubernetes/charts/tree/master/stable/nginx-ingress).

#### Concerns

- The NGINX Ingress Controller can be set up to either work across all namespaces, or 
within a single namespace. The other controllers allow using a subset of namespaces. Users 
can acheive the same effect using NGINX and deploying multiple controllers however, 
so it may not be a critical issue.

---

## voyager

#### Overview

- Created by AppsCode.
- Detailed [documentation](https://appscode.com/products/voyager/5.0.0-rc.11/welcome/).
- Written in Go.
- Has an official [chart](https://github.com/kubernetes/charts/tree/master/stable/voyager).

---

## traefik

#### Overview

- Created by Containous.
- Detailed [documentation](https://docs.traefik.io/).
- Written in Go.
- Has an official [chart](https://github.com/kubernetes/charts/tree/master/stable/traefik).

#### Concerns

- Traefik only supports L7 level proxying currently, although there is discussion of adding 
support for proxing at TCP level.

---

## contour

#### Overview

- Created by Heptio.
- Written in Go, but uses Envoy as a reverse proxy, which is written in C++.

#### Concerns

- At a much more incomplete stage than the other Ingress Controllers.
- Limited [documentation](https://github.com/heptio/contour/tree/master/docs).
- Does not have an official chart.

---

### Comparisons

| Feauture                         | nginx-ingress      | voyager            | Traefik            | Contour            |
|----------------------------------|--------------------|--------------------|--------------------|--------------------|
| TLS Termination                  | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| TLS Passthrough                  | :white_check_mark: | :white_check_mark: | :white_check_mark: | :x:                |
| L7 Loadbalancing                 | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| TCP Loadbalancing                | :white_check_mark: | :white_check_mark: | :x:                | :white_check_mark: |
| RBAC Support                     | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| Prometheus Metric Support        | :white_check_mark: | :white_check_mark: | :white_check_mark: | :x:                |
| Annotation Support               | :white_check_mark: | :white_check_mark: | :white_check_mark: | :x:                |
| Cross Namespace Service Support  | :x:                | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| Wildcard Virtual Hosting         | :white_check_mark: | :white_check_mark: | :white_check_mark: | :x:                |
| Weighted Loadbalancing           | :white_check_mark: | :white_check_mark: | :white_check_mark: | :x:                |
| Supports `ExternalName` Services | :white_check_mark: | :white_check_mark: | :white_check_mark: | :x:                |
| Built in UI                      | :x:                | :x:                | :white_check_mark: | :x:                |
