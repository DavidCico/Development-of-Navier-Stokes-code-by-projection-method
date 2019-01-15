subroutine reading_data()
use variables
implicit none

dx = 1./float(nx)
dy = 1./float(ny)
ddx = 1./dx
ddy = 1./dy
nu1 = 1./nu

end subroutine reading_data
