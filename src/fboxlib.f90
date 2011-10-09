module fboxlib

  use blobjects
  implicit none

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
  ! multifab routines

  subroutine create_multifab_from_boxes(nc,ng,boxes,nboxes,dim,oid)
    implicit none
    integer, intent(in)  :: nc, ng, dim, nboxes, boxes(nboxes,2,dim)
    integer, intent(out) :: oid

    integer :: i
    type(box) :: bs(nboxes)
    type(boxarray) :: ba
    type(layout) :: la
    type(multifab), pointer :: mfab

    do i=1,nboxes
       bs(i) = make_box(boxes(i,1,:), boxes(i,2,:))
    end do

    call pybl_multifab_new(oid,mfab)

    call build(ba, bs)
    call build(la, ba)
    call build(mfab, la, nc=nc, ng=ng)

  end subroutine create_multifab_from_boxes

  subroutine print_multifab(oid)
    implicit none
    integer, intent(in) :: oid
    type(multifab), pointer :: mfab

    call pybl_multifab_get(oid,mfab)
    call print(mfab)
  end subroutine print_multifab

  ! subroutine initialize()
  !   implicit none

  !   type(box) :: boxes(1)
  !   type(boxarray) :: ba
  !   type(layout) :: la

  !   real(8), pointer :: fptr(:,:,:,:)

  !   ! build a test multifab for now

  !   boxes(1) = make_box((/0, 0/), (/32,32/))
  !   call build(ba, boxes)
  !   call build(la, ba)
  !   call build(mfabs(1), la, nc=1, ng=1)

  !   ! put some data in the test multifab

  !   fptr => dataptr(mfabs(1),1)

  !   fptr(1,1,1,1) = 1.0
  !   fptr(1,3,1,1) = 3.0

  ! end subroutine initialize

  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  subroutine multifab_as_numpy_f(oid, nbox, aptr, nx, ny, nz, nc) bind(c)
    use iso_c_binding
    implicit none

    integer(c_int), intent(in)  :: oid, nbox
    type(c_ptr), intent(out)    :: aptr
    integer(c_int), intent(out) :: nx, ny, nz, nc

    real(8), pointer :: fptr(:,:,:,:)
    type(multifab), pointer :: mfab

    call pybl_multifab_get(oid,mfab)

    fptr => dataptr(mfab,nbox)

    aptr = c_loc(fptr(1,1,1,1))
    nx   = size(fptr,1)
    ny   = size(fptr,2)
    nz   = size(fptr,3)
    nc   = size(fptr,4)

  end subroutine multifab_as_numpy_f

end module fboxlib
