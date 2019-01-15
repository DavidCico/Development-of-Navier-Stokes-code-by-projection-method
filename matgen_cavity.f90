	subroutine matgen_cavity(coef,jcoef,nx,ny,ndim,mdim,dx,dy) 
	implicit none

	integer :: nx,ny,i,j,k,mdim,ndim
	integer ,dimension(1:mdim) :: jcoef 


	real*8 ,dimension(1:ndim,1:mdim)::coef 
	real*8 :: dx,dy,aa,bb

	k=1 
	do j=1,ny
	   do i=1,nx
              coef(k,1) =2./dx/dx+2./dy/dy 
              coef(k,2) =-1./dx/dx 
              coef(k,3) =-1./dy/dy 
	      k=k+1
	   enddo
	enddo

	k=1 
	do j=1,ny
	   do i=1,nx
              if(i.eq.1)then
                 aa=-1./dx/dx
              elseif(i.eq.nx)then
                 aa=-1./dx/dx
              else
                aa=0.0
              endif

              if(j.eq.1)then
                 bb=-1./dy/dy
               elseif(j.eq.ny)then
                 bb=-1./dy/dy
               else
                 bb=0.0
              endif

	      coef(k,1)=coef(k,1)+aa+bb
	      k=k+1
	   enddo
	enddo

	k=1
	do j=1,ny
	   do i=1,nx
	      if(i.eq.nx)then
	         coef(k,2)=0.0
	      endif
	      if(j.eq.ny)then
	         coef(k,3)=0.0
	      endif
	      k=k+1
	   enddo
	enddo

	jcoef(1)=0
	jcoef(2)=1
	jcoef(3)=nx
	
	return
	end
