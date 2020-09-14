.data
strE: .ASCIIZ"ERROR"
strI: .ASCIIZ"\nINPUT = "
strR: .ASCIIZ"\nRESULT = "

.text

li $s0 0x31
li $s1 0x30
li $s2 0x48
li $s3 0x74


loop:
#get the number for operation
li $v0 4
la $a0 strI
syscall
li $v0 5
syscall

beqz $v0 endLoop

srl $t0 $v0 24
#check which operation to do
Beq $t0 $s0 case1
Beq $t0 $s1 case2
Beq $t0 $s2 case3
Beq $t0 $s3 case4

#print ERROR if not recognized the op code
li $v0 4
la $a0 strE
syscall

j loop
#put 1 in spcific bits
case1:

ori $t0 $v0 195

li $v0 4
la $a0 strR
syscall
li $v0 1
move $a0 $t0
syscall

j loop
#put 0 in spcific bits
case2:
andi $t0 $v0 0xffffff3c

li $v0 4
la $a0 strR
syscall
li $v0 1
move $a0 $t0
syscall

j loop
#reverse spcific bits
case3:
li $t0 65280
xor $t0 $v0 $t0

li $v0 4
la $a0 strR
syscall
li $v0 1
move $a0 $t0
syscall

j loop
#shift left n times v0(n number that represented by 20-24 bits)
case4:
sll $t0 $v0 7
srl $t0 $t0 27
sllv  $t0 $v0 $t0

li $v0 4
la $a0 strR
syscall
li $v0 1
move $a0 $t0
syscall

j loop

endLoop:
