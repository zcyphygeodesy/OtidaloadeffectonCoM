!  OceantidaloadeffCoM.f90 
!
!  FUNCTIONS:
!  OceantidaloadeffCoM - Entry point of console application.
!
!****************************************************************************

      program OceantidaloadeffCoM
      implicit none
	character*42::head
	character*800::line,str,astr,stm
	integer i,j,k,nn,IY,IM,ID,ih,imn,kk,sn,knd,kln
	real*8 GRS(6),mjd,mjd01,mjd02,mjd1,mjd2,stmjd,sec,rec(800)
      real*8 BLH(3),XYZ0(3),rln(3),rln0(3),enr(3),pi,RAD,ae,tm,td,bias,th
	real*8::doodson(80),dx(3),cs(80,6),fk,bgntm, endtm, tmdlt,ltm
	integer::status=0
!---------------------------------------------------------------------
      call CAL2JD (1950,1,1,mjd1,j) 
      call CAL2JD (2100,12,31,mjd2,j) 
      pi=datan(1.d0)*4.d0; RAD=pi/180.d0
      GRS(1)= 3.986004415d14; GRS(2)=6378137.d0; GRS(3)=1.0826359d-3
      GRS(4) = 7.292115d-5; GRS(5)=1.d0/298.25641153d0
      !Input starting time (long integer time), ending time, time interval (minute) 输入起止时间与时间间隔
      bgntm=20160701; endtm=20160715; tmdlt=60.d0/1440.d0
      fk=dsqrt(3.d0)*1.025d-2/5.517d0*GRS(2)*1.d3
      !读海潮分潮负荷一阶项同相幅值和异相幅值cs(:,6)
      !read the first-degree ocean tidal load spherical harmonic coefficients
      k=0
      open(unit=8,file="OtideOne.dat",status="old",iostat=status)
      if(status/=0)goto 902
      read(8,'(a)') line
      read(8,'(a)') line
      do while(.not.eof(8))
         k=k+1
         read(8,*)head,doodson(k),cs(k,1:6)
         doodson(k)=doodson(k)*1.d3
	enddo
	close(8)
      nn=k
      stmjd=0.d0
      call tmcnt(bgntm,IY,IM,ID,ih,imn,sec)
      call CAL2JD (IY,IM,ID,mjd,j)
      mjd01=mjd+dble(ih)/24.d0+dble(imn)/1440.d0+dble(sec)/864.d2 !GPS_MJD
      call tmcnt(endtm,IY,IM,ID,ih,imn,sec)
      call CAL2JD (IY,IM,ID,mjd,j)
      mjd02=mjd+dble(ih)/24.d0+dble(imn)/1440.d0+dble(sec)/864.d2 !GPS_MJD
      if(mjd02<mjd01.or.mjd01<mjd1.or.mjd01>mjd2.or.mjd02<mjd1.or.mjd02>mjd2) goto 902
      open(unit=10,file="reslt.txt",status="replace")
      write(10,'(a15,3F8.2,F15.6)')'Otidegeocenter',0,0,0,mjd01
      mjd=mjd01;mjd02=mjd02+1.d-6
      do while(mjd<mjd02)
         dx=0.d0
         do i=1,nn
            !calculate the phase bias (degree) of the tidal constituent i
            call BiasTide(doodson(i),bias)
            !calculate the astronomical argument (radian) of the tidal constituent i at mjd
            call Argutheta(mjd,doodson(i),th)
            dx(1)=dx(1)+cs(i,3)*dcos(th)+cs(i,4)*dsin(th)
            dx(2)=dx(2)+cs(i,5)*dcos(th)+cs(i,6)*dsin(th)
            dx(3)=dx(3)+cs(i,1)*dcos(th)+cs(i,2)*dsin(th)
         enddo
         dx=dx*fk
         call mjdtotm(mjd,ltm)
         call tmtostr(ltm,stm)
         write(10,'(a15,F12.6,3F12.4)')adjustl(stm), mjd-mjd01, (dx(i),i=1,3)
         mjd=mjd+tmdlt
906	   continue
	enddo
      close(10)
902	continue
101   format(a,40F12.4)
      write (*,*)'  Complete the computation! The results are saved in the file reslt.txt.'
      pause
      end
