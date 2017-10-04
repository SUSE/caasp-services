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
* Docker CLI support from outside the cluster. This implementation creates a working registry, but does not 
support docker login, or pushing and pulling from outside the cluster. There are two reasons why access from 
outside the cluster is currently not working:
    * When attempting to login to the Docker registry the request is initially redirected to an endpoint that 
    authenticates the User, and returns a token. This endpoint is internal to the Kubernetes cluster, and resolves 
    when containers within the deployment use it. However if the registry pods 5000 port is exposed outside of the 
    cluster, and an outside Docker client tries to login to the registry, the registry sends the client back the 
    internal token authentication url, which is not resolvable outside the cluster, so the client is unable to 
    receive a token.
    * Internally the Docker registry is given the domain name `registry`, and listens on port `5000`. The Portus 
    app also saves a reference to the registry connection point when being set up, and only allows images to be 
    pushed to the exact endpoint that is saved when setting up the app. So even if the registry pod is exposed on 
    a NodePort, pushes will be rejected since the external Docker client needs to be set up to communicate with 
    the registry through the NodePort, which will not match the internal registry endpoint. The push requests 
    show the external NodePort as part of the registry request, and the Portus app rejects the push request. I 
    tried setting the registry port internally to something in the NodePort range so that the NodePort could 
    potentially be setup to be identical to the internal representation, but that seemed to break the registry app. 
    It may be possible to change the internal port with some more config changes, but we probably want to address 
    this in a cleaner way.
   
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
    
    `Hostname: registry:5000`
and do not check the box that says `Use SSL`.

###

## Pushing and pulling images

In order to test that the registry is working correctly it is necessary to login to the registry within the 
cluster. You can SSH into a node running in your cluster, and then you should be able to push and pull to the 
registry. 

*Note, you will have to add the registry as an `--insecure-registry` to the Docker daemen running on the node 
in order to be able to connect to it. I updated the hosts file on the node I was logged into on my cluster to 
resolve the corresponding pod IP addresses to the domain names `portus` `nginx` and `registry`. I then added the 
argument `--insecure-registry registry:5000` to `/etc/sysconfig/docker`. It was then necessary to restart the 
Docker daemen on my node, which restarted all of the pods. But once they started back up I was able to check 
that pushing and pulling worked. This is of course not ideal at all, but it demonstrates that the registry is 
functional.

