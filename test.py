
from pyfboxlib import fboxlib
from pyboxlib import *

fboxlib.open()

la = layout()
la.create(boxes=[((1,1), (3,3)), ((7,7), (100,100))])

lmfab = lmultifab()
lmfab.create(la)

b = lmfab.fab(2)
b[2:8,2:8] = True

lmfab.echo()

la = layout()
la.from_regrid(lmfab)

la.echo()

mfab = multifab()
mfab.create(la)
#mfab.echo()

fboxlib.close()

