
import numpy as np

from pyfboxlib import fboxlib, mfarray


class multifab(object):
  """MultiFAB."""

  def __init__(self):
    self._fid = None

  @property
  def fid(self):
    return self._fid

  @fid.setter
  def fid(self, value):
    assert self._fid is None
    assert isinstance(value, int)
    self._fid = value


  def __str__(self):
    return 'multifab (id %d)' % self.fid


  def create(self, components=1, ghost_cells=1, boxes=[]):
    """Create a multifab from a list of boxes.

    Implicitly creates a layout.
    """

    self.fid = fboxlib.create_multifab(components, ghost_cells, boxes)


  def echo(self):
    fboxlib.print_multifab(self.fid)


  # XXX: add a more fancy get/set?
  def array(self, box):
    return mfarray(self.fid, box)


  # XXX: delete routines...



