subroutine calcul_2nd_membre() ! Calculate the second membre of equation AX=B
use variables
implicit none


	do j=1,ny
	   do i=1,nx
	      div(i,j)= ddt*(ddx*(u_star(i,j)-u_star(i-1,j))+ddy*(v_star(i,j)-v_star(i,j-1))) 
	   enddo
	enddo

	sum=0.0
	do j=1,ny
	   do i=1,nx
	      sum=sum+div(i,j)
	   enddo
	enddo

        sum=sum/float(nx*ny)
	k=1
	do j=1,ny
	   do i=1,nx
	      div(i,j)=div(i,j)-sum
              div1(k)=-div(i,j)
	      x1(k)=0.
	      k=k+1
	    enddo
	enddo

end subroutine calcul_2nd_membre
