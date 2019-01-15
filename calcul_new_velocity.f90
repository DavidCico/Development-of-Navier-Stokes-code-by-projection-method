subroutine calcul_new_velocity()
use variables
implicit none


!-------------------------------------------------!
!    Calculation of velocity field at t = dt*n+1  !
!-------------------------------------------------!

!!! In x direction !!!

do j=1,ny
  do i=1,nx-1
u1(i,j) = u_star(i,j) - dt*ddx*(p(i+1,j)-p(i,j))
  end do
end do

!!! In y direction !!!

do j=1,ny-1
  do i =1,nx
v1(i,j) = v_star(i,j) - dt*ddy*(p(i,j+1)-p(i,j))
  end do
end do




!------------------------------------------------------------------------------------------!
!               Centering variables to get matrix (1:nx,1:ny) for Paraview                 !
!------------------------------------------------------------------------------------------!


do j=1,ny
  do i=1,nx
uc(i,j) = 0.5*(u1(i,j)+u1(i-1,j))
vc(i,j) = 0.5*(v1(i,j)+v1(i,j-1))
  end do
end do



!---------------------------------------------------!
!    Rotational calculus (corners + centering)      !
!---------------------------------------------------!


!!! Corner boundary conditions (variable w) !!!

w(1,1)=0
w(nx,1)=0
w(1,ny)=0
w(nx,ny)=0

!!! General calculation !!!

do j=2,ny
  do i=2,nx
w(i,j) = ddx*(v1(i+1,j)-v1(i,j))-ddy*(u1(i,j+1)-u1(i,j))
  end do
end do

!!! Top and bottom wall computation !!!

do i=2,nx-1
  w(i,1) = ddx*(v1(i+1,1)-v1(i,1))-ddy*(u1(i,2)-u1(i,1))
  w(i,ny) = ddx*(v1(i+1,ny)-v1(i,ny))-ddy*(u1(i,ny+1)-u1(i,j))
end do

!!! Left and right wall computation !!!

do j=2,ny-1
  w(1,j) = ddx*(v1(2,j)-v1(1,j))-ddy*(u1(1,j+1)-u1(1,j))
  w(nx,j) = ddx*(v1(nx+1,j)-v1(nx,j))-ddy*(u1(nx,j+1)-u1(nx,j))
end do

!!! Centered rotational (at the center of mesh cells) !!!

do j=2,ny
  do i=2,nx
rot(i,j) = 0.25*(w(i,j)+w(i-1,j)+w(i,j-1)+w(i-1,j-1))
  end do
end do

end subroutine calcul_new_velocity


