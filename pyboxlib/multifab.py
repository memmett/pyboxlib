
import numpy as np

from pyfboxlib import fboxlib, mfarray

import base

class multifab(base.BLObject):
  """MultiFAB."""

  def __str__(self):
    return 'multifab (id %d)' % self.oid

  def create(self, components=1, ghost_cells=1, boxes=[]):
    """Create a multifab from a list of boxes.

    Implicitly creates a layout.
    """

    if boxes:
      self.oid = fboxlib.create_multifab_from_boxes(components, ghost_cells, boxes)


  def echo(self):
    fboxlib.print_multifab(self.oid)


  # XXX: add a more fancy get/set
  def array(self, box):
    return mfarray(self.oid, box)

  # XXX: delete routines...









