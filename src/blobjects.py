
src = '''\
module blobjects
  use multifab_module
  use layout_module
  integer, parameter :: PYBL_MAX_STORE = 256
  {stores}
contains
  {routines}
end module blobjects
'''

store = '''\
type({type}), save, target :: pybl_{type}_store(PYBL_MAX_STORE)
integer, save :: pybl_{type}_count = 0
'''

get = '''\
subroutine pybl_{type}_get(oid,object)
  integer, intent(in) :: oid
  type({type}), pointer, intent(out) :: object

  object => pybl_{type}_store(oid)
end subroutine pybl_{type}_get'''

new = '''\
subroutine pybl_{type}_new(oid,object)
  integer, intent(out) :: oid
  type({type}), pointer, intent(out) :: object

  oid = pybl_{type}_count + 1
  object => pybl_{type}_store(oid)

  pybl_{type}_count = pybl_{type}_count + 1
end subroutine pybl_{type}_new
'''

stores = []
routines = []
for t in ['multifab', 'layout']:
    stores.append(store.format(type=t))
    routines.append(get.format(type=t))
    routines.append(new.format(type=t))

with open('blobjects.f90', 'w') as f:
    f.write(src.format(
        stores='\n'.join(stores),
        routines='\n'.join(routines)))


