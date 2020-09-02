.data
list: .byte 5 3 10 7 4
str: .ASCIIZ"The biggest number : " 
.text
la $a0 list
li $a1 5
lb $v0 0($a0)

loop:
subi $a1 $a1 1
beq $a1 $zero end
addi $a0 $a0 1
lb $t0 0($a0)
slt $t1 $t0 $v0 
bne $t1 $zero next
add $v0 $zero $t0
next:
j loop
end:
move $t8 $v0
la $a0 str
li $v0 4
syscall
add $a0 $zero $t8
li $v0 1
syscall


