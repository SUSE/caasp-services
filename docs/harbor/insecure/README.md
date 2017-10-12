# Deploying Harbor

https://github.com/vmware/harbor

### 

This setup demonstrates a basic implementation of Harbor within Kubernetes. However, this implementation is not 
production ready. 

###

## Issues

These issues will need to be resolved before we start offering this service:

* Support for persistent storage. The stored images, and underlying database will need to be setup using 
persistent storage.
* HTTPS support. This implementation does not use HTTPS.
* Mail server support. Harbor provides integration with an email server, which can be used to send 
notifications.
* Image scanning. Harbor also offers integration with a module that periodically scans images, to check for
security issues.
   
###

## About the implementation

This implementation uses an Nginx server as a proxy to both the web ui and the Docker registry. The 
Harbor examples were used as a reference for this implementation: 
https://github.com/vmware/harbor/tree/master/make

###

## Deploying

To test out this basic configuration no changes should need to be made to the provided yml files. There is a 
very basic `start` script, which will just apply all of the yml files to the default namespace in your cluster, 
and a `cleanup` script, which will remove all of the resources.

###

## Acessing Harbor

Once all of the files have been applied, you can connect to the Harbor app from the URL `<node IP>:30523`.

`30523` is a NodePort set in the `nginx/nginx.svc.yml` file. So if you want to use a different port set the 
value there.

You will need to use the default Harbor login credentials to initially sign in:

    Username: admin
    Password: Harbor12345

###

## Pushing and pulling images

You can access the Docker registry from `<node IP>:30522`.

`30522` is a NodePort set in the `registry/registry.svc.yml` file. So if you want to use a different port set the 
value there.

You will need to setup this endpoint as an insecure registry for your Docker client before you can access it.
