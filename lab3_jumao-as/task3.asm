    .data
newline:    .asciiz "\n"

    .text
    .globl main

main:
    # Load s1 with the given value
    li $s1, 0x87654321      # Load $s1 with 0x87654321

    # Perform SLL operation: s2 = s1 << 16
    sll $s2, $s1, 16

    # Perform SRL operation: s3 = s1 >> 8 (logical)
    srl $s3, $s1, 8

    # Perform SRA operation: s4 = s1 >> 12 (arithmetic)
    sra $s4, $s1, 12

    # Print the results
    li $v0, 1               # Syscall for printing an integer

    # Exit the program
    li $v0, 10              # Syscall to exit (code 10)
    syscall
