.data

first:.space 40
second:.space 40
result:.space 40
str1:.asciiz "Enter first matrix dimensions:\n"
str2:.asciiz "Enter second matrix dimensions:\n"
str3:.asciiz"new row:\n"
str4:.asciiz"Enter data for the first matrix:\n"
str5:.asciiz"Enter data for the second matrix:\n"
str_row:.asciiz"rows - "
str_column:.asciiz"columns - "
error:.asciiz"ERROR:the dimensions not match\n"
enter:.asciiz"\n"
blank:.asciiz"   "
str_first:.asciiz"first matrix:\n"
str_second:.asciiz"second matrix:\n"
str_result:.asciiz"result matrix:\n"

.text

#get the dimensions:
loop:
li $v0 4
la $a0 str1
syscall
 
li $v0 4
la $a0 str_row
syscall 
li $v0 5
syscall 

move $t0 $v0

li $v0 4
la $a0 str_column
syscall 
li $v0 5
syscall 

move $t1 $v0


li $v0 4
la $a0 str2
syscall
 
li $v0 4
la $a0 str_row
syscall 
li $v0 5
syscall 

move $t2 $v0

li $v0 4
la $a0 str_column
syscall 
li $v0 5
syscall
 
move $t3 $v0

beq $t1 $t2 endloop
li $v0 4
la $a0 error
syscall
 
j loop
endloop:

#get numbers for the first matrix:
move $t7 $t0
la $a1 first

li $v0 4
la $a0 str4
syscall 
li $v0 4
la $a0 str3
syscall
 
row_loop1:

move $t8 $t1

column_loop1:

li $v0 5
syscall
 
sw $v0 ($a1)

addi $t8 $t8 -1
addi $a1 $a1 4
beqz $t8 end_column_loop1

j column_loop1

end_column_loop1:

addi $t7 $t7 -1
beqz $t7 end_row_loop1
li $v0 4
la $a0 str3
syscall
 
j row_loop1

end_row_loop1:

#get numbers for the second matrix:
move $t7 $t2 
la $a1 second

li $v0 4
la $a0 str5
syscall 
li $v0 4
la $a0 str3
syscall 

row_loop2:

move $t8 $t3

column_loop2:

li $v0 5
syscall 
sw $v0 ($a1)
addi $t8 $t8 -1
addi $a1 $a1 4
beqz $t8 end_column_loop2

j column_loop2

end_column_loop2:

addi $t7 $t7 -1
beqz $t7 end_row_loop2
li $v0 4
la $a0 str3
syscall
 
j row_loop2

end_row_loop2:

#multiply the matrices
la $v1 result
li $t9 4
move $t7 $t0
la $a0 first

row_loop:

beqz $t7 end_row_loop
la $a1 second
move $t8 $t3
column_loop:

beqz $t8 end_column_loop

move $a2 $a0
move $a3 $a1
move $t6 $t1
li $v0 0

mult_loop:

beqz $t6 end_mult_loop
lw $t4 ($a2)
lw $t5 ($a3)
mult $t4 $t5
mflo $t4
add $v0 $v0 $t4

addi $a2 $a2 4
mult $t9 $t3
mflo $t4
add $a3 $a3 $t4

addi $t6 $t6 -1

j mult_loop

end_mult_loop:

sw $v0 ($v1)
addi $v1 $v1 4
addi $a1 $a1 4
addi $t8 $t8 -1

j column_loop

end_column_loop:

mult $t9 $t1
mflo $t4
add $a0 $a0 $t4
addi $t7 $t7 -1

j row_loop

end_row_loop:

#print first matrix:
li $v0 4
la $a0 str_first
syscall 
move $t7 $t0 
la $a1 first

loop_print_row1:

beqz  $t7 end_print_row1
move $t8 $t1

loop_print_column1:

beqz  $t8 end_print_column1
lw $a0 ($a1)
li $v0 1
syscall 

la $a0 blank
li $v0 4
syscall 

addi $a1 $a1 4
addi $t8 $t8 -1

j loop_print_column1

end_print_column1:

la $a0 enter
li $v0 4
syscall 

addi $t7 $t7 -1

j loop_print_row1

end_print_row1:

#print second matrix:
li $v0 4
la $a0 str_second
syscall 
move $t7 $t2 
la $a1 second

loop_print_row2:

beqz  $t7 end_print_row2
move $t8 $t3

loop_print_column2:

beqz  $t8 end_print_column2
lw $a0 ($a1)
li $v0 1
syscall 

la $a0 blank
li $v0 4
syscall 

addi $a1 $a1 4
addi $t8 $t8 -1

j loop_print_column2

end_print_column2:

la $a0 enter
li $v0 4
syscall 

addi $t7 $t7 -1

j loop_print_row2

end_print_row2:

#print result matrix:
li $v0 4 
la $a0 str_result
syscall 
move $t7 $t0 
la $a1 result

loop_print_row3:

beqz  $t7 end_print_row3
move $t8 $t3

loop_print_column3:

beqz  $t8 end_print_column3
lw $a0 ($a1)
li $v0 1
syscall 

la $a0 blank
li $v0 4
syscall
 
addi $a1 $a1 4
addi $t8 $t8 -1

j loop_print_column3

end_print_column3:

la $a0 enter
li $v0 4
syscall 

addi $t7 $t7 -1

j loop_print_row3

end_print_row3:
