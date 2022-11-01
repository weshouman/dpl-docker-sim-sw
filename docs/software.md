| SW        | Source Capturing  | Issues  | Caution  | fixes  | Status |
| ---       | --- | --- | --- | ---| --- |
| deal2     | AUR  |  |  |  | Done  |
| dune      |  |  |  |  | Done  |
| dumux     |  |  |  |  | Done  |
| eigen     | Arch + git repo  |  |  |  | Done  |
| espresso  | AUR  | Python-sphinx<2.1.0 is not found<br>Building fails, follow https://aur.archlinux.org/packages/espressomd-git#comment-886320  | cuda is to be installed, consuming 1.8GB of bandwidth and 6GB of disk space  | While installing, we had to correct the sha256sum of python-griddataformats in the aur | Failed |
| fenics    |  | Building fenics has some issues [issue with build and install the C++ core · Issue #2410 · FEniCS/dolfinx · GitHub](https://github.com/FEniCS/dolfinx/issues/2410) |  |  | Failed |
| firedrake | Ubuntu, build script |  | https://github.com/firedrakeproject/firedrake/discussions/2596  |  | Done  |
| gmsh      | AUR  |  |  |  | Done  |
| lammps    |  |  |  |  | Done  |
| palabos   |  |  | hdf5-openmpi was chosen for the installation https://gitlab.com/unigespc/palabos/-/issues/110,<br>ssh is necessary for the first example [Dependency on SSH is not stated (#111) · Issues · UniGeSPC / palabos · GitLab](https://gitlab.com/unigespc/palabos/-/issues/111) |  | Done |
| petsc     | AUR  |  |  |  | Done |
| precice   | AUR  |  |  |  | Done |
| pyiron    |  |  |  |  |  |
| pymor     |  |  |  |  |  |
| su2       |  |  |  |  |  |
| sundials  |  |  |  |  |  |
| trilinos  |  |  |  |  |  |
| visit     |  |  |  |  |  |
| xsdk      |  |  |  |  |  |
| ginkgo    |  |  |  |  |  |


