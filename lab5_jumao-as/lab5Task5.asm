.data
input_buffer:   .space 32               # Allocate space for 32 bytes for the output string
unsigned:       .asciiz 		"Please enter an unsigned integer: "
radix:          .asciiz 		"Please enter a radix value between 2 and 10: "
invalid_radix:  .asciiz 		"Invalid radix! Please enter a value between 2 and 10.\n"
result_string:  .asciiz 		"The converted result is: "

.text
.globl main

main:
    
    li      $v0, 4                  # syscall for print string
    la      $a0, radix              # load address of radix
    syscall

    li      $v0, 5                  # syscall for read integer
    syscall
    move    $t1, $v0                # store radix in $t1

    
    blt     $t1, 2, invalid_radix_msg
    bgt     $t1, 10, invalid_radix_msg

   
    li      $v0, 4                  # syscall for print string
    la      $a0, unsigned            # load address of unsigned
    syscall

    li      $v0, 5                  # syscall for read integer
    syscall
    move    $t0, $v0                # store the unsigned integer in $t0

   
    la      $t2, input_buffer       # Address of the output buffer
    li      $t3, 0                   # Counter for number of digits

convert_loop:
    beqz    $t0, finish_conversion    # If integer is 0, exit loop

    divu    $t4, $t0, $t1             # Divide $t0 by $t1
    mfhi    $t5                        # $t5 = remainder (digit)
    mflo    $t0                        # $t0 = quotient

    addi    $t5, $t5, '0'              # Convert to ASCII ('0' = 48)
    sb      $t5, ($t2)                # Store ASCII character in buffer
    addiu   $t2, $t2, 1                # Move buffer pointer
    addiu   $t3, $t3, 1                # Increment digit count
    j       convert_loop               # Repeat for the next digit

finish_conversion:

    la      $t2, input_buffer         # Reset $t2 to the start of the string
    add     $t4, $t2, $t3              # $t4 = end of string (t2 + digit count)
    addi    $t4, $t4, -1               # Point to the last character

reverse_loop:
    bge     $t2, $t4, display_result   # If start >= end, done reversing
    lb      $t6, ($t2)                 # Load character from start
    lb      $t7, ($t4)                 # Load character from end
    sb      $t6, ($t4)                 # Swap characters
    sb      $t7, ($t2)                
    addiu   $t2, $t2, 1                 # Move start pointer forward
    addiu   $t4, $t4, -1                # Move end pointer backward
    j       reverse_loop                # Repeat

display_result:
    
    li      $v0, 4                     # syscall for print string
    la      $a0, result_string         # Load address of result_string
    syscall

    
    la      $a0, input_buffer          # Load address of input_buffer
    li      $v0, 4                     # syscall for print string
    syscall

   
    li      $v0, 10                    # syscall for exit
    syscall

invalid_radix_msg:
    li      $v0, 4                     # syscall for print string
    la      $a0, invalid_radix         # Load address of invalid_radix message
    syscall
    j       main                       # Go back to main to re-prompt
