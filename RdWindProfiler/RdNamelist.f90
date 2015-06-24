!==============================================================
!>
!! Reading parameters from wd.nl
!!
!! \author Yu Zhang: zhangyu_meteo@163.com
!!        
!! \history \n
!! Creation: Jun. 2015
!
!=============================================================
SUBROUTINE Rdnamelist
  USE Typedefine
  IMPLICIT NONE
!local scalars
  CHARACTER(LEN=90)   :: namelist_file      ! Input namelist filename.
  INTEGER, PARAMETER  :: namelist_unit = 99 ! Input namelist unit.
  INTEGER             :: iost               ! Error code.

!! FOR obs para
  NAMELIST /obs_in     / indir,inname

!! FOR ascii out para
  NAMELIST /ascii_out /  ascdir,ascname

!----------------------------------------------------------------------------
! 1.0 Open namelist file:
!----------------------------------------------------------------------------
  namelist_file = 'wd.nl'

  WRITE(0,*)
  WRITE(0,*)'++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
  WRITE(0,*)'RdNamelist.f90:'
  WRITE(0, '(/,A,A)' ) '   Reading NAMELIST : ', namelist_file

  iost = 0

  OPEN ( UNIT   = namelist_unit,       &
         FILE   = namelist_file,       &
         STATUS = 'OLD',               &
         ACCESS = 'SEQUENTIAL',        &
         FORM   = 'FORMATTED',         &
         ACTION = 'READ' ,             &
         ERR    = 9999 ,               &
         IOSTAT = iost )

!----------------------------------------------------------------------------
! 2.0 Read namelist and close:
!----------------------------------------------------------------------------

  READ(UNIT = namelist_unit, NML = obs_in        , ERR= 9999, IOSTAT = iost)
  READ(UNIT = namelist_unit, NML = ascii_out     , ERR= 9999, IOSTAT = iost)
  !READ(UNIT = namelist_unit, NML = Obs_error     , ERR= 9999, IOSTAT = iost)
!----------------------------------------------------------------------------
  CLOSE (namelist_unit)
  PRINT*,"Read namelist finished!"
  WRITE(0,*)'++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'

  RETURN

9999  WRITE (0,'(A,A,A,I3,/)') '   Error reading namelist file ',    &
                                   TRIM(namelist_file),' iostat = ', &
                                     iost
  STOP                         '   in RdNamelist.f90'



     

END SUBROUTINE Rdnamelist
