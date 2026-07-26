This is a repo to document my RISC-V learning proccess, with my final goal being a RISC-V core SoC.


# Controller unit mapping for verilog
### Reference tables
<table>
<tr>
<td valign="top">

| ALUCtrl | operation |
| :-----: | :-------: |
|  0000   |    ADD    |
|  0001   |    SUB    |
|  0010   |    AND    |
|  0011   |    OR     |
|  0100   |    XOR    |
|  0101   |    SLL    |
|  0110   |    SRL    |
|  0111   |    SRA    |
|  1000   |    SLT    |
|  1001   |   SLTU    |

</td>

<td valign="top">

| ALUop |     explanation     |
| :---: |   :-------------:   |
|  00   |      forced ADD     |
|  01   |      forced SUB     |
|  10   | look at funct3/7(R) |
|  11   | look at funct3/7(I) |

<br>

| PCSrc |     explanation     |
| :---: |     :---------:     |
|  00   |       PC + 4        |
|  01   |     jal / branch    |
|  10   |        jalr         |
|  11   |       unused        |

</td>

<td valign="top">

| ResultSrc | explanation |
| :-------: | :---------: |
|    00     |  ALUResult  |
|    01     |  readData   |
|    10     |   PCPlus4   |
|    11     |     LUI     |

</td>
</tr>
</table>

### Main decoder
| group[i] | name[i] |   op[i]   | ALUSrc[o] | memWE[o] | regWE[o] | immSrc[o] | ResultSrc[o] | ALUop[o] | branch[o] |  jump[o] |
| :------: | :-----: | :-------: | :-------: | :------: | :------: | :-------: | :----------: | :------: | :-------: |  :----:  |
|    R     | normal  |  0110011  |     0     |    0     |    1     |     R     |      00      |    10    |     0     |    00    |
|    I     | normal  |  0010011  |     1     |    0     |    1     |     I     |      00      |    10    |     0     |    00    |
|    I     |  load   |  0000011  |     1     |    0     |    1     |     I     |      01      |    00    |     0     |    00    |
|    I     |  jalr   |  1100111  |     1     |    0     |    1     |     I     |      10      |    00    |     0     |    10    |
|    S     |  store  |  0100011  |     1     |    1     |    0     |     S     |      00      |    00    |     0     |    00    |
|    B     | branch  |  1100011  |     0     |    0     |    0     |     B     |      00      |    01    |     1     |    00    |
|    J     |  jump   |  1101111  |     1     |    0     |    1     |     J     |      10      |    00    |     0     |    01    |
|    U     |   lui   |  0110111  |     1     |    0     |    1     |     U     |      00      |    00    |     0     |    00    |
|    U     |  auipc  |  0010111  |     1     |    0     |    1     |     U     |      00      |    00    |     0     |    00    |


### ALU decoder
| Group[i] | Name[i] | funct3[i] | funct7[i] | ALUop[i] | ALUCtrl[o] |
| :------: | :-----: | :-------: | :-------: | :------: | :--------: |
|    R     |   add   |    0x0    |   0x00    |    10    |    0000    |
|    R     |   sub   |    0x0    |   0x20    |    10    |    0001    |
|    R     |   xor   |    0x4    |   0x00    |    10    |    0100    |
|    R     |   or    |    0x6    |   0x00    |    10    |    0011    |
|    R     |   and   |    0x7    |   0x00    |    10    |    0010    |
|    R     |   sll   |    0x1    |   0x00    |    10    |    0101    |
|    R     |   srl   |    0x5    |   0x00    |    10    |    0110    |
|    R     |   sra   |    0x5    |   0x20    |    10    |    0111    |
|    R     |   slt   |    0x2    |   0x00    |    10    |    1000    |
|    R     |  sltu   |    0x3    |   0x00    |    10    |    1001    |
|    I     |  addi   |    0x0    |     -     |    10    |    0000    |
|    I     |  xori   |    0x4    |     -     |    10    |    0100    |
|    I     |   ori   |    0x6    |     -     |    10    |    0011    |
|    I     |  andi   |    0x7    |     -     |    10    |    0010    |
|    I     |  slli   |    0x1    |   0x00    |    10    |    0101    |
|    I     |  srli   |    0x5    |   0x00    |    10    |    0110    |
|    I     |  srai   |    0x5    |   0x20    |    10    |    0111    |
|    I     |  slti   |    0x2    |     -     |    10    |    1000    |
|    I     |  sltui  |    0x3    |     -     |    10    |    1001    |
|    I     |   lb    |    0x0    |     -     |    00    |    0000    |
|    I     |   lh    |    0x1    |     -     |    00    |    0000    |
|    I     |   lw    |    0x2    |     -     |    00    |    0000    |
|    I     |   lbu   |    0x4    |     -     |    00    |    0000    |
|    I     |   lhu   |    0x5    |     -     |    00    |    0000    |
|    I     |  jalr   |    0x0    |     -     |    00    |    0000    |
|    S     |   sb    |    0x0    |     -     |    00    |    0000    |
|    S     |   sh    |    0x1    |     -     |    00    |    0000    |
|    S     |   sw    |    0x2    |     -     |    00    |    0000    |
|    B     |   beq   |    0x0    |     -     |    01    |    0001    |
|    B     |   bne   |    0x1    |     -     |    01    |    0001    |
|    B     |   blt   |    0x4    |     -     |    01    |    0001    |
|    B     |   bge   |    0x5    |     -     |    01    |    0001    |
|    B     |  bltu   |    0x6    |     -     |    01    |    0001    |
|    B     |  bgeu   |    0x7    |     -     |    01    |    0001    |
|    J     |   jal   |    0x0    |     -     |    00    |    0000    |
|    U     |   lui   |    0x0    |     -     |    00    |    0000    |
|    U     |  auipc  |    0x0    |     -     |    00    |    0000    |


### branch logic
|     name[i]    | branch[i]  | jump[i]  | branch taken[i] | PCSrc[o] |
|----------------|:----------:|:--------:|:---------------:|:--------:|
| normal         |     0      |    00    |        x        |    00    |
| jal            |     x      |    01    |        x        |    01    |
| jalr           |     x      |    10    |        x        |    10    |
| branch         |     1      |    00    |        1        |    00    |
| don't branch   |     1      |    00    |        0        |    00    |

|  name[i]  | funct3[i] | branch taken[o] |
|-----------|:---------:|:---------------:|
| beq       |    0x0    |      zero       |
| bne       |    0x1    |      ~zero      |
| blt       |    0x4    |      less       |
| bge       |    0x5    |      ~less      |
| bltu      |    0x6    |      lessU      |
| bgeu      |    0x7    |      ~lessU     |