.data
str1: .ASCIIZ"\nEnter value :"
str2: .ASCIIZ"Enter op code :"
str3: .ASCIIZ"The result is :"
strE: .ASCIIZ"ERROR"
.text
li $t0 '+'
li $t1 '*'
li $t2 '^'

la $a0 str1
li $v0 4
syscall
li $v0 5
syscall
move $t0 $v0

la $a0 str2
li $v0 4
syscall
li $v0 12
syscall

beq $v0 $t0 Add
beq $v0 $t1 Mult
beq $v0 $t2 Pow

Add: 
la $a0 str1
li $v0 4
syscall
li $v0 5
syscall
move $a0 $t0
move $a1 $v0
jal AddF
j next

Mult:
la $a0 str1
li $v0 4
syscall
li $v0 5
syscall
move $a0 $t0
move $a1 $v0
jal MultF
j next

Pow:
la $a0 str1
li $v0 4
syscall
li $v0 5
syscall
beqz $v0 case0
move $a0 $t0
move $a1 $v0
jal PowF
j next

case0: 
beqz $t0 ERROR
li $v0 1

next:
move $t0 $v0
la $a0 str3
li $v0 4
syscall
move $a0 $t0
li $v0 1 
syscall
j end

ERROR:
la $a0 strE
li $v0 4
syscall

j end

#functions
AddF: 
add $v0 $a0 $a1

jr $ra

MultF:
addi $sp $sp -8
sw $ra 0($sp)
sw $t0 4($sp)

beqz $a1 zero
addi $t0 $a1 -1
move $a1 $a0
move $v0 $a0

loop:
beqz $t0 endMultF
jal AddF
addi $t0 $t0 -1
move $a1 $v0
j loop

zero:
li $v0 0

endMultF:
lw $t0 4($sp)
lw $ra 0($sp)
addi $sp $sp 8

jr $ra

PowF:
addi $sp $sp -4
sw $ra 0($sp)


addi $t0 $a1 -1
move $a1 $a0
move $v0 $a0

loop1:
beqz $t0 endPowF
jal MultF
addi $t0 $t0 -1
move $a1 $v0
j loop1

endPowF:
lw $ra 0($sp)
addi $sp $sp 4

jr $ra

end:
