subroutine discretisation_intermediary_velocity_centre()
use variables
implicit none

!!! u_star calculation (x component) !!!

do j=1,ny
  do i=1,nx-1

u_tilde_x1=0.5*(u(i,j)+u(i+1,j)) !1 for +(i or j)
u_tilde_x2=0.5*(u(i-1,j)+u(i,j))  !2 for -(i or j)
v_tilde_x1=0.5*(v(i,j)+v(i+1,j))
v_tilde_x2=0.5*(v(i,j-1)+v(i+1,j-1))

u_star(i,j) = u(i,j)-dt*ddx*0.5*(u_tilde_x1*(u(i,j)+u(i+1,j))-u_tilde_x2*(u(i,j)+u(i-1,j))) &
             -dt*ddy*0.5*(v_tilde_x1*(u(i,j)+u(i,j+1))-v_tilde_x2*(u(i,j)+u(i,j-1))) &
             +nu*dt*(ddx**2)*(u(i+1,j)-2*u(i,j)+u(i-1,j))+nu*dt*(ddy**2)*(u(i,j+1)-2*u(i,j)+u(i,j-1))

  end do
end do

!!! v_star calculation (y component) !!!

do j=1,ny-1
  do i=1,nx

u_tilde_y1=0.5*(u(i,j)+u(i,j+1))
u_tilde_y2=0.5*(u(i-1,j)+u(i-1,j+1))
v_tilde_y1=0.5*(v(i,j)+v(i,j+1))
v_tilde_y2=0.5*(v(i,j-1)+v(i,j))

v_star(i,j) = v(i,j)-dt*ddx*0.5*(u_tilde_y1*(v(i,j)+v(i+1,j))-u_tilde_y2*(v(i,j)+v(i-1,j))) &
             -dt*ddy*0.5*(v_tilde_y1*(v(i,j)+v(i,j+1))-v_tilde_y2*(v(i,j)+v(i,j-1))) &
             +nu*dt*(ddx**2)*(v(i+1,j)-2*v(i,j)+v(i-1,j))+nu*dt*(ddy**2)*(v(i,j+1)-2*v(i,j)+v(i,j-1))

  end do
end do

end subroutine discretisation_intermediary_velocity_centre
