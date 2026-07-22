This is a repo to document my RISC-V learning proccess, with my final goal being a RISC-V core SoC.


## Controller unit mapping for verilog

# Main decoder
| group[i] | name[i] |  op[i]  | ALUSrc[o] | memWE[o] | regWE[o] | immSrc[o] | ResultSrc[o] |
| :------: | :-----: | :-----: | :-------: | :------: | :------: | :-------: | :----------: |
|     R    |  normal | 0110011 |     0     |     0    |     1    |  R (000)  |      00      |
|     I    |  normal | 0010011 |     1     |     0    |     1    |  I (001)  |      00      |
|     I    |   load  | 0000011 |     1     |     0    |     1    |  I (001)  |      01      |
|     I    |   jalr  | 1100111 |     1     |     0    |     1    |  I (001)  |      10      |
|     S    |  store  | 0100011 |     1     |     1    |     0    |  S (010)  |      00      |
|     B    |  branch | 1100011 |     0     |     0    |     0    |  B (011)  |      00      |
|     U    |   lui   | 0110111 |     1     |     0    |     1    |  U (100)  |      00      |
|     U    |  auipc  | 0010111 |     1     |     0    |     1    |  U (100)  |      00      |
|     J    |   jump  | 1101111 |     1     |     0    |     1    |  J (101)  |      10      |

# ALU decoder
# branch logic
