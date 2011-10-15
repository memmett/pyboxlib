
import numpy as np
from pyfboxlib import fboxlib, multifab_array, lmultifab_array
import base

from fab import fab

class multifab(base.BLObject):
  """MultiFAB."""

  def create(self, components=1, ghost_cells=0, boxarray=None, boxes=None):
    """Create a multifab from a list of boxes.

    Implicitly creates a layout.
    """

    if boxarray is not None:
      self.oid = fboxlib.create_multifab_from_boxarray(components, ghost_cells, boxarray.oid)
    elif boxes is not None:
      self.oid = fboxlib.create_multifab_from_boxes(components, ghost_cells, boxes)

    if self.oid:
      self.dim, self.nboxes, self.nc, self.ng = fboxlib.get_multifab_info(self.oid)

  # def fab(self, box):
  #   return multifab_array(self.oid, box)

  def fab(self, box):
    return fab(self, box)



class lmultifab(base.BLObject):
  """Logical MultiFAB."""

  def create(self, boxes=[]):
    """Create a logical (boolean) multifab from a list of boxes.

    Implicitly creates a layout.
    """

    if boxes:
      self.oid = fboxlib.create_lmultifab_from_boxes(boxes)

  # XXX: add a more fancy get/set
  def array(self, box):
    return lmultifab_array(self.oid, box)

  # XXX: delete routines...









