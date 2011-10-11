
import numpy as np

from pyfboxlib import fboxlib

import base

class boxarray(base.BLObject):
  """BoxArray."""

  def create_from_regrid(self, lmultifab, buffer_width=0):
    """Create a new boxarray from a logical multifab that tags cells
    that should be refined."""

    self.oid = fboxlib.regrid(lmultifab.oid, buffer_width)
