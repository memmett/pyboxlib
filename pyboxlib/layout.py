"""PyBoxLib layout class."""

import numpy as np

from pyfboxlib import fboxlib

import base

class layout(base.BLObject):
  """BoxLib layout."""

  def create(self, boxes=[]):
    """Create a layout from a list of boxes."""

    self.oid = fboxlib.create_layout_from_boxes(boxes)







