# Deploying Portus

https://github.com/SUSE/Portus

### 

This setup demonstrates a basic implementation of Portus within Kubernetes. However, this implementation is not 
production ready. 

###

## Issues

These issues will need to be resolved before we start offering this service:

* Support for persistent storage. The stored images, and underlying database will need to be setup using 
persistent storage.
* HTTPS support. This implementation does not use HTTPS. I was able to augment this deployment and get it 
working with full SSL support by self signing certificates across the containers, and forcing the containers 
to trust the certs. So adding support for HTTPS to this configuration is possible, but will require some 
additional work to implement it in a clean way.
* Image scanning. There is documentation explaining how to setup image scanning to periodically check 
uploaded images for security purposes:
http://port.us.org/features/6_security_scanning.html
   
###

## About the implementation

This implementation uses an Nginx server as a proxy to both the Portus application and the Docker registry. The 
Portus DockerCompose examples were used as a reference for this implementation: 
https://github.com/SUSE/Portus/tree/master/examples/compose

The Nginx setup, which was heavily borrowed from the Portus guide was originally implemented by Djelibeybi: 
https://github.com/Djelibeybi/Portus-On-OracleLinux7/

An image based off of the official `opensuse/portus` image is used for the Portus and Crono containers. This 
image updates the `/srv/Portus/config/config.yml` file to not require an SSL connection, in order to facilitate 
an insecure setup, as well as changes the FQDN from `portus.test.lan`. 
https://hub.docker.com/r/jbonham/portus-dev/

###

## Deploying

To test out this basic configuration no changes should need to be made to the provided yml files. There is a 
very basic `start` script, which will just apply all of the yml files to the default namespace in your cluster, 
and a `cleanup` script, which will remove all of the resources.

###

## Acessing Portus

Once all of the files have been applied, you can connect to the Portus app from the URL `<node IP>:32123`

`32123` is a NodePort set in the `nginx/nginx.svc.yml` file. So if you want to use a different port set the 
value there.

Once you have setup a User account, you will be prompted to associate the site with a registry. You can name 
the registry whatever you want, but make sure to set:
    
    `Hostname: registry:30521`
and do not check the box that says `Use SSL`.

###

## Pushing and pulling images

You can access the Docker registry from `<node IP>:30521`.

`30521` is a NodePort set in the `registry/registry.svc.yml` file. So if you want to use a different port set the 
value there.

You will need to setup this endpoint as an insecure registry for your Docker client before you can access it.

