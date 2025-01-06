This python code generate specified amount of protein with specified number of randomly generated residues.
Prerequisite: Linux, Python compiler, fortrun
1) Please make sure that all the files are in the same folders including Ribosome tool.
2) Run the command: "./run.sh" in the main directory in the terminal of the Linux system.
3) First, it will ask you how many number of randomly generated protein you want and then it will ask how many residues you want in all the proteins.
You will find 2 folders:-
ribfiles: which contains all the .rib files for the random structure protein.
PDB_files: which contains the .pdb files of the randomly generated .rib files

If there is an error running the code like "unable to open the input file", then:
1) Open the python program in a compiler like VS Code or Anaconda.
2) Run the code where it will ask  how many number of randomly generated protein you want and then it will ask how many residues you want in all the proteins.
You will find ribfile folder with your desired protein .rib files but this case will not work to generate .pdb files of the .rib files.