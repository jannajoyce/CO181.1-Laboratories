# Program Name: HelloWorld.asm	(Optional)



	.data				# data segment

hello:	.asciiz "Hello, world!\n"	# a null terminated string

	.text				# code segment

	.globl main			#

main:

	la	$a0, hello		# load string address

	li	$v0, 4			# specify system write service

	syscall				# call the kernel (write string)

	li	$v0, 10			# exit to OS

	syscall

