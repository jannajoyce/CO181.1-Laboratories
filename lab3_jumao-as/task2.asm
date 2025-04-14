    .data
newline:    .asciiz "\n"

    .text
    .globl main

main:
    # Load s1 and s2 with the given values
    li $s1, 0x12345678      # Load $s1 with 0x12345678
    li $s2, 0xffff9a00      # Load $s2 with 0xffff9a00

    # Perform AND operation: s3 = s1 & s2
    and $s3, $s1, $s2

    # Perform OR operation: s4 = s1 | s2
    or $s4, $s1, $s2

    # Perform XOR operation: s5 = s1 ^ s2
    xor $s5, $s1, $s2

    # Perform NOR operation: s6 = ~(s1 | s2)
    nor $s6, $s1, $s2

    # Print the results
    li $v0, 1               # Syscall for printing an integer

    # Exit the program
    li $v0, 10              # Syscall to exit (code 10)
    syscall
