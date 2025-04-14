.data
str1:		.asciiz		"Enter first integer:"
str2:		.asciiz		"Enter second integer:"
str3:		.asciiz		"equal"
str4:		.asciiz		"not equal"

.globl		main
.text
main:
	li	$v0, 4   	#service code for print string
	la	$a0, str1	#load address of str1 into $a0
	syscall			#print str1 string
	li	$v0, 5		#service code for read integer
	syscall			#read integer input into $v0
	move 	$s0, $v0	#save input value in $s0
	
	li	$v0, 4   	#service code for print string
	la	$a0, str2	#load address of str1 into $a0
	syscall			#print str1 string
	li	$v0, 5		#service code for read integer
	syscall			#read integer input into $v0
	move 	$s1, $v0	#save input value in $s0
	
	beq $s0, $s1, equal
	bne $s0, $s1, not_equal
	
	
equal:
	li	$v0, 4   	#service code for print string
	la	$a0, str3	#load address of str1 into $a0
	syscall			#print str1 string
	li $v0, 10
	syscall

not_equal:	
	li	$v0, 4   	#service code for print string
	la	$a0, str4	#load address of str1 into $a0
	syscall			#print str1 string
	li $v0, 10
	syscall