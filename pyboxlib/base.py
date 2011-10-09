
class BLObject(object):

  def __init__(self):
    self._oid = None

  @property
  def oid(self):
    return self._oid

  @oid.setter
  def oid(self, value):
    assert self._oid is None
    assert isinstance(value, int)
    self._oid = value
