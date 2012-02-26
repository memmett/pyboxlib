
libpyfboxlib.so: $(objects)
	mpif90 -shared -o libpyfboxlib.so $(objects)

NPINCLUDE=-I/usr/include/python2.7
NPINCLUDE+=-I/usr/lib64/python2.7/site-packages/numpy/core/include/numpy

libpycboxlib.so: $(PYBOXLIB)/src/boxlib_numpy.c
	 gcc -fPIC -shared $(NPINCLUDE) -L. -lpyfboxlib -o libpycboxlib.so $(PYBOXLIB)/src/boxlib_numpy.c 
