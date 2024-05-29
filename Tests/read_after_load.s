addi x2, x0, 3
addi x1, x0, 6
sw x1, 0(x0) 
lw x10, 0(x0)
addi x3, x10, 0

; expected result: x3 == 6