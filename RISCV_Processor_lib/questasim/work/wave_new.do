onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix binary /top_tb/top_i/seven_seg_1
add wave -noupdate -radix binary /top_tb/top_i/seven_seg_2
add wave -noupdate -radix binary /top_tb/top_i/seven_seg_3
add wave -noupdate -radix binary /top_tb/top_i/seven_seg_4
add wave -noupdate /top_tb/top_i/clk
add wave -noupdate -radix decimal /top_tb/top_i/cpu_i/operand_a
add wave -noupdate -radix decimal /top_tb/top_i/cpu_i/operand_b
add wave -noupdate -radix decimal -childformat {{/top_tb/top_i/cpu_i/register_file_i/register_array(0) -radix decimal} {/top_tb/top_i/cpu_i/register_file_i/register_array(1) -radix decimal} {/top_tb/top_i/cpu_i/register_file_i/register_array(2) -radix decimal} {/top_tb/top_i/cpu_i/register_file_i/register_array(3) -radix decimal} {/top_tb/top_i/cpu_i/register_file_i/register_array(4) -radix decimal} {/top_tb/top_i/cpu_i/register_file_i/register_array(5) -radix decimal} {/top_tb/top_i/cpu_i/register_file_i/register_array(6) -radix decimal} {/top_tb/top_i/cpu_i/register_file_i/register_array(7) -radix decimal} {/top_tb/top_i/cpu_i/register_file_i/register_array(8) -radix decimal} {/top_tb/top_i/cpu_i/register_file_i/register_array(9) -radix decimal} {/top_tb/top_i/cpu_i/register_file_i/register_array(10) -radix decimal} {/top_tb/top_i/cpu_i/register_file_i/register_array(11) -radix decimal} {/top_tb/top_i/cpu_i/register_file_i/register_array(12) -radix decimal} {/top_tb/top_i/cpu_i/register_file_i/register_array(13) -radix decimal} {/top_tb/top_i/cpu_i/register_file_i/register_array(14) -radix decimal} {/top_tb/top_i/cpu_i/register_file_i/register_array(15) -radix decimal} {/top_tb/top_i/cpu_i/register_file_i/register_array(16) -radix decimal} {/top_tb/top_i/cpu_i/register_file_i/register_array(17) -radix decimal} {/top_tb/top_i/cpu_i/register_file_i/register_array(18) -radix decimal} {/top_tb/top_i/cpu_i/register_file_i/register_array(19) -radix decimal} {/top_tb/top_i/cpu_i/register_file_i/register_array(20) -radix decimal} {/top_tb/top_i/cpu_i/register_file_i/register_array(21) -radix decimal} {/top_tb/top_i/cpu_i/register_file_i/register_array(22) -radix decimal} {/top_tb/top_i/cpu_i/register_file_i/register_array(23) -radix decimal} {/top_tb/top_i/cpu_i/register_file_i/register_array(24) -radix decimal} {/top_tb/top_i/cpu_i/register_file_i/register_array(25) -radix decimal} {/top_tb/top_i/cpu_i/register_file_i/register_array(26) -radix decimal} {/top_tb/top_i/cpu_i/register_file_i/register_array(27) -radix decimal} {/top_tb/top_i/cpu_i/register_file_i/register_array(28) -radix decimal} {/top_tb/top_i/cpu_i/register_file_i/register_array(29) -radix decimal} {/top_tb/top_i/cpu_i/register_file_i/register_array(30) -radix decimal} {/top_tb/top_i/cpu_i/register_file_i/register_array(31) -radix decimal}} -expand -subitemconfig {/top_tb/top_i/cpu_i/register_file_i/register_array(0) {-height 17 -radix decimal} /top_tb/top_i/cpu_i/register_file_i/register_array(1) {-height 17 -radix decimal} /top_tb/top_i/cpu_i/register_file_i/register_array(2) {-height 17 -radix decimal} /top_tb/top_i/cpu_i/register_file_i/register_array(3) {-height 17 -radix decimal} /top_tb/top_i/cpu_i/register_file_i/register_array(4) {-height 17 -radix decimal} /top_tb/top_i/cpu_i/register_file_i/register_array(5) {-height 17 -radix decimal} /top_tb/top_i/cpu_i/register_file_i/register_array(6) {-height 17 -radix decimal} /top_tb/top_i/cpu_i/register_file_i/register_array(7) {-height 17 -radix decimal} /top_tb/top_i/cpu_i/register_file_i/register_array(8) {-height 17 -radix decimal} /top_tb/top_i/cpu_i/register_file_i/register_array(9) {-height 17 -radix decimal} /top_tb/top_i/cpu_i/register_file_i/register_array(10) {-height 17 -radix decimal} /top_tb/top_i/cpu_i/register_file_i/register_array(11) {-height 17 -radix decimal} /top_tb/top_i/cpu_i/register_file_i/register_array(12) {-height 17 -radix decimal} /top_tb/top_i/cpu_i/register_file_i/register_array(13) {-height 17 -radix decimal} /top_tb/top_i/cpu_i/register_file_i/register_array(14) {-height 17 -radix decimal} /top_tb/top_i/cpu_i/register_file_i/register_array(15) {-height 17 -radix decimal} /top_tb/top_i/cpu_i/register_file_i/register_array(16) {-height 17 -radix decimal} /top_tb/top_i/cpu_i/register_file_i/register_array(17) {-height 17 -radix decimal} /top_tb/top_i/cpu_i/register_file_i/register_array(18) {-height 17 -radix decimal} /top_tb/top_i/cpu_i/register_file_i/register_array(19) {-height 17 -radix decimal} /top_tb/top_i/cpu_i/register_file_i/register_array(20) {-height 17 -radix decimal} /top_tb/top_i/cpu_i/register_file_i/register_array(21) {-height 17 -radix decimal} /top_tb/top_i/cpu_i/register_file_i/register_array(22) {-height 17 -radix decimal} /top_tb/top_i/cpu_i/register_file_i/register_array(23) {-height 17 -radix decimal} /top_tb/top_i/cpu_i/register_file_i/register_array(24) {-height 17 -radix decimal} /top_tb/top_i/cpu_i/register_file_i/register_array(25) {-height 17 -radix decimal} /top_tb/top_i/cpu_i/register_file_i/register_array(26) {-height 17 -radix decimal} /top_tb/top_i/cpu_i/register_file_i/register_array(27) {-height 17 -radix decimal} /top_tb/top_i/cpu_i/register_file_i/register_array(28) {-height 17 -radix decimal} /top_tb/top_i/cpu_i/register_file_i/register_array(29) {-height 17 -radix decimal} /top_tb/top_i/cpu_i/register_file_i/register_array(30) {-height 17 -radix decimal} /top_tb/top_i/cpu_i/register_file_i/register_array(31) {-height 17 -radix decimal}} /top_tb/top_i/cpu_i/register_file_i/register_array
add wave -noupdate /top_tb/top_i/cpu_i/divider_i/divider_result
add wave -noupdate /top_tb/top_i/cpu_i/divider_i/divider_result_int
add wave -noupdate /top_tb/top_i/cpu_i/divider_i/remainder_int
add wave -noupdate /top_tb/top_i/cpu_i/divider_i/quotient_int
add wave -noupdate /top_tb/top_i/cpu_i/divider_i/mode_int
add wave -noupdate /top_tb/top_i/cpu_i/divider_i/divider_i/state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {6537 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {1024 ns}
