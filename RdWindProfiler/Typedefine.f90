!==============================================================
!>
!! This is the  module typedefine. The defination of all
!! the variables used in the code                    
!!
!! \author Yu Zhang and YuHuang Li
!!        
!! \history \n
!! Creation: Nov. 2014
!
!=============================================================
MODULE Typedefine
IMPLICIT NONE
!-----------for parameters
 REAL,PARAMETER                         ::undef=-99999.99    !undefined variables
!-----------for observation
 INTEGER,PARAMETER                      ::maxstnnum=200      !max station number
 INTEGER,PARAMETER                      ::maxobsnum=1000     !max obs levels for each station

 TYPE :: wdobs                                               !type for each level's obs
  INTEGER                               :: obsnum            !
  REAL,DIMENSION(maxobsnum)             :: obshgt            !observation height
  REAL,DIMENSION(maxobsnum)             :: obsdir            !horizontal wind dir
  REAL,DIMENSION(maxobsnum)             :: obshsp            !horizontal speed
  REAL,DIMENSION(maxobsnum)             :: obswsp            !vertical speed
  REAL,DIMENSION(maxobsnum)             :: obshrec           !horizontal reliability
  REAL,DIMENSION(maxobsnum)             :: obswrec           !vertical reliability
  REAL,DIMENSION(maxobsnum)             :: obscn2            !cn2
  REAL,DIMENSION(maxobsnum)             :: obsqc             !qc 1 for rain; 0 for sun
 END TYPE wdobs

 TYPE :: wdstn                                               !type for each station
  CHARACTER(len=5)                      :: id
  REAL                                  :: lat
  REAL                                  :: lon
  REAL                                  :: elevation         !station elevation
  CHARACTER(len=2)                      :: rdtype            !radar type
  CHARACTER(len=14)                     :: obstime           !observation time
  REAL                                  :: stnqc             !qc 1 for rain; 0 for sun; should the same as obsqc
  TYPE(wdobs)                           :: mode1obs          !each mode for one station;only 3 mode used now
  TYPE(wdobs)                           :: mode2obs
  TYPE(wdobs)                           :: mode3obs
  TYPE(wdobs)                           :: mode4obs
 END TYPE wdstn

  INTEGER                               :: nstn              !number of stations
  INTEGER                               :: nsample           !number of sample


!--------initial obs variable
  TYPE(wdstn),DIMENSION(maxstnnum)      :: wd
  
!-----------for namelist parameters
  CHARACTER(len=120)                    ::indir,ascdir
  CHARACTER(len=80)                     ::inname,ascname
  
END MODULE Typedefine
