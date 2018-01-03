# Ingress Controllers

The Kubernetes commnunity primarily uses two Ingress Controllers, in order to support Ingress resources. 
[nginx-ingress](https://github.com/kubernetes/ingress-nginx), and
[voyager](https://github.com/appscode/voyager) are both fully featured, and actively developed Ingress
Controllers. They are both popular, and have either could potentially be used as an Ingress Controller
for CaaS.

---

## nginx-ingress

#### Overview

- Created and overseen by NGINX.
- Has great documentation https://github.com/kubernetes/ingress-nginx.
- Written in Go.
- Has an official [chart](https://github.com/kubernetes/charts/tree/master/stable/nginx-ingress).

#### Features

#### Concerns

---

## voyager

#### Overview

- Created and overseen by AppsCode.
- Does not have great documentation https://github.com/appscode/voyager/tree/master/docs. Missing
sections, and hard to find specific areas.
- Written in Go.
- Has an official [chart](https://github.com/kubernetes/charts/tree/master/stable/voyager).

#### Features

#### Concerns

---

### Comparisons

| Feauture | nginx-ingress | voyager |
|----------|--------------|------------------|
| HTTP Loadbalancing| MAYBE??? | :white_check_mark: |
| TCP Loadbalancing | MAYBE??? | :white_check_mark: |
| TLS Termination | :white_check_mark: | :white_check_mark: |
| Name and Path based virtual hosting | :white_check_mark: | :white_check_mark: |
| Cross Namespace service support | :x: | :white_check_mark: |
| URL and Header rewriting | MAYBE??? | :white_check_mark: |
| Wildcard name virtual hosting | :white_check_mark: | :white_check_mark: |
| Loadbalancer statistics | :x: | :white_check_mark: |
| Route Traffic to StatefulSet Pods Based on Host Name | MAYBE??? | :white_check_mark: |
| Weighted Loadbalancing for Canary Deployment| MAYBE??? | :white_check_mark: |
| Supports Loadbalancer Source Range | MAYBE??? | :white_check_mark: |
| Supports redirects/DNS resolve for `ExternalName` type service | MAYBE??? | :white_check_mark: |
| Expose HAProxy stats for Prometheus | :white_check_mark: | :white_check_mark: |
| Supports AWS certificate manager | :x: | :white_check_mark: |
