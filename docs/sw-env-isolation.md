# Software Environment Isolation
---

In this isolation type, it’s enough to have an image of the software binaries/libraries and we don’t need at all to rebuild the software inside the docker image, as that would be:

- Error Prune, if the build is failed we would
- Violate the Separation of Concern, as we would now be only concerned about using the software.
- Not DRY, as we would be rebuilding the software every time the image caches are invalidated (for example: for updating a dependency) even though we already tested that with [Building the Software isolation](#Building-the-Software).

## Using the Software

To isolate the SW usage we need to think first about how are the inputs and outputs of the software are formed, following are some samples:

1. Inputs and outputs are arguments
```
./sw.sh input output
```
2. Inputs are scripts that call the software
```
echo testdata > input
./input
```
3. Inputs are programs that get built and outputs are files (for example paraview plugins)
```
cd inputDir
echo testdata > input
./configure
make
```

Given these samples 2 different approaches could be considered each has his own tradeoff

Note: The following 2 forms of isolating the software environment have the same concern thus they are considered 2 solutions for the same problem, taking into consideration that `Adding a Backend Sidecar` is a more sophisticated solution than `Volume Sharing`. And accordingly the number of forms mentioned in the intro section is only 3 not 4.

## Volume Sharing

Through volume sharing we basically have a local directory (volume) that we develop over, which is shared with the container for both the inputs and outputs, that way the software with all it’s libraries are running in an isolated environment.

Note: the volume for the simulation output is optional as one could:
1. Use a single volume for input and output if the output is in the same directory
2. Copy the output directly to the host
3. The output could be a GUI based and directly appears to the user, for example by sharing the X11

### Structure

To implement this method, one needs to implement the following structure
[user][Volume For Simulation Input]  → [Docker Image With Binaries] → [Volume for Simulation Output (Optional)][user]

### Pros

Pros of this method

- Simpler to implement for the DevOps engineer

### Cons
- Require containerization knowledge from the simulation engineer, which could be automated through make targets.


## Adding a Backend Sidecar

To implement this method we would add a sidecar application to receive some input and return the output, for example using a RESTful API on TCP.

The expected inputs are 
- Input data and simulation parameters
- A script to execute over the input, that could take 2 forms
	- text form of the script: Which is very dangerous, but easier to extend
	- an option to select which pre-written script to execute: Safer, but would need to add scripts manually
	- A mix of previous options, supplying an option for the more privilege users to add scripts and less privilege users to select the option.
 
*Note: the script could be any of the previously mentioned 3 samples, or any other sample. As it basically an instruction set for the sidecar telling it how to run the simulation.*

Eventually the sidecar notifies the user when the output is ready, for example may by giving a status link for the user to check, then he would be able to download the output.

In real life, most simulation software do not have such sidecar, or have it written in a non-standard way, which needs an adapter, and thus one would need to develop such sidecar, in an ideal scenario, **generically** to fit all supported SW.


### Structure
To implement this method, one needs to implement the following structure
[user][frontend]  ↔  [backend sidecar][Docker Image With Binaries]

### Pros

Pros of this method

- Simpler for the simulation engineer, he needs only to upload and download files.
- Has more room for extensions, like multi-client servers

### Cons
Cons of this method

- Requires understanding the protocol used for communication, or developing another frontend for uploading/downloading the software.
- Requires dependency on a sidecar.
- Requires the effort of developing and maintaining the sidecar.

## Caching

If the sidecar implementation does not support caching and treats every simulation as a totally different entity, using the sidecar would be inefficient in running scenarios like the third sample, in which the input is to be built, thus caching reduces the time wasted for rebuilding unnecessary parts, which could be very expensive.

Thus cache support would be considered a necessity for the sidecar to prove its worthiness in some cases. And of course, with such support, caching between different users would be a great addition that may make `Adding a Backend Sidecar` surpasses the Volume Sharing

