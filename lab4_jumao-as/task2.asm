    .data
n1:     .asciiz "Enter the first integer (n1): "
n2:     .asciiz "Enter the second integer (n2): "
result:    .asciiz "The sum of all numbers from n1 to n2 is: "
newline:       .asciiz "\n"
error:     .asciiz "Error: n1 should be less than or equal to n2.\n"

    .text
    .globl main

main:
    # First integer n1
    li $v0, 4                
    la $a0, n1        
    syscall                  

    # Read n1 from user
    li $v0, 5               
    syscall                  
    move $t0, $v0            # Store n1 in $t0

    # Second integer n2
    li $v0, 4                
    la $a0, n2        
    syscall                  

    # Read n2 from user
    li $v0, 5               
    syscall                  
    move $t1, $v0            # Store n2 in $t1

    # Check if n1 <= n2
    ble $t0, $t1, calculate_sum  # If n1 <= n2, continue to sum calculation

    # Error if n1 > n2
    li $v0, 4                
    la $a0, error        
    syscall                  
    j exit                   # Jump to program exit

calculate_sum:
    # Initialize sum
    move $t2, $t0            # $t2 is the running number (starts from n1)
    li $t3, 0                # $t3 will hold the total sum

sum_loop:
    # Add current number to sum
    add $t3, $t3, $t2        # $t3 = $t3 + $t2

    # Increment number and check if it reached n2
    addi $t2, $t2, 1         # $t2 = $t2 + 1
    ble $t2, $t1, sum_loop   # Continue loop if $t2 <= $t1

    # Print result message
    li $v0, 4               
    la $a0, result       
    syscall                  

    # Print the sum
    move $a0, $t3            # Move the sum to $a0 for printing
    li $v0, 1                # Syscall to print integer
    syscall                  

    # Print newline
    li $v0, 4                
    la $a0, newline          
    syscall                  

exit:
    # Exit program
    li $v0, 10               
    syscall
