addi x1, x0, 1
addi x2, x0, 13
addi x3, x0, 0
loop:
bge x3, x2, doom
add x1, x1, x1
addi x3, x3, 1
jal x0, loop

doom: jal x0, doom

