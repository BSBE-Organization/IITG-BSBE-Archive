      program ribosome

      implicit character(a-z)

      include 'ribsiz.i'
      include 'files.i'
      include 'resdue.i'
      include 'seqdat.i'

c
* intitialize variables *
c
      call initvr()

      if (iargc() .eq. 0) then
         print *, 'Usage: ribosome inputfile outputfile parameterfile'
         stop
      end if
c
* get name of input command file *
c
      call getarg(1,inname)
c
* get name of output file - file to which coordinates are written *
c
      call getarg(2,outnam)
c
* get name of residue description file *
c
      call getarg(3,resfil)
c
* read command file *
c
      call rdcom()
c
* read residue description file *
c
      call rdres()
c
* build the peptide in default conformation *
c
      call buildr()
c
* modify the conformation to user specified values for phi, psi, chi, omega *
c
      call folder()
c
* generate xyz coordinates from Z-matrix style description *
c
      call zmtxyz()
c
* write out the conformation *
c
      call pepwri()
c
* all done *
c
      end
