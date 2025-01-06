      logical function isreal(aa)
c
*         Function to check if a value is of type real *
c
      implicit character (a-z)

      character aa*(*)
      integer   ipos

      isreal = .false.

      ipos = index(aa,'.')
      if( ipos .ne. 0 ) then
         isreal = .true.
      endif

      return
      end
