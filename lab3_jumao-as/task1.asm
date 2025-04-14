    .data                   
intA:    .asciiz "Enter the first integer (A): "
intB:    .asciiz "Enter the second integer (B): "
result:  .asciiz "The result of A + 2B - 5 is: "
newline:    .asciiz "\n"

    .text                   
    .globl main

main:
    # Prompt for A
    li $v0, 4               
    la $a0, intA         # Load the address of the promptA message
    syscall                 

    # Read integer A
    li $v0, 5               
    syscall                
    move $t0, $v0           # Store A in register $t0

    # Prompt for B
    li $v0, 4               
    la $a0, intB          # Load the address of the promptB message
    syscall                
    
    # Read integer B
    li $v0, 5               
    syscall                
    move $t1, $v0           # Store B in register $t1

    # Compute A + 2B - 5
    li $t2, 2               # Load 2 into $t2
    mul $t3, $t1, $t2       # Multiply B by 2 (t1 * 2) and store result in $t3
    add $t4, $t0, $t3       # Add A (in $t0) to the result in $t3
    li $t5, 5               # Load 5 into $t5
    sub $t6, $t4, $t5       # Subtract 5 from the result (A + 2B)

    # Print the result message
    li $v0, 4               
    la $a0, result          # Load the address of the result message
    syscall                

    # Print the result (A + 2B - 5)
    move $a0, $t6           # Move the result into $a0 for printing
    li $v0, 1               # Load syscall for printing an integer 
    syscall                 

    # Print newline for formatting
    li $v0, 4               # Load syscall for printing a string 
    la $a0, newline         # Load the address of the newline
    syscall               

    # Exit the program
    li $v0, 10              # Load syscall for exit s
    syscall                
