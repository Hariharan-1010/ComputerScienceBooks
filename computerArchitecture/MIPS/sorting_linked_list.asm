.macro PRINT(%s)                                                                                                                                                        
        .data                                                                                                                                                           
                txt: .asciiz %s                                                                                                                                         
        .text                                                                                                                                                           
                la $a0, txt                                                                                                                                             
                li $v0, 4                                                                                                                                               
                syscall                                                                                                                                                 
.end_macro                                                                                                                                                              
                                                                                                                                                                        
.data                                                                                                                                                                   
        head: .space 8                                                                                                                                                  
.text                                                                                                                                                                   
                                                                                                                                                                        
main:                                                                                                                                                                   
#sort singly linked list                                                                                                                                                
# create an index of nameList, find index of particular character                                                                                                       
                                                                                                                                                                        
                                                                                                                                                                        
                                                                                                                                                                        
#node => data, pointer                                                                                                                                                  
#for each new entry dynamically allocate new data and pointer memory and                                                                                                
#pointer of previous node should point to current node                                                                                                                  
                                                                                                                                                                        
#how do i create a structure in MIPS???                                                                                                                                 
#what is a structure?                                                                                                                                                   
#It is a way of grouping different datatypes into one single datatype;                                                                                                  
#How do I do the above in MIPS????                                                                                                                                      
# Allocate memory of 8 bytes => 2 words (4 bytes for integer data and 4 bytes for pointer)                                                                              
                                                                                                                                                                        
                                                                                                                                                                        
#li $v0, 9, $a0 => numebr of bytes, $v0 => address of allocated memory                                                                                                  
                                                                                                                                                                        
PRINT("Enter the number of elements :")                                                                                                                                 
li $v0, 5                                                                                                                                                               
syscall                                                                                                                                                                 
move $s0, $v0 # $s0 contains the number of elements.                                                                                                                    
                                                                                                                                                                        
jal getElements                                                                                                                                                         
jal printElements      
PRINT("\n")                                                                                                                                                 
jal sortList                                                                                                                                                            
jal printElements                                                                                                                                                       
li $v0, 10                                                                                                                                                              
syscall                                                                                                                                                                 
                                                                                                                                                                        
                                                                                                                                                                        
getElements:                                                                                                                                                            
        add $t0, $zero, $s0 #copy of $s0                                                                                                                                
        la $t2, head                                                                                                                                                    
        getElements_loop:                                                                                                                                               
                beq $zero, $t0, end_getElements                                                                                                                         
                PRINT("Enter next element : ")                                                                                                                          
                li $v0, 5                                                                                                                                               
                syscall                                                                                                                                                 
                move $t1, $v0                                                                                                                                           

                li $v0, 9                                                                                                                                               
                li $a0, 8                                                                                                                                               
                syscall                                                                                                                                                 
                #make head of next to current address                                                                                                                   
                sw $t1, 0($v0)#add data to the element                                                                                                                  
                sw $zero, 4($v0)                                                                                                                                        
                sw $v0, 4($t2)                                                                                                                                          

                move $t2, $v0 #make prev node to current node                                                                                                           
                addi $t0, $t0, -1                                                                                                                                       

                j getElements_loop                                                                                                                                      

        end_getElements:                                                                                                                                                
                jr $ra                                                                                                                                                  
                                                                                                                                                                        
printElements:                                                                                                                                                          
        add $t0, $zero, $s0                                                                                                                                             
        la $t2, head                                                                                                                                                    
        lw $t2, 4($t2)                                                                                                                                                  

        printElement_loop:                                                                                                                                              
                beq $zero, $t0, end_printElements                                                                                                                       
                li $v0, 1                                                                                                                                               
                lw $a0, 0($t2)
                syscall                                                                                                                                                 
                PRINT(" ")                                                                                                                                              

                lw $t2, 4($t2)                                                                                                                                          
                addi $t0, $t0, -1                                                                                                                                       

                j printElement_loop                                                                                                                                     

        end_printElements:                                                                                                                                              
                jr $ra                                                                                                                                                  
sortList:
	addi $sp, $sp, -4                                                                                                                                                               
	sw $ra, ($sp)
        la $t0, head
  	lw $t1, 4($t0)
  	sortListOuter:
  		beqz  $t1, endOuterLoop
  		move $t2, $t1
  		lw $t3, 4($t2)
  		
  		jal sortListInner
  		move $t0, $t1
  		lw $t1, 4($t0)
  		j sortListOuter
  	endOuterLoop:
  		lw $ra, ($sp)
  		addi $sp, $sp, 4
  		
  		jr $ra
  	sortListInner:
  		sortListInnerLoop:
	  		beqz $t3, endInnerLoop
  			lw $a1, ($t1)
	  		lw $a2, ($t3)
  			
	  		blt $a2, $a1, swap
	  		move $t2, $t3
	  		lw $t3, 4($t2)
	  		j sortListInnerLoop
	  	endInnerLoop:
	  		jr $ra
	 swap:
	 	move $t9, $ra
	 	lw $t5, 4($t1)
	 	lw $t6, 4($t3)
	 	
	 	sw $t3, 4($t0)
	 	sw $t5, 4($t3)

	 	sw $t1, 4($t2)
	 	sw $t6, 4($t1)
		
		move $t2, $t1
		lw $t3, 4($t2)
		lw $t1, 4($t0)
		jal printElements
		move $ra, $t9
	  	j sortListInnerLoop
	 	
  		
        	