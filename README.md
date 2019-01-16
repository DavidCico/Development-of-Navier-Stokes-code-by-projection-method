# Development-of-Navier-Stokes-code-by-projection-method
<p align="justify">This code is a Fortran implementation of a 2D flow using projection method with FVM. Navier Stokes equations are solved for velocity and pressure fields. The rotational of velocity is also calculated, and the output data can be visualized with Ensight or Paraview.</p>

## Getting Started

<p align="justify">These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.</p>

### Prerequisites

<p align="justify">The code being implemented in Fortran 90, and Fortran being a compiled language, it requires a compiler such as <a href="https://gcc.gnu.org/wiki/GFortran">GFortran</a>.</p>

In Ubuntu, Mint and Debian you can install GFortran like this:

    sudo apt-get install gfortran
    
<p align="justify">Alongside the GFortran compiler, the open-source platform for data analysis and visualization, <a href="https://www.paraview.org/">ParaView</a>, is also required and installed through the commands:</p>

    sudo apt-get update
    sudo apt-get install paraview

<p align="justify">Paraview is preferred compared to Ensight as it is free and open-source, so that everybody can use it.</p>

For other Linux flavors, OS X and Windows, packages are available at:

https://gcc.gnu.org/wiki/GFortranBinaries for GFortran    
https://www.paraview.org/download/ for ParaView


## File descriptions
<ul>
    <li>'.f90' files in which the main code, as well as the different subroutines are programmed.</li>
    <li>'Makefile' to compile the code.</li>
    <li>In the directory 'Documents', there are 3 files in PDF format:
        <ul>
            <li>2 papers 'cavityflow.pdf' and 'ghia82.pdf', which treat of the lid driven cavity problem for incompressible flows.</li>             <li>'Program_presentation.pdf' which describe all the steps followed in the code implementation.</li>
        </ul>
    </li>
</ul>

### Running the program

1. Input numerical values for the mesh size and viscosity, in the file 'variables module.f90'.
 ```fortran
 ! Parameters for reading data to be modified
 integer ,parameter :: nx=11,ny=11,nz=1 ! nx and ny correpond to the number of cells in x and y direction
 real*8 ,parameter :: nu = 1e-02, dt2 = 1e-04 ! nu is the fluid viscosity and dt2 is the initial timestep. 
 ```
2. Simulation parameters to be defined in the main program 'main.f90'.
```fortran
!!! Parameters for the simulation
  zeta=1.e-8       ! zeta and itmax for solving pressure matrix in ICCG2 subroutines
  itmax=300
  time = 0.        ! initialize time of simulation
  nstep = 20000    ! number of timesteps for the simulation
  isto = 200       ! data stored every 'isto' steps
```
3. Use the **Makefile** to compile all the files and create the executable (run the command 'make' while being in the main directory of the program).

4. Launch the executable <i>NS_lid_driven_cavity</i>, which will create the mesh and run the discretised calculation on the latter.

<p align="justify">&emsp;5. Observe the different fields (u, v, p and omega) on the domain using Paraview. Ensight6 and Ensight Gold formats are normally supported by Paraview.</p>

6. Remove the created files thanks to the commands 'make clean' and 'make cleanall'.

## Contributing

Please read [CONTRIBUTING.md](https://github.com/DavidCico/Study-of-buy-and-hold-investment/blob/master/CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags). 

## Authors

* **David Cicoria** - *Initial work* - [DavidCico](https://github.com/DavidCico)

See also the list of [contributors](https://github.com/DavidCico/Study-of-buy-and-hold-investment/graphs/contributors) who participated in this project.
