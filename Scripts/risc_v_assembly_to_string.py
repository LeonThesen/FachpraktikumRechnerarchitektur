import subprocess

# Step 1: Write your RISC-V assembly code to a file
assembly_code = """
.section .text
.globl _start

_start:
    addi x1, x0, 1     # Add immediate 1 to x0 and store in x1
    addi x2, x1, 2     # Add immediate 2 to x1 and store in x2
    add  x3, x1, x2    # Add x1 and x2 and store in x3
"""

with open("example.s", "w") as f:
    f.write(assembly_code)

# Step 2: Compile the assembly code to binary using GCC
command = "riscv64-unknown-elf-gcc -nostdlib -nostartfiles -Ttext=0x0 -o example.elf example.s"
subprocess.run(command, shell=True, check=True)

# Step 3: Convert the binary file to a string representation
command = "riscv64-unknown-elf-objcopy -O binary example.elf example.bin"
subprocess.run(command, shell=True, check=True)

# Read the binary file and convert it to a string
with open("example.bin", "rb") as f:
    binary_data = f.read()

binary_string = ''.join(format(byte, '08b') for byte in binary_data)

# Print or use the binary string as needed
print(binary_string)
