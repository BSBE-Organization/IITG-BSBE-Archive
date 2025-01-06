      character atmnam(maxatm)*5,resnam(maxres)*4,angnam(maxatm)*4,
     &          molnam*70
      integer   numatm,numres,na(maxatm),nb(maxatm),nc(maxatm),
     &          poltyp(maxatm),resnum(maxatm),resptr(maxres)
      real      geo(3,maxatm),xcrd(maxatm),ycrd(maxatm),zcrd(maxatm),
     &          phival(maxres),psival(maxres),chival(6,maxres),
     &          omeval(maxres)
      logical   lapolr

      common /seq1/atmnam,resnam,angnam,molnam
      common /seq2/numatm,numres,na,nb,nc,poltyp,resnum,resptr
      common /seq3/geo,xcrd,ycrd,zcrd,phival,psival,chival,omeval
      common /seq4/lapolr

      save /seq1/
      save /seq2/
      save /seq3/
      save /seq4/
