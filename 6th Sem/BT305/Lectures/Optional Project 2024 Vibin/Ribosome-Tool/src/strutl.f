c===================================================================c
      subroutine parse(string,nmargs,argptr)
c
*            Subroutine to parse a given string or line to find *
*            the number of arguments and set up pointers to the *
*            first and last position of the arguments.          *
c
      implicit character(a-z)

      character string*(*),apos*1
      integer   nmargs,argptr(2,25),i,j,icntr,ilen

      nmargs = 0
      ilen = len(string)
      icntr = 1
    5 continue
      do 15 i = icntr,ilen
         apos = string(i:i)
         if( apos .eq. ' ' .or. apos .eq. '\t') then
            icntr = icntr + 1
         else
            nmargs = nmargs + 1
            argptr(1,nmargs) = i
            do 10 j = i+1,ilen
               apos = string(j:j)
               if( apos .eq. ' ' .or. apos .eq. '\t') then
                  argptr(2,nmargs) = j-1
                  icntr = j
                  go to 20
               elseif(j.eq.ilen) then
                  argptr(2,nmargs) = j
                  icntr = j
                  go to 20
               endif
   10    continue
         endif
   15 continue
   20 continue
      if( icntr .lt. ilen) go to 5
      return
      end

c===================================================================c   
      subroutine touppr(line)
c
*      Subroutine to convert a string to all UPPERCASE *
c
      implicit character(a-z)
      character line*(*),aa*1
      integer   ii,i

      do 5 i = 1,len(line)
         aa = line(i:i)
         ii = ichar(aa)
         if( ii.ge.97 .and. ii.le.122) line(i:i)=char(ii-32)
    5 continue
      return
      end
c===================================================================c   
      subroutine blank(line)
c
*         Subroutine to intialize a string to whitespace *
c
      implicit character(a-z)
      character line*(*)
      integer   i

      do 5 i = 1,len(line)
         line(i:i) = ' '
    5 continue

      return
      end
      

      


      

         
      
          
