!==============================================================%
!>
!! Initial obs variables
!!
!! \author Yu Zhang: zhangyu_meteo@163.com
!!        
!! \history \n
!! Creation: Jun. 2015
!
!=============================================================
SUBROUTINE InitialObsVar(inum)
  USE Typedefine
  IMPLICIT NONE

!local var
  INTEGER               ::inum

  wd(inum)%lat = undef
  wd(inum)%lon = undef
  wd(inum)%elevation = undef
  wd(inum)%obstime = ""
  wd(inum)%stnqc = undef

  wd(inum)%mode1obs%obsnum = 0
  wd(inum)%mode2obs%obsnum = 0
  wd(inum)%mode3obs%obsnum = 0

  wd(inum)%mode1obs%obshgt = undef
  wd(inum)%mode1obs%obsdir = undef
  wd(inum)%mode1obs%obshsp = undef
  wd(inum)%mode1obs%obswsp = undef
  wd(inum)%mode1obs%obshrec= undef
  wd(inum)%mode1obs%obswrec= undef
  wd(inum)%mode1obs%obscn2 = undef
  wd(inum)%mode1obs%obsqc  = undef

  wd(inum)%mode2obs%obshgt = undef
  wd(inum)%mode2obs%obsdir = undef
  wd(inum)%mode2obs%obshsp = undef
  wd(inum)%mode2obs%obswsp = undef
  wd(inum)%mode2obs%obshrec= undef
  wd(inum)%mode2obs%obswrec= undef
  wd(inum)%mode2obs%obscn2 = undef
  wd(inum)%mode2obs%obsqc  = undef
     
  wd(inum)%mode3obs%obshgt = undef
  wd(inum)%mode3obs%obsdir = undef
  wd(inum)%mode3obs%obshsp = undef
  wd(inum)%mode3obs%obswsp = undef
  wd(inum)%mode3obs%obshrec= undef
  wd(inum)%mode3obs%obswrec= undef
  wd(inum)%mode3obs%obscn2 = undef
  wd(inum)%mode3obs%obsqc  = undef
     

END SUBROUTINE InitialObsVar
