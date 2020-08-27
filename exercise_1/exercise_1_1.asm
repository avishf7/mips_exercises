.data
start_data:
1 3 5 0
end_data:

.text
li $v0 0
la $a0 start_data
la $a1 end_data

labal:
lw $t0 0($a0)
sw $t0 0($a1)

beq $t0 $zero end_text

addi $v0 $v0 1
addi $a0 $a0 4
addi $a1 $a1 4
j labal

end_text: