    .data
prompt_integer:   .asciiz "Enter an integer: "
prompt_position:  .asciiz "Enter a bit position (0-31): "
bit_value_msg:    .asciiz "The value of the bit is: "
newline:          .asciiz "\n"
error_msg:        .asciiz "Invalid bit position! Please enter a value between 0 and 31.\n"

    .text
    .globl main

main:
    # Prompt user to enter an integer
    li $v0, 4                 
    la $a0, prompt_integer    
    syscall                    

    # Read the integer from the user
    li $v0, 5                
    syscall                    
    move $s0, $v0              # Move the input integer to $s0 for processing

    # Prompt user to enter a bit position (0-31)
    li $v0, 4                 
    la $a0, prompt_position    
    syscall                    

    # Read the bit position from the user
    li $v0, 5                
    syscall                    
    move $s1, $v0              # Move the input bit position to $s1

    # Check if the bit position is valid (between 0 and 31)
    li $s2, 0                 # Load 0 into $s2 (lower bound)
    li $s3, 31                # Load 31 into $s3 (upper bound)

    # Check if s1 < 0 using slt (Set on Less Than)
    slt $s4, $s1, $s2         # If $s1 < $s2, $s4 = 1, else $s4 = 0
    bne $s4, $zero, invalid_bit_position  # If $s1 < 0, jump to error

    # Check if s1 > 31 using slt
    slt $s4, $s3, $s1         # If $s3 < $s1, $s4 = 1, else $s4 = 0
    bne $s4, $zero, invalid_bit_position  # If $s1 > 31, jump to error

    # Compute the bit value: shift the number to the right by $s1 and get the LSB
    srlv $s5, $s0, $s1        # Shift the integer in $s0 right by the number of bits in $s1
    andi $s6, $s5, 1          # Extract the LSB (bit value)

    # Print the result message
    li $v0, 4                
    la $a0, bit_value_msg      # Load address of the bit value message
    syscall                    

    # Print the bit value (1 or 0)
    move $a0, $s6             # Move the bit value to $a0
    li $v0, 1                 # Syscall for printing an integer
    syscall                   

    # Print a newline
    li $v0, 4                 
    la $a0, newline            
    syscall                    

    # Exit the program
    li $v0, 10               
    syscall

invalid_bit_position:
    # Print an error message for invalid bit position
    li $v0, 4                 
    la $a0, error_msg          # Load address of the error message
    syscall                    

    # Exit the program
    li $v0, 10                
    syscall
