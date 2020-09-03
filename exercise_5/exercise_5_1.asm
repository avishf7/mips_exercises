.data 
list: .byte 4 8 9 6 3 2 7 4 5 8 2 1 6 9 8 7 5 1 2 6 4 5 9 8 7 5 3 2 1 4 8 7
basicCode: .byte 0 0 0 0 0 0
str: .ASCIIZ"Enter 6 digits:\n"
str1: .ASCIIZ"the basic code "
strE: .ASCIIZ"Exists."
strNE: .ASCIIZ"Not exists."
blank: .ASCIIZ" "
.text



li $t1 6

la $a0 str
li $v0 4
syscall

la $a0 basicCode
loop1:
beq $t1 $zero end1
li $v0 5
syscall
sb $v0 0($a0)
addi $t1 $t1 -1
addi $a0 $a0 1
j loop1
end1:
la $a0 basicCode
la $a1 list
li $a2 32
li $a3 6
jal find

move $t8 $v0
la $a0 str1
li $v0 4
syscall
la $a1 basicCode
labal1:
beqz $a3 endLabal1
lb $a0 0($a1)
li $v0 1
syscall
la $a0 blank
li $v0 4
syscall
addi $a3 $a3 -1
addi $a1 $a1 1
j labal1
endLabal1:

beqz $t8 notExists
la $a0 strE
li $v0 4
syscall
j endProgram

notExists:
la $a0 strNE
li $v0 4
syscall
j endProgram


#functions

#get:
# a0 - address to the first element to check in the basicCode
# a1 - address to the first element to check in the list
# a2 - quantity of numbers to check from a1
# a3 - quantity of numbers in basicCode
#return:
# v0 - 0 if not found 1 if found
find:
addi $sp $sp -4
sw $ra 0($sp)

lb $t2 0($a0)
loop:
lb $t0 0($a1)
beq $t0 $t2 endLoop
beq $a2 $zero Zero
addi $a1 $a1 1
addi $a2 $a2 -1
j loop
endLoop:
bgt $a3 $a2 Zero
jal findBasicCode
bnez $v0 end 
addi $a1 $a1 1
addi $a2 $a2 -1
j loop

Zero:li $v0 0

end: 
lw $ra 0($sp)
addi $sp $sp 4
jr $ra

findBasicCode:
addi $sp $sp -16
sw $ra 0($sp)
sw $a0 4($sp)
sw $a1 8($sp)
sw $a3 12($sp)

labal:
addi $a3 $a3 -1
beqz $a3 found 
addi $a0 $a0 1
addi $a1 $a1 1
lb $t0 0($a0)
lb $t1 0($a1)
bne $t0 $t1 notFound
j labal

found:
li $v0 1
j endfindBasicCode

notFound:
li $v0 0

endfindBasicCode:
lw $a3 12($sp)
lw $a1 8($sp)
lw $a0 4($sp)
lw $ra 0($sp)
addi $sp $sp 16

jr $ra

endProgram:
