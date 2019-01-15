subroutine velocities_output()
use variables

  open (9,file='u_velocity.txt')
      write(9,*) 'u_vertical_line'
         do j=1,ny
      write (9,'(F1.5)') u((nx-1)/2,j)
         enddo
  close(9)

  open (10,file='v_velocity.txt')
       write(10,*) 'v_horizontal_line'
          do i=1,nx
       write (10,'(F1.5)') v(i,(ny-1)/2)
          enddo
  close(10)
  
  open (11,file='omega_boundary.txt')
       write(11,*) 'omega_boundary'
          do i=2,nx
       write (11,'(F1.5)') rot(i,ny)
          enddo
  close(11)

end subroutine velocities_output
