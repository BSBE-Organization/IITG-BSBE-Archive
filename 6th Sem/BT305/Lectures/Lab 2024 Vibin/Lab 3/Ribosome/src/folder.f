      subroutine folder()
c
*            subroutine to set the phi,psi etc. values to user specifed *
*            values.                                                    *
c
      implicit character(a-z)
      include 'ribsiz.i'
      include 'seqdat.i'

      character aa*1,aptr*4
      integer   ires,ival,i,j,k,l,m,i1,i2,i3
      real      r1

      do 55 ires = 1,numres
         r1 = phival(ires)
         ival = int(r1)
         if( ival .lt. -180) go to 10
         i = resptr(ires)
         j = resptr(ires+1) - 1
         do 5 k = i,j
            if( angnam(k) .eq. 'PHI ') then
                geo(3,k) = r1
                go to 10
            endif
    5    continue
   10 continue
         r1 = psival(ires)
         ival = int(r1)
         if( ival .lt. -180) go to 20
         i = resptr(ires)
         j = resptr(ires+1) - 1
         do 15 k = i,j
            if( angnam(k) .eq. 'PSI ') then
                geo(3,k) = r1
                go to 20
            endif
   15    continue
   20 continue
         r1 = omeval(ires)
         ival = int(r1)
         if( ival .lt. -180) go to 30
         i = resptr(ires)
         j = resptr(ires+1) - 1
         do 25 k = i,j
            if( angnam(k) .eq. 'OMEG') then
                geo(3,k) = r1
                go to 30
            endif
   25    continue
   30 continue
         do 50 l = 1,6
            r1 = chival(l,ires)
            ival = int(r1)
            if( ival .lt. -180 ) go to 50
            m = l - 1
            write(aa,'(i1)')m
            aptr = 'CHI'//aa
            i = resptr(ires)
            j = resptr(ires+1) - 1
            do 40 k = i,j
               if( angnam(k) .eq. aptr) then
                   geo(3,k) = r1
* fix for chiral inversion at c-alpha *
                   if( aptr .eq. 'CHI0') then
                      i1 = na(k)
                      i2 = nb(k)
                      do 35 i3 = k+1,j
                        if( na(i3).eq.i1 .and. nb(i3).eq.i2)then
                          geo(3,i3)=r1
                          go to 45
                        endif
   35                 continue
                   endif
                   go to 45
               endif
   40       continue
            print*,'Warning!! ',aptr,' not a valid option '
            print*,'for ',resnam(ires),'. No action taken.'
   45    continue
   50    continue
   55 continue
      return
      end
