
from pyfboxlib import fboxlib
from pyboxlib import *

fboxlib.open()

la = layout()
la.create(boxes=[((1,1), (3,3)), ((7,7), (9,9))])

lmfab = lmultifab()
lmfab.create(la)

b = lmfab.array(1)                      # XXX
b[4:10,4:10] = True

#lmfab.echo()

la = layout()
la.from_regrid(lmfab)

mfab = multifab()
mfab.create(la)
mfab.echo()

fboxlib.close()

