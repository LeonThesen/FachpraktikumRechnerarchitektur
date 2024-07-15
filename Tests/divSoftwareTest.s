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
     # Load dividend
     #add a0, t4, x0
     li a0, 10 
     # Load divisor
     #add a1, t5, x0
     li a1, 3 
        # Perform the division: quotient = dividend / divisor
     call __divsi3
    
     # Put result into t6
     add t6, a0, x0

    # Increment the divisor
    addi t5, t5, 1        # t5 = divisor + 1

    # Check if divisor is within the range
    ble t5, t1, inner_loop

    # Increment the dividend
    addi t4, t4, 1        # t4 = dividend + 1

    # Check if dividend is within the range
    ble t4, t1, outer_loop

doom: j doom

__udivsi3:
  add   t0, ra, x0
  jal    __udivdi3
  jr     t0

__divsi3:
  /* Check for special case of INT_MIN/-1. Otherwise, fall into __divdi3.  */
  li    t0, -1
  beq   a1, t0, .L20

__divdi3:
  bltz  a0, .L10
  bltz  a1, .L11
  /* Since the quotient is positive, fall into __udivdi3.  */

__udivdi3:
  mv    a2, a1
  mv    a1, a0
  li    a0, -1
  beqz  a2, .L5
  li    a3, 1
  bgeu  a2, a1, .L2
.L1:
  blez  a2, .L2
  slli  a2, a2, 1
  slli  a3, a3, 1
  bgtu  a1, a2, .L1
.L2:
  li    a0, 0
.L3:
  bltu  a1, a2, .L4
  sub   a1, a1, a2
  or    a0, a0, a3
.L4:
  srli  a3, a3, 1
  srli  a2, a2, 1
  bnez  a3, .L3
.L5:
  ret
  /* Handle negative arguments to __divdi3.  */
.L10:
  neg   a0, a0
  /* Zero is handled as a negative so that the result will not be inverted.  */
  bgtz  a1, .L12     /* Compute __udivdi3(-a0, a1), then negate the result.  */

  neg   a1, a1
  j     __udivdi3    /* Compute __udivdi3(-a0, -a1).  */
.L11:                /* Compute __udivdi3(a0, -a1), then negate the result.  */
  neg   a1, a1
.L12:
  add  t0, ra, x0
  jal   __udivdi3
  neg   a0, a0
  jr    t0
.L20:
  slli   t0, t0, 31
  bne   a0, t0, __divdi3
  ret
