
from pyfboxlib import fboxlib, multifab_array


class fab(object):
  """FAB.

  Here we assume that a fab is attached to a multifab.

  DIM:    Dimension
  BX:     The Box in index space for which this FAB is defined
  IBX:    The index range of the valid data for the FAB
  PBX:    The physical box for the FAB
  NC:     Number of components
  NG:     Number of ghost cells

  When a FAB is created IBX = BX, unless it is nodal, in which case
  IBX = grow(BX, FACE=hi, 1 (in the nodal directions).
  PBX = grow(IBX, NG)

  For parallel systems the BX, IBX, PBX, etc are all defined, but the
  underlying pointer will not be allocated.

  All FABS are 'Four' dimensional, conventially, (NX,NY,NZ,NC) in size.
  NY = 1, NZ = 1, when DIM =1, NZ = 1, when DIM = 2.

  """

  def __init__(self, mfab, nbox):

    self.mfab = mfab
    self.nbox = nbox

    assert 1 <= nbox <= mfab.nboxes

    (self.dim, self.nc, self.bx_lo, self.bx_hi, self.pbx_lo, self.pbx_hi,
     self.ibx_lo, self.ibx_hi) = fboxlib.get_fab_info(mfab.oid, nbox)

    self.array = multifab_array(self.mfab.oid, nbox).squeeze()

  def __getitem__(self, key):
    return self.array[key]

  def __setitem__(self, key, value):
    self.array[key] = value
