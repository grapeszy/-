PROGRAM test

IMPLICIT NONE
INTEGER               ::a,g,nstn,i,j,nc
INTEGER               ::stnlev,hh,tmpi
REAL                  ::stnlon,stnlat,stnhgt
REAL                  ::dd,uu,tmpf,qc
CHARACTER*80          ::stntype,stntime,stnqc
REAL                  ::b,c,d
CHARACTER*80          ::tmpc,e,f,timec
CHARACTER*5           ::stnid


OPEN(unit=20,file="stn.txt",form="FORMATTED")
OPEN(unit=10,file="./sample.txt",form="FORMATTED")
  READ(10,*)timec,nstn
  nc=0
  DO j = 1, nstn
    IF(nc .eq. 0) THEN
      READ(10,*)tmpc
    ENDIF
    nc = 0
    PRINT*,'j=',j
    READ(10,*)stnid,stnlon,stnlat,stnhgt,stntype,stntime,stnqc
    WRITE(20,'(2F14.8)') stnlon,stnlat
    PRINT*,stnid,stnlon,stnlat,stnhgt,stntype,stntime,stnqc
    READ(10,*)tmpc
    READ(10,'(A5,A5,I4)',err=105)tmpc,tmpc,stnlev
    PRINT*,tmpc,tmpc,stnlev
    DO i = 1,stnlev
      READ(10,*,err=106)hh,dd,uu,tmpf,tmpi,tmpi,tmpf,qc
!      PRINT*,hh,dd,uu,tmpf,tmpi,tmpi,tmpf,qc
106 CYCLE
    ENDDO
    READ(10,*) tmpc
    PRINT*,"mode first finished"

    READ(10,'(A5,A6,I4)',err=105)tmpc,tmpc,stnlev
    PRINT*,tmpc,tmpc,stnlev
    DO i = 1,stnlev
      READ(10,*,err=107)hh,dd,uu,tmpf,tmpi,tmpi,tmpf,qc
!      PRINT*,hh,dd,uu,tmpf,tmpi,tmpi,tmpf,qc
107 CYCLE
    ENDDO
    READ(10,*) tmpc
    PRINT*,"mode second finished"

    READ(10,'(A5,A5,I4)',err=105)tmpc,tmpc,stnlev
    PRINT*,tmpc,tmpc,stnlev
    DO i = 1,stnlev
      READ(10,*,err=108)hh,dd,uu,tmpf,tmpi,tmpi,tmpf,qc
      !PRINT*,hh,dd,uu,tmpf,tmpi,tmpi,tmpf,qc
108 CYCLE
    ENDDO
    READ(10,*) tmpc
    PRINT*,"mode THIRD finished"
    !READ(10,*) tmpc

    PRINT*,"read the next stantion"
    CYCLE

105 nc=1

  ENDDO !for j

CLOSE(10)

CLOSE(20)



END
