.data
str1:		.asciiz		"\nEnter the value of a:"
str2:		.asciiz		"\nEnter the value of b:"
str3:		.asciiz		"\nEnter the value of c:"
str4:		.asciiz		"\nThe value of s is "

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
	
	li	$v0, 4   	#service code for print string
	la	$a0, str3	#load address of str1 into $a0
	syscall			#print str1 string
	li	$v0, 5		#service code for read integer
	syscall			#read integer input into $v0
	move 	$s2, $v0	#save input value in $s0
	
	add $s3, $s0, $s1
	addi $s4, $s2, 101
	sub $s5, $s3, $s4
	
	li	$v0, 4   	#service code for print string
	la	$a0, str4	#load address of str1 into $a0
	syscall			#print str1 string
	li	$v0, 1		#service code to print integer
	move	$a0, $s5	#copy input value
	syscall			#print integer
	
	li $v0, 10
syscall