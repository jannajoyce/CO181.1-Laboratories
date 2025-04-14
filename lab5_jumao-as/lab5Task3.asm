.data
msg:		.asciiz		"\nPlease enter a positive integer: "
result: 	.asciiz 	"The factorial is: "
limit:		.asciiz 	"The factorial exceeds 32-bit limit."

.text
.globl main
main:

    li $v0, 4                    # syscall for print_string
    la $a0, msg                  # load address of msg
    syscall

    
    li $v0, 5                    # syscall for read_int
    syscall
    move $t0, $v0                # store input in $t0

   
    li $t1, 1                    # $t1 will hold the factorial result, start with 1
    move $t2, $t0                # $t2 will be the counter (n, n-1, ..., 1)

factorial_loop:

    beq $t2, 0, display_result   # if $t2 is 0, factorial is complete


    mul $t3, $t1, $t2            # $t3 = $t1 * $t2

  
    div $t4, $t3, $t2            # $t4 = $t3 / $t2
    mflo $t4                     # move quotient to $t4
    bne $t4, $t1, overflow       # if $t4 != $t1, overflow occurred

    
    move $t1, $t3                # $t1 = $t3 (new factorial result)
    sub $t2, $t2, 1              # decrement $t2

   
    j factorial_loop

display_result:
    
    li $v0, 4                    # syscall for print_string
    la $a0, result	         # load address of result message
    syscall

   
    li $v0, 1                    # syscall for print_int
    move $a0, $t1                # move factorial result to $a0
    syscall
    j main

overflow:
    
    li $v0, 4                    # syscall for print_string
    la $a0, limit	         # load address of overflow message
    syscall
    j exit

exit:
    li $v0, 10                   # syscall for exit
    syscall
