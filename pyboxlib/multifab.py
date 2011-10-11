
import numpy as np

from pyfboxlib import fboxlib, multifab_array, lmultifab_array

import base

class multifab(base.BLObject):
  """MultiFAB."""

  def create(self, components=1, ghost_cells=1, boxes=[]):
    """Create a multifab from a list of boxes.

    Implicitly creates a layout.
    """

    if boxes:
      self.oid = fboxlib.create_multifab_from_boxes(components, ghost_cells, boxes)

  # XXX: add a more fancy get/set
  def array(self, box):
    return multifab_array(self.oid, box)

  # XXX: delete routines...


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









