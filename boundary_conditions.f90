subroutine boundary_conditions()
use variables
implicit none


!---------------------------------------------------!
!         Boundary conditions calculation           !
!---------------------------------------------------!


!!!!!!!!Velocity boundary conditions!!!!!!!!

!Left vertical wall
do j=0,ny+1
  u(0,j) = 0
  v(0,j) = -v(1,j)
  u1(0,j) = 0
  v1(0,j) = -v1(1,j)
  u_star(0,j) = 0 
  v_star(0,j) = -v_star(1,j)
end do

!Right vertical wall
do j=0,ny+1
  u(nx,j) = 0
  v(nx+1,j) = -v(nx,j)
  u1(nx,j) = 0
  v1(nx+1,j) = -v1(nx,j)
  u_star(nx,j) = 0
  v_star(nx+1,j) = -v_star(nx,j)
end do

!Bottom horizontal wall
do i=0,nx+1
  u(i,0) = -u(i,1)
  v(i,0) = 0
  u1(i,0) = -u1(i,1)
  v1(i,0) = 0
  u_star(i,0) = -u_star(i,1)
  v_star(i,0) = 0
end do

!Top horizontal wall
do i=0,nx+1
  u(i,ny+1) = 2-u(i,ny) 
  v(i,ny) = 0
  u1(i,ny+1) = 2-u1(i,ny)
  v1(i,ny) = 0
  u_star(i,ny+1) = 2-u_star(i,ny)
  v_star(i,ny) = 0
end do


!!!!!!!Pressure boundary conditions!!!!!!!

!Left vertical wall
do j=0,ny+1
   p(0,j)=p(1,j)
end do

!Right vertical wall
do j=0,ny+1
   p(nx+1,j)=p(nx,j)
end do


!Bottom horizontal wall
do i=0,nx+1
   p(i,0)=p(i,1)
end do

!Top horizontal wall
do i=0,nx+1
   p(i,ny+1)=p(i,ny)
end do

end subroutine boundary_conditions
