.data
	A: .word -9, 20, 17, -2, -10, -4, -20, -6, 16, -17, -11, -13, 1, -14, 2, 11
	msg: .asciiz "MIPS program 1: The sum is "
	
.text
	li $s0, 16		# s0 = size = 16
	sll $s0, $s0, 2		# s0 = size << 2 = 64
	la $s1, A		# s1 = address of A
	li $t0, 0		# t0 = sum = 0
	li $t1, 0		# t1 = array index = 0
    Loop:
    	add $t2, $t1, $s1	# t2 = &A[i]
    	lw $t2, 0($t2)		# t2 = A[i]
    	add $t0, $t0, $t2	# sum += A[i]
    	addi $t1, $t1, 4	# advance index
    	bne $t1, $s0, Loop	# if (t1 < s0) goto Loop
    	
    	la $a0, msg		# print string
    	li $v0, 4		# code to print string
    	syscall			# system call
    	move $a0, $t0		# print sum
    	li $v0, 1		# code to print integer
    	syscall			# system call