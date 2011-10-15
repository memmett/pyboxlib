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
  ! layout routines

  subroutine create_layout_from_boxes(boxes,nboxes,dim,oid)
    implicit none
    integer, intent(in)  :: dim, nboxes, boxes(nboxes,2,dim)
    integer, intent(out) :: oid

    integer :: i
    type(box) :: bs(nboxes)
    type(boxarray) :: ba
    type(layout), pointer :: la

    do i=1,nboxes
       bs(i) = make_box(boxes(i,1,:), boxes(i,2,:))
    end do

    call pybl_layout_new(oid,la)

    call build(ba, bs)
    call build(la, ba)

  end subroutine create_layout_from_boxes

  subroutine print_layout(oid)
    implicit none
    integer, intent(in) :: oid
    type(layout), pointer :: la

    call pybl_layout_get(oid,la)
    call print(la)
  end subroutine print_layout

  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  ! multifab routines

  subroutine get_multifab_info(oid, dim, nboxes, nc, ng)
    implicit none
    integer, intent(in) :: oid
    integer, intent(out) :: dim, nboxes, nc, ng
    type(multifab), pointer :: mfab

    call pybl_multifab_get(oid,mfab)
    dim = mfab%dim
    nboxes = mfab%nboxes
    nc = mfab%nc
    ng = mfab%ng
  end subroutine get_multifab_info

  subroutine get_fab_info(oid, nbox, dim, nc, bx_lo, bx_hi, pbx_lo, pbx_hi, ibx_lo, ibx_hi)
    implicit none
    integer, intent(in) :: oid, nbox
    integer, intent(out) :: dim, nc
    integer, intent(out), dimension(3) :: bx_lo, bx_hi, pbx_lo, pbx_hi, ibx_lo, ibx_hi
    type(multifab), pointer :: mfab
    type(box) :: bx

    call pybl_multifab_get(oid,mfab)
    dim = get_dim(mfab%fbs(nbox))
    nc = ncomp(mfab%fbs(nbox))

    bx = get_box(mfab%fbs(nbox))
    bx_lo = bx%lo
    bx_hi = bx%hi

    bx = get_pbox(mfab%fbs(nbox))
    pbx_lo = bx%lo
    pbx_hi = bx%hi

    bx = get_ibox(mfab%fbs(nbox))
    ibx_lo = bx%lo
    ibx_hi = bx%hi
  end subroutine get_fab_info

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
    call setval(mfab, 0.0d0)

  end subroutine create_multifab_from_boxes

  subroutine create_multifab_from_boxarray(nc,ng,boxarray_oid,oid)
    implicit none
    integer, intent(in)  :: nc, ng, boxarray_oid
    integer, intent(out) :: oid

    type(boxarray), pointer :: ba
    type(layout) :: la
    type(multifab), pointer :: mfab

    call pybl_multifab_new(oid,mfab)
    call pybl_boxarray_get(boxarray_oid,ba)

    call build(la, ba)
    call build(mfab, la, nc=nc, ng=ng)
    call setval(mfab, 0.0d0)

  end subroutine create_multifab_from_boxarray

  subroutine print_multifab(oid)
    implicit none
    integer, intent(in) :: oid
    type(multifab), pointer :: mfab

    call pybl_multifab_get(oid,mfab)
    call print(mfab)
  end subroutine print_multifab

  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  ! lmultifab routines

  subroutine create_lmultifab_from_boxes(boxes,nboxes,dim,oid)
    implicit none
    integer, intent(in)  :: dim, nboxes, boxes(nboxes,2,dim)
    integer, intent(out) :: oid

    integer :: i
    type(box) :: bs(nboxes)
    type(boxarray) :: ba
    type(layout) :: la
    type(lmultifab), pointer :: mfab

    do i=1,nboxes
       bs(i) = make_box(boxes(i,1,:), boxes(i,2,:))
    end do

    call pybl_lmultifab_new(oid,mfab)

    call build(ba, bs)
    call build(la, ba)
    call build(mfab, la)
    call setval(mfab, .false.)

  end subroutine create_lmultifab_from_boxes

  subroutine print_lmultifab(oid)
    implicit none
    integer, intent(in) :: oid
    type(lmultifab), pointer :: mfab

    call pybl_lmultifab_get(oid,mfab)
    call print(mfab)
  end subroutine print_lmultifab

  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  ! boxarray routines

  subroutine print_boxarray(oid)
    implicit none
    integer, intent(in) :: oid
    type(boxarray), pointer :: ba

    call pybl_boxarray_get(oid, ba)
    call print(ba)
  end subroutine print_boxarray

  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  ! regrid

  subroutine regrid(tags_oid, buffer_width, boxes_oid)
    use cluster_module
    implicit none

    integer, intent(in) :: tags_oid, buffer_width
    integer, intent(out) :: boxes_oid

    type(lmultifab), pointer :: tags
    type(boxarray), pointer :: boxes

    call pybl_boxarray_new(boxes_oid, boxes)

    call pybl_lmultifab_get(tags_oid, tags)
    call cluster(boxes, tags, buffer_width)

  end subroutine regrid

end module fboxlib
