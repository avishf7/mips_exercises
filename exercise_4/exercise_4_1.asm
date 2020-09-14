.data
str1: .ASCIIZ"\nEnter value :"
str2: .ASCIIZ"Enter op code :"
str3: .ASCIIZ"The result is :"
strE: .ASCIIZ"ERROR"
.text
li $t0 '+'
li $t1 '*'
li $t2 '^'

#get the fitst element for the operation
la $a0 str1
li $v0 4
syscall
li $v0 5
syscall
move $t0 $v0
#get the operator
la $a0 str2
li $v0 4
syscall
li $v0 12
syscall
#check which operator was received
beq $v0 $t0 Add
beq $v0 $t1 Mult
beq $v0 $t2 Pow

Add: 
#get the second element for the operation
la $a0 str1
li $v0 4
syscall
li $v0 5
syscall
#put the elements in registers that received by the function
move $a0 $t0
move $a1 $v0

jal AddF
j next

Mult:
#get the second element for the operation
la $a0 str1
li $v0 4
syscall
li $v0 5
syscall
#put the elements in registers that received by the function:
move $a0 $t0
move $a1 $v0

jal MultF
j next

Pow:
#get the second element for the operation:
la $a0 str1
li $v0 4
syscall
li $v0 5
syscall
#check if the pow is 0 to do other operation:
beqz $v0 case0
#put the elements in registers that received by the function:
move $a0 $t0
move $a1 $v0
jal PowF
j next

case0:
#check if the number is 0 and write a ERROR message:
beqz $t0 ERROR
li $v0 1

next:
#print the result:
move $t0 $v0
la $a0 str3
li $v0 4
syscall
move $a0 $t0
li $v0 1 
syscall
j end

ERROR:
#write a ERROR massege
la $a0 strE
li $v0 4
syscall

j end

#functions

#add a0 and a1
AddF: 
add $v0 $a0 $a1

jr $ra

#add a0 with himself n times(n = a1)
MultF:
#push  ra and t0 to stack
addi $sp $sp -8
sw $ra 0($sp)
sw $t0 4($sp)

beqz $a1 zero # check if the multiplier is 0 than the result is 0
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
#pop  ra and t0 from stack
lw $t0 4($sp)
lw $ra 0($sp)
addi $sp $sp 8

jr $ra
#mult a0 with himself n times(n = a1)
PowF:
#push  ra and t0 to stack
addi $sp $sp -8
sw $ra 0($sp)
sw $t0 4($sp)

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
#pop  ra and t0 from stack
lw $t0 4($sp)
lw $ra 0($sp)
addi $sp $sp 8

jr $ra

end:
