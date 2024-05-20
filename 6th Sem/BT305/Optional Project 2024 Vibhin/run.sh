python3 protein.py
cd ribfiles

for rib_file in protein*.rib; do
    ../ribosome "$rib_file" "../PDB_files/${rib_file%.rib}.pdb" ../res.zmat
done