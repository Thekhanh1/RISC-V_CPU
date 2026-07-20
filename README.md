This is a repo to document my RISC-V learning proccess, with my final goal being a RISC-V core SoC.


## Controller unit mapping for verilog
# Instruction Groups and Opcodes

| Group | Name   | Opcode (`op`) | Zero | ResultSrc | regSrc | PCSrc | ALUSrc | memWE | regWE |
|:-----:|--------|:-------------:|:----:|:---------:|:------:|:-----:|:------:|:-----:|:-----:|
| R | normal | `0110011` | | | | | | | |
| R | normal | `0010011` | | | | | | | |
| I | load   | `0000011` | | | | | | | |
| I | jalr   | `1100111` | | | | | | | |
| I | env    | `1110011` | | | | | | | |
| S | store  | `0100011` | | | | | | | |
| B | branch | `1100011` | | | | | | | |
| J | jump   | `1101111` | | | | | | | |
| U | lui    | `0010111` | | | | | | | |
| U | auipc  | `0110111` | | | | | | | |
