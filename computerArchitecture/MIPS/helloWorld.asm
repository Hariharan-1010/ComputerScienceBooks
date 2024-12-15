.data
	msg: .asciiz "Hello World"
	num1: .word 10
	num2: .word 20
.text
	.globl main
main:
	li $v0, 1
	lw $a0, num1
	syscall
	li $v0, 4
	la $a0, msg
	syscall
	lw $t0, num1($zero)
	lw $t1, num2($zero)
	add $t2, $t0, $t1
	li $v0, 1
	move $a0, $t2
	syscall
	li $v0, 10
	syscall