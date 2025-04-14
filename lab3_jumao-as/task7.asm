    .data
prompt:     .asciiz "Enter an unsigned integer: "
result: .asciiz "The result after swapping bits is: "
newline:    .asciiz "\n"

    .text
    .globl main

main:
    # Prompt the user to enter an unsigned integer
    li $v0, 4                  
    la $a0, prompt            
    syscall                    

    # Read the unsigned integer
    li $v0, 5                  
    syscall                     
    move $s0, $v0              # Move the input integer to $s0

    # Initialize masks for swapping
    li $t0, 0xAAAAAAAA         # Mask for odd bits (0b10101010... for 32 bits)
    li $t1, 0x55555555         # Mask for even bits (0b01010101... for 32 bits)

    # Isolate odd and even bits
    and $t2, $s0, $t0          # Get the odd bits in $t2
    and $t3, $s0, $t1          # Get the even bits in $t3

    # Shift the odd bits to the right
    srl $t2, $t2, 1            # Right shift odd bits to even positions

    # Shift the even bits to the left
    sll $t3, $t3, 1            # Left shift even bits to odd positions

    # Combine the results
    or $s1, $t2, $t3           # Combine the swapped bits

    # Print the result message
    li $v0, 4                  
    la $a0, result            
    syscall                     

    # Print the result (the swapped number)
    move $a0, $s1              # Move the result to $a0
    li $v0, 1                  
    syscall                    

    # Print a newline
    li $v0, 4                  
    la $a0, newline           
    syscall                     

    # Exit the program
    li $v0, 10                
    syscall
