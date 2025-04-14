    .data
msg: 	        .asciiz 	"\n -98765 * -54321\n"
lo_result: 	.asciiz 	"\n LO register: "
hi_result: 	.asciiz 	"\n HI register: "

    .text
    .globl main

main:
    
    li $v0, 4                  # syscall code for print string
    la $a0, msg                # load msg address
    syscall                    # print msg

    
    li $t0, -98765             # load -98765 into $t0
    li $t1, -54321             # load -54321 into $t1
    mult $t0, $t1              # perform signed multiplication (-98765 * -54321)

    
    mflo $t2                   # move LO register result to $t2
    mfhi $t3                   # move HI register result to $t3

    # Display LO result
    li $v0, 4                  # syscall code for print string
    la $a0, lo_result          # load lo_result address
    syscall                    # print "LO register: "
    
    li $v0, 1                  # syscall code for print integer
    move $a0, $t2              # load LO result into $a0
    syscall                    # print LO value

    # Display HI result
    li $v0, 4                  # syscall code for print string
    la $a0, hi_result          # load hi_result address
    syscall                    # print "HI register: "
    
    li $v0, 1                  # syscall code for print integer
    move $a0, $t3              # load HI result into $a0
    syscall                    # print HI value

   
    li $v0, 10                 # syscall code for exit
    syscall                    # exit program
