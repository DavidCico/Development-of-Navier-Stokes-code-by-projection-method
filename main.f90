program NS_lid_driven_cavity
  use variables
  implicit none

  call reading_data()         ! reading some data for mesh creation and calculation
  call mesh_creation()        ! creating the mesh for the simulation
  call initial_conditions()    ! initializing conditions
  call boundary_conditions()  ! boundary conditions of the domain

  write(*,*) 'Choice of numerical scheme: 1-Upwind; 2-Centred'
  read(*,*) Q
    
  !!! Parameters for the simulation
    zeta=1.e-8       ! zeta and itmax for solving pressure matrix in ICCG2 subroutines
    itmax=300
    time = 0.        ! initialize time of simulation
    nstep = 20000    ! number of timesteps for the simulation
    isto = 200       ! data stored every 'isto' steps
	  
   do istep=1,nstep  ! main loop on the timesteps

      if (Q == 1) then !Upwind scheme
 
         call timestep()
         call discretisation_intermediary_velocity_upwind()

      else if (Q == 2) then !Centred scheme

         call timestep()
         call discretisation_intermediary_velocity_centre()

      end if

      call calcul_2nd_membre() ! Calculate the second membre of equation AX=B
      call matgen_cavity(coef,jcoef,nx,ny,ndim,mdim,dx,dy) ! Generate coefficients of matrix A
      call ICCG2(coef,jcoef,L,Ldiag,div1,x1,ndim,mdim,zeta,p_s,r_s,r2_s,q_s,s_s,itmax) ! CONJUGUATE GRADIENT + PRECONDITIONED LU for solving X field (pressure here)
      call calcul_pressure_field() ! update the pressure field
      call calcul_new_velocity() ! update velocity field + calculate rotational 'omega'

      !! loops to update the main u and v velocity fields
      do j=1,ny
	      do i=1,nx-1
            u(i,j) = u1(i,j)    
         enddo
      enddo
      
      do j=1,ny-1
	      do i=1,nx
            v(i,j) = v1(i,j)    
         enddo
      enddo
		   
      time = time + dt           ! update in time --> time = time + timestep
      write(*,*) 'time = ',time  ! write the time of simulation

      call boundary_conditions() ! recall boundary conditions to update them

      if (mod(istep,isto)==0) then ! write results in ensight format if isto = istep
 
         call write_result_ensight(xx,yy,uc,vc,rot,pre,nx,ny,nz,istep,isto,nstep)

      end if
   
   end do
   
   call velocities_output() ! write velocity and omega on lines at final stage

end program NS_lid_driven_cavity
