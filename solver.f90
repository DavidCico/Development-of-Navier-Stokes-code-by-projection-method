SUBROUTINE ICCG2(coef,jcoef,L,Ldiag,b,x,n,m,eps,p,r,r2,q,s,itmax)

!-----------------------------------------------------------------------!
!                                                                       !
! 	  CONJUGUATE GRADIENT + PRECONDITIONED LU FILL-IN 2                 !
!                                                                       !
!     ATTENTION : coef, jcoef et b are modified in this routine         !
!     ---------                                                         !
!                                                                       !
!-----------------------------------------------------------------------!

	implicit none

!---------------------------------------------------!
!    VARIABLES IN CALL                              !
!---------------------------------------------------!

	integer, intent(in) :: n,m,itmax
	real*8, intent(in) :: eps

	integer, dimension(m), intent(inout) :: jcoef
	real*8, dimension(n,m), intent (inout) :: coef

	integer, dimension(5), intent(inout) :: Ldiag
	real*8, dimension(n,5), intent (inout) :: L

	real*8, dimension(n), intent (inout) :: b,x
	real*8, dimension(n), intent(inout) :: p,r,r2,q,s

!---------------------------------------------------!
!    LOCAL VARIABLES                                !
!---------------------------------------------------!

	real*8 :: alpha,beta,nu,mu,norm0,norm,sum,scal,norm1,norm2
	integer :: i,j,col



        write(6,*) 'itmax=',itmax
!-----------------------------------------------------------!
!   PRECONDITIONING MATRIX CALCULUS + SCALING               !
!-----------------------------------------------------------!
	do i=1,3; Ldiag(i)=jcoef(i); end do
	Ldiag(4)=Ldiag(3)-1
	Ldiag(5)=Ldiag(3)-2

	L=0.

	do i=1,n

		L(i,1)=coef(i,1)
		do j=2,5
			col=Ldiag(j)
			if (col<i) L(i,1)=L(i,1)-L(i-col,j)*L(i-col,j)*s(i-col)
		end do
		s(i)=1./L(i,1) ! Temporary variable to avoid divisions by L(i,1)

		L(i,2)=coef(i,2)
		do j=4,5
			col=Ldiag(j)
			if (col<i) L(i,2)=L(i,2)-L(i-col,j)*L(i-col,j-1)*s(i-col)
		end do
		
		L(i,3)=coef(i,3)
		
		if (i>1) then
			L(i,4)=-L(i-1,3)*L(i-1,2)*s(i-1)
			L(i,5)=-L(i-1,4)*L(i-1,2)*s(i-1)
		end if

	end do

	do i=1,n; L(i,1)=sqrt(s(i)); end do

	do j=1,3
		col=Ldiag(j)
		do i=1,n-col
			coef(i,j)=coef(i,j)*L(i,1)*L(i+col,1)
		end do
	end do
	
	do i=1,n
		
		L(i,2)=coef(i,2)
		do j=4,5
			col=Ldiag(j)
			if (col<i) L(i,2)=L(i,2)-L(i-col,j)*L(i-col,j-1)
		end do
		
		L(i,3)=coef(i,3)
		
		if (i>1) then
			L(i,4)=-L(i-1,3)*L(i-1,2)
			L(i,5)=-L(i-1,4)*L(i-1,2)
		end if

	end do

	norm0=norm2(b,n)

	do i=1,n; s(i)=1./s(i); end do

	do i=1,n; b(i)=b(i)*L(i,1); end do

!---------------------------------------------------!
!    CONJUGUATE GRADIENT                            !
!---------------------------------------------------!

	call matmul_ell(p,coef,jcoef,x,n,m)
	do i=1,n; r(i)=b(i)-p(i); end do

	call resLU_ell5(r2,L,Ldiag,r,n) 

	p=r2
	nu=scal(r,r2,n)

	norm=0.
	do i=1,n; norm=norm+r(i)*r(i)*s(i); end do
	norm=sqrt(norm)/norm0

	j=0

	do while (norm>eps.and.j.lt.itmax)
		j=j+1

		call matmul_ell(q,coef,jcoef,p,n,m)

		alpha=nu/scal(p,q,n)
		
		do i=1,n; x(i)=x(i)+alpha*p(i); end do
		do i=1,n; r(i)=r(i)-alpha*q(i); end do

		call resLU_ell5(r2,L,Ldiag,r,n)

		mu=scal(r,r2,n)

		beta=mu/nu

		do i=1,n; p(i)=r2(i)+beta*p(i); end do

		nu=mu

		norm=0.
		do i=1,n; norm=norm+r(i)*r(i)*s(i); end do
		norm=sqrt(norm)/norm0

	end do

!---------------------------------------------------!
!    SOLUTION SCALING                               !
!---------------------------------------------------!

	do i=1,n; x(i)=x(i)*L(i,1); end do

        if(j.ge.itmax) then
	   print*, 'non convergence apres =', j,norm
        else
	   print*, ' Nombre It�rations ICCG2 ( Fill-In 2 ) =', j
	endif
	return

END SUBROUTINE ICCG2





SUBROUTINE resLU_ell5(x,L,Ldiag,y,n)

	implicit none

	integer, intent(in) :: n
	real*8, dimension(n,5), intent (in) :: L
	integer, dimension(5), intent(in) :: Ldiag
	real*8, dimension(n), intent(in) :: y
	real*8, dimension(n), intent(out) :: x
	
	integer :: i,j,col1,col2,col3,col4,col5,col6
	
	col1=Ldiag(2)
	col2=Ldiag(5)
	col3=Ldiag(4)
	col4=Ldiag(3)

	do i=1,col1
		x(i)=y(i)
	end do
	
	do i=col1+1,col2
		x(i)=y(i)-L(i-col1,2)*x(i-col1)
	end do
	
	do i=col2+1,col3
		x(i)=y(i)-L(i-col1,2)*x(i-col1)-L(i-col2,5)*x(i-col2)
	end do

	do i=col3+1,col4
		x(i)=y(i)-L(i-col1,2)*x(i-col1)-L(i-col2,5)*x(i-col2)&
		         -L(i-col3,4)*x(i-col3)
	end do
	
	do i=col4+1,n
		x(i)=y(i)-L(i-col1,2)*x(i-col1)-L(i-col2,5)*x(i-col2)&
		         -L(i-col3,4)*x(i-col3)-L(i-col4,3)*x(i-col4)
	end do

	do i=n-col1,n-col2+1,-1
		x(i)=x(i)-L(i,2)*x(i+col1)
	end do
	
	do i=n-col2,n-col3+1,-1
		x(i)=x(i)-L(i,2)*x(i+col1)-L(i,5)*x(i+col2)
	end do
	
	do i=n-col3,n-col4+1,-1
		x(i)=x(i)-L(i,2)*x(i+col1)-L(i,5)*x(i+col2)-L(i,4)*x(i+col3)
	end do
	
	do i=n-col4,1,-1
		x(i)=x(i)-L(i,2)*x(i+col1)-L(i,5)*x(i+col2)-L(i,4)*x(i+col3)&
		         -L(i,3)*x(i+col4)
	end do

	return

END SUBROUTINE resLU_ell5





SUBROUTINE matmul_ell(x,coef,jcoef,y,n,m)

	implicit none

	integer, intent(in) :: n,m
	real*8, dimension(n,m), intent (in) :: coef
	integer, dimension(m), intent(in) :: jcoef
	real*8, dimension(n), intent(in) :: y
	real*8, dimension(n), intent(out) :: x
	
	integer :: i,j,col

	do i=1,n
		x(i)=coef(i,1)*y(i)
	end do

	do j=2,m
		col=jcoef(j)
		do i=1,n-col
			x(i)=x(i)+coef(i,j)*y(i+col)
			x(i+col)=x(i+col)+coef(i,j)*y(i)
		end do
	end do

	return

END SUBROUTINE matmul_ell


FUNCTION scal(x,y,n) result(res)

	implicit none

	integer, intent(in) :: n
	real*8, dimension(n), intent(in) :: x,y

	integer :: i

	real*8 :: res

	res=0.
	do i=1,n; res=res+x(i)*y(i); end do

END FUNCTION


FUNCTION norm1(x,n) result(res)

	implicit none

	integer, intent(in) :: n
	real*8, dimension(n), intent(in) :: x

	integer :: i

	real*8 :: res

	res=0.
	do i=1,n; res=res+x(i)*x(i); end do

END FUNCTION


FUNCTION norm2(x,n) result(res)

	implicit none

	integer, intent(in) :: n
	real*8, dimension(n), intent(in) :: x

	integer :: i

	real*8 :: res

	res=0.
	do i=1,n; res=res+x(i)*x(i); end do
	res=sqrt(res)

END FUNCTION
