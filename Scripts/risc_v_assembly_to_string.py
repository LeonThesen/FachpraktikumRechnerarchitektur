import subprocess
import re

# Step 1: Write your RISC-V assembly code to a file
assembly_code = """
.section .text
.globl _start

_start:
    addi x1, x0, 1
    addi x2, x0, 1
    nop
    nop
    ori x3, x1, 1
"""

with open("example.s", "w") as f:
    f.write(assembly_code)

# Step 2: Compile the assembly code to binary using GCC
command = "riscv64-unknown-elf-gcc -nostdlib -nostartfiles -Ttext=0x0 -o example.elf example.s"
subprocess.run(command, shell=True, check=True)

# Step 3: Extract the binary instructions from the ELF file
command = "riscv64-unknown-elf-readelf -x .text example.elf"
output = subprocess.check_output(command, shell=True, text=True)

# Extract hexadecimal instructions using regular expressions
hex_instructions = re.findall(r'\s+0x[0-9a-f]+:\s+(([0-9a-f]{2}\s+)+)', output)

# Convert hexadecimal instructions to binary strings
binary_instructions = ["".join(format(int(hex_inst, 16), '08b') for hex_inst in line[0].split()) for line in hex_instructions]

# Concatenate binary strings
binary_string = "".join(binary_instructions)

# Print or use the binary string as needed
print(binary_string)
