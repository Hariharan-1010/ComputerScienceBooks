.data
	prompt: .asciiz "Enter Number to find factorial: "
	answerPrompt: .asciiz "The answer is: "
	newLine: .asciiz "\n"
	userInput: .word 0
	answer: .word 0
.text
	.globl main
	
main:
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0, 5
	syscall
	sw $v0, userInput
	
	lw $a0, userInput
	jal findFact
	sw $v0, answer
	
	li $v0, 4
	la $a0, newLine
	syscall
	
	la $a0, answerPrompt
	syscall
	
	li $v0, 1
	lw $a0, answer
	syscall
	
	li $v0, 10
	syscall

findFact:
	addi $sp, $sp, -8
	sw $ra, ($sp)
	sw $s0, 4($sp)
	
	li $v0, 1
	beq $a0, 0, endFact
	
	move $s0, $a0
	subi $a0, $a0, 1
	jal findFact

	mul $v0, $v0, $s0
	
endFact:
	lw $ra, ($sp)
	lw $s0, 4($sp)
	addi $sp, $sp, 8
	jr $ra
	