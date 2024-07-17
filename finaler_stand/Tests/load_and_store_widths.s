addi x2, x0, 12
addi x1, x0, 6
sw x1, 0(x0) ; an addresse 0 ist 6
lw x10, 0(x0) ; x10 = 6
sw x10, 0(x2) ; an addresse 12 ist 6
sh x10, 2(x2) ; an adresse 14 ist 6
sb x10, 3(x2) ; an adresse 15 ist 6
lh x11, 0(x2) ; x11 = 0x0006
lh x12, 2(x2) ; x12 = 0x0606
lb x13, 3(x2) ; x13 = 0x06

