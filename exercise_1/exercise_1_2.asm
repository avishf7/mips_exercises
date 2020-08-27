#???? - ?? ???????? ???????? ???? ?????? ??????
.data
str_in: .ASCIIZ"Enter integer number between -99 to 99:"
str_end: .ASCIIZ"sum of all numbers - "
.text
li $t6 100
li $t7 -100

input:
li $v0 4
la $a0 str_in
syscall

li $v0 5
syscall

slt $t2 $v0 $t6
slt $t3 $t7 $v0
and $t4 $t3 $t2
beq $t4 $zero input

add $t0 $t0 $v0 

bne $v0 $zero input

end:
li $v0 4
la $a0 str_end
syscall

add $a0 $zero $t0
li $v0 1
syscall