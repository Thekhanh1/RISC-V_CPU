This is a repo to document my RISC-V learning proccess, with my final goal being a RISC-V core SoC.


## Controller unit mapping for verilog
# Instruction Groups and Opcodes

| Group | Name   | Op        | Zero | PCSrc  | ALUSrc  | memWE | regWE |
|-------|--------|-----------|------|--------|---------|-------|-------|
| R     | normal | '0110011' | 0    | 0      | 0       | 1     | 1     |
| I     | normal | '0010011' | 0    | 1      | 1       |       |       |
| I     | load   | '0000011' | 0    | 0      | 1       |       | 1     |
| I     | jalr   | '1100111' | 0    | 1      | 1       |       |       |
| S     | store  | '0100011' | 0    | 1      | 1       | 1     | 1     |
| B     | branch | '1100011' | 0    | 1      |         |       |       |
| J     | jump   | '1101111' | 0    | 1      |         |       |       |
| U     | lui    | '0010111' | 0    | 1      |         |       |       |
| U     | auipc  | '0110111' | 0    | 1      |         |       |       |
