.data
	A: .word 0x20 : 16
	B: .word 0x10 : 16

.text
    main:
    	# B[8] = A[i] + A[j] ; //C-code
	li $s0, 0	# f = 0
	li $s1, 1	# g = 1
	li $s2, 2	# h = 2
	li $s3, 3	# i = 3
	li $s4, 0	# j = 0
	la $s6, A	# base address of Array A
	la $s7, B	# base address of Array B
	
	sll $t0, $s3, 2		# t0 = 4i
	add $t0, $t0, $s6	# t0 = A + 4i
	lw $t0, 0($t0)		# t0 = A[i]
	sll $t1, $s4, 2		# t1 = 4j
	add $t1, $t1, $s6	# t1 = A + 4j
	lw $t1, 0($t1)		# t1 = A[j]
	add $t0, $t0, $t1	# t0 += t1 aka A[i] + A[j]
	sw $t0, 32($s7)		# B[8] = A[i] + A[j]
	
    print:
    	li $v0, 1		# system call code to print out integer
    	move $a0, $t0		# move results to argument register a0
    	syscall
    	
    	addi $v0, $0, 10	# system call code for exit
    	syscall