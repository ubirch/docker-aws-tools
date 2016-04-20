# AWS tools container
This container contains some basic tools to work with AWS APIs.
It will have python and boto preinstalled.

To use it you mount your project to the ```/build``` directory. This is the default
working directory for the container.

The ENTRYPOINT for the container is ```/usr/bin/python```. This is convenient if your
project already contains a Makefile.

If that needs to be created first, I recommend placing a shell script in the root
directory of your project that contains your build steps and call it with the
container:

```docker run --rm -v $PWD:/build ubirch/aws-tools build.sh```
