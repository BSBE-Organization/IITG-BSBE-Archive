from random import *
import os
import shutil

amino_acids = ['ala', 'cys', 'asp', 'glu', 'phe', 'gly', 'his', 'ile', 'lys',  'leu',  'met',  'asn',  'pro',  'gln',  'arg',  'ser',  'thr',  'val',  'trp',  'tyr']

def angle(lower_bound, upper_bound):
    range_size = upper_bound - lower_bound
    random_value = random()
    return random_value * range_size + lower_bound
   
def generate_rib_file(index, num_residues):
    with open(f"ribfiles/protein{index}.rib", "w") as output_file:
        output_file.write("# sample command file. this builds the peptide as a helix\n\n")
        output_file.write("# except for the glycine which has a phi of 90.0 and psi of 0.0\n\n")
        output_file.write("TITLE RIBOSOME EXAMPLE\n\ndefault helix\n\n")

        for i in range(num_residues):
            amino_acid = amino_acids[randint(0,19)]
            strand = randint(0, 1)
            if strand:
                phi=angle(-65, -55)
                psi=angle(-55, -45)
            else:
                phi=angle(-145, -135)
                psi=angle(125, 135)

            output_file.write(f"res {amino_acid} phi {phi:.2f} psi {psi:.2f}\n\n")

if os.path.exists("ribfiles"):
    try:
        shutil.rmtree("ribfiles")
    except OSError as error:
        print(f"Error deleting folder: {error}")

if os.path.exists("PDB_files"):
    try:
        shutil.rmtree("PDB_files")
    except OSError as error:
        print(f"Error deleting folder: {error}")

os.makedirs("ribfiles", exist_ok=True)
os.makedirs("PDB_files", exist_ok=True)

t = int(input("Number of protein structures to produce: "))
n = int(input("Length of the protein: "))
for i in range(1,t+1):
    generate_rib_file(i, n)