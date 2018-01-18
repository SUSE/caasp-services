# Ingress Controllers

A number of Ingress Controllers have been developed, in order to support Ingress resources.
[nginx-ingress](https://github.com/kubernetes/ingress-nginx),
[voyager](https://github.com/appscode/voyager),
[traefik](https://github.com/containous/traefik),
[contour](https://github.com/heptio/contour), are are all used by the community.

---

## nginx-ingress

#### Overview

- Created by NGINX.
- Has great documentation https://github.com/kubernetes/ingress-nginx.
- Written in Go.
- Has an official [chart](https://github.com/kubernetes/charts/tree/master/stable/nginx-ingress).

#### Concerns

---

## voyager

#### Overview

- Created by AppsCode.
- Does not have great documentation https://github.com/appscode/voyager/tree/master/docs. Missing
sections, and hard to find specific areas.
- Written in Go.
- Has an official [chart](https://github.com/kubernetes/charts/tree/master/stable/voyager).

#### Concerns

---

## traefik

#### Overview

- Created by Containous.

#### Concerns

---

## contour

#### Overview

- Created by Containous.

#### Concerns

- At a much more incomplete stage than the other ingress

---

### Comparisons

| Feauture | nginx-ingress | voyager | Traefik | Contour
|----------|--------------|------------------|---------|--------| 
| TLS Termination | :white_check_mark: | :white_check_mark: | :white_check_mark: | :x: |
| TLS Passthrough | :white_check_mark: | :white_check_mark: | :white_check_mark: | :x: |
| L7 Loadbalancing | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| RBAC | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| Prometheus Metric Support | :white_check_mark: | :white_check_mark: | :white_check_mark: | :x: |
| TCP Loadbalancing | :white_check_mark: | :white_check_mark: | :x: | :white_check_mark: |
| Annotation Support | :white_check_mark: | :white_check_mark: | :white_check_mark: | :x: |
| Cross Namespace Service Support | :x: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| Wildcard Virtual Hosting | :white_check_mark: | :white_check_mark: | :white_check_mark: | :x: |
| Weighted Loadbalancing | :white_check_mark: | :white_check_mark: | :white_check_mark: | :x: |
| Supports `ExternalName` Services | :white_check_mark: | :white_check_mark: | :white_check_mark: | :x: |
| Default UI | :x: | :x: | :white_check_mark: | :x: |
