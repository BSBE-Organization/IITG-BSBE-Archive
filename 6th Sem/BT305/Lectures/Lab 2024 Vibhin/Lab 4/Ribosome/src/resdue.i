      character monnam(maxtyp)*4,subnam(maxsub,maxtyp)*5,
     &          angptr(maxsub,maxtyp)*4
      integer   numtyp,numsub(maxtyp),pcode(maxsub,maxtyp),
     &          n1(maxsub,maxtyp),n2(maxsub,maxtyp),
     &          n3(maxsub,maxtyp)
      real      zmat(3,maxsub,maxtyp)

      common /res1/monnam,subnam,angptr
      common /res2/numtyp,numsub,pcode,n1,n2,n3
      common /res3/zmat

      save   /res1/
      save   /res2/
      save   /res3/
