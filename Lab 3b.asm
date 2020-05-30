.data
	A: .word -9, 20, 17, -2, -10, -4, -20, -6, 16, -17, -11, -13, 1, -14, 2, 11
	msg: .asciiz "MIPS program 2: The sum is "
	
.text
	li $s0, 16		# s0 = size = 16
	sll $s0, $s0, 2		# s0 = size << 2 = 64
	la $t0, A		# t0 = address of A
	li $t1, 0		# t1 = sum = 0
	add $t2, $t0, $s0	# t2 = A + s0
    Loop:
    	lw $t3, 0($t0)		# t3 = A[i]
    	add $t1, $t1, $t3	# sum += A[i]
    	addi $t0, $t0, 4	# advance pointer
    	bne $t0, $t2, Loop	# if (t0 != t2) goto Loop
    	
    	la $a0, msg		# print string
    	li $v0, 4		# code to print string
    	syscall			# system call
    	move $a0, $t1		# print sum
    	li $v0, 1		# code to print integer
    	syscall			# system call