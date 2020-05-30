.data
	newLine:	.asciiz	"\n"
	SP:		.asciiz	"SP = "
	RA:		.asciiz	", RA = "
	N:		.asciiz	", N = "

.text
main:
	li  $a0,    6           # compute 6!
	jal fact

	move $a0,  $v0
	li   $v0,  1
	syscall

	li $v0, 10
	syscall

fact:
	addi $sp, $sp, -8	# adjust stack for 2 items 
	sw   $ra, 4($sp)	# save return address 
	sw   $a0, 0($sp)	# save argument 

	slti $t0, $a0, 1	# test for n < 1 
	beq  $t0, $zero, L1
	addi $v0, $zero, 1	# if so, result is 1 
	lw   $a0, 0($sp)	# xxx Q1 (4%): Explain why these two statements have no
	lw   $ra, 4($sp)	# xxx     impact on the program. Give your answer below.
	# The above 2 statements are not necessary because $a0 and $ra are not changed
	# when n < 1. We can pop these 2 items out of the stack immediately.

	addi $sp, $sp, 8	# pop 2 items from stack 
	jr   $ra		# and return
	
    L1:
	addi $a0, $a0, -1	# else decrement n
	move $s0, $v0		# save v0 in s0
	jal  Trace		# xxx the stack expands for each function call
	move $v0, $s0		# store v0 from s0
	
	jal  fact		# recursive call
	move $s0, $v0		# save v0 in s0
	jal  Trace		# xxx stack space is released when the function finishes
	move $v0, $s0		# store v0 from s0
	
	lw   $a0, 0($sp)	# xxx Q2(4%): Why do we have to have this and next statement?
	lw   $ra, 4($sp)	# xxx What are they used for? Give answer below.
	# Line 40 restores the argument n of the current procedure from the stack to use below
	# Line 41 restores the return address of the current procedure from the stack so it
	# can jr $ra back to the correct instruction address

	addi $sp, $sp, 8	# pop 2 items from stack
	mul  $v0, $a0, $v0	# multiply to get result
	jr   $ra		# and return

Trace:
	# xxx Q3 (4%): Since function Trace will use $v0 to display numbers, 
	# xxx the caller (function fact) also needs to save and retrieve the original value
	# xxx of $v0 before and after the calls to function Trace. 
	# xxx Revise function fact according to this change.

	# xxx finish the missing codes to display the values of $sp, $ra, and $a0
	# xxx at the top of the stack before and after each function call (jal fact).
	# xxx List your program for question Q5 below
	
	move $t0, $a0		# save a0 in t0
	
	la   $a0, SP		# load SP address to a0
	li   $v0, 4		# code to print string
	syscall			# print string SP
	move $a0, $sp		# load SP value to a0
	li   $v0, 34		# code to print integer as hex
	syscall			# print SP value
	
	la   $a0, RA		# load RA address to a0
	li   $v0, 4		# code to print string
	syscall			# print string RA
	lw   $a0, 4($sp)	# load RA value from stack to a0
	li   $v0, 34		# code to print integer as hex
	syscall			# print RA value
	
	la   $a0, N		# load N address to a0
	li   $v0, 4		# code to print string
	syscall			# print string N
	lw   $a0, 0($sp)	# load a0 value from stack to a0
	li   $v0, 1		# code to print integer
	syscall			# print a0 value
	
	la   $a0, newLine	# load newLine address to a0
	li   $v0, 4		# code to print string
	syscall			# print string newLine
	move $a0, $t0		# restore initial value of a0 from t0
	jr   $ra		# xxx the last statement