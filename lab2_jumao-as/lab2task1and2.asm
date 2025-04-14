.data
str1:		.asciiz		"\nEnter an integer value:"
str2: 		.asciiz		"You entered "
str3:		.asciiz		"\nThe double is: "
str4:		.asciiz		"\nRepeat [y/n]?: "

.globl		main
.text
main:
	li	$v0, 4   	#service code for print string
	la	$a0, str1	#load address of str1 into $a0
	syscall			#print str1 string
	li	$v0, 5		#service code for read integer
	syscall			#read integer input into $v0
	move 	$s0, $v0	#save input value in $s0
	li	$v0, 4		#service code for print string
	la	$a0, str2	#load address of str2 into $a0
	syscall			#print str2 string
	li	$v0, 1		#service code to print integer
	move	$a0, $s0	#copy input value
	syscall			#print integer
#doubling the input number	
	li	$v0, 4	
	la	$a0, str3	
	syscall
	add	$s1, $s0, $s0	#double the input number using add instruction
	li	$v0, 1		
	move	$a0, $s1
	syscall	
#repeat the program(?)
	
	li	$v0, 4
	la	$a0, str4
	syscall
	
	li	$v0, 12		#use service code 12 to read a character
	syscall	
	
	li	$t0, 'y'	
	beq	$t0, $v0, main	#compare the input and the t0, if equal back to main label.
	
													
	li	$v0, 10		
	syscall			
