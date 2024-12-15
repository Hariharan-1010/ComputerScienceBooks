.data
	msg1:    .asciiz "Enter Length of the Array: "
	msg2:    .asciiz "Enter the Array Elements: "
	space:   .asciiz " "
	newLine: .asciiz "\n"
.text
	.globl main
	
main:
	li $v0, 4
	la $a0, msg1
	syscall
	
	li $v0, 5
	syscall
	
	sll $a0, $v0, 2
	move $s1, $v0 # $s1 = length of dynamic array
	li $v0, 9
	syscall
	
	move $s0, $v0 # $s0 = base address
	
	li $v0, 4
	la $a0, msg2
	syscall
	
	sll $a1, $s1, 2
	li $s2, 0
	
getArrayElements:
	beq $s2, $a1, init
	add $a2, $s2, $s0
	
	li $v0, 5
	syscall
	
	sw $v0, ($a2)
	addi $s2, $s2, 4
	j getArrayElements

init:
	li $s2, 0
	sll $a1, $s1, 2
	li $v0, 4
	la $a0, newLine
	
printArrayElements:
	beq $s2, $a1, end
	add $a2, $s2, $s0
	
	li $v0, 1
	lw $a0, ($a2)
	syscall
	
	li $v0, 4
	la $a0, space
	syscall
	
	addi $s2, $s2, 4
	
	j printArrayElements

end:
	li $v0, 10
	syscall