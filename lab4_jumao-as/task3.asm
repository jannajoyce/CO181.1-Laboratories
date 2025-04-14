    .data
integer:        .asciiz "Enter an integer: "
newline:       .asciiz "\n"
hex:       .asciiz "The hexadecimal representation is: "

    .text
    .globl main

main:
    # Enter an integer
    li $v0, 4                  
    la $a0, integer             # load address of prompt message
    syscall                   

    # Read integer input from the user
    li $v0, 5                  
    syscall                   
    move $t0, $v0              # store the input integer in $t0

    # Print the message for hexadecimal output
    li $v0, 4                  
    la $a0, hex               # load address of hex message
    syscall                   

    # Print the integer in hexadecimal
    move $a0, $t0              # move the integer to $a0 for printing
    li $v0, 34                 # syscall for print_hex
    syscall                   

    # Print newline
    li $v0, 4                  
    la $a0, newline            # load address of newline
    syscall                   

    # Exit program
    li $v0, 10                 # syscall for exit
    syscall
