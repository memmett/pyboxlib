from pyfboxlib import fboxlib, blarray

fboxlib.open()
fboxlib.initialize()

a = blarray(1,1)

print a.shape
print a[0,0,0,0]
print a[0,2,0,0]

fboxlib.close()
