subroutine discretisation_intermediary_velocity_upwind()
use variables 
implicit none


!!! u_star calculation (x component) !!!

do j=1,ny
  do i=1,nx-1

u_tilde_x1=0.5*(u(i,j)+u(i+1,j)) !1 for +(i or j)
u_tilde_x2=0.5*(u(i-1,j)+u(i,j))  !2 for -(i or j)
v_tilde_x1=0.5*(v(i,j)+v(i+1,j))
v_tilde_x2=0.5*(v(i,j-1)+v(i+1,j-1))

if (u_tilde_x1 >= 0) then 
        
        a=u(i,j)
    else 
        a=u(i+1,j)
end if


if (u_tilde_x2 >= 0) then
       
        b=u(i-1,j)
    else 
        b=u(i,j)
end if


if (v_tilde_x1 >= 0) then
 
        c=u(i,j)
    else 
        c=u(i,j+1)
end if


if (v_tilde_x2 >= 0) then 
        
        d=u(i,j-1)
    else 
        d=u(i,j)
end if
 

u_star(i,j) = u(i,j)-dt*ddx*(u_tilde_x1*a-u_tilde_x2*b)-dt*ddy*(v_tilde_x1*c-v_tilde_x2*d) &
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

if (u_tilde_y1 >= 0) then 

        e=v(i,j)
    else 
        e=v(i+1,j)
end if


if (u_tilde_y2 >= 0) then 
        
        f=v(i-1,j)
    else 
        f=v(i,j)
end if


if (v_tilde_y1 >= 0) then 
        
        g=v(i,j)
    else 
        g=v(i,j+1)
end if


if (v_tilde_y2 >= 0) then 
        
        h=v(i,j-1)
    else 
        h=v(i,j)
end if
  

v_star(i,j) = v(i,j)-dt*ddx*(u_tilde_y1*e-u_tilde_y2*f)-dt*ddy*(v_tilde_y1*g-v_tilde_y2*h) &
             +nu*dt*(ddx**2)*(v(i+1,j)-2*v(i,j)+v(i-1,j))+nu*dt*(ddy**2)*(v(i,j+1)-2*v(i,j)+v(i,j-1))

  end do
end do

end subroutine discretisation_intermediary_velocity_upwind
