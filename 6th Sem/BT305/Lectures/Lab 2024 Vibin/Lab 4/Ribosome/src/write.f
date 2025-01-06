      subroutine pepwri()
c
*      subroutine to write out the structure to file *
c
      implicit character(a-z)
      
      include 'ribsiz.i'
      include 'files.i'
      include 'seqdat.i'

      integer   i,j,k,ierr

c
* open the output file *
c
      open(unit=outunt,file=outnam,status='new',iostat=ierr)
      if (ierr .ne. 0) then
          print *, 'Unable to open output file'
          stop
      end if
c
* write out molecule name *
c
      write(outunt,3000)molnam
      j = 0
c
* write out SEQRES records *
c
      do 5 i = 1,numres,13
         j = j+1
         write(outunt,3001)j,numres,(resnam(k),k=i,i+12)
    5 continue
c
* write out ATOM records *
c
      j = 0
      do 15 i = 1,numatm
c
* if the atom is a dummy atom skip *
c
         if( atmnam(i) .eq. ' DU ') go to 15
c
* if this is not an all-atom model then skip apolar hydrogens *
c
         if( lapolr ) go to 10
         if( poltyp(i) .ne. 1) go to 15
   10 continue
         j = j + 1
         write(outunt,3002)j,atmnam(i),resnam(resnum(i)),
     &resnum(i),xcrd(i),ycrd(i),zcrd(i)
   15 continue
c
* write out 'TER' record *
c
      write(outunt,3003)
c
* format statements *
c
 3000 format('COMPND',4x,(a))
 3001 format('SEQRES',i4,2x,i5,2x,13(a3,1x))
 3002 format('ATOM  ',i5,1x,a5,a4,1x,i4,4x,3f8.3)
 3003 format('TER')
      close(outunt)
      return
      end
