.data
input_buffer:   	.space 32               # Allocate space for 32 bytes for the input string
radix:   		.asciiz 		"Please enter a radix value between 2 and 10: "
digit:   		.asciiz 		"Please enter a string of digits in the specified radix: "
invalid_radix:  	.asciiz 		"Invalid radix! Please enter a value between 2 and 10.\n"
invalid_digit:  	.asciiz 		"Invalid input! Please use digits in the specified radix.\n"
result:     		.asciiz 		"The converted integer is: "

.text
.globl main

main:
    
    li      $v0, 4                    # syscall for print string
    la      $a0, radix         	      # load address of radix prompt
    syscall

    li      $v0, 5                    # syscall for read integer
    syscall
    move    $t1, $v0                  # store radix in $t1

   
    blt     $t1, 2, invalid_radix_msg
    bgt     $t1, 10, invalid_radix_msg

    
    li      $v0, 4                    # syscall for print string
    la      $a0, digit         	      # load address of digit prompt
    syscall

   
    li      $v0, 8                    # syscall for read string
    la      $a0, input_buffer         # load address of input buffer
    li      $a1, 32                   # maximum number of characters
    syscall

    
    li      $t0, 0                    # $t0 will hold the final integer result

   
    la      $t2, input_buffer         # Load the starting address of input buffer

convert_loop:
    lb      $t3, ($t2)                # Load a character from the input buffer
    beq     $t3, 0x0A, display_result # Newline (end of input), proceed to display result
    beq     $t3, 0, display_result    # Null terminator, end of input

    # Check if character is within the valid range for the specified radix
    sub     $t3, $t3, '0'             # Convert ASCII to integer value
    blt     $t3, 0, invalid_digit_msg # Check if less than 0
    bge     $t3, $t1, invalid_digit_msg # Check if greater than or equal to radix

    # Multiply the current result by the radix and add the new digit
    mul     $t0, $t0, $t1             # result = result * radix
    add     $t0, $t0, $t3             # result += current digit

    # Move to the next character in the string
    addi    $t2, $t2, 1               # Advance to the next character
    j       convert_loop              # Repeat the loop

display_result:
   
    li      $v0, 4                    # syscall for print string
    la      $a0, result           # Load address of result message
    syscall

   
    move    $a0, $t0                  # Move the result to $a0
    li      $v0, 1                    # syscall for print integer
    syscall

    
    li      $v0, 10                   # syscall for exit
    syscall

invalid_radix_msg:
    # Display invalid radix message and restart program
    li      $v0, 4                    # syscall for print string
    la      $a0, invalid_radix        # Load address of invalid radix message
    syscall
    j       main                      # Restart the program

invalid_digit_msg:
    
    li      $v0, 4                    # syscall for print string
    la      $a0, invalid_digit        # Load address of invalid digit message
    syscall
    j       main                      # Restart the program
