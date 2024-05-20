      subroutine zmtxyz()
c
*            subroutine to convert a zmatrix to x,y,z,coordinates*
c
      implicit character(a-z)
      
      include 'ribsiz.i'
      include 'resdue.i'
      include 'seqdat.i'

      integer   i,mma,mb,mc,k
      real      degree,ccos,cosa,xb,yb,zb,rbc,xyb,xa,ya,za,xpa,xpb,
     &          costh,sinth,ypa,sinph,cosph,zqa,yza,coskh,sinkh,sina,
     &          sind,cosd,xd,yd,zd,xpd,ypd,zpd,xqd,yqd,zqd,xrd,xqa


      degree = 57.29578

c
* place first atom at origin *
c
      xcrd(1)=0.000
      ycrd(1)=0.000
      zcrd(1)=0.000
c
* place second atom on X axis *
c
      xcrd(2)=geo(1,2)
      ycrd(2)=0.000
      zcrd(2)=0.000
c
* place third atom in X-Y plane *
c
      ccos=cos(geo(2,3)/degree)
      if(na(3).eq.1)then
         xcrd(3)=xcrd(1)+geo(1,3)*ccos
      else
         xcrd(3)=xcrd(2)-geo(1,3)*ccos
      endif
      ycrd(3)=geo(1,3)*sin(geo(2,3)/degree)
      zcrd(3)=0.000
c
* process atoms with indices greater than 3 *
c
      do 20 i=4,numatm
         cosa=cos(geo(2,i)/degree)
         mb=nb(i)
         mc=na(i)
         xb=xcrd(mb)-xcrd(mc)
         yb=ycrd(mb)-ycrd(mc)
         zb=zcrd(mb)-zcrd(mc)
         rbc=xb*xb+yb*yb+zb*zb
         rbc=1.000/sqrt(rbc)
         mma=nc(i)
         xa=xcrd(mma)-xcrd(mc)
         ya=ycrd(mma)-ycrd(mc)
         za=zcrd(mma)-zcrd(mc)
c
*     rotate about the z-axis to mmake yb=0, and xb positive.  if xyb is *
*     too smmall, first rotate the y-axis by 90 degrees. *
c
         xyb=sqrt(xb*xb+yb*yb)
         k=-1
         if (xyb.gt.0.100) go to 5
         xpa=za
         za=-xa
         xa=xpa
         xpb=zb
         zb=-xb
         xb=xpb
         xyb=sqrt(xb*xb+yb*yb)
         k=+1
c
*     rotate about the y-axis to mmake zb vanish *
c
    5    costh=xb/xyb
         sinth=yb/xyb
         xpa=xa*costh+ya*sinth
         ypa=ya*costh-xa*sinth
         sinph=zb*rbc
         cosph=sqrt(abs(1.00-sinph*sinph))
         xqa=xpa*cosph+za*sinph
         zqa=za*cosph-xpa*sinph
c
c     rotate about the x-axis to mmake za=0, and ya positive.
c
         yza=sqrt(ypa**2+zqa**2)
         if(yza.lt.0.0001)  go to 10
         coskh=ypa/yza
         sinkh=zqa/yza
         go to 15
   10 continue
c
c   angle too smmall to be important
c
         coskh=1.0
         sinkh=0.0
   15 continue
c
c     xyz coordinates :-   a=(xqa,yza,0),   b=(rbc,0,0),  c=(0,0,0)
c     none are negative.
c     the xyzinates of i are evaluated in the new frame.
c
         sina=sin(geo(2,i)/degree)
         sind=-sin(geo(3,i)/degree)
         cosd=cos(geo(3,i)/degree)
         xd=geo(1,i)*cosa
         yd=geo(1,i)*sina*cosd
         zd=geo(1,i)*sina*sind
c
c     transform the xyzinates back to the original system.
c
         ypd=yd*coskh-zd*sinkh
         zpd=zd*coskh+yd*sinkh
         xpd=xd*cosph-zpd*sinph
         zqd=zpd*cosph+xd*sinph
         xqd=xpd*costh-ypd*sinth
         yqd=ypd*costh+xpd*sinth
         if(k.ne.-1) then
            xrd=-zqd
            zqd=xqd
            xqd=xrd
         endif
         xcrd(i)=xqd+xcrd(mc)
         ycrd(i)=yqd+ycrd(mc)
         zcrd(i)=zqd+zcrd(mc)
   20 continue

      return
      end
