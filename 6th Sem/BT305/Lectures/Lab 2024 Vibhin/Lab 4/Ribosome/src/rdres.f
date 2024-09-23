      subroutine rdres()
c
*            subroutine to read in residue information from a file *
c
      implicit character(a-z)

      include 'ribsiz.i'
      include 'files.i'
      include 'resdue.i'


      character yesno*1,buffer*128,cval*20
      integer   ierr,i,j,i1,i2,i3,i4,i5,nmargs,argptr(2,25),ilen,
     &          numlin,l
      logical   isreal,chkrea

      external  isreal

c
* open the residue description file *
c
    5 open(unit=resunt,file=resfil,status='old',iostat=ierr)
      if( ierr .ne. 0) then
c
* unable to open file - print to screen and ask for alternative file name *
c
         print 2000,resfil
         print 2001
         read(5,'(a)')yesno
         if( yesno .eq. 'Y' .or. yesno .eq. 'y') then
            print 2002
            read(5,'(a)')resfil
            go to 5
         else
            call exit()
         endif
      endif
c
* initialize total number of residue types to null *
c
      numtyp = 0
c
* initialize total number of lines in residue description file to null *
c
      numlin = 0
c
* initialize total number of atoms in each residue and names of residues *
* and atoms to null *
c
      do 6 i = 1,maxtyp
         numsub(i) = 0
         monnam(i) = '    '
         do 6 j = 1,maxsub
            subnam(j,i) = '    '
    6 continue
c
* begin reading the file *
c
   10 read(resunt,'(a)',end=25) buffer
c
* increment total number of lines in file *
c
      numlin = numlin + 1
c
* convert line to UPPERCASE *
c
      call touppr(buffer)
      call parse(buffer,nmargs,argptr)
c
* check if this is a blank line *
c
      if( nmargs .eq. 0 ) go to 10
c
* check if this is a comment line *
c
      i1 = argptr(1,1)
      i2 = argptr(2,1)
      if( buffer(i1:i1) .eq. '#') go to 10
c
* process name and number of atoms in residue *
c
      if( buffer(i1:i2) .eq. 'NAME') then
c
* -- ensure line has the necessary number of fields *
c
         if( nmargs .lt. 4) then
            print 2003,numlin,buffer
            stop
         endif
c
* -- increment total number of residue types *
c
         numtyp = numtyp + 1
c
* -- make sure we have not exceeded the maximum allowed residue types *
c
         if( numtyp .gt. maxtyp) then
            print 2004,maxtyp
            stop
         endif
c
* -- store name of residue *
c
         i3 = argptr(1,2)
         i4 = argptr(2,2)
         monnam(numtyp)(1:i4-i3+1) = buffer(i3:i4)
c
* -- store number of atoms in residue *
c
         i3 = argptr(1,4)
         i4 = argptr(2,4)
         read(buffer(i3:i4),'(i4)')numsub(numtyp)
c
* -- if number of atoms in residue exceeds maximum allowed exit *
c
         if( numsub(numtyp) .gt. maxsub) then
            print 2005,monnam(numtyp),numsub(numtyp),maxsub
            stop
         endif
c
* read in atom description for residue *
c
         do 12 i = 1,numsub(numtyp)
            numlin = numlin + 1
            read(resunt,'(a)')buffer
            call touppr(buffer)
            call parse(buffer,nmargs,argptr)
            if( nmargs .lt. 9) then
                print 2006,numlin,buffer
                stop
            endif
            i3 = argptr(1,1)
            i4 = argptr(2,1)
            ilen = ichar(buffer(i3:i3))
            if( ilen .lt. 65 .or. ilen .gt. 90) then
               l = 0
            else
               l = 1
            endif
            
            do 11 j = i3,i4
               l = l + 1
               subnam(i,numtyp)(l:l) = buffer(j:j)
   11       continue

            i3 = argptr(1,2)
            i4 = argptr(2,2)
            call blank(cval)
            cval(1:i4-i3+1) = buffer(i3:i4)
            chkrea = isreal(cval)
            if( .not. chkrea) then
               print 2007,cval
               stop
            endif
            read(buffer(i3:i4),'(f8.3)')zmat(1,i,numtyp)

            i3 = argptr(1,3)
            i4 = argptr(2,3)
            call blank(cval)
            cval(1:i4-i3+1) = buffer(i3:i4)
            chkrea = isreal(cval)
            if( .not. chkrea) then
               print 2007,cval
               stop
            endif
            read(buffer(i3:i4),'(f8.3)')zmat(2,i,numtyp)

            i3 = argptr(1,4)
            i4 = argptr(2,4)
            call blank(cval)
            cval(1:i4-i3+1) = buffer(i3:i4)
            chkrea = isreal(cval)
            if( .not. chkrea) then
               print 2007,cval
               stop
            endif
            read(buffer(i3:i4),'(f8.3)')zmat(3,i,numtyp)

            i3 = argptr(1,5)
            i4 = argptr(2,5)
            read(buffer(i3:i4),'(i3)')n1(i,numtyp)

            i3 = argptr(1,6)
            i4 = argptr(2,6)
            read(buffer(i3:i4),'(i3)')n2(i,numtyp)

            i3 = argptr(1,7)
            i4 = argptr(2,7)
            read(buffer(i3:i4),'(i3)')n3(i,numtyp)

            i5 = argptr(1,8)
            if( buffer(i5:i5) .eq. '+') then
               pcode(i,numtyp) = 1
            endif

            i3 = argptr(1,9)
            i4 = argptr(2,9)
            read(buffer(i3:i4),'(a4)')angptr(i,numtyp)

   12    continue
      endif
      go to 10
   25 continue
      return

 2000 format((a),':','ERROR!!! Unable to open file.')
 2001 format('Would you like to specify another file? (Y/N)')
 2002 format('Enter File Name:')
 2003 format('ERROR!!! Not enough arguments in line',i6,/,'(a)')
 2004 format('ERROR!!! Number of residues in residue file ',
     &'exceeds the maximum of',i5,' allowed.')
 2005 format('ERROR!!! Residue ',a4,1x,'with ',i4,' atoms ',
     &'exceeds the maximum of',i5,' allowed.')
 2006 format('ERROR!!! Not enough arguments in line',i6,/,'(a)')
 2007 format('ERROR!!! ',(a),' is not type REAL.')

      end
