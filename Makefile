BOXLIB_HOME ?= /home/memmett/projects/BoxLib

MPI  := t
COMP := gfortran

include $(BOXLIB_HOME)/Tools/F_mk/GMakedefs.mak

CC       := mpicc
FC       := mpif90
F90      := mpif90
F90FLAGS += -fPIC		# needed for dynamic loading with Python
CFLAGS   += -fPIC

include $(BOXLIB_HOME)/Src/F_BaseLib/GPackage.mak
VPATH_LOCATIONS += $(BOXLIB_HOME)/Src/F_BaseLib

#include $(BOXLIB_HOME)/Src/LinearSolvers/F_MG/GPackage.mak
#VPATH_LOCATIONS += $(BOXLIB_HOME)/Src/LinearSolvers/F_MG

# default target
pyfboxlib.so: $(objects) src/pyfboxlib.m4 src/fboxlib.pyf src/fboxlib.f90 src/boxlib_numpy.c
	@cd src && m4 pyfboxlib.m4 > pyfboxlib.pyf
	@echo Running f2py...
	@f2py --quiet --fcompiler=gnu95 --f90exec=$(FC) --f90flags="-I $(mdir)" \
		-c src/pyfboxlib.pyf src/fboxlib.f90 $(objects)

include $(BOXLIB_HOME)/Tools/F_mk/GMakerules.mak

