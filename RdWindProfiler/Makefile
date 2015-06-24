#---------------------------------------------
# makefile for main program RdWindProfiler
# 
# 2015.06.18  Yu Zhang 
#----------------------------------------------
#
PROG =  ./rdwd.exe
FC = ifort
FFLAGS =  -g -C 

#LAPACKDIR = /g2/iumnwp/EPS/software/lapack-3.5.0
#NETCDFDIR = /opt/apps/netcdf413-intel/lib
#GRIBAPIDIR= /g2/iumnwp/EPS/software/grib_api
#LIBS =  -L${LAPACKDIR} -llapack -lrefblas -ltmglib -L${NETCDFDIR} -lnetcdff -lnetcdf \
#	-L${GRIBAPIDIR}/lib -lgrib_api_f90 -lgrib_api -I${GRIBAPIDIR}/include

OBJS =  Typedefine.o \
	RdNamelist.o \
	InitialObsVar.o \
	RdWindProfiler.o

.SUFFIXES: .o .c .f90 .a .f
.f90.o:;    $(FC) $(FFLAGS) -c $*.f90 $(LIBS)
.f.o:;      $(FC) $(FFLAGS) -c $*.f   $(LIBS)

###############################################

$(PROG): $(OBJS)
### for PC Linux
	$(FC) -g -C -o $@ $(OBJS) 
#	$(LIBS)
### for IBM_SP
#       $(FC) -q64 -qmaxmem=-1 -o $@ $(OBJS) $(OTHEROBJS) $(LIBS)


clean:
	rm -f $(PROG) $(OBJS) *.mod
#       rm -f $(PROG) ../../moddir/modu*.mod ../../objdir/*.o

