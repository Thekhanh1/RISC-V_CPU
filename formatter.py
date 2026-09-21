import os
import subprocess
import shutil

path = r"D:\RISC-V\rv32ui_dump_hex"
path_hex = r"D:\RISC-V\rv32ui_dump_hex\hex"
path_hex_configured = r"D:\RISC-V\rv32ui_dump_hex\hex_configured"

# converting the ELF files to the verilog hex files

for f in os.listdir(path):
    if f.endswith(".dump"):
        continue
    ifile = os.path.join(path, f)
    ofile = ifile + ".hex"

    if not os.path.isfile(ifile):
        continue
 
    subprocess.run([
        "riscv64-unknown-elf-objcopy",
        "-O", "verilog",
        "--verilog-data-width=4",
        ifile, ofile
    ], check=True)
 
# moving the unmodified hex into a folder

for f in os.listdir(path):
    if (f.endswith(".hex")):
        shutil.move(os.path.join(path, f), path_hex)


# reformating the hex file for my implementation 

for f in os.listdir(path_hex):
    if (f.endswith(".hex")):
        with open(os.path.join(path_hex, f), 'r') as mfile:
            mbuff = mfile.read().splitlines()
    
        words = {}             # word_index -> hex word token, as-is from objcopy
        base_addr = None        # first @address seen (word units) == our index 0
        next_word_addr = None   # running word address of the next expected token
    
        for line in mbuff:
            line = line.strip()
            if not line:
                continue
    
            if line[0] == '@':
                addr = int(line[1:], 16)   # already word-indexed
                if base_addr is None:
                    base_addr = addr
                next_word_addr = addr
                continue
    
            for tok in line.split():
                word_index = next_word_addr - base_addr
                words[word_index] = tok
                next_word_addr += 1
        if not words:
            continue
    
        out_path = os.path.join(path_hex, "c_" + f[:-4] + "-configured.hex")
        with open(out_path, 'w') as ofile:
            prev_index = None
            for idx in sorted(words):
                if prev_index is None or idx != prev_index + 1:
                    ofile.write(f"@{idx:x}\n")   # gap -> tell $readmemh to jump
                ofile.write(words[idx] + "\n")
                prev_index = idx
 
# moving the reformatted file into a folder

for f in os.listdir(path_hex):
    if (f.startswith("c_") and f.endswith("-configured.hex")):
        shutil.move(os.path.join(path_hex, f), path_hex_configured)
