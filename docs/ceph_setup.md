# CEPH Cluster for Kubernetes

## Installation of SES and CEPH

Follow these instructions: https://www.suse.com/documentation/ses-4/book_storage_admin/data/ceph_install_ceph-deploy.html

## Create CEPH Pool

On the CEPH admin node:
```bash
ceph -k ceph.client.admin.keyring osd pool create caasp 128 128
```

## Create the CEPH secret in Kubernetes

Get the key from the keyring and use it to create a secret in Kubernetes. Here the example key is "ABC123".

```bash
cat ceph.client.admin.keyring
[client.admin]
    key = ABC123

kubectl create secret generic ceph-secret --type="kubernetes.io/rbd" --from-literal=key='ABC123' --namespace=kube-system    
```

## Create the Kubernetes storage class

Create a file names `storage-class.yaml`. In the monitors section be sure to set the hostnames to match those of your SES nodes. Here the examples are "sesnode1", "sesnode2", etc.

```yaml
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: fast
provisioner: kubernetes.io/rbd
parameters:
  monitors: sesnode1:6789,sesnode2:6789,sesnode3:6789,sesnode4:6789
  adminId: admin
  adminSecretName: ceph-secret
  adminSecretNamespace: kube-system
  pool: caasp
  userId: admin
  userSecretName: ceph-secret 
```

```bash
kuubectl apply -f storage-class.yaml
```


## Use the "fast" storage class

Now when you create a kubernetes manifest that uses persistence, set the storage class to "fast".
