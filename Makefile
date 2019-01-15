# Makefile 
# Nom du compilateur
FC = gfortran

# Options de compilation: optimisation, debug etc...
OPT = -fdefault-real-8 -O3
# nom de l'executable
EXE = NS_lid_driven_cavity
# Options de l'edition de lien..
LINKOPT = 

# Defining the objects (OBJS) variables

OBJS =  \
       variables_module.o \
       main.o \
       reading_data.o \
       mesh_creation.o \
       initial_conditions.o \
       boundary_conditions.o \
       timestep.o \
       discretisation_upwind.o \
       discretisation_centre.o \
       calcul_2nd_membre.o \
       matgen_cavity.o \
       solver.o \
       calcul_pressure_field.o \
       calcul_new_velocity.o \
       velocities_output.o \
       ensight_cavity.o \
  
    

# Linking object files
exe :   $(OBJS)
	$(FC) $(LINKOPT) $(OBJS)  -o $(EXE) 

%.o:%.f90
	$(FC) $(OPT) -c $<

main.o : variables_module.o

reading_data.o : variables_module.o

mesh_creation.o: variables_module.o

initial_conditions.o : variables_module.o

boundary_conditions.o : variables_module.o

timestep.o : variables_module.o

discretisation_upwind.o : variables_module.o

discretisation_centre.o : variables_module.o

calcul_2nd_membre.o : variables_module.o

calcul_pressure_field.o : variables_module.o

calcul_new_velocity.o : variables_module.o

velocities_output.o : variables_module.o



# Removing object files
clean :
	/bin/rm -f $(OBJS) $(EXE)  *.mod

cleanall : 
	/bin/rm -f $(OBJS) $(EXE)  *.mod
	/bin/rm -f *.scl
	/bin/rm -f *.vec

config :
	if [ ! -d obj ] ; then mkdir obj ; fi
	if [ ! -d run ] ; then mkdir run ; fi
