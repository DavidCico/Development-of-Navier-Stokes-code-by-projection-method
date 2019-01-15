subroutine calcul_pressure_field()
use variables
implicit none

!-------------------------------------------------!
!              Update pressure field              !
!-------------------------------------------------!

    k=1
       do j=1,ny 
	  do i=1,nx 
  	      pre(i,j)=x1(k)
	      k=k+1
	  enddo
       enddo


       do j=1,ny
          do i=1,nx
             p(i,j) = pre(i,j)
          end do
       end do
   

end subroutine calcul_pressure_field
