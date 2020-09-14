.data
str1: .ASCIIZ"\nEnter value :"
str2: .ASCIIZ"Enter op code :"
str3: .ASCIIZ"The result is :"
str4: .ASCIIZ"ERROR"
.text
li $t0 '+'
li $t1 '-'
li $t2 '*'
li $t3 '@'
li $t8 0xffffffff

la $a0 str1
li $v0 4
syscall
#get the fitst element for the operation
li $v0 5
syscall
add $t4 $zero $v0

loop:
la $a0 str2
li $v0 4
syscall
#get the operator
li $v0 12
syscall
#check which operator was received
beq $v0 $t0 Add
beq $v0 $t1 Sub
beq $v0 $t2 Mult
beq $v0 $t3 endLoop

Add:
la $a0 str1
li $v0 4
syscall
#get the second element for the operation
li $v0 5
syscall
add $t4 $t4 $v0
j loop

Sub:
la $a0 str1
li $v0 4
syscall
#get the second element for the operation
li $v0 5
syscall
sub $t4 $t4 $v0
j loop

Mult:
la $a0 str1
li $v0 4
syscall
#get the second element for the operation
li $v0 5
syscall
mult  $t4 $v0
mfhi $t5
mflo $t6
# check overflow
beq $t5 $t8 checkNegative
beq $t5 $zero checkPositive

checkNegative:
bge $t6 $zero error
add $t4 $t4 $t6
j loop

checkPositive:
blt $t6 $zero error
add $t4 $zero $t6
j loop

endLoop:
#print the result:
la $a0 str3
li $v0 4
syscall
add $a0 $t4 $zero
li $v0 1 
syscall
j end

error:
#print error message:
la $a0 str4
li $v0 4
syscall
end:
