	.data
	
percent:	.byte	'%'
dec:		.byte	'd'
hex:		.byte	'x'
uns:		.byte	'u'
oct:		.byte	'o'
stri:		.byte	's'


buffer:	.space	20000			# 2000 bytes of empty space 
					# starting at address 'buffer'
	
format:	.asciiz "string: %s, unsigned dec: %u, hex: 0x%x, oct: 0%o, dec: %d\n"
					# null-terminated string of 
					# ascii bytes.  Note that the 
					# \n counts as one byte: a newline 
					# character.
str:	.asciiz "thirty-nine"		# null-terminated string at
					# address 'str'
chrs:	.asciiz " characters:\n"	# null-terminated string at 
					# address 'chrs'
	.text
	

	.globl sprintf	

main:
	addi	$sp,$sp,-32	# reserve stack space

	# $v0 = sprintf(buffer, format, str, 255, 255, 250, -255)
	
	la	$a0,buffer	
	la	$a1,format	
	la	$a2,str		
	
	addi	$a3,$0,-25	
	sw	$a3,16($sp)	
	
	addi	$t0,$0,17
	sw	$t0,20($sp)	

        addi    $t0,$0,92
        sw      $t0,24($sp)     

	sw	$ra,28($sp)	
	jal	sprintf		


	add	$a0,$v0,$0	
	jal	putint		

 	li 	$v0, 4	
	la     	$a0, chrs
	syscall
	
	li	$v0, 4
	la	$a0, buffer
	syscall
	
	addi	$sp,$sp,32	
	li 	$v0, 10		
	syscall

putint:	addi	$sp,$sp,-8	
	sw	$ra,0($sp)	

	remu	$t0,$a0,10	
	addi	$t0,$t0,'0'	
	divu	$a0,$a0,10	
	beqz	$a0,onedig	 
	sw	$t0,4($sp)	
	jal	putint		
	lw	$t0,4($sp)	
	                         
onedig:	move	$a0, $t0
	li 	$v0, 11
	syscall			
	#putc	$t0		
	lw	$ra,0($sp)	
	addi	$sp,$sp, 8	
	jr	$ra		
sprintf:
	add	$t0, $a0, $0	
	la	$t1, ($a1)	
	lb	$t2, percent	
	lb	$t3, ($t1)	
	addi	$sp, $sp, 8
	sw	$a3, 0($sp)
	li	$t7, 0
	
check: 	
	beqz	$t3, Exit
	beq	$t3, $t2, type
	li	$v0, 11
	add	$a0, $t3, $0
	syscall
	addi	$t7, $t7, 1
	lb	$t3, format + 0($t7)
	j	check
	
type:	
	addi	$t7, $t7, 1		
	lb	$t3, format + 0($t7)	
	lb	$t2, stri
	beq	$t3, $t2, string
	lb	$t2, uns	
	beq	$t3, $t2, unsigned 
	lb	$t2, dec
	beq	$t3, $t2, decimal
	lb	$t2, hex
	beq	$t3, $t2, hexi
	lb	$t2, oct
	beq	$t3, $t2, octi
	 
string: add	$sp, $sp, 4
	la	$a0, 0($sp)  
	li	$v0, 4				
	syscall
	addi	$t7, $t7, 1
	lb	$t3, format + 0($t7)
	lb	$t2, percent
	j	check


unsigned:
	add	$sp, $sp, 4
	lw	$a0, 0($sp) 
	slt	$t4, $a0, $0
	beq	$t4, 1, positive
after:	li	$v0, 1
	syscall
	addi	$t7, $t7, 1
	lb	$t3, format + 0($t7)
	lb	$t2, percent
	j	check

positive:
	sub	$a0, $0, $a0
	j	after
	

decimal:add	$sp, $sp, 4
	lw	$a0, 0($sp)
	slt	$t4, $a0, $0
	beq	$t4, 1, negative
back:	li	$v0, 1
	syscall
	addi	$t7, $t7, 1
	lb	$t3, format + 0($t7)
	lb	$t2, percent
	j	check

negative: 
	add	$t4, $a0, $a0
	li	$a0, '-'
	li	$v0, 11
	syscall
	add	$a0, $t4, $0
	j	back


hexi:	
	add	$sp, $sp, 4	
					
hexloop:

	j check

octi:
	add	$sp, $sp, 4	
					
octi_loop:	
	j check
	
Exit:
	jr	$ra		#this sprintf implementation rocks!