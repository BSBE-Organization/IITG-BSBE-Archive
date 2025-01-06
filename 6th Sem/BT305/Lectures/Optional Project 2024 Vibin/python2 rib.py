import random

HEADER = """
# sample command file. this builds the peptide as a helix 

#except for the glycine which has a phi of 90.0 and psi of 0.0 

TITLE RIBOSOME EXAMPLE 2

default helix
"""

def generate_random_data():
   
    protein_names = ['ala', 'arg', 'asn', 'asp', 'cys', 'gln', 'glu', 'gly', 'his', 'ile',
                     'leu', 'lys', 'met', 'phe', 'pro', 'ser', 'thr', 'trp', 'tyr', 'val']
    
    # Generate random protein name
    protein_name = random.choice(protein_names)
    
    
    if protein_name == 'gly':
        phi = 90.0
        psi = 0.0
    else:
        phi = round(random.uniform(-80, -50), 2)
        psi = round(random.uniform(-60, -25), 2)
    
    
    return f"res {protein_name} phi {phi} psi {psi}\n"

def main():
    
    num_times = int(input("Enter the number of times to generate random data: "))
    
    if num_times > 300:
        print("Input exceeds 300. Please provide a number equal to or less than 300.")
        return
    
   
    with open("output.rib", "w") as file:
        
        file.write(HEADER)
        
       
        for _ in range(num_times):
            file.write(generate_random_data() + "\n")

    print("Random data written to output.rib")

if __name__ == "__main__":
    main()
