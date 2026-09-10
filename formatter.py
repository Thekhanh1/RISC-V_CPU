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

    subprocess.run(["riscv64-unknown-elf-objcopy", "-O", "verilog", ifile, ofile], check = True)

# moving the unmodified hex into a folder

for f in os.listdir(path):
    if (f.endswith(".hex")):
        shutil.move(os.path.join(path, f), path_hex)


# reformating the hex file for my implementation 

for f in os.listdir(path_hex):
    mfile = open(os.path.join(path_hex, f), 'r')
    ofile = open(os.path.join(path_hex, "c_" + f[:-4] + "-configured.hex"), 'w')

    mbuff = mfile.read().splitlines()
    for line in mbuff:
        if not line or line[0] == '@': continue
        buf = ""

        for char in line:
            if char == ' ':
                continue

            buf += char

            if len(buf) == 8:
                bytes_ = [buf[i:i+2] for i in range(0, 8, 2)]
                ofile.write(''.join(bytes_[::-1]) + '\n')
                buf = ''
    mfile.close()
    ofile.close()

# moving the reformatted file into a folder

for f in os.listdir(path_hex):
    if (f.startswith("c_") and f.endswith("-configured.hex")):
        shutil.move(os.path.join(path_hex, f), path_hex_configured)
