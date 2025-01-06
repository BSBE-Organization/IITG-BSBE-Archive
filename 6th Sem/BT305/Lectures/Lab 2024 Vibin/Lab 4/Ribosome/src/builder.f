      subroutine buildr()
c
*          main subroutine to build the peptide *
c
      implicit character(a-z)
      include 'ribsiz.i'
      include 'resdue.i'
      include 'seqdat.i'

      character rnam*4
      integer   i,j,k,l,m

      numatm = 0
      do 5 i = 1,maxatm
         na(i) = 0
         nb(i) = 0
         nc(i) = 0
         atmnam(i) = '    '
         poltyp(i) = 0
         angnam(i) = '    '
    5 continue

      do 25 i = 1,numres
         rnam = resnam(i)
         do 6 j = 1,numtyp
            if( rnam .eq. monnam(j))go to 10
    6    continue
         print 2000,rnam
         stop
   10    continue
         resptr(i) = numatm + 1
         numatm = numatm + numsub(j)
         l = 0
         do 20 k = resptr(i),numatm
            l = l + 1
            atmnam(k) = subnam(l,j)
            resnum(k) = i
            do 15 m = 1,3
               geo(m,k) = zmat(m,l,j)
   15       continue
            na(k) = n1(l,j)
            nb(k) = n2(l,j)
            nc(k) = n3(l,j)
            angnam(k) = angptr(l,j)
            poltyp(k) = pcode(l,j)
            if( na(k) .lt. 0 ) then
               if( i .gt. 1) then
                  na(k) = resptr(i-1) - na(k) -1
               else
                  na(k) = 0
               endif
            else
               na(k) = na(k) + resptr(i) - 1
            endif
            if( nb(k) .lt. 0 ) then
               if( i .gt. 1) then
                  nb(k) = resptr(i-1) - nb(k) -1
               else
                  nb(k) = 0
               endif
            else
               nb(k) = nb(k) + resptr(i) - 1
            endif
            if( nc(k) .lt. 0 ) then
               if( i .gt. 1) then
                  nc(k) = resptr(i-1) - nc(k) -1
               elseif( k .le. 3) then
                  nc(k) = 0
               else
                  nc(k) = k -1
               endif
            else
               nc(k) = nc(k) + resptr(i) - 1
            endif
   20    continue
   25 continue
      resptr(numres+1) = numatm

c
* format statement *
c
 2000 format('Unknown Residue: ',a4)
      return
      end
