.data
x:               .asciiz        "Please enter the numerator (x): "
y:               .asciiz        "Please enter the denominator (y): "
output_msg:      .asciiz        "The result of x divided by y is: "
error_msg:       .asciiz        "ERROR: Division by zero is not allowed."
newline:         .asciiz        "\n"
output_buffer:   .space         32          # Buffer for output formatting


.text
.globl main

main:
   
    li $v0, 4                     # syscall for print_string
    la $a0, x             	  # load address of prompt_x
    syscall

    
    li $v0, 5                     # syscall for read_int
    syscall
    move $t0, $v0                 # Store numerator in $t0 (x)

   
    li $v0, 4                     # syscall for print_string
    la $a0, y                     # load address of prompt_y
    syscall

   
    li $v0, 5                     # syscall for read_int
    syscall
    move $t1, $v0                 # Store denominator in $t1 (y)

    # Check for division by zero
    beqz $t1, handle_zero         # If y is zero, jump to handle_zero

    # Perform division
    mtc1 $t0, $f0                 # Move integer numerator to $f0
    mtc1 $t1, $f1                 # Move integer denominator to $f1
    cvt.s.w $f0, $f0              # Convert to float
    cvt.s.w $f1, $f1              # Convert to float
    div.s $f2, $f0, $f1           # Divide $f0 by $f1, result in $f2

    # Prepare result for output
    li $v0, 4                     # syscall for print_string
    la $a0, output_msg            # load address of output message
    syscall

    
    li $v0, 2                     # syscall for print_float
    mov.s $f12, $f2               # Move result to $f12 for printing
    syscall

   
    li $v0, 4                     # syscall for print_string
    la $a0, newline               # load address of newline
    syscall

    j finish                      # Jump to finish

handle_zero:
    
    li $v0, 4                     # syscall for print_string
    la $a0, error_msg             # load address of error message
    syscall

   
    li $v0, 4                     # syscall for print_string
    la $a0, newline               # load address of newline
    syscall

finish:
    li $v0, 10                    # syscall for exit
    syscall
