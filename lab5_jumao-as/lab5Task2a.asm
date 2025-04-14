.data
    quo: 	.asciiz 	"Quotient (LO): "
    remainder: 	.asciiz 	"\nRemainder (HI): "
.text
.globl main

main:
    
    li $t0, 98765         # Load 98765 into $t0
    li $t1, 54321         # Load 54321 into $t1


    divu $t0, $t1         # Unsigned division of $t0 by $t1
    mflo $a0              # Move quotient (LO) to $a0
    mfhi $a1              # Move remainder (HI) to $a1

    
    li $v0, 4             # Load syscall for print string
    la $a0, quo  	  # Load address of message
    syscall               # Print "Quotient (LO): "

    li $v0, 1             # Load syscall for print integer
    move $a0, $a0         # Move quotient to $a0 for printing
    syscall               # Print quotient

  
    li $v0, 4             # Load syscall for print string
    la $a0, remainder     # Load address of message
    syscall               # Print "\nRemainder (HI): "

    li $v0, 1             # Load syscall for print integer
    move $a0, $a1         # Move remainder to $a0 for printing
    syscall               # Print remainder


    li $v0, 10            # Load syscall for exit
    syscall
