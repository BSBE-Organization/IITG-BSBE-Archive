      character*128 inname,outnam,resfil
      integer       resunt,inpunt,outunt

      common /file1/ inname,outnam,resfil
      common /file2/ resunt,inpunt,outunt

      save /file1/
      save /file2/
