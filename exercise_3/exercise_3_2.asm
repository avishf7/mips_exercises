.data
list:  .byte 2 4 6 8 10 
str1: .ASCIIZ"a1 = " 
str2: .ASCIIZ"\nq = "
str3: .ASCIIZ"\nd = " 

.text
la $a0 list
li $a1 5

#reset the registrs that we check with them the type of the series 
li $t4 0
li $t5 1
li $t6 1

#check if all pair in the series are uphold Engineering series or invoice:

lb $t0 0($a0)
lb $t1 1($a0)
sub $t7 $t1 $t0
div $t1 $t0
mflo $t8
mfhi $t9
addi $a0 $a0 1
subi $a1 $a1 1
loop:
subi $a1 $a1 1
beq $a1 $zero endLoop
lb $t0 0($a0)
lb $t1 1($a0)
bne $t4 $zero divide
sub $t2 $t1 $t0
sub $t4 $t7 $t2
divide:
bne $t5 $t6 next
div $t1 $t0 
mflo $t0
mfhi $t3
div $t8 $t0
mflo $t5
beq $t3 $t9 next
li $t5 0 
next:
addi $a0 $a0 1
j loop
endLoop:

la $a0 str1
li $v0 4
syscall
la $a2 list
lb $a0 0($a2)
li $v0 1
syscall

#print the difference if exists
bne $t4 $zero divPrint
la $a0 str3
li $v0 4
syscall
move $a0 $t2 
li $v0 1
syscall
divPrint:
#print the division if exists
bne $t5 $t6 endProgram
la $a0 str2
li $v0 4
syscall
move $a0 $t0 
li $v0 1
syscall
endProgram:
