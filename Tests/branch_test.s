addi x1, x0, 1
addi x2, x0, 1
beq x1, x2, passed_1
j failed

passed_1:
addi x30, x30, 1
addi x1, x0, 2
addi x2, x0, 3
bne x1, x2, passed_2
j failed

passed_2:
addi x30, x30, 1
addi x1, x0, 2
addi x2, x0, 3
blt x1, x2, passed_3
j failed

passed_3:
addi x30, x30, 1
addi x1, x0, 3
addi x2, x0, 3
bge x1, x2, passed_4
j failed

passed_4:
addi x30, x30, 1
addi x1, x0, 4
addi x2, x0, 3
bge x1, x2, passed_5
j failed

passed_5:
addi x30, x30, 1
addi x1, x0, 3
addi x2, x0, 4
bltu x1, x2, passed_6
j failed

passed_6:
addi x30, x30, 1
addi x1, x0, 3
addi x2, x0, 3
bgeu x1, x2, passed_7
j failed


passed_7:
addi x30, x30, 1
addi x1, x0, 4
addi x2, x0, 3
bgeu x1, x2, passed_8
j failed

passed_8:
addi x30, x30, 1
addi x1, x0, 3
addi x2, x0, 3
bgeu x1, x2, passed_9
j failed

passed_9:
addi x30, x30, 1
auipc x2, 0
jalr x0, x2, 12; passed_10
j failed

passed_10:
addi x30, x30, 1
addi x1, x0, -1
addi x2, x0, -1
beq x1, x2, passed_11
j failed

passed_11:
addi x30, x30, 1
addi x1, x0, -2
addi x2, x0, 3
bne x1, x2, passed_12
j failed

passed_12:
addi x30, x30, 1
addi x1, x0, -2
addi x2, x0, 3
blt x1, x2, passed_13
j failed

passed_13:
addi x30, x30, 1
addi x1, x0, 3
addi x2, x0, -3
bge x1, x2, passed_14
j failed