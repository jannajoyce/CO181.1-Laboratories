    .data
integer:         .asciiz "Enter a positive integer n: "
result:     .asciiz "The nth Fibonacci number is: "
newline:        .asciiz "\n"
error:      .asciiz "Please enter a non-negative integer!\n"

    .text
    .globl main

main:
    # Enter an integer
    li $v0, 4                  
    la $a0, integer             # load prompt message address
    syscall                   

    # Read integer input from the user
    li $v0, 5                 
    syscall                   
    move $t0, $v0              # store input integer in $t0 (n)

    # Check if input is positive
    bltz $t0, error      # if $t0 < 0, jump to error message

    # Initialize Fibonacci values: Fib0 = 0, Fib1 = 1
    li $t1, 0                  # fib0 = 0
    li $t2, 1                  # fib1 = 1

    # Check if n == 0, then result is fib0 (0)
    beq $t0, 0, fib0     

    # Loop to calculate Fibonacci up to the nth term
    li $t3, 2                  # i = 2
fibonacci_loop:
    # Exit loop if i > n
    bgt $t3, $t0, fib1   

    # Execute the algorithm steps
    move $t4, $t1              # temp = fib0
    move $t1, $t2              # fib0 = fib1
    add $t2, $t4, $t2          # fib1 = temp + fib1

    # Increment i
    addi $t3, $t3, 1           # i++
    j fibonacci_loop           # repeat the loop

fib1:
    # Print result message for nth Fibonacci number
    li $v0, 4                  # syscall for print_string
    la $a0, result         # load result message address
    syscall                   

    # Print fib1 (result)
    move $a0, $t2              # move the nth Fibonacci number to $a0
    li $v0, 1                  # syscall for print_integer
    syscall                   

    # Print newline
    li $v0, 4                 
    la $a0, newline           
    syscall                   

    # Exit program
    li $v0, 10                 
    syscall                   

fib0:
    # Print result message for fib0 (if n == 0)
    li $v0, 4                  # syscall for print_string
    la $a0, result         # load result message address
    syscall                   

    # Print 0
    move $a0, $t1              # move fib0 to $a0 (0)
    li $v0, 1                  # syscall for print_integer
    syscall                   

    # Print newline
    li $v0, 4                 
    la $a0, newline           
    syscall                   

    # Exit program
    li $v0, 10                 
    syscall                   

print_error:
    # Print error message if input is negative
    li $v0, 4                 
    la $a0, error        
    syscall                   

    # Exit program
    li $v0, 10                
    syscall
