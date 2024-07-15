.set smallestNum, -511
.set biggestNum, 511

start:
    # Load the smallestNum and biggestNum into registers
    li t0, smallestNum    # load address of smallestNum into t0
    li t1, biggestNum     # load address of biggestNum into t2

    # Initialize dividend to smallestNum
    mv t4, t0             # t4 = dividend = smallestNum

outer_loop:
    # Initialize divisor to smallestNum for each new dividend
    mv t5, t0             # t5 = divisor = smallestNum

inner_loop:
    # Perform the division
    div t6, t4, t5        # t6 = quotient = dividend / divisor

    # Increment the divisor
    addi t5, t5, 1        # t5 = divisor + 1

    # Check if divisor is within the range
    ble t5, t1, inner_loop

    # Increment the dividend
    addi t4, t4, 1        # t4 = dividend + 1

    # Check if dividend is within the range
    ble t4, t1, outer_loop

doom: j doom
