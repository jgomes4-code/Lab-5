.section .data
Numbers:
    .long 1
    .long 15
    .long 4
    .long 2
    .long 7
    .long 9
    .long 23
    .long 7
    .long 3
    .long 11

Array_length:
    .long 10

fmt:
    .string "Maximum value is %d\n"

.section .text
.globl main
.extern printf

main:
    pushl %ebp
    movl %esp, %ebp

    subl $8, %esp              # local space
                               # -4(%ebp) = i
                               # -8(%ebp) = max

    # max = Numbers[0]
    movl Numbers, %eax
    movl %eax, -8(%ebp)

    # i = 1
    movl $1, -4(%ebp)

while_loop:
    # while (i < Array_length)
    movl -4(%ebp), %eax
    cmpl Array_length, %eax
    jge done_loop

    # load Numbers[i]
    movl -4(%ebp), %eax
    movl Numbers(,%eax,4), %edx

    # if (Numbers[i] > max)
    movl -8(%ebp), %eax
    cmpl %eax, %edx
    jle skip_update

    # max = Numbers[i]
    movl %edx, -8(%ebp)

skip_update:
    # i++
    addl $1, -4(%ebp)
    jmp while_loop

done_loop:
    # printf("Maximum value is %d\n", max);
    pushl -8(%ebp)
    pushl $fmt
    call printf
    addl $8, %esp

    movl $0, %eax
    leave
    ret