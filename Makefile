TYPICAL_APPS = deal2 dune dumux eigen firedrake fenicsx gmsh lammps

$(addprefix build_,$(TYPICAL_APPS)):
	@#echo target is $@, app is $(@:build_%=%)
	docker build -t $(@:build_%=%)_image -f Dockerfile_$(@:build_%=%) .

$(addprefix run_,$(TYPICAL_APPS)):
	@#echo target is $@, app is $(@:run_%=%)
	docker run --rm -it --entrypoint /bin/bash $(@:run_%=%)_image

 
build_espressomd:
	docker build -t cuda-arch -f Dockerfile_cuda .
	docker build -t espressomd_build -f Dockerfile_espressomd .

run_espressomd:
	docker run --rm -it --entrypoint /bin/bash espressomd_build

