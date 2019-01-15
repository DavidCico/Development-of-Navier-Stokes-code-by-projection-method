subroutine mesh_creation()
use variables
implicit none

    do i=1,nx
       xx(i)=(i-0.5)*dx
    enddo
	
    do j=1,ny
       yy(j)=(j-0.5)*dy
    enddo

!Results are stored in the file 'coordinates.txt'

  open (7,file='coordinates.txt')
      write(7,'(2I6)') nx,ny
      do i=1,nx
         do j=1,ny
           write (7,'(F6.3,a,F6.3)') xx(i),'      ', yy(j)    
         enddo
      enddo
      close(7)


end subroutine mesh_creation
