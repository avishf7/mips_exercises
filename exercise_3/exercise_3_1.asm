.data
list:  5 3 7 40 9
str: .ASCIIZ"Sorted list: " 
blank: .ASCIIZ" " 
.text
la $a0 list
li $a1 5

move $t7 $a1
move $t8 $t7
loop:
subi $t8 $t8 1
beq $t8 $zero endLoop
lw $t0 0($a0)
lw $t1 4($a0)
slt $t2 $t1 $t0 
beq $t2 $zero next
sw $t1 0($a0)
sw $t0 4($a0)
next:
addi $a0 $a0 4
j loop
endLoop:
la $a0 list
subi $t7 $t7 1
move $t8 $t7
bne $t8 $zero loop

la $a0 str
li $v0 4
syscall

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
