      subroutine Argutheta(mjd,doodson,th)
!calculate the astronomical argument (radian) of the tidal constituent doodson at mjd
	  integer::nn,i,j,n,m,k,maxn,bs,td
	  real*8::doodson,mjd,t,pi,RAD
	  real*8::th,astr(6),tt,dod(6)
!---------------------------------------------------------------------
      pi=datan(1.d0)*4.d0;RAD=pi/180.d0
      t=(mjd-51544.5d0)/36525.d0 !J2000.0 
      tt=(mjd-51545.d0)-floor(mjd-51545.d0)!Restore 0.5 days ²¹»Ø0.5Ìì
      astr(2)=218.31664563d0+481267.88119575d0*t-0.001466388889d0*t**2    !s
     >	-0.000000074112d0*t**3-0.000000153389d0*t**4
	astr(3)=280.4664501606d0+36000.769748805556d0*t+0.000303222222d0*t**2 !h
     >	-0.000001905501d0*t**3-0.000000065361d0*t**4
	astr(4)=83.35324312d0+4069.01363525d0*t-0.010321722222d0*t**2     !p
     >	-0.000014417168d0*t**3+0.0000000526333d0*t**4
	astr(5)=234.95544499d0+1934.136261972222d0*t-0.002075611111d0*t**2      !N'
     >	-0.000000213944d0*t**3+0.000000164972d0*t**4
	astr(6)=282.9373409806d0+1.719457666668d0*t**2+0.000456888889d0*t**2     !ps
     >	-0.000001943279d0*t**3-0.0000000033444d0*t**4
	astr(1)=360.d0*tt-astr(2)+astr(3)
	astr=dmod(astr*RAD,2.d0*pi)
      th=0.d0;td=nint(doodson);bs=100000
	do j=1,6
	   dod(j)=td/bs;td=td-bs*dod(j);bs=bs/10
         if(j>1)dod(j)=dod(j)-5
      enddo
      do j=1,6
	   th=th+dble(dod(j))*astr(j)
      enddo
      th=dmod(th,2.d0*pi)
      return
      end
