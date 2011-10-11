
from pyfboxlib import fboxlib
from pyboxlib import *

fboxlib.open()

mfab = multifab()
mfab.create(boxes=[((1,1), (3,3)), ((7,7), (9,9))])

a = mfab.array(1)
a[0,1] = 22.0

#mfab.echo()

la = layout()
la.create(boxes=[((1,1), (3,3)), ((7,7), (9,9))])
#la.echo()

lmfab = lmultifab()
#lmfab.create(boxes=[((1,1), (3,3)), ((4,4), (20,20))])
lmfab.create(boxes=[((4,4), (20,20))])

b = lmfab.array(1)
b[4:10,4:10] = True

lmfab.echo()

ba = boxarray()
ba.create_from_regrid(lmfab)
ba.echo()

fboxlib.close()

