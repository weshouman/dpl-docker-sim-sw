# Build Process Isolation
---

Build process isolation is needed for 2 reasons, ensuring that the master is building, and having an isolated environment for development.

## Pros
Lots of varieties and possibilities are now open, including but not limited to:

- Using a Kubernetes cluster of multiple nodes: The build could be parallelized for an increased speed (of course if the SW supports parallelization and the parallelization between nodes are not expensive)
- Using a Kubernetes cluster of multiple heterogeneous nodes: The build could be tested on different architectures, for example x64 and arm.
- Using Jenkins: It’s easily executable on other machines than the one in use


## Software Building

Software that has been pushed to the remote, have to be successfully building. Lots of SW provides a HowTo for the build process, however it’s not always the case that the build process is easily re-runnable for everybody.  
Here the build process is to be written into a Dockerfile so that it could run isolated by building its image. The verdict of whether the build passed or failed would be the return of 0 or may be even more serious by running some acceptance tests.  

Note: It’s desired to avoid recreating big chunks while building the container image by utilizing the docker image caching and minimizing the effort done through each step, for example by using a separate `apt install` or `pacman -S`  per package when suitable, and of course separating the build in a different step then dependency capturing.  

For example:  
Avoid using

```
RUN apt update && \
         apt install a b -y && \
         ./configure && \
         make
```

in favor of using

```
RUN apt update
RUN apt install a -y
RUN apt install b -y
RUN ./configure
RUN make
```

### Examples

--8<-- "docs/software.md"

## Software Development

For the case of having the source code locally and desiring to build it while developing it or just after doing some modifications it’s beneficial to containerize the build process that captures uncommitted changes.  

With such isolation the developer could easily try the changes on different SW versions which in turn could have different dependencies, or may even try the changes on the same SW version but on different Linux flavors. Thus increasing the ability of observing the extent of the changes.  

## Notes

- Ansible was avoided for the build steps in the implemented examples on purpose to maximize the cache usage, and speed up prototyping, however in more advanced scenarios especially when a hybrid situation of VM and container are to be deployed onto, an Ansible playbook would be very useful.
- Further caching optimizations could be considered by comparing the dependency sizes/time for building and reusing some those images, that would be useful if different simulation software are expected to run on the same machine.

## Comparison

The main differences between the `Development` and the `Building` scenarios are in the following aspects.  
 
### Caching 

For the `Development` scenarios caching previous builds needs to be considered, otherwise, one would spend a lot of time only doing superfluous rebuilds.  

### Context

For the `Development` scenarios we need to have a context, for example the source code should be available on our machine, which would be shared of course with the container, however, ideally, such context is not mandatory for `Building` scenarios.  

