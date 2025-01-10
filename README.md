## Fortran codes for forecast of ocean tidal load effects on Earth's centric variation of mass
https://www.zcyphygeodesy.com/en/h-nd-128.html
## [Algorithm purpose]
&emsp;```Input time series parameters, and forecast the ocean tidal load effect time series on Earth's mass centric variation (Xcm, Ycm, Zcm, in unit of mm) from the first-degree ocean tidal load spherical harmonic coefficient file OtideOne.dat output by the function [Spherical harmonic analysis on ocean tidal constituent harmonic constants].```  
&emsp;```Improve the algorithm of tidal load effects on Earth's mass centric variation in the IERS Conventions (2010), so that the tidal load effects on Earth's mass centric variation is strictly one-to-one correspondence with global tidal load spherical harmonic coefficient model.```  
&emsp;```The Earth's tidal force from the celestial body at the Earth's center of mass is always equal to zero, so geodesy does not specifically study the solid tidal effect on the Earth's center of mass. Ocean tides and surface atmosphere tides lead to the redistribution of surface mass, causing periodic variations of Earth's center of mass.```
![](https://24192633.s21i.faiusr.com/2/ABUIABACGAAguLbQuQYo__3L9wEwlg44ugk.jpg)
## [Geophysical models]
    (1) The first-degree ocean tidal load spherical harmonic coefficient file OtideOne.dat.
    The file is output by the function [Spherical harmonic analysis on ocean tidal constituent harmonic constants]. From the FES2014b ocean tide model, the first-degree ocean tidal load spherical harmonic coefficient file can be generated with the spherical harmonic analysis of 34 tidal constituent harmonic constants.
## [Main program for test entrance]
    OceantidaloadeffCoM.f90
    The record of the test output file reslt.txt: the long integer time agreed by ETideLoad, difference between the MJD day and starting MJD0, ocean tidal load effects (dX, dY, dZ; in unit of mm) on Earth's mass centric variation.
## (1) Algorithm module for the phase bias of the tidal constituent
    BiasTide(doodson,bias)
    Input parameters: doodson(6) - Doodson constants of the tidal constituent.
    Return parameters: bias - the phase bias (degree) of the tidal constituent.
## (2) Algorithm module for the astronomical argument of the tidal constituent
    Argutheta(mjd,doodson,th)
    Input parameters: mjd, doodson(6) - the forecast epoch time (MJD day), and Doodson constants of the tidal constituent.
    Return: th - the astronomical argument (radian) of the tidal constituent at mjd.
## (3) Algorithm library for transforming of geodetic coordinates
    BLH_RLAT(GRS, BLH, RLAT); BLH_XYZ(GRS, BLH, XYZ)
    RLAT_BLH(GRS, RLAT, BLH)
## (4) Algorithm library for converting of time system
    CAL2JD (IY0, IM0, ID0, DJM, J); JD2CAL(DJ1, DJ2, IY, IM, ID, FD, J)
## (5) Other auxiliary modules
    PickRecord(str0, kln, rec, nn); tmcnt(tm, iyr, imo, idy, ihr, imn, sec)
    mjdtotm(mjd0, ltm); tmtostr(tm, tmstr)
## [For compile and link]
    Fortran90, 132 Columns fixed format. Fortran compiler for any operating system. No external link library required.
## [Algorithmic formula] ETideLoad4.5 User Reference https://www.zcyphygeodesy.com/en/
    8.5.1(1) Tidal effect prediction calculation on the Earth's mass centric variations
The zip compression package includes the test project in visual studio 2017 - intel fortran integrated environment, DOS executable test file, geophysical models and all input and output data.
![](https://24192633.s21i.faiusr.com/2/ABUIABACGAAguLbQuQYooqanxQUwlg44ugk.jpg)
![](https://24192633.s21i.faiusr.com/2/ABUIABACGAAgt7bQuQYo6JvSswYwlg44ugk.jpg)
