.data
strE: .ASCIIZ"ERROR"
strI: .ASCIIZ"INPUT = "
strR: .ASCIIZ"RESULT = "

.text

li $s0 0x31
li $s1 0x30
li $s2 0x48
li $s3 0x74

loop:
li $v0 4
li $a0 strI
syscall
li $v0 5
syscall

beqz $v0 endLoop

sll $t0 $v0 24

Beq $t0 $s0 case1
Beq $t0 $s1 case2
Beq $t0 $s2 case3
Beq $t0 $s3 case4

li $v0 4
li $a0 strE
syscall

j loop
case1:

ori $a0 $v0 195

li $v0 4
li $a0 strR
syscall
li $v0 1
syscall

j loop

case2:
andi $a0 $v0 195

li $v0 4
li $a0 strR
syscall
li $v0 1
syscall

j loop

case3:
case4:


endLoop: