# Vagrant Workshop

This is a sample repository containing everything required to learn Vagrant except for a Vagrantfile.
The creation of a Vagrantfile is left as an exercise to the reader, starting with `vagrant init ubuntu/xenial64`

Once running this project will run a simple ToDo app at http://localhost:18000 with todo items persisted to a postgres database. The web application uses flask and is hosted with gunicorn and nginx.

The only Vagrant box that has been tested against is ubuntu/xenial64.

## Layout

* `myproject` contains the python source for the ToDo web app.
* `scripts` contains the scripts and config files used during provisioning of the Vagrant box.

## Slides

The slides for this workshop can be found here: https://mleonard87.github.io/vagrant-workshop
