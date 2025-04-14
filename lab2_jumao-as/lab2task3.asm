.data
str1:		.asciiz		"\nEnter your name:"
str2:		.asciiz		"Hello "
str3:		.space		20

.globl		main
.text
main:
	li	$v0, 4   	#service code for print string
	la	$a0, str1	#load address of str1 into $a0
	syscall			#print str1 string
	li	$v0, 8
	la	$a0, str3
	li	$a1, 20
	syscall
	li	$v0, 4   	#service code for print string
	la	$a0, str2	#load address of str1 into $a0
	syscall			#print str1 string
	li	$v0, 4   	#service code for print string
	la	$a0, str3	#load address of str1 into $a0
	syscall			#print str1 string

li $v0, 10
syscall