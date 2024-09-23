      subroutine rdcom()
c
*        subroutine to read in a command file *
c
      implicit character(a-z)

      include 'ribsiz.i'
      include 'files.i'
      include 'resdue.i'
      include 'seqdat.i'

      character comlin*200,cval*20
      integer   i1,i2,i3,i4,i5,i6,i,nmargs,argptr(2,25),ichi, ierr
      real      r1
      logical   chkrea,isreal

      external  isreal

c
* open the command file for reading *
c
      open(unit=inpunt,file=inname,status='old', iostat=ierr)
      if (ierr .ne. 0) then
          print *,'Unable to open input file'
          stop
      end if
c
* read a line from the command file *
c
    5 read(inpunt,'(a)',end=25)comlin
c
* convert the line to all UPPERCASE *
c
      call touppr(comlin)
c
* generate pointers to the beginning and end of each word in the line *
c
      call parse(comlin,nmargs,argptr)
c
* check for blank line *
c
      if( nmargs .eq. 0) go to 5
      i1 = argptr(1,1)
      i2 = argptr(2,1)
c
* check for comment line *
c
      if( comlin(i1:i2) .eq. '#') go to 5
c
* check if line gives the title for the molecule *
c
      if( comlin(i1:i2) .eq. 'TITLE') then
         i3 = argptr(1,2)
         molnam = comlin(i3:i3+69)
c
* check for all-atom keyword *
c
      elseif( comlin(i1:i2) .eq. 'ALLH') then
         lapolr = .true.
c
* line is a residue description *
c
      elseif( comlin(i1:i1+2) .eq. 'RES') then
c
* increment total number of resiudes *
c
         numres = numres + 1
         i3 = argptr(1,2)
c
* store name of residue *
c
         resnam(numres) = comlin(i3:i3+3)
c
* process any optional arguments *
c
         do 10 i = 3,nmargs,2
            i4 = argptr(1,i)
c
* -- process phi value, if specified *
c
            if( comlin(i4:i4+2) .eq. 'PHI') then
               i5 = argptr(1,i+1)
               i6 = argptr(2,i+1)
               call blank(cval)
               cval(1:i6-i5+1) = comlin(i5:i6)
               chkrea = isreal(cval)
               if( .not. chkrea) then
                  print 2001,cval
                  stop
               endif
               read(comlin(i5:i6),'(f8.3)')r1
               if( r1 .gt. 180.0) then
                  r1 = r1 - 360.0
               elseif( r1 .lt. -180.0) then
                  r1 = r1 + 360.0
               endif
               phival(numres) = r1
c
* -- process psi value, if specified *
c
            elseif( comlin(i4:i4+2) .eq. 'PSI') then
               i5 = argptr(1,i+1)
               i6 = argptr(2,i+1)
               call blank(cval)
               cval(1:i6-i5+1) = comlin(i5:i6)
               chkrea = isreal(cval)
               if( .not. chkrea) then
                  print 2001,cval
                  stop
               endif
               read(comlin(i5:i6),'(f8.3)')r1
               r1 = r1 + 180.0
               if( r1 .gt. 180.0) then
                  r1 = r1 - 360.0
               elseif( r1 .lt. -180.0) then
                  r1 = r1 + 360.0
               endif
               psival(numres) = r1
c
* -- process omega value, if specified *
c
            elseif( comlin(i4:i4+2) .eq. 'OME') then
               i5 = argptr(1,i+1)
               i6 = argptr(2,i+1)
               call blank(cval)
               cval(1:i6-i5+1) = comlin(i5:i6)
               chkrea = isreal(cval)
               if( .not. chkrea) then
                  print 2001,cval
                  stop
               endif
               read(comlin(i5:i6),'(f8.3)')r1
              if( r1 .gt. 180.0) then
                  r1 = r1 - 360.0
               elseif( r1 .lt. -180.0) then
                  r1 = r1 + 360.0
               endif
               omeval(numres) = r1
c
* -- process chi values, if specified *
c
            elseif( comlin(i4:i4+2) .eq. 'CHI') then
c
* -- check which chi value is being processed *
* --- CHI0 determines stereochemistry at CA   *
* --- CHI1 - CHI5 point to the various possible sidechain torsions *
c
               read(comlin(i4+3:i4+3),'(i1)')ichi
               ichi = ichi + 1
               i5 = argptr(1,i+1)
               i6 = argptr(2,i+1)
               call blank(cval)
               cval(1:i6-i5+1) = comlin(i5:i6)
               chkrea = isreal(cval)
               if( .not. chkrea) then
                  print 2001,cval
                  stop
               endif
               read(comlin(i5:i6),'(f8.3)')r1
               if( r1 .gt. 180.0) then
                  r1 = r1 - 360.0
               elseif( r1 .lt. -180.0) then
                  r1 = r1 + 360.0
               endif
               chival(ichi,numres) = r1
            endif
   10    continue
c
* check if line specifies default values to use for any of the angles *
c
      elseif( comlin(i1:i1+2) .eq. 'DEF') then
         i3 = argptr(1,2)
         i4 = argptr(2,2)
         if( comlin(i3:i4) .eq. 'HELIX') then
            do 11 i = 1,maxres
               phival(i) = -64.0
               psival(i) = 137.0
   11       continue
         elseif( comlin(i3:i4) .eq. 'SHEET') then
            do 12 i = 1,maxres
               phival(i) = -120.0
               psival(i) =  -60.0
   12       continue
         elseif( comlin(i3:i4) .eq. 'EXTENDED') then
            do 13 i = 1,maxres
               phival(i) = 180.0
               psival(i) =   0.0
   13       continue
         elseif( comlin(i3:i4) .eq. 'PHI') then
            i5 = argptr(1,3)
            i6 = argptr(2,3)
            call blank(cval)
            cval(1:i6-i5+1) = comlin(i5:i6)
            chkrea = isreal(cval)
            if( .not. chkrea) then
               print 2001,cval
               stop
            endif
            read(cval,'(f8.3)')r1
            if( r1 .gt. 180.) r1 = r1 - 360.
            if( r1 .lt. -180.)r1 = r1 + 360.
            do 14 i = 1,maxres 
               phival(i) = r1
   14       continue
         elseif( comlin(i3:i4) .eq. 'PSI') then
            i5 = argptr(1,3)
            i6 = argptr(2,3)
            call blank(cval)
            cval(1:i6-i5+1) = comlin(i5:i6)
            chkrea = isreal(cval)
            if( .not. chkrea) then
               print 2001,cval
               stop
            endif
            read(cval,'(f8.3)')r1
            if( r1 .gt. 180.) r1 = r1 - 360.
            if( r1 .lt. -180.)r1 = r1 + 360.
            r1 = r1 + 180.
            if( r1 .gt. 180.) r1 = r1 - 360.
            do 15 i = 1,maxres 
               psival(i) = r1
   15       continue
         elseif( comlin(i3:i4) .eq. 'OMEGA') then
            i5 = argptr(1,3)
            i6 = argptr(2,3)
            call blank(cval)
            cval(1:i6-i5+1) = comlin(i5:i6)
            chkrea = isreal(cval)
            if( .not. chkrea) then
               print 2001,cval
               stop
            endif
            read(cval,'(f8.3)')r1
            if( r1 .gt. 180.) r1 = r1 - 360.
            if( r1 .lt. -180.)r1 = r1 + 360.
            do 16 i = 1,maxres 
               omeval(i) = r1
   16       continue
         elseif(  comlin(i3:i3+2) .eq. 'CHI') then
            i5 = argptr(1,3)
            i6 = argptr(2,3)
            call blank(cval)
            cval(1:i6-i5+1) = comlin(i5:i6)
            chkrea = isreal(cval)
            if( .not. chkrea) then
               print 2001,cval
               stop
            endif
            read(cval,'(f8.3)')r1
            ichi = ichi + 1
            read(comlin(i4+1:),'(f8.3)')r1
            if( r1 .gt. 180.) r1 = r1 - 360.
            if( r1 .lt. -180.)r1 = r1 + 360.
            do 17 i = 1,maxres 
               chival(ichi,i) = r1
   17       continue
         endif
c
* if here, we have an error in command line - report and stop *
c
      else
         print 2000,comlin
         call exit()
      endif
      go to 5
   25 continue
      return
c
* format statements *
c
 2000 format('ERROR!!! Invalid Command Line: ',/,(a))
 2001 format('ERROR!!! ',(a),' is not type REAL.')
      end
