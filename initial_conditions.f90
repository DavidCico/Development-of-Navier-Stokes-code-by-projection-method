subroutine initial_conditions()
use variables
implicit none

!---------------------------------------------------!
!         Initial conditions calculation            !
!---------------------------------------------------!


do j=0,ny+1
 do i=0,nx+1

   u(i,j) = 0
   v(i,j) = 0
   u1(i,j) = 0
   v1(i,j) = 0
   p(i,j) = 0
   u_star(i,j) = 0
   v_star(i,j) = 0

 end do
end do

end subroutine initial_conditions



