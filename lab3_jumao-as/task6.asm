.data
prompt:     .asciiz "Enter a signed integer: "
result:     .asciiz "The result of multiplying by 24.5 is: "
newline:    .asciiz "\n"
floatValue: .float 24.5        # Store the floating-point constant 24.5

.text
.globl main

main:
    # Prompt the user to enter a signed integer
    li $v0, 4                 
    la $a0, prompt           
    syscall                   

    # Read the signed integer
    li $v0, 5                 
    syscall                     
    move $s0, $v0             # Move the input integer to $s0

    # Load the floating-point value 24.5
    l.s $f0, floatValue       # Load the floating-point value 24.5 into $f0

    # Convert the integer in $s0 to a floating-point number
    mtc1 $s0, $f1             # Move the integer from $s0 to $f1
    cvt.s.w $f1, $f1          # Convert the integer in $f1 to single-precision float

    # Multiply the floating-point numbers
    mul.s $f2, $f1, $f0       # $f2 = $f1 * $f0 (signed integer * 24.5)

    # Print the result message
    li $v0, 4                 
    la $a0, result            
    syscall                    

    # Print the result (floating-point value)
    li $v0, 2                 
    mov.s $f12, $f2           # Move the result to $f12 for printing
    syscall                   

    # Print a newline
    li $v0, 4                  
    la $a0, newline           
    syscall                     

    # Exit the program
    li $v0, 10                 
    syscall
