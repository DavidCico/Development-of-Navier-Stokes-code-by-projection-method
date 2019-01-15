subroutine timestep()
use variables
implicit none
 
do j = 0,ny+1
  do i = 0,nx+1

   abs_u(i,j)=abs(u(i,j))
   abs_v(i,j)=abs(v(i,j))

  end do
end do

max_x = 1./maxval(abs_u) 
max_y = 1./maxval(abs_v)

if (Q == 1) then ! Timestep for Upwind scheme

min_u = min(dx*max_x,dx**2*0.5*nu1)
min_v = min(dy*max_y,dy**2*0.5*nu1)

else if (Q == 2) then ! Timestep for Centered scheme

min_u = min(nu*(max_x)**2,(dx)**2*0.5*nu1)
min_v = min(nu*(max_y)**2,(dy)**2*0.5*nu1)

end if

dt = min(min_u,min_v,dt2)

ddt = 1./dt


end subroutine timestep
