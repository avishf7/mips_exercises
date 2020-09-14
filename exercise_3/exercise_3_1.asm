.data
list:  5 3 7 40 9
str: .ASCIIZ"Sorted list: " 
blank: .ASCIIZ" " 
.text
la $a0 list
li $a1 5

#save the size of the list to reuse him
move $t7 $a1
move $t8 $t7


#bubble sort:
loop:
subi $t8 $t8 1 # down by one the count of the loop
beq $t8 $zero endLoop # check if the list ended
lw $t0 0($a0)
lw $t1 4($a0)
#if t0 bigger than t1 swap between them:
slt $t2 $t1 $t0 
beq $t2 $zero next
sw $t1 0($a0)
sw $t0 4($a0)
next:
addi $a0 $a0 4 # move to next element in the list
j loop
endLoop:

#repeat the bubble n times(n = a0 = size of the list):
la $a0 list
subi $t7 $t7 1
move $t8 $t7
bne $t8 $zero loop


la $a0 str
li $v0 4
syscall
#print the sorted list:
la $a2 list
printLoop:
beq $a1 $zero endProgram
lw $a0 0($a2) 
li $v0 1
syscall
la $a0 blank
li $v0 4
syscall

addi $a2 $a2 4
subi $a1 $a1 1
j printLoop
endProgram:
