
.globl boo
boo:

pushq %rbp
movq %rsp, %rbp
subq $8, %rsp
movq %rdi, %rax
movq $12, %rcx
addq %rcx, %rax
movq %rax, -8(%rbp)

movq -8(%rbp), %rax
addq $8, %rsp
popq  %rbp
retq

.globl foo
foo:

pushq %rbp
movq %rsp, %rbp
subq $24, %rsp
movq %rdi, %rax
movq $12, %rcx
addq %rcx, %rax
movq %rax, -8(%rbp)

movq $24, %rdi
movq -8(%rbp), %rsi
callq boo
movq %rax, -16(%rbp)

movq -16(%rbp), %rax
movq -8(%rbp), %rcx
subq %rcx, %rax
movq %rax, -24(%rbp)

movq -24(%rbp), %rax
addq $24, %rsp
popq  %rbp
retq
