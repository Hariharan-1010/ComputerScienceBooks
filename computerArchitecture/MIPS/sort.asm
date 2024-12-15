.data                                                                                                                                                                   
        prompt1: .asciiz "Enter the Number of elements: "                                                                                                               
        prompt2: .asciiz "Enter the Elements: "                                                                                                                         
        newline: .asciiz "\n"                                                                                                                                           
        space:   .asciiz " "                                                                                                                                            
.text                                                                                                                                                                   
        .globl main                                                                                                                                                     
main:                                                                                                                                                                   
        li $v0, 4                                                                                                                                                       
        la $a0, prompt1                                                                                                                                                 
        syscall                                                                                                                                                         
        li $v0, 5                                                                                                                                                       
        syscall                                                                                                                                                         
        move $s0, $v0 # Number of elements in $s0                                                                                                                       

        li $v0, 4                                                                                                                                                       
        la $a0, newline                                                                                                                                                 
        syscall                                                                                                                                                         
        li $v0, 4                                                                                                                                                       
        la $a0, prompt2                                                                                                                                                 
        syscall                                                                                                                                                         

        sll $t0, $s0, 2                                                                                                                                                 

        li $v0, 9                                                                                                                                                       
        move $a0, $t0                                                                                                                                                   
        syscall                                                                                                                                                         

        move $s1, $v0 # Base address of the array in $s1                                                                                                                
        move $s2, $s1                                                                                                                                                   
        li $t0, 0                                                                                                                                                       

        jal get_array # Get array elements                                                                                                                              

        jal print_array # Array before sorting                                                                                                                          
        jal sort # Sorting...                                                                                                                                           
        li $v0, 4                                                                                                                                                       
        la $a0, newline                                                                                                                                                 
        syscall                                                                                                                                                         
        jal print_array # Array after sorting                                                                                                                           
        li $v0, 4                                                                                                                                                       
        la $a0, newline                                                                                                                                                 
        syscall                                                                                                                                                         

        li $v0, 10                                                                                                                                                      
        syscall                                                                                                                                                         

get_array:                                                                                                                                                              
        beq $t0, $s0, end_loop                                                                                                                                          
        li $v0, 5                                                                                                                                                       
        syscall                                                                                                                                                         
        sw $v0, ($s2)                                                                                                                                                   
        addi $s2, $s2, 4                                                                                                                                                
        addi $t0, $t0, 1                                                                                                                                                
        j get_array                                                                                                                                                     

print_array:                                                                                                                                                            
        beq $t0, $s0, end_loop                                                                                                                                          
        lw $a0, ($s2)                                                                                                                                                   
        li $v0, 1                                                                                                                                                       
        syscall                                                                                                                                                         
        li $v0, 4                                                                                                                                                       
        la $a0, space                                                                                                                                                   
        syscall                                                                                                                                                         

        addi $t0, $t0, 1                                                                                                                                                
        addi $s2, $s2, 4                                                                                                                                                
        j print_array                                                                                                                                                   
end_loop:                                                                                                                                                               
        li $t0, 0                                                                                                                                                       
        move $s2, $s1                                                                                                                                                   
        jr $ra                                                                                                                                                          
sort:                                                                                                                                                                   
        li $t1, 0 # For outer loop => i                                                                                                                                 
        addi $t2, $t1, 1 # For inner loop => j                                                                                                                          
        addi $sp, $sp, -4                                                                                                                                               
        sw $ra, ($sp)                                                                                                                                                   

outer_loop:                                                                                                                                                             
        beq $t1, $s0, end_sort                                                                                                                                          
        jal inner_loop                                                                                                                                                  
        addi $t1, $t1, 1                                                                                                                                                
        j outer_loop                                                                                                                                                    
inner_loop:                                                                                                                                                             
        beq $t2, $s0, end_inner_loop                                                                                                                                    
        mul $t3, $t1, 4                                                                                                                                                 
        mul $t4, $t2, 4                                                                                                                                                 

        add $t3, $s1, $t3                                                                                                                                               
        add $t4, $s1, $t4                                                                                                                                               

        lw $t5, ($t3) # arr[i]                                                                                                                                          
        lw $t6, ($t4) # arr[j]                                                                                                                                          

        bgt $t5, $t6, swap                                                                                                                                              
        addi $t2, $t2, 1                                                                                                                                                
        j inner_loop                                                                                                                                                    
end_sort:                                                                                                                                                               
        move $s2, $s1                                                                                                                                                   
        li $t0, 0                                                                                                                                                       
        lw $ra, ($sp)                                                                                                                                                   
        jr $ra                                                                                                                                                          
end_inner_loop:                                                                                                                                                         
        addi $t2, $t1, 2                                                                                                                                                
        jr $ra                                                                                                                                                          
                                                                                                                                                                        
swap:                                                                                                                                                                   
        sw $t5, ($t4)                                                                                                                                                   
        sw $t6, ($t3)                                                                                                                                                   

        addi $t2, $t2, 1                                                                                                                                                
        j inner_loop                                                                                                                                                    
