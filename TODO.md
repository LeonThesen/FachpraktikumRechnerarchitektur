TODO: 
    - Forwarding Logik Prozess
    - NOP und Stall Erzeugung

Vivado Fehlermeldungen:
[alu_behav.vhd]
    - unnötiges Signal: signal substract_result_int: word_t; 
    - when others => alu_result_int <= (others => '0'); // sonst würden wir ein latch erzeugen
[rs1_fwd_mux_behav.vhd]
    - when others entfernen // sonst würden wir ein latch erzeugen
[rs2_fwd_mux_behav.vhd]
    - when others entfernen // sonst würden wir ein latch erzeugen

Compiler Flags für GCC:
-nostdlib -nolibc -nodefaultlibs -nostartfiles -march=rv32i -mabi=ilp32
