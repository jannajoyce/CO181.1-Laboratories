    .data
prompt:     .asciiz "Enter an alphabetic character: "
newline:    .asciiz "\n"
result:     .asciiz "\nThe case-changed character is: "

    .text
    .globl main

main:
    # Prompt user for input
    li $v0, 4               
    la $a0, prompt          
    syscall               

    # Read a character from the user
    li $v0, 12             
    syscall               
    move $t0, $v0           # Move the input character to $t0 for processing

    # Check if the character is lowercase (ASCII 'a' to 'z')
    li $t1, 97              # ASCII value of 'a'
    li $t2, 122             # ASCII value of 'z'
    blt $t0, $t1, check_upper_case    # If character < 'a', check if it's uppercase
    bgt $t0, $t2, check_upper_case    # If character > 'z', check if it's uppercase

    # Convert lowercase to uppercase
    li $t3, 32              # Difference between lower and uppercase letters
    sub $t0, $t0, $t3       # Subtract 32 to convert lowercase to uppercase
    j display_result        # Jump to display the result

check_upper_case:
    # Check if the character is uppercase (ASCII 'A' to 'Z')
    li $t1, 65              # ASCII value of 'A'
    li $t2, 90              # ASCII value of 'Z'
    blt $t0, $t1, invalid_character  # If character < 'A', it's invalid
    bgt $t0, $t2, invalid_character  # If character > 'Z', it's invalid

    # Convert uppercase to lowercase
    li $t3, 32              # Difference between lower and uppercase letters
    add $t0, $t0, $t3       # Add 32 to convert uppercase to lowercase

display_result:
    # Display the result
    li $v0, 4               
    la $a0, result          
    syscall                 

    # Print the converted character
    move $a0, $t0           # Move the character to $a0
    li $v0, 11              
    syscall                 

    # Print a newline
    li $v0, 4
    la $a0, newline
    syscall

    # Exit the program
    li $v0, 10              # Syscall to exit 
    syscall

invalid_character:
    # Handle invalid character input (non-alphabetic character)
    li $v0, 4              
    la $a0, newline         # Print a newline as invalid input handling
    syscall

    # Exit the program
    li $v0, 10              
    syscall
