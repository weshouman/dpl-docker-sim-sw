# Index

---

## A Unified Approach for Simulation Software Development in Isolated Environments

This documentation discusses methodologies for unifying the development of simulation software, following the [Simulation Software Engineering Course](https://simulation-software-engineering.github.io/homepage/) at Stuttgart University.


There are 3 different ways for how the containerization would fit and help in the process of developing research/simulation software, namely; building the software, developing the software, and using the software, the 3 different forms are described in the following sections in details.

- [Build Process Isolation](build-process-isolation.md)
- [Software Environment Isolation](sw-env-isolation.md)

## Notes

Throughout the documentation, the containers were preferred over the virtual machines, as the increased level of virtualization won’t be worth the penalty on the developer (penalty of the storage, processing, memory and time increase) same goes for `lxc` (even with it being much lighter than the virtual machines).
Integration into Kubernetes clusters is also a great bonus for container usage.

