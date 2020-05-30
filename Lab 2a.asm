.data
	A: .word 0x1234	: 8
	   .word 0xABCD	: 8
	B: .word 0x0	: 16
.text
	li $s0, 0	# f = 0
	li $s1, 1	# g = 1
	li $s2, 2	# h = 2
	li $s3, 3	# i = 3
	li $s4, 0	# j = 0
	la $s6, A	# base address of Array A
	la $s7, B	# base address of Array B
	
	sub $t0, $s3, $s4	# t0 = i - j
	sll $t0, $t0, 2		# t0 = 4(i - j)
	add $t0, $t0, $s6	# t0 = A + 4(i - j)
	lw $t0, 0($t0)		# t0 = A[i - j]
	sw $t0, 32($s7)		# B[8] = A[i - j]