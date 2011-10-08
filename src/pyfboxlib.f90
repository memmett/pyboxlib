module fboxlib

  use multifab_module
  !use ml_layout_module

  implicit none

  integer, parameter :: MAXMFABS = 256
  type(multifab), save :: mfabs(MAXMFABS)

contains

  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  ! open, close, set_comm

  subroutine hello()
    print *, 'Hello from Fortran, with FBoxLib!'
  end subroutine hello

  subroutine open()
    use parallel
    call parallel_initialize()
  end subroutine open

  subroutine close()
    use parallel
    call parallel_finalize()
  end subroutine close

  ! subroutine set_comm(comm)
  !   use parallel
  !   implicit none
  !   integer, intent(in) :: comm
  !   call parallel_set_m_comm(comm)
  ! end subroutine set_comm

  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  ! initialize

  subroutine initialize()
    implicit none

    type(box) :: boxes(1)
    type(boxarray) :: ba
    type(layout) :: la

    real(8), pointer :: fptr(:,:,:,:)

    ! build a test multifab for now

    boxes(1) = make_box((/0, 0/), (/32,32/))
    call build(ba, boxes)
    call build(la, ba)
    call build(mfabs(1), la, nc=1, ng=1)

    ! put some data in the test multifab

    fptr => dataptr(mfabs(1),1)

    fptr(1,1,1,1) = 1.0
    fptr(1,3,1,1) = 3.0

  end subroutine initialize

  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  ! blarray

  subroutine blarrayptr(mfid, nbox, aptr, nx, ny, nz, nc) bind(c)
    use iso_c_binding
    implicit none

    integer(c_int), intent(in)  :: mfid, nbox
    type(c_ptr), intent(out)    :: aptr
    integer(c_int), intent(out) :: nx, ny, nz, nc

    real(8), pointer :: fptr(:,:,:,:)

    fptr => dataptr(mfabs(mfid),nbox)

    aptr = c_loc(fptr(1,1,1,1))
    nx   = size(fptr,1)
    ny   = size(fptr,2)
    nz   = size(fptr,3)
    nc   = size(fptr,4)

  end subroutine blarrayptr

end module fboxlib
