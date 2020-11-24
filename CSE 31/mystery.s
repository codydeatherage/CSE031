
	.text

main:
	li $a0, 0
	jal putDec
	li $a0, '\n'
	li $v0, 11
	syscall
	
	li $a0, 1
	jal putDec
	li $a0, '\n'
	li $v0, 11
	syscall
	
	li $a0, 196
	jal putDec
	li $a0, '\n'
	li $v0, 11
	syscall
	
	li $a0, -1
	jal putDec
	li $a0, '\n'
	li $v0, 11
	syscall
	
	li $a0, -452
	jal putDec
	li $a0, '\n'
	li $v0, 11
	syscall
	
	li $a0, 2
	jal mystery
	move $a0, $v0
	jal putDec
	li $a0, '\n'
	li $v0, 11
	syscall

	li $a0, 3
	jal mystery
	move $a0, $v0
	jal putDec
	li $a0, '\n'
	li $v0, 11
	syscall

	li 	$v0, 10		# terminate program
	syscall

putDec: 
	## FILL IN ##
	
		li $s7, 10
		bne $a0, 0, checker
	zero:	li $v0, 0
		syscall
		jr $ra
	checker:	sle $t0, $a0, 0
			beq $t0, 0, loop
	negative:	move $t0, $a0
			li $v0, '-'
			syscall
			move $a0, $t0
			sub $a0, 0, $a0
			jal loop
	loop:	beq $a0, $0, done
		addi $sp, $sp, -8
		sw $ra, 0($sp)
		remu $t0, $a0, $s7
		divu $a0, $a0, $s7
		addi $t9, $t9, 48
		sb $t7, 4($sp)
		jal loop
		lw $ra, 0($sp)
		lb $t0, 4($sp)
		move $a0, $t7
		li $v0, 11
		syscall
		addi $sp, $sp, 8
		jr	$ra		# returnv

mystery: bne $0, $a0, recur 	# 
 	li $v0, 0 		#
 	jr $ra 			#
 recur: sub $sp, $sp, 8 	#
 	sw $ra, 4($sp) 	#
 	sub $a0, $a0, 1 	#
 	jal mystery 		#
 	sw $v0, 0($sp) 	#
 	jal mystery 		#
 	lw $t0, 0($sp) 	#
 	addu $v0, $v0, $t0 	#
 	addu $v0, $v0, 1 	#
 	add $a0, $a0, 1 	#
 	lw $ra, 4($sp) 	#
 	add $sp, $sp, 8 	#
 	jr $ra 			#
