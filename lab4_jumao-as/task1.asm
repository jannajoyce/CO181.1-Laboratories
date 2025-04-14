    .data
prompt:     .asciiz "Enter an integer: "
result: .asciiz "The number of 1's in the binary representation is: "
newline:    .asciiz "\n"

    .text
    .globl main

main:
    # Enter an integer
    li $v0, 4                 
    la $a0, prompt            
    syscall                   

    # Read integer input from user
    li $v0, 5                
    syscall                    
    move $t0, $v0             # Store the input integer in $t0

    # Initialize counter for 1's count
    li $t1, 0                 # $t1 holds the count of 1's

count_ones:
    # Check if the least significant bit is 1
    andi $t2, $t0, 1          # $t2 = $t0 AND 1 (extract least significant bit)
    beq $t2, $zero, skip      # If the bit is 0, skip increment

    # Increment the counter if LSB is 1
    addi $t1, $t1, 1          # Increment count of 1's

skip:
    # Shift right to process the next bit
    srl $t0, $t0, 1           # Shift $t0 right by 1 bit
    bne $t0, $zero, count_ones # Repeat until $t0 becomes 0

    # Display result message
    li $v0, 4                
    la $a0, result       
    syscall                   

    # Print the count of 1's
    move $a0, $t1             # Move count to $a0 for printing
    li $v0, 1                 # Print integer syscall
    syscall                   

    # Print newline
    li $v0, 4                 
    la $a0, newline           
    syscall                   

    # Exit the program
    li $v0, 10                
    syscall
