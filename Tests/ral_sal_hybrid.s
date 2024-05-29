addi x2, x0, 3
addi x1, x0, 6
sw x1, 0(x0) 
lw x10, 0(x0)
sw x10, 0(x10)

; expected result: 6 at address 6