
from pyfboxlib import fboxlib
from pyboxlib import multifab

fboxlib.open()

mfab = multifab()
mfab.create(boxes=[((1,1), (3,3)), ((7,7), (9,9))])

a = mfab.array(1)
a[0,1] = 22.0

mfab.echo()

mfab = multifab()
mfab.create(components=2, ghost_cells=3, boxes=[((0,0,0), (2,2,2))])
mfab.echo()

fboxlib.close()
