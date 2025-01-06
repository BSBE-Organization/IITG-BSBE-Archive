      subroutine initvr()
c
*            subroutine to initialize all variables *
c
      implicit character(a-z)
      include 'ribsiz.i'
      include 'files.i'
      include 'resdue.i'
      include 'seqdat.i'
      integer   i,j

      numres = 0
      numatm = 0
      numtyp = 0
      lapolr = .false.

      do 5 i = 1,maxres
         resnam(i) = '    '
         phival(i) = -999.
         psival(i) = -999.
         omeval(i) = -999.
         do 5 j = 1,6
            chival(j,i) = -999.
    5 continue

      do 10 j = 1,maxatm
            atmnam(j) = '     '
   10 continue

      do 15 i = 1,maxtyp
         monnam(i) = '    '
         numsub(i) = 0
         do 15 j = 1,maxsub
            subnam(j,i) = '     '
   15 continue

      resfil = 'res.dat'
      resunt = 23
      inname = ' '
      inpunt = 24
      outnam = ' '
      outunt = 25

      return
      end
