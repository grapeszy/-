!==============================================================
!>
!! This is the main code:
!!    Read the RAW windprofiler data from MOC
!! Need module:
!!    Typedefine :  global variables
!!
!! \author Yu Zhang: zhangyu_meteo@163.com
!!         
!!        
!! \history \n
!! Creation: Jun. 2014
!
!=============================================================

PROGRAM RdWD
  USE  Typedefine
  IMPLICIT NONE

!global variables are defined in typedefine

!local variables:
  INTEGER                           :: i,j,k
  INTEGER                           :: fin,fout
  INTEGER                           :: nflag,stnlev
  CHARACTER(len=14)                 :: timec,tmpc


!0.0---------------prepare env--------------------------------
  CALL Rdnamelist
  fin=10
  fout=20
!-------------------------------------------------------------

!1.0---------------read raw obs-------------------------------
!1.1--open raw obs file
  PRINT*,'++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
  PRINT*,'read the raw obs in: ',TRIM(indir)//TRIM(inname)
  OPEN(UNIT=fin,FILE=TRIM(indir)//TRIM(inname),FORM="formatted")

  READ(fin,*)timec,nstn
  PRINT*,'the total station number at ',TRIM(timec),' is : ',nstn
  nflag=0
  DO i = 1, nstn
!-------initial the obs at this station
    CALL InitialObsVar(i)
    IF(nflag .eq. 0) THEN
      READ(fin,*)tmpc
    ENDIF
    nflag = 0
!-------stn info
    READ(fin,*)wd(i)%id,wd(i)%lon,wd(i)%lat,&
               wd(i)%elevation,wd(i)%obstime,wd(i)%stnqc
    READ(fin,*)tmpc

!-------mode first
    READ(fin,'(A5,A5,I4)',err=105)tmpc,tmpc,wd(i)%mode1obs%obsnum
    DO j = 1,wd(i)%mode1obs%obsnum
      READ(fin,*,err=106)wd(i)%mode1obs%obshgt(j),wd(i)%mode1obs%obsdir(j),&
                         wd(i)%mode1obs%obshsp(j),wd(i)%mode1obs%obswsp(j),&
                         wd(i)%mode1obs%obshrec(j),wd(i)%mode1obs%obswrec(j),&
                         wd(i)%mode1obs%obscn2(j),wd(i)%mode1obs%obsqc(j)
!      PRINT*,wd(i)%mode1obs%obshgt(j),wd(i)%mode1obs%obsdir(j),&
!                         wd(i)%mode1obs%obshsp(j),wd(i)%mode1obs%obswsp(j),&
!                         wd(i)%mode1obs%obshrec(j),wd(i)%mode1obs%obswrec(j),&
!                         wd(i)%mode1obs%obscn2(j),wd(i)%mode1obs%obsqc(j)
106 CYCLE
    ENDDO
    READ(10,*) tmpc

!-------mode second
    READ(fin,'(A5,A6,I4)',err=105)tmpc,tmpc,wd(i)%mode2obs%obsnum
    DO j = 1,wd(i)%mode2obs%obsnum      
      READ(fin,*,err=107)wd(i)%mode2obs%obshgt(j),wd(i)%mode2obs%obsdir(j),&
                         wd(i)%mode2obs%obshsp(j),wd(i)%mode2obs%obswsp(j),&
                         wd(i)%mode2obs%obshrec(j),wd(i)%mode2obs%obswrec(j),&
                         wd(i)%mode2obs%obscn2(j),wd(i)%mode2obs%obsqc(j)
!      PRINT*,wd(i)%mode1obs%obshgt(j),wd(i)%mode1obs%obsdir(j),&
!                         wd(i)%mode1obs%obshsp(j),wd(i)%mode1obs%obswsp(j),&
!                         wd(i)%mode1obs%obshrec(j),wd(i)%mode1obs%obswrec(j),&
!                         wd(i)%mode1obs%obscn2(j),wd(i)%mode1obs%obsqc(j)
107 CYCLE
    ENDDO
    READ(10,*) tmpc

!-------mode third
    READ(fin,'(A5,A5,I4)',err=105)tmpc,tmpc,wd(i)%mode3obs%obsnum
    DO j = 1,wd(i)%mode3obs%obsnum
      READ(fin,*,err=108)wd(i)%mode3obs%obshgt(j),wd(i)%mode3obs%obsdir(j),&
                         wd(i)%mode3obs%obshsp(j),wd(i)%mode3obs%obswsp(j),&
                         wd(i)%mode3obs%obshrec(j),wd(i)%mode3obs%obswrec(j),&
                         wd(i)%mode3obs%obscn2(j),wd(i)%mode3obs%obsqc(j)
!      PRINT*,wd(i)%mode1obs%obshgt(j),wd(i)%mode1obs%obsdir(j),&
!                         wd(i)%mode1obs%obshsp(j),wd(i)%mode1obs%obswsp(j),&
!                         wd(i)%mode1obs%obshrec(j),wd(i)%mode1obs%obswrec(j),&
!                         wd(i)%mode1obs%obscn2(j),wd(i)%mode1obs%obsqc(j)
108 CYCLE
    ENDDO
    READ(10,*) tmpc


!    PRINT*,"                   read the next stantion"
    CYCLE

105 nflag=1
!    PRINT*,"                   read the next stantion"

  ENDDO ! for i loop stations

  CLOSE(fin)
  PRINT*,"Read raw obs finished!"
  PRINT*,'++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
!-------------------------------------------------------------

!2.0---------------output acsii files for obs check-----------
!2.1---each station-------------------------------------------
  DO i = 1, nstn
    PRINT*,"output the station data in: ",TRIM(ascdir)//TRIM(wd(i)%id)//".txt"
    OPEN(UNIT=fout,FILE=TRIM(ascdir)//TRIM(wd(i)%id)//".txt",FORM="formatted")

    DO j = 1, wd(i)%mode1obs%obsnum
      IF(wd(i)%mode1obs%obsqc(j) .GE. 0) THEN
        WRITE(fout,'(A5,2F14.6,2F10.2,2F14.6,2F4.0)') &
                       wd(i)%id,wd(i)%lat,wd(i)%lon,wd(i)%elevation,&
                       wd(i)%mode1obs%obshgt(j),wd(i)%mode1obs%obsdir(j),&
                       wd(i)%mode1obs%obshsp(j),wd(i)%mode1obs%obshrec(j),wd(i)%mode1obs%obswrec(j)
      ENDIF
    ENDDO

    DO j = 1, wd(i)%mode2obs%obsnum
      IF(wd(i)%mode2obs%obsqc(j) .GE. 0) THEN
        WRITE(fout,'(A5,2F14.6,2F10.2,2F14.6,2F4.0)') &
                       wd(i)%id,wd(i)%lat,wd(i)%lon,wd(i)%elevation,&
                       wd(i)%mode2obs%obshgt(j),wd(i)%mode2obs%obsdir(j),&
                       wd(i)%mode2obs%obshsp(j),wd(i)%mode2obs%obshrec(j),wd(i)%mode2obs%obswrec(j)
      ENDIF
    ENDDO

    DO j = 1, wd(i)%mode3obs%obsnum
      IF(wd(i)%mode3obs%obsqc(j) .GE. 0) THEN
        WRITE(fout,'(A5,2F14.6,2F10.2,2F14.6,2F4.0)') &
                       wd(i)%id,wd(i)%lat,wd(i)%lon,wd(i)%elevation,&
                       wd(i)%mode3obs%obshgt(j),wd(i)%mode3obs%obsdir(j),&
                       wd(i)%mode3obs%obshsp(j),wd(i)%mode3obs%obshrec(j),wd(i)%mode3obs%obswrec(j)
      ENDIF
    ENDDO

    CLOSE(fout)
  ENDDO ! for nstn loop

!-------------------------------------------------------------

!3.0---------------convert the obs into littile-R format------
!-------------------------------------------------------------

END
