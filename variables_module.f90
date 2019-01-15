MODULE variables
implicit none 

!This module gathers all structures and variable declarations. 
!The different variables no need to be redefined and can this file can just be called in the subroutines.

integer ,parameter :: nx=11,ny=11,nz=1
real*8 ,parameter :: nu = 1e-02, dt2 = 1e-04


integer :: k, i, j, itmax, isto, istep, nstep, Q
integer ,parameter :: ndim = nx*ny,mdim=3
integer, dimension(1:mdim):: jcoef
integer, dimension(1:5):: Ldiag                                                                                             
real*8 :: max_x, max_y, min_u, min_v, u_tilde_x1, u_tilde_x2, u_tilde_y1, u_tilde_y2, v_tilde_x1, v_tilde_x2, v_tilde_y1, v_tilde_y2
real*8 :: zeta, time, dt, dx, dy, ddx, ddt, ddy, nu1, a, b, c, d, e, f, g, h, sum ! a=u(i+1/2,j); b=u(i-1/2,j); c=u(i,j+1/2); d=u(i,j-1/2); e=v(i+1/2,j); f=v(i-1/2,j); g=v(i,j+1/2); h=v(i,j-1/2)
real*8, dimension(0:nx+1,0:ny+1) :: p,u,v,u1,v1,u_star,v_star,abs_u,abs_v
real*8 ,dimension(1:nx,1:ny):: div,uc,vc,rot,w,pre
real*8 ,dimension(1:ndim,1:mdim) :: coef
real*8 ,dimension(1:ndim) :: div1,p_s,r_s,r2_s
real*8 ,dimension(1:ndim) :: q_s,s_s,x1
real*8 ,dimension(1:ndim,1:5)::L
real, dimension (1:nx) :: xx
real, dimension (1:ny) :: yy

end module
