# Private Docker Image Registry Solutions

There are two actively developed and fully featured private Docker Registry management tools available- Portus and Harbor. They 
both provide web based UI's, and have fully containerized solutions. Each have a number of strengths and weaknesses. 

---

## Portus

#### Overview

- Created and overseen by SUSE.
- Has great documentation http://port.us.org/documentation.html.
- Written in Ruby on Rails.
- Configured to run on a Puma web server (or ngnix), a Mariadb database, the Docker registry, and a crono process to keep the 
Docker Registry and database synced up.

#### Web Interface

- Browsable collection of Images, organized by Namespace and group.
- Admin tools, which provide an interface to add new Users, Namespaces, Groups and Webhooks.
- Logs can be viewed and downloaded.
- Users have interactive abilities- Images can be starred and commented on.

#### Unique Features

- Multiple Docker Registries can be setup.
- Custom Webhook support. Users can create Webhooks for different Namespaces, which are either triggered after GET or POST
actions, and which send data to a provided URL. Webhooks can be disabled.
- Ability to star Images.
- Users can be grouped together, and then added to Namespaces as a group, instead of individually.
- Users can comment on Images.
- Logs can be downloaded as CSV files.

## Harbor

#### Overview

- Harbor is a mature private Docker Image Registry management tool, developed and maintained by VMware. 
- Written primarily in Go, with AngularJS frontend components.
- Configured to run on an ngnix web server, with a Mysql database, a component to run background replication jobs, a frontend 
and a backend component, and the Docker Registry.
- Harbor provides basic documentation for deploying with Kubernetes.

#### Web Interface

- Browsable collection of Images, organized by Projects, which function the same as Namespaces in Portus.
- Admin tools, which provide an interface to add Users, and change visibilty and access rights of Users for individual 
Projects. Admins can also manage configurations from the web interface, which provide token expiration settings, smtp setup, 
and replication controls. 
- Logs can be viewed and searched through.

#### Unique Features

- More detailed descriptions of uploaded Images- which include a number of datapoints missing in Portus, like the Docker 
version used to generate Images, and architecture and operating system details.
- Replication controls, which allows rules to be set up to automatically copy Images to other registries.
- Robust admin features, like SMTP settings, multiple auth modes (database or LDAP), and configurable token expiration time. 
Self registration can be turned off as well.
- A visual representation of how much available storage is left.
- Logs can be filtered by both date range and search terms.
- Multi language support. Right now there is only one language translations (I think it is Madarin, but I am not sure), but 
this might be expanded to support more languages in the future.
- Optional Notary component, which can be setup for auditing purposes- it scans uploaded Images and warns of vulnerabilities.