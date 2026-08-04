fib:
    addi sp, sp, -16
    sw ra, 12(sp)
    sw a0, 8(sp)

    li t0, 2
    blt a0, t0, return

    addi a0, a0, -1
    jal ra, fib
    sw a0, 4(sp)

    lw a0, 8(sp)
    addi a0, a0, -2
    jal ra, fib

    lw t0, 4(sp)
    add a0, a0, t0
return:
    lw ra, 12(sp)
    addi sp, sp, 16
    jr ra
    
main:
    li sp, 0x400

    li a0, 5
    jal ra, fib

done:
    jal x0, done
