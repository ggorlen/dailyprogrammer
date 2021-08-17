# lettersum("") => 0
# lettersum("a") => 1
# lettersum("z") => 26
# lettersum("cab") => 6
# lettersum("excellent") => 100
# lettersum("microspectrophotometries") => 317

    .data
input: .space 128

    .text
    .globl main
main:
    # get user input string
    li $v0, 8
    la $a0, input
    li $a1, 128
    syscall

    li $t0, 0  # letter sum total
while:
    # break upon reaching newline character "\n"
    lb $t2, ($a0)
    beq $t2, 10, exit
    
    # total += ((char)s[i]) - 97
    addi $t3, $t2, -96
    add $t0, $t0, $t3

    # i++
    addi $a0, $a0, 1
    j while

exit: 
    # print the result integer
    li $v0, 1
    la $a0, ($t0)
    syscall

    li $v0 10
    syscall
