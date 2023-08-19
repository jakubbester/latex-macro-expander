
obj/kernel.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000040000 <entry_from_boot>:
# The entry_from_boot routine sets the stack pointer to the top of the
# OS kernel stack, then jumps to the `kernel` routine.

.globl entry_from_boot
entry_from_boot:
        movq $0x80000, %rsp
   40000:	48 c7 c4 00 00 08 00 	mov    $0x80000,%rsp
        movq %rsp, %rbp
   40007:	48 89 e5             	mov    %rsp,%rbp
        pushq $0
   4000a:	6a 00                	push   $0x0
        popfq
   4000c:	9d                   	popf   
        // Check for multiboot command line; if found pass it along.
        cmpl $0x2BADB002, %eax
   4000d:	3d 02 b0 ad 2b       	cmp    $0x2badb002,%eax
        jne 1f
   40012:	75 0d                	jne    40021 <entry_from_boot+0x21>
        testl $4, (%rbx)
   40014:	f7 03 04 00 00 00    	testl  $0x4,(%rbx)
        je 1f
   4001a:	74 05                	je     40021 <entry_from_boot+0x21>
        movl 16(%rbx), %edi
   4001c:	8b 7b 10             	mov    0x10(%rbx),%edi
        jmp 2f
   4001f:	eb 07                	jmp    40028 <entry_from_boot+0x28>
1:      movq $0, %rdi
   40021:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
2:      jmp kernel
   40028:	e9 3a 01 00 00       	jmp    40167 <kernel>
   4002d:	90                   	nop

000000000004002e <gpf_int_handler>:
# Interrupt handlers
.align 2

        .globl gpf_int_handler
gpf_int_handler:
        pushq $13               // trap number
   4002e:	6a 0d                	push   $0xd
        jmp generic_exception_handler
   40030:	eb 6e                	jmp    400a0 <generic_exception_handler>

0000000000040032 <pagefault_int_handler>:

        .globl pagefault_int_handler
pagefault_int_handler:
        pushq $14
   40032:	6a 0e                	push   $0xe
        jmp generic_exception_handler
   40034:	eb 6a                	jmp    400a0 <generic_exception_handler>

0000000000040036 <timer_int_handler>:

        .globl timer_int_handler
timer_int_handler:
        pushq $0                // error code
   40036:	6a 00                	push   $0x0
        pushq $32
   40038:	6a 20                	push   $0x20
        jmp generic_exception_handler
   4003a:	eb 64                	jmp    400a0 <generic_exception_handler>

000000000004003c <sys48_int_handler>:

sys48_int_handler:
        pushq $0
   4003c:	6a 00                	push   $0x0
        pushq $48
   4003e:	6a 30                	push   $0x30
        jmp generic_exception_handler
   40040:	eb 5e                	jmp    400a0 <generic_exception_handler>

0000000000040042 <sys49_int_handler>:

sys49_int_handler:
        pushq $0
   40042:	6a 00                	push   $0x0
        pushq $49
   40044:	6a 31                	push   $0x31
        jmp generic_exception_handler
   40046:	eb 58                	jmp    400a0 <generic_exception_handler>

0000000000040048 <sys50_int_handler>:

sys50_int_handler:
        pushq $0
   40048:	6a 00                	push   $0x0
        pushq $50
   4004a:	6a 32                	push   $0x32
        jmp generic_exception_handler
   4004c:	eb 52                	jmp    400a0 <generic_exception_handler>

000000000004004e <sys51_int_handler>:

sys51_int_handler:
        pushq $0
   4004e:	6a 00                	push   $0x0
        pushq $51
   40050:	6a 33                	push   $0x33
        jmp generic_exception_handler
   40052:	eb 4c                	jmp    400a0 <generic_exception_handler>

0000000000040054 <sys52_int_handler>:

sys52_int_handler:
        pushq $0
   40054:	6a 00                	push   $0x0
        pushq $52
   40056:	6a 34                	push   $0x34
        jmp generic_exception_handler
   40058:	eb 46                	jmp    400a0 <generic_exception_handler>

000000000004005a <sys53_int_handler>:

sys53_int_handler:
        pushq $0
   4005a:	6a 00                	push   $0x0
        pushq $53
   4005c:	6a 35                	push   $0x35
        jmp generic_exception_handler
   4005e:	eb 40                	jmp    400a0 <generic_exception_handler>

0000000000040060 <sys54_int_handler>:

sys54_int_handler:
        pushq $0
   40060:	6a 00                	push   $0x0
        pushq $54
   40062:	6a 36                	push   $0x36
        jmp generic_exception_handler
   40064:	eb 3a                	jmp    400a0 <generic_exception_handler>

0000000000040066 <sys55_int_handler>:

sys55_int_handler:
        pushq $0
   40066:	6a 00                	push   $0x0
        pushq $55
   40068:	6a 37                	push   $0x37
        jmp generic_exception_handler
   4006a:	eb 34                	jmp    400a0 <generic_exception_handler>

000000000004006c <sys56_int_handler>:

sys56_int_handler:
        pushq $0
   4006c:	6a 00                	push   $0x0
        pushq $56
   4006e:	6a 38                	push   $0x38
        jmp generic_exception_handler
   40070:	eb 2e                	jmp    400a0 <generic_exception_handler>

0000000000040072 <sys57_int_handler>:

sys57_int_handler:
        pushq $0
   40072:	6a 00                	push   $0x0
        pushq $57
   40074:	6a 39                	push   $0x39
        jmp generic_exception_handler
   40076:	eb 28                	jmp    400a0 <generic_exception_handler>

0000000000040078 <sys58_int_handler>:

sys58_int_handler:
        pushq $0
   40078:	6a 00                	push   $0x0
        pushq $58
   4007a:	6a 3a                	push   $0x3a
        jmp generic_exception_handler
   4007c:	eb 22                	jmp    400a0 <generic_exception_handler>

000000000004007e <sys59_int_handler>:

sys59_int_handler:
        pushq $0
   4007e:	6a 00                	push   $0x0
        pushq $59
   40080:	6a 3b                	push   $0x3b
        jmp generic_exception_handler
   40082:	eb 1c                	jmp    400a0 <generic_exception_handler>

0000000000040084 <sys60_int_handler>:

sys60_int_handler:
        pushq $0
   40084:	6a 00                	push   $0x0
        pushq $60
   40086:	6a 3c                	push   $0x3c
        jmp generic_exception_handler
   40088:	eb 16                	jmp    400a0 <generic_exception_handler>

000000000004008a <sys61_int_handler>:

sys61_int_handler:
        pushq $0
   4008a:	6a 00                	push   $0x0
        pushq $61
   4008c:	6a 3d                	push   $0x3d
        jmp generic_exception_handler
   4008e:	eb 10                	jmp    400a0 <generic_exception_handler>

0000000000040090 <sys62_int_handler>:

sys62_int_handler:
        pushq $0
   40090:	6a 00                	push   $0x0
        pushq $62
   40092:	6a 3e                	push   $0x3e
        jmp generic_exception_handler
   40094:	eb 0a                	jmp    400a0 <generic_exception_handler>

0000000000040096 <sys63_int_handler>:

sys63_int_handler:
        pushq $0
   40096:	6a 00                	push   $0x0
        pushq $63
   40098:	6a 3f                	push   $0x3f
        jmp generic_exception_handler
   4009a:	eb 04                	jmp    400a0 <generic_exception_handler>

000000000004009c <default_int_handler>:

        .globl default_int_handler
default_int_handler:
        pushq $0
   4009c:	6a 00                	push   $0x0
        jmp generic_exception_handler
   4009e:	eb 00                	jmp    400a0 <generic_exception_handler>

00000000000400a0 <generic_exception_handler>:


generic_exception_handler:
        pushq %gs
   400a0:	0f a8                	push   %gs
        pushq %fs
   400a2:	0f a0                	push   %fs
        pushq %r15
   400a4:	41 57                	push   %r15
        pushq %r14
   400a6:	41 56                	push   %r14
        pushq %r13
   400a8:	41 55                	push   %r13
        pushq %r12
   400aa:	41 54                	push   %r12
        pushq %r11
   400ac:	41 53                	push   %r11
        pushq %r10
   400ae:	41 52                	push   %r10
        pushq %r9
   400b0:	41 51                	push   %r9
        pushq %r8
   400b2:	41 50                	push   %r8
        pushq %rdi
   400b4:	57                   	push   %rdi
        pushq %rsi
   400b5:	56                   	push   %rsi
        pushq %rbp
   400b6:	55                   	push   %rbp
        pushq %rbx
   400b7:	53                   	push   %rbx
        pushq %rdx
   400b8:	52                   	push   %rdx
        pushq %rcx
   400b9:	51                   	push   %rcx
        pushq %rax
   400ba:	50                   	push   %rax
        movq %rsp, %rdi
   400bb:	48 89 e7             	mov    %rsp,%rdi
        call exception
   400be:	e8 74 08 00 00       	call   40937 <exception>

00000000000400c3 <exception_return>:
        # `exception` should never return.


        .globl exception_return
exception_return:
        movq %rdi, %rsp
   400c3:	48 89 fc             	mov    %rdi,%rsp
        popq %rax
   400c6:	58                   	pop    %rax
        popq %rcx
   400c7:	59                   	pop    %rcx
        popq %rdx
   400c8:	5a                   	pop    %rdx
        popq %rbx
   400c9:	5b                   	pop    %rbx
        popq %rbp
   400ca:	5d                   	pop    %rbp
        popq %rsi
   400cb:	5e                   	pop    %rsi
        popq %rdi
   400cc:	5f                   	pop    %rdi
        popq %r8
   400cd:	41 58                	pop    %r8
        popq %r9
   400cf:	41 59                	pop    %r9
        popq %r10
   400d1:	41 5a                	pop    %r10
        popq %r11
   400d3:	41 5b                	pop    %r11
        popq %r12
   400d5:	41 5c                	pop    %r12
        popq %r13
   400d7:	41 5d                	pop    %r13
        popq %r14
   400d9:	41 5e                	pop    %r14
        popq %r15
   400db:	41 5f                	pop    %r15
        popq %fs
   400dd:	0f a1                	pop    %fs
        popq %gs
   400df:	0f a9                	pop    %gs
        addq $16, %rsp
   400e1:	48 83 c4 10          	add    $0x10,%rsp
        iretq
   400e5:	48 cf                	iretq  

00000000000400e7 <sys_int_handlers>:
   400e7:	3c 00                	cmp    $0x0,%al
   400e9:	04 00                	add    $0x0,%al
   400eb:	00 00                	add    %al,(%rax)
   400ed:	00 00                	add    %al,(%rax)
   400ef:	42 00 04 00          	add    %al,(%rax,%r8,1)
   400f3:	00 00                	add    %al,(%rax)
   400f5:	00 00                	add    %al,(%rax)
   400f7:	48 00 04 00          	rex.W add %al,(%rax,%rax,1)
   400fb:	00 00                	add    %al,(%rax)
   400fd:	00 00                	add    %al,(%rax)
   400ff:	4e 00 04 00          	rex.WRX add %r8b,(%rax,%r8,1)
   40103:	00 00                	add    %al,(%rax)
   40105:	00 00                	add    %al,(%rax)
   40107:	54                   	push   %rsp
   40108:	00 04 00             	add    %al,(%rax,%rax,1)
   4010b:	00 00                	add    %al,(%rax)
   4010d:	00 00                	add    %al,(%rax)
   4010f:	5a                   	pop    %rdx
   40110:	00 04 00             	add    %al,(%rax,%rax,1)
   40113:	00 00                	add    %al,(%rax)
   40115:	00 00                	add    %al,(%rax)
   40117:	60                   	(bad)  
   40118:	00 04 00             	add    %al,(%rax,%rax,1)
   4011b:	00 00                	add    %al,(%rax)
   4011d:	00 00                	add    %al,(%rax)
   4011f:	66 00 04 00          	data16 add %al,(%rax,%rax,1)
   40123:	00 00                	add    %al,(%rax)
   40125:	00 00                	add    %al,(%rax)
   40127:	6c                   	insb   (%dx),%es:(%rdi)
   40128:	00 04 00             	add    %al,(%rax,%rax,1)
   4012b:	00 00                	add    %al,(%rax)
   4012d:	00 00                	add    %al,(%rax)
   4012f:	72 00                	jb     40131 <sys_int_handlers+0x4a>
   40131:	04 00                	add    $0x0,%al
   40133:	00 00                	add    %al,(%rax)
   40135:	00 00                	add    %al,(%rax)
   40137:	78 00                	js     40139 <sys_int_handlers+0x52>
   40139:	04 00                	add    $0x0,%al
   4013b:	00 00                	add    %al,(%rax)
   4013d:	00 00                	add    %al,(%rax)
   4013f:	7e 00                	jle    40141 <sys_int_handlers+0x5a>
   40141:	04 00                	add    $0x0,%al
   40143:	00 00                	add    %al,(%rax)
   40145:	00 00                	add    %al,(%rax)
   40147:	84 00                	test   %al,(%rax)
   40149:	04 00                	add    $0x0,%al
   4014b:	00 00                	add    %al,(%rax)
   4014d:	00 00                	add    %al,(%rax)
   4014f:	8a 00                	mov    (%rax),%al
   40151:	04 00                	add    $0x0,%al
   40153:	00 00                	add    %al,(%rax)
   40155:	00 00                	add    %al,(%rax)
   40157:	90                   	nop
   40158:	00 04 00             	add    %al,(%rax,%rax,1)
   4015b:	00 00                	add    %al,(%rax)
   4015d:	00 00                	add    %al,(%rax)
   4015f:	96                   	xchg   %eax,%esi
   40160:	00 04 00             	add    %al,(%rax,%rax,1)
   40163:	00 00                	add    %al,(%rax)
	...

0000000000040167 <kernel>:
//    Initialize the hardware and processes and start running. The `command`
//    string is an optional string passed from the boot loader.

static void process_setup(pid_t pid, int program_number);

void kernel(const char* command) {
   40167:	55                   	push   %rbp
   40168:	48 89 e5             	mov    %rsp,%rbp
   4016b:	48 83 ec 20          	sub    $0x20,%rsp
   4016f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    hardware_init();
   40173:	e8 7b 1b 00 00       	call   41cf3 <hardware_init>
    pageinfo_init();
   40178:	e8 23 12 00 00       	call   413a0 <pageinfo_init>
    console_clear();
   4017d:	e8 9a 3f 00 00       	call   4411c <console_clear>
    timer_init(HZ);
   40182:	bf 64 00 00 00       	mov    $0x64,%edi
   40187:	e8 57 20 00 00       	call   421e3 <timer_init>

    // Set up process descriptors
    memset(processes, 0, sizeof(processes));
   4018c:	ba 00 0e 00 00       	mov    $0xe00,%edx
   40191:	be 00 00 00 00       	mov    $0x0,%esi
   40196:	bf 20 e0 04 00       	mov    $0x4e020,%edi
   4019b:	e8 93 36 00 00       	call   43833 <memset>
    for (pid_t i = 0; i < NPROC; i++) {
   401a0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   401a7:	eb 44                	jmp    401ed <kernel+0x86>
        processes[i].p_pid = i;
   401a9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401ac:	48 63 d0             	movslq %eax,%rdx
   401af:	48 89 d0             	mov    %rdx,%rax
   401b2:	48 c1 e0 03          	shl    $0x3,%rax
   401b6:	48 29 d0             	sub    %rdx,%rax
   401b9:	48 c1 e0 05          	shl    $0x5,%rax
   401bd:	48 8d 90 20 e0 04 00 	lea    0x4e020(%rax),%rdx
   401c4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401c7:	89 02                	mov    %eax,(%rdx)
        processes[i].p_state = P_FREE;
   401c9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401cc:	48 63 d0             	movslq %eax,%rdx
   401cf:	48 89 d0             	mov    %rdx,%rax
   401d2:	48 c1 e0 03          	shl    $0x3,%rax
   401d6:	48 29 d0             	sub    %rdx,%rax
   401d9:	48 c1 e0 05          	shl    $0x5,%rax
   401dd:	48 05 e8 e0 04 00    	add    $0x4e0e8,%rax
   401e3:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
    for (pid_t i = 0; i < NPROC; i++) {
   401e9:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   401ed:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   401f1:	7e b6                	jle    401a9 <kernel+0x42>
    }   

    if (command && strcmp(command, "fork") == 0) {
   401f3:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   401f8:	74 29                	je     40223 <kernel+0xbc>
   401fa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   401fe:	be 40 41 04 00       	mov    $0x44140,%esi
   40203:	48 89 c7             	mov    %rax,%rdi
   40206:	e8 99 36 00 00       	call   438a4 <strcmp>
   4020b:	85 c0                	test   %eax,%eax
   4020d:	75 14                	jne    40223 <kernel+0xbc>
        process_setup(1, 4);
   4020f:	be 04 00 00 00       	mov    $0x4,%esi
   40214:	bf 01 00 00 00       	mov    $0x1,%edi
   40219:	e8 cf 01 00 00       	call   403ed <process_setup>
   4021e:	e9 c2 00 00 00       	jmp    402e5 <kernel+0x17e>
    } else if (command && strcmp(command, "forkexit") == 0) {
   40223:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40228:	74 29                	je     40253 <kernel+0xec>
   4022a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4022e:	be 45 41 04 00       	mov    $0x44145,%esi
   40233:	48 89 c7             	mov    %rax,%rdi
   40236:	e8 69 36 00 00       	call   438a4 <strcmp>
   4023b:	85 c0                	test   %eax,%eax
   4023d:	75 14                	jne    40253 <kernel+0xec>
        process_setup(1, 5);
   4023f:	be 05 00 00 00       	mov    $0x5,%esi
   40244:	bf 01 00 00 00       	mov    $0x1,%edi
   40249:	e8 9f 01 00 00       	call   403ed <process_setup>
   4024e:	e9 92 00 00 00       	jmp    402e5 <kernel+0x17e>
    } else if (command && strcmp(command, "test") == 0) {
   40253:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40258:	74 26                	je     40280 <kernel+0x119>
   4025a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4025e:	be 4e 41 04 00       	mov    $0x4414e,%esi
   40263:	48 89 c7             	mov    %rax,%rdi
   40266:	e8 39 36 00 00       	call   438a4 <strcmp>
   4026b:	85 c0                	test   %eax,%eax
   4026d:	75 11                	jne    40280 <kernel+0x119>
        process_setup(1, 6);
   4026f:	be 06 00 00 00       	mov    $0x6,%esi
   40274:	bf 01 00 00 00       	mov    $0x1,%edi
   40279:	e8 6f 01 00 00       	call   403ed <process_setup>
   4027e:	eb 65                	jmp    402e5 <kernel+0x17e>
    } else if (command && strcmp(command, "test2") == 0) {
   40280:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40285:	74 39                	je     402c0 <kernel+0x159>
   40287:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4028b:	be 53 41 04 00       	mov    $0x44153,%esi
   40290:	48 89 c7             	mov    %rax,%rdi
   40293:	e8 0c 36 00 00       	call   438a4 <strcmp>
   40298:	85 c0                	test   %eax,%eax
   4029a:	75 24                	jne    402c0 <kernel+0x159>
        for (pid_t i = 1; i <= 2; ++i) {
   4029c:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
   402a3:	eb 13                	jmp    402b8 <kernel+0x151>
            process_setup(i, 6);
   402a5:	8b 45 f8             	mov    -0x8(%rbp),%eax
   402a8:	be 06 00 00 00       	mov    $0x6,%esi
   402ad:	89 c7                	mov    %eax,%edi
   402af:	e8 39 01 00 00       	call   403ed <process_setup>
        for (pid_t i = 1; i <= 2; ++i) {
   402b4:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   402b8:	83 7d f8 02          	cmpl   $0x2,-0x8(%rbp)
   402bc:	7e e7                	jle    402a5 <kernel+0x13e>
   402be:	eb 25                	jmp    402e5 <kernel+0x17e>
        }
    } else {
        for (pid_t i = 1; i <= 4; ++i) {
   402c0:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%rbp)
   402c7:	eb 16                	jmp    402df <kernel+0x178>
            process_setup(i, i - 1);
   402c9:	8b 45 f4             	mov    -0xc(%rbp),%eax
   402cc:	8d 50 ff             	lea    -0x1(%rax),%edx
   402cf:	8b 45 f4             	mov    -0xc(%rbp),%eax
   402d2:	89 d6                	mov    %edx,%esi
   402d4:	89 c7                	mov    %eax,%edi
   402d6:	e8 12 01 00 00       	call   403ed <process_setup>
        for (pid_t i = 1; i <= 4; ++i) {
   402db:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   402df:	83 7d f4 04          	cmpl   $0x4,-0xc(%rbp)
   402e3:	7e e4                	jle    402c9 <kernel+0x162>
        }
    }

    // Set proper `perms` for memory of each process
    for (pid_t i = 0; i < NPROC; i++) {
   402e5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
   402ec:	e9 9c 00 00 00       	jmp    4038d <kernel+0x226>
        if (processes[i].p_state == P_RUNNABLE) {
   402f1:	8b 45 f0             	mov    -0x10(%rbp),%eax
   402f4:	48 63 d0             	movslq %eax,%rdx
   402f7:	48 89 d0             	mov    %rdx,%rax
   402fa:	48 c1 e0 03          	shl    $0x3,%rax
   402fe:	48 29 d0             	sub    %rdx,%rax
   40301:	48 c1 e0 05          	shl    $0x5,%rax
   40305:	48 05 e8 e0 04 00    	add    $0x4e0e8,%rax
   4030b:	8b 00                	mov    (%rax),%eax
   4030d:	83 f8 01             	cmp    $0x1,%eax
   40310:	75 77                	jne    40389 <kernel+0x222>
            virtual_memory_map(processes[i].p_pagetable, 0, 0, PROC_START_ADDR,
   40312:	8b 45 f0             	mov    -0x10(%rbp),%eax
   40315:	48 63 d0             	movslq %eax,%rdx
   40318:	48 89 d0             	mov    %rdx,%rax
   4031b:	48 c1 e0 03          	shl    $0x3,%rax
   4031f:	48 29 d0             	sub    %rdx,%rax
   40322:	48 c1 e0 05          	shl    $0x5,%rax
   40326:	48 05 f0 e0 04 00    	add    $0x4e0f0,%rax
   4032c:	48 8b 00             	mov    (%rax),%rax
   4032f:	41 b8 03 00 00 00    	mov    $0x3,%r8d
   40335:	b9 00 00 10 00       	mov    $0x100000,%ecx
   4033a:	ba 00 00 00 00       	mov    $0x0,%edx
   4033f:	be 00 00 00 00       	mov    $0x0,%esi
   40344:	48 89 c7             	mov    %rax,%rdi
   40347:	e8 e5 2b 00 00       	call   42f31 <virtual_memory_map>
                            PTE_P | PTE_W);
            virtual_memory_map(processes[i].p_pagetable, CONSOLE_ADDR, CONSOLE_ADDR,
   4034c:	bf 00 80 0b 00       	mov    $0xb8000,%edi
   40351:	be 00 80 0b 00       	mov    $0xb8000,%esi
   40356:	8b 45 f0             	mov    -0x10(%rbp),%eax
   40359:	48 63 d0             	movslq %eax,%rdx
   4035c:	48 89 d0             	mov    %rdx,%rax
   4035f:	48 c1 e0 03          	shl    $0x3,%rax
   40363:	48 29 d0             	sub    %rdx,%rax
   40366:	48 c1 e0 05          	shl    $0x5,%rax
   4036a:	48 05 f0 e0 04 00    	add    $0x4e0f0,%rax
   40370:	48 8b 00             	mov    (%rax),%rax
   40373:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   40379:	b9 00 10 00 00       	mov    $0x1000,%ecx
   4037e:	48 89 fa             	mov    %rdi,%rdx
   40381:	48 89 c7             	mov    %rax,%rdi
   40384:	e8 a8 2b 00 00       	call   42f31 <virtual_memory_map>
    for (pid_t i = 0; i < NPROC; i++) {
   40389:	83 45 f0 01          	addl   $0x1,-0x10(%rbp)
   4038d:	83 7d f0 0f          	cmpl   $0xf,-0x10(%rbp)
   40391:	0f 8e 5a ff ff ff    	jle    402f1 <kernel+0x18a>
                            PAGESIZE, PTE_P | PTE_W | PTE_U);
        }
    }

    // Switch to the first process using run()
    run(&processes[1]);
   40397:	bf 00 e1 04 00       	mov    $0x4e100,%edi
   4039c:	e8 a2 0f 00 00       	call   41343 <run>

00000000000403a1 <find_free_page>:
// find_free_page()
//    Iterates through the pageinfo data structure and finds a free page.
//    It returns the index of this page, and if it does not find a free page,
//    it will return the value of -1 to the user.

int find_free_page() {
   403a1:	55                   	push   %rbp
   403a2:	48 89 e5             	mov    %rsp,%rbp
   403a5:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 0; i < PAGENUMBER(MEMSIZE_PHYSICAL); i++) {
   403a9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   403b0:	eb 2b                	jmp    403dd <find_free_page+0x3c>
        if (pageinfo[i].owner == 0 && pageinfo[i].refcount == 0) {
   403b2:	8b 45 fc             	mov    -0x4(%rbp),%eax
   403b5:	48 98                	cltq   
   403b7:	0f b6 84 00 40 ee 04 	movzbl 0x4ee40(%rax,%rax,1),%eax
   403be:	00 
   403bf:	84 c0                	test   %al,%al
   403c1:	75 16                	jne    403d9 <find_free_page+0x38>
   403c3:	8b 45 fc             	mov    -0x4(%rbp),%eax
   403c6:	48 98                	cltq   
   403c8:	0f b6 84 00 41 ee 04 	movzbl 0x4ee41(%rax,%rax,1),%eax
   403cf:	00 
   403d0:	84 c0                	test   %al,%al
   403d2:	75 05                	jne    403d9 <find_free_page+0x38>
            return i;
   403d4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   403d7:	eb 12                	jmp    403eb <find_free_page+0x4a>
    for (int i = 0; i < PAGENUMBER(MEMSIZE_PHYSICAL); i++) {
   403d9:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   403dd:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   403e4:	7e cc                	jle    403b2 <find_free_page+0x11>
        }
    }
    return -1;
   403e6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   403eb:	c9                   	leave  
   403ec:	c3                   	ret    

00000000000403ed <process_setup>:
// process_setup(pid, program_number)
//    Load application program `program_number` as process number `pid`.
//    This loads the application's code and data into memory, sets its
//    %rip and %rsp, gives it a stack page, and marks it as runnable.

void process_setup(pid_t pid, int program_number) {
   403ed:	55                   	push   %rbp
   403ee:	48 89 e5             	mov    %rsp,%rbp
   403f1:	48 83 ec 50          	sub    $0x50,%rsp
   403f5:	89 7d bc             	mov    %edi,-0x44(%rbp)
   403f8:	89 75 b8             	mov    %esi,-0x48(%rbp)
    process_init(&processes[pid], 0);
   403fb:	8b 45 bc             	mov    -0x44(%rbp),%eax
   403fe:	48 63 d0             	movslq %eax,%rdx
   40401:	48 89 d0             	mov    %rdx,%rax
   40404:	48 c1 e0 03          	shl    $0x3,%rax
   40408:	48 29 d0             	sub    %rdx,%rax
   4040b:	48 c1 e0 05          	shl    $0x5,%rax
   4040f:	48 05 20 e0 04 00    	add    $0x4e020,%rax
   40415:	be 00 00 00 00       	mov    $0x0,%esi
   4041a:	48 89 c7             	mov    %rax,%rdi
   4041d:	e8 53 20 00 00       	call   42475 <process_init>
    // Isolate address spaces by creating separate pagetables
    x86_64_pagetable *p_pagetables[5];

    // Iterate through and reserve space for the separate pagetables
    int index;
    for (int j = 0; j < 5; j++) {
   40422:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   40429:	eb 7c                	jmp    404a7 <process_setup+0xba>
        index = find_free_page();
   4042b:	b8 00 00 00 00       	mov    $0x0,%eax
   40430:	e8 6c ff ff ff       	call   403a1 <find_free_page>
   40435:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (index == -1) {
   40438:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%rbp)
   4043c:	75 19                	jne    40457 <process_setup+0x6a>
            console_printf(CPOS(24, 0), 0x0C00, "Out of physical memory!");
   4043e:	ba 59 41 04 00       	mov    $0x44159,%edx
   40443:	be 00 0c 00 00       	mov    $0xc00,%esi
   40448:	bf 80 07 00 00       	mov    $0x780,%edi
   4044d:	b8 00 00 00 00       	mov    $0x0,%eax
   40452:	e8 11 3c 00 00       	call   44068 <console_printf>
        }
        p_pagetables[j] = (x86_64_pagetable *)PAGEADDRESS(index);
   40457:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4045a:	48 98                	cltq   
   4045c:	48 c1 e0 0c          	shl    $0xc,%rax
   40460:	48 89 c2             	mov    %rax,%rdx
   40463:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40466:	48 98                	cltq   
   40468:	48 89 54 c5 c8       	mov    %rdx,-0x38(%rbp,%rax,8)
        memset(p_pagetables[j], 0, sizeof(x86_64_pagetable));
   4046d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40470:	48 98                	cltq   
   40472:	48 8b 44 c5 c8       	mov    -0x38(%rbp,%rax,8),%rax
   40477:	ba 00 10 00 00       	mov    $0x1000,%edx
   4047c:	be 00 00 00 00       	mov    $0x0,%esi
   40481:	48 89 c7             	mov    %rax,%rdi
   40484:	e8 aa 33 00 00       	call   43833 <memset>
        assign_physical_page(PAGEADDRESS(index), pid);
   40489:	8b 45 bc             	mov    -0x44(%rbp),%eax
   4048c:	0f be c0             	movsbl %al,%eax
   4048f:	8b 55 f4             	mov    -0xc(%rbp),%edx
   40492:	48 63 d2             	movslq %edx,%rdx
   40495:	48 c1 e2 0c          	shl    $0xc,%rdx
   40499:	89 c6                	mov    %eax,%esi
   4049b:	48 89 d7             	mov    %rdx,%rdi
   4049e:	e8 04 02 00 00       	call   406a7 <assign_physical_page>
    for (int j = 0; j < 5; j++) {
   404a3:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   404a7:	83 7d fc 04          	cmpl   $0x4,-0x4(%rbp)
   404ab:	0f 8e 7a ff ff ff    	jle    4042b <process_setup+0x3e>
    }

    // Connect the pagetable pages togethers
    p_pagetables[0]->entry[0] =
        (x86_64_pageentry_t) p_pagetables[1] | PTE_P | PTE_W | PTE_U;
   404b1:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   404b5:	48 89 c2             	mov    %rax,%rdx
    p_pagetables[0]->entry[0] =
   404b8:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
        (x86_64_pageentry_t) p_pagetables[1] | PTE_P | PTE_W | PTE_U;
   404bc:	48 83 ca 07          	or     $0x7,%rdx
    p_pagetables[0]->entry[0] =
   404c0:	48 89 10             	mov    %rdx,(%rax)
    p_pagetables[1]->entry[0] =
        (x86_64_pageentry_t) p_pagetables[2] | PTE_P | PTE_W | PTE_U;
   404c3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   404c7:	48 89 c2             	mov    %rax,%rdx
    p_pagetables[1]->entry[0] =
   404ca:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
        (x86_64_pageentry_t) p_pagetables[2] | PTE_P | PTE_W | PTE_U;
   404ce:	48 83 ca 07          	or     $0x7,%rdx
    p_pagetables[1]->entry[0] =
   404d2:	48 89 10             	mov    %rdx,(%rax)
    p_pagetables[2]->entry[0] =
        (x86_64_pageentry_t) p_pagetables[3] | PTE_P | PTE_W | PTE_U;
   404d5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   404d9:	48 89 c2             	mov    %rax,%rdx
    p_pagetables[2]->entry[0] =
   404dc:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
        (x86_64_pageentry_t) p_pagetables[3] | PTE_P | PTE_W | PTE_U;
   404e0:	48 83 ca 07          	or     $0x7,%rdx
    p_pagetables[2]->entry[0] =
   404e4:	48 89 10             	mov    %rdx,(%rax)
    p_pagetables[2]->entry[1] =
        (x86_64_pageentry_t) p_pagetables[4] | PTE_P | PTE_W | PTE_U;
   404e7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   404eb:	48 89 c2             	mov    %rax,%rdx
    p_pagetables[2]->entry[1] =
   404ee:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
        (x86_64_pageentry_t) p_pagetables[4] | PTE_P | PTE_W | PTE_U;
   404f2:	48 83 ca 07          	or     $0x7,%rdx
    p_pagetables[2]->entry[1] =
   404f6:	48 89 50 08          	mov    %rdx,0x8(%rax)

    // Reassign process pagetable from the original kernel table
    processes[pid].p_pagetable = p_pagetables[0];
   404fa:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   404fe:	8b 45 bc             	mov    -0x44(%rbp),%eax
   40501:	48 63 c8             	movslq %eax,%rcx
   40504:	48 89 c8             	mov    %rcx,%rax
   40507:	48 c1 e0 03          	shl    $0x3,%rax
   4050b:	48 29 c8             	sub    %rcx,%rax
   4050e:	48 c1 e0 05          	shl    $0x5,%rax
   40512:	48 05 f0 e0 04 00    	add    $0x4e0f0,%rax
   40518:	48 89 10             	mov    %rdx,(%rax)

    // Identity map the process' pagetable to everything before PROC_START_ADDR
    virtual_memory_map(processes[pid].p_pagetable, 0, 0, PROC_START_ADDR,
   4051b:	8b 45 bc             	mov    -0x44(%rbp),%eax
   4051e:	48 63 d0             	movslq %eax,%rdx
   40521:	48 89 d0             	mov    %rdx,%rax
   40524:	48 c1 e0 03          	shl    $0x3,%rax
   40528:	48 29 d0             	sub    %rdx,%rax
   4052b:	48 c1 e0 05          	shl    $0x5,%rax
   4052f:	48 05 f0 e0 04 00    	add    $0x4e0f0,%rax
   40535:	48 8b 00             	mov    (%rax),%rax
   40538:	41 b8 03 00 00 00    	mov    $0x3,%r8d
   4053e:	b9 00 00 10 00       	mov    $0x100000,%ecx
   40543:	ba 00 00 00 00       	mov    $0x0,%edx
   40548:	be 00 00 00 00       	mov    $0x0,%esi
   4054d:	48 89 c7             	mov    %rax,%rdi
   40550:	e8 dc 29 00 00       	call   42f31 <virtual_memory_map>
                       PTE_P | PTE_W);
    virtual_memory_map(processes[pid].p_pagetable, CONSOLE_ADDR, CONSOLE_ADDR,
   40555:	bf 00 80 0b 00       	mov    $0xb8000,%edi
   4055a:	be 00 80 0b 00       	mov    $0xb8000,%esi
   4055f:	8b 45 bc             	mov    -0x44(%rbp),%eax
   40562:	48 63 d0             	movslq %eax,%rdx
   40565:	48 89 d0             	mov    %rdx,%rax
   40568:	48 c1 e0 03          	shl    $0x3,%rax
   4056c:	48 29 d0             	sub    %rdx,%rax
   4056f:	48 c1 e0 05          	shl    $0x5,%rax
   40573:	48 05 f0 e0 04 00    	add    $0x4e0f0,%rax
   40579:	48 8b 00             	mov    (%rax),%rax
   4057c:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   40582:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40587:	48 89 fa             	mov    %rdi,%rdx
   4058a:	48 89 c7             	mov    %rax,%rdi
   4058d:	e8 9f 29 00 00       	call   42f31 <virtual_memory_map>
                       PAGESIZE, PTE_P | PTE_W | PTE_U);
    
    // Load in the program and check that it loads correctly
    int r = program_load(&processes[pid], program_number, NULL);
   40592:	8b 45 bc             	mov    -0x44(%rbp),%eax
   40595:	48 63 d0             	movslq %eax,%rdx
   40598:	48 89 d0             	mov    %rdx,%rax
   4059b:	48 c1 e0 03          	shl    $0x3,%rax
   4059f:	48 29 d0             	sub    %rdx,%rax
   405a2:	48 c1 e0 05          	shl    $0x5,%rax
   405a6:	48 8d 88 20 e0 04 00 	lea    0x4e020(%rax),%rcx
   405ad:	8b 45 b8             	mov    -0x48(%rbp),%eax
   405b0:	ba 00 00 00 00       	mov    $0x0,%edx
   405b5:	89 c6                	mov    %eax,%esi
   405b7:	48 89 cf             	mov    %rcx,%rdi
   405ba:	e8 24 2e 00 00       	call   433e3 <program_load>
   405bf:	89 45 f8             	mov    %eax,-0x8(%rbp)
    assert(r >= 0);
   405c2:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
   405c6:	79 14                	jns    405dc <process_setup+0x1ef>
   405c8:	ba 71 41 04 00       	mov    $0x44171,%edx
   405cd:	be bb 00 00 00       	mov    $0xbb,%esi
   405d2:	bf 78 41 04 00       	mov    $0x44178,%edi
   405d7:	e8 56 26 00 00       	call   42c32 <assert_fail>

    // Find the index and load in the page
    processes[pid].p_registers.reg_rsp = MEMSIZE_VIRTUAL;
   405dc:	8b 45 bc             	mov    -0x44(%rbp),%eax
   405df:	48 63 d0             	movslq %eax,%rdx
   405e2:	48 89 d0             	mov    %rdx,%rax
   405e5:	48 c1 e0 03          	shl    $0x3,%rax
   405e9:	48 29 d0             	sub    %rdx,%rax
   405ec:	48 c1 e0 05          	shl    $0x5,%rax
   405f0:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   405f6:	48 c7 00 00 00 30 00 	movq   $0x300000,(%rax)
    index = find_free_page();
   405fd:	b8 00 00 00 00       	mov    $0x0,%eax
   40602:	e8 9a fd ff ff       	call   403a1 <find_free_page>
   40607:	89 45 f4             	mov    %eax,-0xc(%rbp)
    if (index == -1) {
   4060a:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%rbp)
   4060e:	75 19                	jne    40629 <process_setup+0x23c>
        console_printf(CPOS(24, 0), 0x0C00, "Out of physical memory!");
   40610:	ba 59 41 04 00       	mov    $0x44159,%edx
   40615:	be 00 0c 00 00       	mov    $0xc00,%esi
   4061a:	bf 80 07 00 00       	mov    $0x780,%edi
   4061f:	b8 00 00 00 00       	mov    $0x0,%eax
   40624:	e8 3f 3a 00 00       	call   44068 <console_printf>
    }
    assign_physical_page(PAGEADDRESS(index), pid);
   40629:	8b 45 bc             	mov    -0x44(%rbp),%eax
   4062c:	0f be c0             	movsbl %al,%eax
   4062f:	8b 55 f4             	mov    -0xc(%rbp),%edx
   40632:	48 63 d2             	movslq %edx,%rdx
   40635:	48 c1 e2 0c          	shl    $0xc,%rdx
   40639:	89 c6                	mov    %eax,%esi
   4063b:	48 89 d7             	mov    %rdx,%rdi
   4063e:	e8 64 00 00 00       	call   406a7 <assign_physical_page>
    virtual_memory_map(processes[pid].p_pagetable, MEMSIZE_VIRTUAL - PAGESIZE,
                       PAGEADDRESS(index), PAGESIZE, PTE_P | PTE_W | PTE_U);
   40643:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40646:	48 98                	cltq   
    virtual_memory_map(processes[pid].p_pagetable, MEMSIZE_VIRTUAL - PAGESIZE,
   40648:	48 c1 e0 0c          	shl    $0xc,%rax
   4064c:	48 89 c2             	mov    %rax,%rdx
   4064f:	8b 45 bc             	mov    -0x44(%rbp),%eax
   40652:	48 63 c8             	movslq %eax,%rcx
   40655:	48 89 c8             	mov    %rcx,%rax
   40658:	48 c1 e0 03          	shl    $0x3,%rax
   4065c:	48 29 c8             	sub    %rcx,%rax
   4065f:	48 c1 e0 05          	shl    $0x5,%rax
   40663:	48 05 f0 e0 04 00    	add    $0x4e0f0,%rax
   40669:	48 8b 00             	mov    (%rax),%rax
   4066c:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   40672:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40677:	be 00 f0 2f 00       	mov    $0x2ff000,%esi
   4067c:	48 89 c7             	mov    %rax,%rdi
   4067f:	e8 ad 28 00 00       	call   42f31 <virtual_memory_map>
    processes[pid].p_state = P_RUNNABLE;
   40684:	8b 45 bc             	mov    -0x44(%rbp),%eax
   40687:	48 63 d0             	movslq %eax,%rdx
   4068a:	48 89 d0             	mov    %rdx,%rax
   4068d:	48 c1 e0 03          	shl    $0x3,%rax
   40691:	48 29 d0             	sub    %rdx,%rax
   40694:	48 c1 e0 05          	shl    $0x5,%rax
   40698:	48 05 e8 e0 04 00    	add    $0x4e0e8,%rax
   4069e:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
}
   406a4:	90                   	nop
   406a5:	c9                   	leave  
   406a6:	c3                   	ret    

00000000000406a7 <assign_physical_page>:
// assign_physical_page(addr, owner)
//    Allocates the page with physical address `addr` to the given owner.
//    Fails if physical page `addr` was already allocated. Returns 0 on
//    success and -1 on failure. Used by the program loader.

int assign_physical_page(uintptr_t addr, int8_t owner) {
   406a7:	55                   	push   %rbp
   406a8:	48 89 e5             	mov    %rsp,%rbp
   406ab:	48 83 ec 10          	sub    $0x10,%rsp
   406af:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   406b3:	89 f0                	mov    %esi,%eax
   406b5:	88 45 f4             	mov    %al,-0xc(%rbp)
    if ((addr & 0xFFF) != 0
   406b8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   406bc:	25 ff 0f 00 00       	and    $0xfff,%eax
   406c1:	48 85 c0             	test   %rax,%rax
   406c4:	75 20                	jne    406e6 <assign_physical_page+0x3f>
        || addr >= MEMSIZE_PHYSICAL
   406c6:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   406cd:	00 
   406ce:	77 16                	ja     406e6 <assign_physical_page+0x3f>
        || pageinfo[PAGENUMBER(addr)].refcount != 0) {
   406d0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   406d4:	48 c1 e8 0c          	shr    $0xc,%rax
   406d8:	48 98                	cltq   
   406da:	0f b6 84 00 41 ee 04 	movzbl 0x4ee41(%rax,%rax,1),%eax
   406e1:	00 
   406e2:	84 c0                	test   %al,%al
   406e4:	74 07                	je     406ed <assign_physical_page+0x46>
        return -1;
   406e6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   406eb:	eb 2c                	jmp    40719 <assign_physical_page+0x72>
    } else {
        pageinfo[PAGENUMBER(addr)].refcount = 1;
   406ed:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   406f1:	48 c1 e8 0c          	shr    $0xc,%rax
   406f5:	48 98                	cltq   
   406f7:	c6 84 00 41 ee 04 00 	movb   $0x1,0x4ee41(%rax,%rax,1)
   406fe:	01 
        pageinfo[PAGENUMBER(addr)].owner = owner;
   406ff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40703:	48 c1 e8 0c          	shr    $0xc,%rax
   40707:	48 98                	cltq   
   40709:	0f b6 55 f4          	movzbl -0xc(%rbp),%edx
   4070d:	88 94 00 40 ee 04 00 	mov    %dl,0x4ee40(%rax,%rax,1)
        return 0;
   40714:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   40719:	c9                   	leave  
   4071a:	c3                   	ret    

000000000004071b <syscall_mapping>:


void syscall_mapping(proc* p) {
   4071b:	55                   	push   %rbp
   4071c:	48 89 e5             	mov    %rsp,%rbp
   4071f:	48 83 ec 70          	sub    $0x70,%rsp
   40723:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)

    uintptr_t mapping_ptr = p->p_registers.reg_rdi;
   40727:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4072b:	48 8b 40 38          	mov    0x38(%rax),%rax
   4072f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    uintptr_t ptr = p->p_registers.reg_rsi;
   40733:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40737:	48 8b 40 30          	mov    0x30(%rax),%rax
   4073b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

    // convert to physical address so kernel can write to it
    vamapping map = virtual_memory_lookup(p->p_pagetable, mapping_ptr);
   4073f:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40743:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   4074a:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4074e:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40752:	48 89 ce             	mov    %rcx,%rsi
   40755:	48 89 c7             	mov    %rax,%rdi
   40758:	e8 8f 2b 00 00       	call   432ec <virtual_memory_lookup>

    // check for write access
    if((map.perm & (PTE_W|PTE_U)) != (PTE_W|PTE_U))
   4075d:	8b 45 e0             	mov    -0x20(%rbp),%eax
   40760:	48 98                	cltq   
   40762:	83 e0 06             	and    $0x6,%eax
   40765:	48 83 f8 06          	cmp    $0x6,%rax
   40769:	75 73                	jne    407de <syscall_mapping+0xc3>
	return;
    uintptr_t endaddr = map.pa + sizeof(vamapping) - 1;
   4076b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4076f:	48 83 c0 17          	add    $0x17,%rax
   40773:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    // check for write access for end address
    vamapping end_map = virtual_memory_lookup(p->p_pagetable, endaddr);
   40777:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4077b:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40782:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   40786:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   4078a:	48 89 ce             	mov    %rcx,%rsi
   4078d:	48 89 c7             	mov    %rax,%rdi
   40790:	e8 57 2b 00 00       	call   432ec <virtual_memory_lookup>
    if((end_map.perm & (PTE_W|PTE_P)) != (PTE_W|PTE_P))
   40795:	8b 45 c8             	mov    -0x38(%rbp),%eax
   40798:	48 98                	cltq   
   4079a:	83 e0 03             	and    $0x3,%eax
   4079d:	48 83 f8 03          	cmp    $0x3,%rax
   407a1:	75 3e                	jne    407e1 <syscall_mapping+0xc6>
	return;
    // find the actual mapping now
    vamapping ptr_lookup = virtual_memory_lookup(p->p_pagetable, ptr);
   407a3:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   407a7:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   407ae:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   407b2:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   407b6:	48 89 ce             	mov    %rcx,%rsi
   407b9:	48 89 c7             	mov    %rax,%rdi
   407bc:	e8 2b 2b 00 00       	call   432ec <virtual_memory_lookup>
    memcpy((void *)map.pa, &ptr_lookup, sizeof(vamapping));
   407c1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   407c5:	48 89 c1             	mov    %rax,%rcx
   407c8:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   407cc:	ba 18 00 00 00       	mov    $0x18,%edx
   407d1:	48 89 c6             	mov    %rax,%rsi
   407d4:	48 89 cf             	mov    %rcx,%rdi
   407d7:	e8 ee 2f 00 00       	call   437ca <memcpy>
   407dc:	eb 04                	jmp    407e2 <syscall_mapping+0xc7>
	return;
   407de:	90                   	nop
   407df:	eb 01                	jmp    407e2 <syscall_mapping+0xc7>
	return;
   407e1:	90                   	nop
}
   407e2:	c9                   	leave  
   407e3:	c3                   	ret    

00000000000407e4 <syscall_mem_tog>:


void syscall_mem_tog(proc* process){ 
   407e4:	55                   	push   %rbp
   407e5:	48 89 e5             	mov    %rsp,%rbp
   407e8:	48 83 ec 18          	sub    $0x18,%rsp
   407ec:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)

    pid_t p = process->p_registers.reg_rdi;
   407f0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   407f4:	48 8b 40 38          	mov    0x38(%rax),%rax
   407f8:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if(p == 0) {
   407fb:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   407ff:	75 14                	jne    40815 <syscall_mem_tog+0x31>
        disp_global = !disp_global;
   40801:	0f b6 05 f8 47 00 00 	movzbl 0x47f8(%rip),%eax        # 45000 <disp_global>
   40808:	84 c0                	test   %al,%al
   4080a:	0f 94 c0             	sete   %al
   4080d:	88 05 ed 47 00 00    	mov    %al,0x47ed(%rip)        # 45000 <disp_global>
   40813:	eb 36                	jmp    4084b <syscall_mem_tog+0x67>
    }
    else {
        if(p < 0 || p > NPROC || p != process->p_pid)
   40815:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   40819:	78 2f                	js     4084a <syscall_mem_tog+0x66>
   4081b:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
   4081f:	7f 29                	jg     4084a <syscall_mem_tog+0x66>
   40821:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40825:	8b 00                	mov    (%rax),%eax
   40827:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   4082a:	75 1e                	jne    4084a <syscall_mem_tog+0x66>
            return;
        process->display_status = !(process->display_status);
   4082c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40830:	0f b6 80 d8 00 00 00 	movzbl 0xd8(%rax),%eax
   40837:	84 c0                	test   %al,%al
   40839:	0f 94 c0             	sete   %al
   4083c:	89 c2                	mov    %eax,%edx
   4083e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40842:	88 90 d8 00 00 00    	mov    %dl,0xd8(%rax)
   40848:	eb 01                	jmp    4084b <syscall_mem_tog+0x67>
            return;
   4084a:	90                   	nop
    }
}
   4084b:	c9                   	leave  
   4084c:	c3                   	ret    

000000000004084d <find_free_process>:
// find_free_process()
//    Iterates through the process data structure and finds a free process.
//    It returns the index of this process, and if it does not find a free
//    process, it will return the value of -1 to the user.

int find_free_process() {
   4084d:	55                   	push   %rbp
   4084e:	48 89 e5             	mov    %rsp,%rbp
   40851:	48 83 ec 10          	sub    $0x10,%rsp
    for (int i = 1; i < NPROC; i++) {
   40855:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
   4085c:	eb 29                	jmp    40887 <find_free_process+0x3a>
        if (processes[i].p_state == P_FREE) {
   4085e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40861:	48 63 d0             	movslq %eax,%rdx
   40864:	48 89 d0             	mov    %rdx,%rax
   40867:	48 c1 e0 03          	shl    $0x3,%rax
   4086b:	48 29 d0             	sub    %rdx,%rax
   4086e:	48 c1 e0 05          	shl    $0x5,%rax
   40872:	48 05 e8 e0 04 00    	add    $0x4e0e8,%rax
   40878:	8b 00                	mov    (%rax),%eax
   4087a:	85 c0                	test   %eax,%eax
   4087c:	75 05                	jne    40883 <find_free_process+0x36>
            return i;
   4087e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40881:	eb 0f                	jmp    40892 <find_free_process+0x45>
    for (int i = 1; i < NPROC; i++) {
   40883:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   40887:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   4088b:	7e d1                	jle    4085e <find_free_process+0x11>
        }
    }
    return -1;
   4088d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   40892:	c9                   	leave  
   40893:	c3                   	ret    

0000000000040894 <free_process>:

// free_process()
//    It iterates through the page information data structure and frees them in
//    in accordance with whatever the process owner is.

void free_process(pid_t pid) {
   40894:	55                   	push   %rbp
   40895:	48 89 e5             	mov    %rsp,%rbp
   40898:	48 83 ec 20          	sub    $0x20,%rsp
   4089c:	89 7d ec             	mov    %edi,-0x14(%rbp)
    // Iterate through the virtual memory page by page
    for (int i = 0; i < PAGENUMBER(MEMSIZE_PHYSICAL); i++) {
   4089f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   408a6:	eb 33                	jmp    408db <free_process+0x47>
        if (pageinfo[i].owner == pid) {
   408a8:	8b 45 fc             	mov    -0x4(%rbp),%eax
   408ab:	48 98                	cltq   
   408ad:	0f b6 84 00 40 ee 04 	movzbl 0x4ee40(%rax,%rax,1),%eax
   408b4:	00 
   408b5:	0f be c0             	movsbl %al,%eax
   408b8:	39 45 ec             	cmp    %eax,-0x14(%rbp)
   408bb:	75 1a                	jne    408d7 <free_process+0x43>
            pageinfo[i].refcount = 0;
   408bd:	8b 45 fc             	mov    -0x4(%rbp),%eax
   408c0:	48 98                	cltq   
   408c2:	c6 84 00 41 ee 04 00 	movb   $0x0,0x4ee41(%rax,%rax,1)
   408c9:	00 
            pageinfo[i].owner = PO_FREE;
   408ca:	8b 45 fc             	mov    -0x4(%rbp),%eax
   408cd:	48 98                	cltq   
   408cf:	c6 84 00 40 ee 04 00 	movb   $0x0,0x4ee40(%rax,%rax,1)
   408d6:	00 
    for (int i = 0; i < PAGENUMBER(MEMSIZE_PHYSICAL); i++) {
   408d7:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   408db:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   408e2:	7e c4                	jle    408a8 <free_process+0x14>
        }
    }

    // Set the registers to a value of zero and the process state to free
    memset(&processes[pid].p_registers, 0, sizeof(x86_64_registers));
   408e4:	8b 45 ec             	mov    -0x14(%rbp),%eax
   408e7:	48 63 d0             	movslq %eax,%rdx
   408ea:	48 89 d0             	mov    %rdx,%rax
   408ed:	48 c1 e0 03          	shl    $0x3,%rax
   408f1:	48 29 d0             	sub    %rdx,%rax
   408f4:	48 c1 e0 05          	shl    $0x5,%rax
   408f8:	48 05 20 e0 04 00    	add    $0x4e020,%rax
   408fe:	48 83 c0 08          	add    $0x8,%rax
   40902:	ba c0 00 00 00       	mov    $0xc0,%edx
   40907:	be 00 00 00 00       	mov    $0x0,%esi
   4090c:	48 89 c7             	mov    %rax,%rdi
   4090f:	e8 1f 2f 00 00       	call   43833 <memset>
    processes[pid].p_state = P_FREE;
   40914:	8b 45 ec             	mov    -0x14(%rbp),%eax
   40917:	48 63 d0             	movslq %eax,%rdx
   4091a:	48 89 d0             	mov    %rdx,%rax
   4091d:	48 c1 e0 03          	shl    $0x3,%rax
   40921:	48 29 d0             	sub    %rdx,%rax
   40924:	48 c1 e0 05          	shl    $0x5,%rax
   40928:	48 05 e8 e0 04 00    	add    $0x4e0e8,%rax
   4092e:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
    
    return;
   40934:	90                   	nop
}
   40935:	c9                   	leave  
   40936:	c3                   	ret    

0000000000040937 <exception>:
//    k-exception.S). That code saves more registers on the kernel's stack,
//    then calls exception().
//
//    Note that hardware interrupts are disabled whenever the kernel is running.

void exception(x86_64_registers* reg) {
   40937:	55                   	push   %rbp
   40938:	48 89 e5             	mov    %rsp,%rbp
   4093b:	48 81 ec 40 01 00 00 	sub    $0x140,%rsp
   40942:	48 89 bd c8 fe ff ff 	mov    %rdi,-0x138(%rbp)
    // Copy the saved registers into the `current` process descriptor
    // and always use the kernel's page table.
    current->p_registers = *reg;
   40949:	48 8b 05 b0 d6 00 00 	mov    0xd6b0(%rip),%rax        # 4e000 <current>
   40950:	48 8b 95 c8 fe ff ff 	mov    -0x138(%rbp),%rdx
   40957:	48 83 c0 08          	add    $0x8,%rax
   4095b:	48 89 d6             	mov    %rdx,%rsi
   4095e:	ba 18 00 00 00       	mov    $0x18,%edx
   40963:	48 89 c7             	mov    %rax,%rdi
   40966:	48 89 d1             	mov    %rdx,%rcx
   40969:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
    set_pagetable(kernel_pagetable);
   4096c:	48 8b 05 8d 06 01 00 	mov    0x1068d(%rip),%rax        # 51000 <kernel_pagetable>
   40973:	48 89 c7             	mov    %rax,%rdi
   40976:	e8 85 24 00 00       	call   42e00 <set_pagetable>
    // Events logged this way are stored in the host's `log.txt` file.
    /*log_printf("proc %d: exception %d\n", current->p_pid, reg->reg_intno);*/

    // Show the current cursor location and memory state
    // (unless this is a kernel fault).
    console_show_cursor(cursorpos);
   4097b:	8b 05 7b 86 07 00    	mov    0x7867b(%rip),%eax        # b8ffc <cursorpos>
   40981:	89 c7                	mov    %eax,%edi
   40983:	e8 ac 1b 00 00       	call   42534 <console_show_cursor>
    if ((reg->reg_intno != INT_PAGEFAULT && reg->reg_intno != INT_GPF) // no error due to pagefault or general fault
   40988:	48 8b 85 c8 fe ff ff 	mov    -0x138(%rbp),%rax
   4098f:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40996:	48 83 f8 0e          	cmp    $0xe,%rax
   4099a:	74 14                	je     409b0 <exception+0x79>
   4099c:	48 8b 85 c8 fe ff ff 	mov    -0x138(%rbp),%rax
   409a3:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   409aa:	48 83 f8 0d          	cmp    $0xd,%rax
   409ae:	75 16                	jne    409c6 <exception+0x8f>
            || (reg->reg_err & PFERR_USER)) // pagefault error in user mode 
   409b0:	48 8b 85 c8 fe ff ff 	mov    -0x138(%rbp),%rax
   409b7:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   409be:	83 e0 04             	and    $0x4,%eax
   409c1:	48 85 c0             	test   %rax,%rax
   409c4:	74 1a                	je     409e0 <exception+0xa9>
    {
        check_virtual_memory();
   409c6:	e8 6c 0d 00 00       	call   41737 <check_virtual_memory>
        if(disp_global){
   409cb:	0f b6 05 2e 46 00 00 	movzbl 0x462e(%rip),%eax        # 45000 <disp_global>
   409d2:	84 c0                	test   %al,%al
   409d4:	74 0a                	je     409e0 <exception+0xa9>
            memshow_physical();
   409d6:	e8 d4 0e 00 00       	call   418af <memshow_physical>
            memshow_virtual_animate();
   409db:	e8 fa 11 00 00       	call   41bda <memshow_virtual_animate>
        }
    }

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();
   409e0:	e8 2c 20 00 00       	call   42a11 <check_keyboard>


    // Actually handle the exception.
    switch (reg->reg_intno) {
   409e5:	48 8b 85 c8 fe ff ff 	mov    -0x138(%rbp),%rax
   409ec:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   409f3:	48 83 e8 0e          	sub    $0xe,%rax
   409f7:	48 83 f8 2a          	cmp    $0x2a,%rax
   409fb:	0f 87 92 08 00 00    	ja     41293 <exception+0x95c>
   40a01:	48 8b 04 c5 40 42 04 	mov    0x44240(,%rax,8),%rax
   40a08:	00 
   40a09:	ff e0                	jmp    *%rax

    case INT_SYS_PANIC:
	    // rdi stores pointer for msg string
	    {
		char msg[160];
		uintptr_t addr = current->p_registers.reg_rdi;
   40a0b:	48 8b 05 ee d5 00 00 	mov    0xd5ee(%rip),%rax        # 4e000 <current>
   40a12:	48 8b 40 38          	mov    0x38(%rax),%rax
   40a16:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
		if((void *)addr == NULL)
   40a1a:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
   40a1f:	75 0f                	jne    40a30 <exception+0xf9>
		    panic(NULL);
   40a21:	bf 00 00 00 00       	mov    $0x0,%edi
   40a26:	b8 00 00 00 00       	mov    $0x0,%eax
   40a2b:	e8 22 21 00 00       	call   42b52 <panic>
		vamapping map = virtual_memory_lookup(current->p_pagetable, addr);
   40a30:	48 8b 05 c9 d5 00 00 	mov    0xd5c9(%rip),%rax        # 4e000 <current>
   40a37:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40a3e:	48 8d 45 90          	lea    -0x70(%rbp),%rax
   40a42:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   40a46:	48 89 ce             	mov    %rcx,%rsi
   40a49:	48 89 c7             	mov    %rax,%rdi
   40a4c:	e8 9b 28 00 00       	call   432ec <virtual_memory_lookup>
		memcpy(msg, (void *)map.pa, 160);
   40a51:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40a55:	48 89 c1             	mov    %rax,%rcx
   40a58:	48 8d 85 d8 fe ff ff 	lea    -0x128(%rbp),%rax
   40a5f:	ba a0 00 00 00       	mov    $0xa0,%edx
   40a64:	48 89 ce             	mov    %rcx,%rsi
   40a67:	48 89 c7             	mov    %rax,%rdi
   40a6a:	e8 5b 2d 00 00       	call   437ca <memcpy>
		panic(msg);
   40a6f:	48 8d 85 d8 fe ff ff 	lea    -0x128(%rbp),%rax
   40a76:	48 89 c7             	mov    %rax,%rdi
   40a79:	b8 00 00 00 00       	mov    $0x0,%eax
   40a7e:	e8 cf 20 00 00       	call   42b52 <panic>
	    }
	    panic(NULL);
	    break;                  // will not be reached

    case INT_SYS_GETPID:
        current->p_registers.reg_rax = current->p_pid;
   40a83:	48 8b 05 76 d5 00 00 	mov    0xd576(%rip),%rax        # 4e000 <current>
   40a8a:	8b 10                	mov    (%rax),%edx
   40a8c:	48 8b 05 6d d5 00 00 	mov    0xd56d(%rip),%rax        # 4e000 <current>
   40a93:	48 63 d2             	movslq %edx,%rdx
   40a96:	48 89 50 08          	mov    %rdx,0x8(%rax)
        break;
   40a9a:	e9 09 08 00 00       	jmp    412a8 <exception+0x971>

    case INT_SYS_YIELD:
        schedule();
   40a9f:	e8 2d 08 00 00       	call   412d1 <schedule>
        break;                  /* will not be reached */
   40aa4:	e9 ff 07 00 00       	jmp    412a8 <exception+0x971>

    case INT_SYS_PAGE_ALLOC: {
        // Find the next free page in physical memory and use its address
        int index = find_free_page();
   40aa9:	b8 00 00 00 00       	mov    $0x0,%eax
   40aae:	e8 ee f8 ff ff       	call   403a1 <find_free_page>
   40ab3:	89 45 e8             	mov    %eax,-0x18(%rbp)
        if (index == -1) {
   40ab6:	83 7d e8 ff          	cmpl   $0xffffffff,-0x18(%rbp)
   40aba:	75 2d                	jne    40ae9 <exception+0x1b2>
            current->p_registers.reg_rax = -1;
   40abc:	48 8b 05 3d d5 00 00 	mov    0xd53d(%rip),%rax        # 4e000 <current>
   40ac3:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40aca:	ff 
            console_printf(CPOS(24, 0), 0x0C00, "Out of physical memory!");
   40acb:	ba 59 41 04 00       	mov    $0x44159,%edx
   40ad0:	be 00 0c 00 00       	mov    $0xc00,%esi
   40ad5:	bf 80 07 00 00       	mov    $0x780,%edi
   40ada:	b8 00 00 00 00       	mov    $0x0,%eax
   40adf:	e8 84 35 00 00       	call   44068 <console_printf>
            break;
   40ae4:	e9 bf 07 00 00       	jmp    412a8 <exception+0x971>
        }

        uintptr_t addr_page = PAGEADDRESS(index);
   40ae9:	8b 45 e8             	mov    -0x18(%rbp),%eax
   40aec:	48 98                	cltq   
   40aee:	48 c1 e0 0c          	shl    $0xc,%rax
   40af2:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
        uintptr_t addr_reg = current->p_registers.reg_rdi;
   40af6:	48 8b 05 03 d5 00 00 	mov    0xd503(%rip),%rax        # 4e000 <current>
   40afd:	48 8b 40 38          	mov    0x38(%rax),%rax
   40b01:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        if (addr_reg % PAGESIZE != 0 || addr_reg > MEMSIZE_VIRTUAL) {
   40b05:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40b09:	25 ff 0f 00 00       	and    $0xfff,%eax
   40b0e:	48 85 c0             	test   %rax,%rax
   40b11:	75 0a                	jne    40b1d <exception+0x1e6>
   40b13:	48 81 7d d8 00 00 30 	cmpq   $0x300000,-0x28(%rbp)
   40b1a:	00 
   40b1b:	76 14                	jbe    40b31 <exception+0x1fa>
            current->p_registers.reg_rax = -1;
   40b1d:	48 8b 05 dc d4 00 00 	mov    0xd4dc(%rip),%rax        # 4e000 <current>
   40b24:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40b2b:	ff 
            break;
   40b2c:	e9 77 07 00 00       	jmp    412a8 <exception+0x971>
        }

        // Assign the physical page and ensure that no error results
        int r = assign_physical_page(addr_page, current->p_pid);
   40b31:	48 8b 05 c8 d4 00 00 	mov    0xd4c8(%rip),%rax        # 4e000 <current>
   40b38:	8b 00                	mov    (%rax),%eax
   40b3a:	0f be d0             	movsbl %al,%edx
   40b3d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40b41:	89 d6                	mov    %edx,%esi
   40b43:	48 89 c7             	mov    %rax,%rdi
   40b46:	e8 5c fb ff ff       	call   406a7 <assign_physical_page>
   40b4b:	89 45 d4             	mov    %eax,-0x2c(%rbp)
        if (r >= 0) {
   40b4e:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   40b52:	78 29                	js     40b7d <exception+0x246>
            virtual_memory_map(current->p_pagetable, addr_reg, addr_page,
   40b54:	48 8b 05 a5 d4 00 00 	mov    0xd4a5(%rip),%rax        # 4e000 <current>
   40b5b:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   40b62:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   40b66:	48 8b 75 d8          	mov    -0x28(%rbp),%rsi
   40b6a:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   40b70:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40b75:	48 89 c7             	mov    %rax,%rdi
   40b78:	e8 b4 23 00 00       	call   42f31 <virtual_memory_map>
                               PAGESIZE, PTE_P | PTE_W | PTE_U);
        }
        current->p_registers.reg_rax = r;
   40b7d:	48 8b 05 7c d4 00 00 	mov    0xd47c(%rip),%rax        # 4e000 <current>
   40b84:	8b 55 d4             	mov    -0x2c(%rbp),%edx
   40b87:	48 63 d2             	movslq %edx,%rdx
   40b8a:	48 89 50 08          	mov    %rdx,0x8(%rax)
        break;
   40b8e:	e9 15 07 00 00       	jmp    412a8 <exception+0x971>
    }

    case INT_SYS_FORK: {
        // Find an available free process to map to
        int index_proc = find_free_process();
   40b93:	b8 00 00 00 00       	mov    $0x0,%eax
   40b98:	e8 b0 fc ff ff       	call   4084d <find_free_process>
   40b9d:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (index_proc == -1) {
   40ba0:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%rbp)
   40ba4:	75 19                	jne    40bbf <exception+0x288>
            console_printf(CPOS(24, 0), 0x0C00, "Couldn't find free process!");
   40ba6:	ba 81 41 04 00       	mov    $0x44181,%edx
   40bab:	be 00 0c 00 00       	mov    $0xc00,%esi
   40bb0:	bf 80 07 00 00       	mov    $0x780,%edi
   40bb5:	b8 00 00 00 00       	mov    $0x0,%eax
   40bba:	e8 a9 34 00 00       	call   44068 <console_printf>
        // Isolate address spaces by creating separate pagetables
        x86_64_pagetable *p_pagetables[5];

        // Iterate through and reserve space for the separate pagetables
        int index_page;
        for (int j = 0; j < 5; j++) {
   40bbf:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   40bc6:	e9 d7 00 00 00       	jmp    40ca2 <exception+0x36b>
            index_page = find_free_page();
   40bcb:	b8 00 00 00 00       	mov    $0x0,%eax
   40bd0:	e8 cc f7 ff ff       	call   403a1 <find_free_page>
   40bd5:	89 45 fc             	mov    %eax,-0x4(%rbp)
            if (index_page == -1) {
   40bd8:	83 7d fc ff          	cmpl   $0xffffffff,-0x4(%rbp)
   40bdc:	75 6e                	jne    40c4c <exception+0x315>
                free_process(processes[index_proc].p_pid);
   40bde:	8b 45 ec             	mov    -0x14(%rbp),%eax
   40be1:	48 63 d0             	movslq %eax,%rdx
   40be4:	48 89 d0             	mov    %rdx,%rax
   40be7:	48 c1 e0 03          	shl    $0x3,%rax
   40beb:	48 29 d0             	sub    %rdx,%rax
   40bee:	48 c1 e0 05          	shl    $0x5,%rax
   40bf2:	48 05 20 e0 04 00    	add    $0x4e020,%rax
   40bf8:	8b 00                	mov    (%rax),%eax
   40bfa:	89 c7                	mov    %eax,%edi
   40bfc:	e8 93 fc ff ff       	call   40894 <free_process>
                processes[index_proc].p_registers.reg_rax = -1;
   40c01:	8b 45 ec             	mov    -0x14(%rbp),%eax
   40c04:	48 63 d0             	movslq %eax,%rdx
   40c07:	48 89 d0             	mov    %rdx,%rax
   40c0a:	48 c1 e0 03          	shl    $0x3,%rax
   40c0e:	48 29 d0             	sub    %rdx,%rax
   40c11:	48 c1 e0 05          	shl    $0x5,%rax
   40c15:	48 05 28 e0 04 00    	add    $0x4e028,%rax
   40c1b:	48 c7 00 ff ff ff ff 	movq   $0xffffffffffffffff,(%rax)
                current->p_registers.reg_rax = -1;
   40c22:	48 8b 05 d7 d3 00 00 	mov    0xd3d7(%rip),%rax        # 4e000 <current>
   40c29:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40c30:	ff 
                console_printf(CPOS(24, 0), 0x0C00, "Out of physical memory");
   40c31:	ba 9d 41 04 00       	mov    $0x4419d,%edx
   40c36:	be 00 0c 00 00       	mov    $0xc00,%esi
   40c3b:	bf 80 07 00 00       	mov    $0x780,%edi
   40c40:	b8 00 00 00 00       	mov    $0x0,%eax
   40c45:	e8 1e 34 00 00       	call   44068 <console_printf>
                break;
   40c4a:	eb 60                	jmp    40cac <exception+0x375>
            }
            p_pagetables[j] = (x86_64_pagetable *)PAGEADDRESS(index_page);
   40c4c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40c4f:	48 98                	cltq   
   40c51:	48 c1 e0 0c          	shl    $0xc,%rax
   40c55:	48 89 c2             	mov    %rax,%rdx
   40c58:	8b 45 f8             	mov    -0x8(%rbp),%eax
   40c5b:	48 98                	cltq   
   40c5d:	48 89 94 c5 d8 fe ff 	mov    %rdx,-0x128(%rbp,%rax,8)
   40c64:	ff 
            memset(p_pagetables[j], 0, sizeof(x86_64_pagetable));
   40c65:	8b 45 f8             	mov    -0x8(%rbp),%eax
   40c68:	48 98                	cltq   
   40c6a:	48 8b 84 c5 d8 fe ff 	mov    -0x128(%rbp,%rax,8),%rax
   40c71:	ff 
   40c72:	ba 00 10 00 00       	mov    $0x1000,%edx
   40c77:	be 00 00 00 00       	mov    $0x0,%esi
   40c7c:	48 89 c7             	mov    %rax,%rdi
   40c7f:	e8 af 2b 00 00       	call   43833 <memset>
            assign_physical_page(PAGEADDRESS(index_page), index_proc);
   40c84:	8b 45 ec             	mov    -0x14(%rbp),%eax
   40c87:	0f be c0             	movsbl %al,%eax
   40c8a:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40c8d:	48 63 d2             	movslq %edx,%rdx
   40c90:	48 c1 e2 0c          	shl    $0xc,%rdx
   40c94:	89 c6                	mov    %eax,%esi
   40c96:	48 89 d7             	mov    %rdx,%rdi
   40c99:	e8 09 fa ff ff       	call   406a7 <assign_physical_page>
        for (int j = 0; j < 5; j++) {
   40c9e:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   40ca2:	83 7d f8 04          	cmpl   $0x4,-0x8(%rbp)
   40ca6:	0f 8e 1f ff ff ff    	jle    40bcb <exception+0x294>
        }
        if (index_page == -1) {
   40cac:	83 7d fc ff          	cmpl   $0xffffffff,-0x4(%rbp)
   40cb0:	0f 84 ee 05 00 00    	je     412a4 <exception+0x96d>
            break;
        }

        // Connect the pagetable pages togethers
        p_pagetables[0]->entry[0] =
            (x86_64_pageentry_t) p_pagetables[1] | PTE_P | PTE_W | PTE_U;
   40cb6:	48 8b 85 e0 fe ff ff 	mov    -0x120(%rbp),%rax
   40cbd:	48 89 c2             	mov    %rax,%rdx
        p_pagetables[0]->entry[0] =
   40cc0:	48 8b 85 d8 fe ff ff 	mov    -0x128(%rbp),%rax
            (x86_64_pageentry_t) p_pagetables[1] | PTE_P | PTE_W | PTE_U;
   40cc7:	48 83 ca 07          	or     $0x7,%rdx
        p_pagetables[0]->entry[0] =
   40ccb:	48 89 10             	mov    %rdx,(%rax)
        p_pagetables[1]->entry[0] =
            (x86_64_pageentry_t) p_pagetables[2] | PTE_P | PTE_W | PTE_U;
   40cce:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
   40cd5:	48 89 c2             	mov    %rax,%rdx
        p_pagetables[1]->entry[0] =
   40cd8:	48 8b 85 e0 fe ff ff 	mov    -0x120(%rbp),%rax
            (x86_64_pageentry_t) p_pagetables[2] | PTE_P | PTE_W | PTE_U;
   40cdf:	48 83 ca 07          	or     $0x7,%rdx
        p_pagetables[1]->entry[0] =
   40ce3:	48 89 10             	mov    %rdx,(%rax)
        p_pagetables[2]->entry[0] =
            (x86_64_pageentry_t) p_pagetables[3] | PTE_P | PTE_W | PTE_U;
   40ce6:	48 8b 85 f0 fe ff ff 	mov    -0x110(%rbp),%rax
   40ced:	48 89 c2             	mov    %rax,%rdx
        p_pagetables[2]->entry[0] =
   40cf0:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
            (x86_64_pageentry_t) p_pagetables[3] | PTE_P | PTE_W | PTE_U;
   40cf7:	48 83 ca 07          	or     $0x7,%rdx
        p_pagetables[2]->entry[0] =
   40cfb:	48 89 10             	mov    %rdx,(%rax)
        p_pagetables[2]->entry[1] =
            (x86_64_pageentry_t) p_pagetables[4] | PTE_P | PTE_W | PTE_U;
   40cfe:	48 8b 85 f8 fe ff ff 	mov    -0x108(%rbp),%rax
   40d05:	48 89 c2             	mov    %rax,%rdx
        p_pagetables[2]->entry[1] =
   40d08:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
            (x86_64_pageentry_t) p_pagetables[4] | PTE_P | PTE_W | PTE_U;
   40d0f:	48 83 ca 07          	or     $0x7,%rdx
        p_pagetables[2]->entry[1] =
   40d13:	48 89 50 08          	mov    %rdx,0x8(%rax)

        // Reassign process pagetable from the original kernel table
        processes[index_proc].p_pagetable = p_pagetables[0];
   40d17:	48 8b 95 d8 fe ff ff 	mov    -0x128(%rbp),%rdx
   40d1e:	8b 45 ec             	mov    -0x14(%rbp),%eax
   40d21:	48 63 c8             	movslq %eax,%rcx
   40d24:	48 89 c8             	mov    %rcx,%rax
   40d27:	48 c1 e0 03          	shl    $0x3,%rax
   40d2b:	48 29 c8             	sub    %rcx,%rax
   40d2e:	48 c1 e0 05          	shl    $0x5,%rax
   40d32:	48 05 f0 e0 04 00    	add    $0x4e0f0,%rax
   40d38:	48 89 10             	mov    %rdx,(%rax)

        // Identity map the process' pagetable to everything before PROC_START_ADDR
        virtual_memory_map(processes[index_proc].p_pagetable, 0, 0, PROC_START_ADDR,
   40d3b:	8b 45 ec             	mov    -0x14(%rbp),%eax
   40d3e:	48 63 d0             	movslq %eax,%rdx
   40d41:	48 89 d0             	mov    %rdx,%rax
   40d44:	48 c1 e0 03          	shl    $0x3,%rax
   40d48:	48 29 d0             	sub    %rdx,%rax
   40d4b:	48 c1 e0 05          	shl    $0x5,%rax
   40d4f:	48 05 f0 e0 04 00    	add    $0x4e0f0,%rax
   40d55:	48 8b 00             	mov    (%rax),%rax
   40d58:	41 b8 03 00 00 00    	mov    $0x3,%r8d
   40d5e:	b9 00 00 10 00       	mov    $0x100000,%ecx
   40d63:	ba 00 00 00 00       	mov    $0x0,%edx
   40d68:	be 00 00 00 00       	mov    $0x0,%esi
   40d6d:	48 89 c7             	mov    %rax,%rdi
   40d70:	e8 bc 21 00 00       	call   42f31 <virtual_memory_map>
                        PTE_P | PTE_W);
        virtual_memory_map(processes[index_proc].p_pagetable, CONSOLE_ADDR, CONSOLE_ADDR,
   40d75:	bf 00 80 0b 00       	mov    $0xb8000,%edi
   40d7a:	be 00 80 0b 00       	mov    $0xb8000,%esi
   40d7f:	8b 45 ec             	mov    -0x14(%rbp),%eax
   40d82:	48 63 d0             	movslq %eax,%rdx
   40d85:	48 89 d0             	mov    %rdx,%rax
   40d88:	48 c1 e0 03          	shl    $0x3,%rax
   40d8c:	48 29 d0             	sub    %rdx,%rax
   40d8f:	48 c1 e0 05          	shl    $0x5,%rax
   40d93:	48 05 f0 e0 04 00    	add    $0x4e0f0,%rax
   40d99:	48 8b 00             	mov    (%rax),%rax
   40d9c:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   40da2:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40da7:	48 89 fa             	mov    %rdi,%rdx
   40daa:	48 89 c7             	mov    %rax,%rdi
   40dad:	e8 7f 21 00 00       	call   42f31 <virtual_memory_map>
                        PAGESIZE, PTE_P | PTE_W | PTE_U);
        
        // Copy all data over from the parent process
        for (uintptr_t i = PROC_START_ADDR; i < MEMSIZE_VIRTUAL; i += PAGESIZE) {
   40db2:	48 c7 45 f0 00 00 10 	movq   $0x100000,-0x10(%rbp)
   40db9:	00 
   40dba:	e9 b1 01 00 00       	jmp    40f70 <exception+0x639>
            vamapping vmap = virtual_memory_lookup(current->p_pagetable, i);
   40dbf:	48 8b 05 3a d2 00 00 	mov    0xd23a(%rip),%rax        # 4e000 <current>
   40dc6:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   40dcd:	48 8d 85 78 ff ff ff 	lea    -0x88(%rbp),%rax
   40dd4:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40dd8:	48 89 ce             	mov    %rcx,%rsi
   40ddb:	48 89 c7             	mov    %rax,%rdi
   40dde:	e8 09 25 00 00       	call   432ec <virtual_memory_lookup>
            if (vmap.pn != -1 && vmap.pa != (uintptr_t)-1 && vmap.perm != 0) {
   40de3:	8b 85 78 ff ff ff    	mov    -0x88(%rbp),%eax
   40de9:	83 f8 ff             	cmp    $0xffffffff,%eax
   40dec:	0f 84 76 01 00 00    	je     40f68 <exception+0x631>
   40df2:	48 8b 45 80          	mov    -0x80(%rbp),%rax
   40df6:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
   40dfa:	0f 84 68 01 00 00    	je     40f68 <exception+0x631>
   40e00:	8b 45 88             	mov    -0x78(%rbp),%eax
   40e03:	85 c0                	test   %eax,%eax
   40e05:	0f 84 5d 01 00 00    	je     40f68 <exception+0x631>
                index_page = find_free_page();
   40e0b:	b8 00 00 00 00       	mov    $0x0,%eax
   40e10:	e8 8c f5 ff ff       	call   403a1 <find_free_page>
   40e15:	89 45 fc             	mov    %eax,-0x4(%rbp)
                if (index_page == -1) {
   40e18:	83 7d fc ff          	cmpl   $0xffffffff,-0x4(%rbp)
   40e1c:	75 71                	jne    40e8f <exception+0x558>
                    free_process(processes[index_proc].p_pid);
   40e1e:	8b 45 ec             	mov    -0x14(%rbp),%eax
   40e21:	48 63 d0             	movslq %eax,%rdx
   40e24:	48 89 d0             	mov    %rdx,%rax
   40e27:	48 c1 e0 03          	shl    $0x3,%rax
   40e2b:	48 29 d0             	sub    %rdx,%rax
   40e2e:	48 c1 e0 05          	shl    $0x5,%rax
   40e32:	48 05 20 e0 04 00    	add    $0x4e020,%rax
   40e38:	8b 00                	mov    (%rax),%eax
   40e3a:	89 c7                	mov    %eax,%edi
   40e3c:	e8 53 fa ff ff       	call   40894 <free_process>
                    processes[index_proc].p_registers.reg_rax = -1;
   40e41:	8b 45 ec             	mov    -0x14(%rbp),%eax
   40e44:	48 63 d0             	movslq %eax,%rdx
   40e47:	48 89 d0             	mov    %rdx,%rax
   40e4a:	48 c1 e0 03          	shl    $0x3,%rax
   40e4e:	48 29 d0             	sub    %rdx,%rax
   40e51:	48 c1 e0 05          	shl    $0x5,%rax
   40e55:	48 05 28 e0 04 00    	add    $0x4e028,%rax
   40e5b:	48 c7 00 ff ff ff ff 	movq   $0xffffffffffffffff,(%rax)
                    current->p_registers.reg_rax = -1;
   40e62:	48 8b 05 97 d1 00 00 	mov    0xd197(%rip),%rax        # 4e000 <current>
   40e69:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   40e70:	ff 
                    console_printf(CPOS(24, 0), 0x0C00, "Out of physical memory!");
   40e71:	ba 59 41 04 00       	mov    $0x44159,%edx
   40e76:	be 00 0c 00 00       	mov    $0xc00,%esi
   40e7b:	bf 80 07 00 00       	mov    $0x780,%edi
   40e80:	b8 00 00 00 00       	mov    $0x0,%eax
   40e85:	e8 de 31 00 00       	call   44068 <console_printf>
   40e8a:	e9 ef 00 00 00       	jmp    40f7e <exception+0x647>
                    break;
                }
                assign_physical_page(PAGEADDRESS(index_page), index_proc);
   40e8f:	8b 45 ec             	mov    -0x14(%rbp),%eax
   40e92:	0f be c0             	movsbl %al,%eax
   40e95:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40e98:	48 63 d2             	movslq %edx,%rdx
   40e9b:	48 c1 e2 0c          	shl    $0xc,%rdx
   40e9f:	89 c6                	mov    %eax,%esi
   40ea1:	48 89 d7             	mov    %rdx,%rdi
   40ea4:	e8 fe f7 ff ff       	call   406a7 <assign_physical_page>
                if (vmap.perm == (PTE_P | PTE_U | PTE_A)) {
   40ea9:	8b 45 88             	mov    -0x78(%rbp),%eax
   40eac:	83 f8 25             	cmp    $0x25,%eax
   40eaf:	75 57                	jne    40f08 <exception+0x5d1>
                    pageinfo[vmap.pn].refcount++;
   40eb1:	8b 85 78 ff ff ff    	mov    -0x88(%rbp),%eax
   40eb7:	48 63 d0             	movslq %eax,%rdx
   40eba:	0f b6 94 12 41 ee 04 	movzbl 0x4ee41(%rdx,%rdx,1),%edx
   40ec1:	00 
   40ec2:	83 c2 01             	add    $0x1,%edx
   40ec5:	48 98                	cltq   
   40ec7:	88 94 00 41 ee 04 00 	mov    %dl,0x4ee41(%rax,%rax,1)
                    virtual_memory_map(processes[index_proc].p_pagetable, i, vmap.pa, PAGESIZE, vmap.perm);
   40ece:	8b 7d 88             	mov    -0x78(%rbp),%edi
   40ed1:	48 8b 55 80          	mov    -0x80(%rbp),%rdx
   40ed5:	8b 45 ec             	mov    -0x14(%rbp),%eax
   40ed8:	48 63 c8             	movslq %eax,%rcx
   40edb:	48 89 c8             	mov    %rcx,%rax
   40ede:	48 c1 e0 03          	shl    $0x3,%rax
   40ee2:	48 29 c8             	sub    %rcx,%rax
   40ee5:	48 c1 e0 05          	shl    $0x5,%rax
   40ee9:	48 05 f0 e0 04 00    	add    $0x4e0f0,%rax
   40eef:	48 8b 00             	mov    (%rax),%rax
   40ef2:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   40ef6:	41 89 f8             	mov    %edi,%r8d
   40ef9:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40efe:	48 89 c7             	mov    %rax,%rdi
   40f01:	e8 2b 20 00 00       	call   42f31 <virtual_memory_map>
   40f06:	eb 60                	jmp    40f68 <exception+0x631>
                } else {
                    memcpy((void *)PAGEADDRESS(index_page), (void *)vmap.pa, PAGESIZE);
   40f08:	48 8b 45 80          	mov    -0x80(%rbp),%rax
   40f0c:	48 89 c1             	mov    %rax,%rcx
   40f0f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40f12:	48 98                	cltq   
   40f14:	48 c1 e0 0c          	shl    $0xc,%rax
   40f18:	ba 00 10 00 00       	mov    $0x1000,%edx
   40f1d:	48 89 ce             	mov    %rcx,%rsi
   40f20:	48 89 c7             	mov    %rax,%rdi
   40f23:	e8 a2 28 00 00       	call   437ca <memcpy>
                    virtual_memory_map(processes[index_proc].p_pagetable, i, PAGEADDRESS(index_page), PAGESIZE, vmap.perm);
   40f28:	8b 7d 88             	mov    -0x78(%rbp),%edi
   40f2b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40f2e:	48 98                	cltq   
   40f30:	48 c1 e0 0c          	shl    $0xc,%rax
   40f34:	48 89 c2             	mov    %rax,%rdx
   40f37:	8b 45 ec             	mov    -0x14(%rbp),%eax
   40f3a:	48 63 c8             	movslq %eax,%rcx
   40f3d:	48 89 c8             	mov    %rcx,%rax
   40f40:	48 c1 e0 03          	shl    $0x3,%rax
   40f44:	48 29 c8             	sub    %rcx,%rax
   40f47:	48 c1 e0 05          	shl    $0x5,%rax
   40f4b:	48 05 f0 e0 04 00    	add    $0x4e0f0,%rax
   40f51:	48 8b 00             	mov    (%rax),%rax
   40f54:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   40f58:	41 89 f8             	mov    %edi,%r8d
   40f5b:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40f60:	48 89 c7             	mov    %rax,%rdi
   40f63:	e8 c9 1f 00 00       	call   42f31 <virtual_memory_map>
        for (uintptr_t i = PROC_START_ADDR; i < MEMSIZE_VIRTUAL; i += PAGESIZE) {
   40f68:	48 81 45 f0 00 10 00 	addq   $0x1000,-0x10(%rbp)
   40f6f:	00 
   40f70:	48 81 7d f0 ff ff 2f 	cmpq   $0x2fffff,-0x10(%rbp)
   40f77:	00 
   40f78:	0f 86 41 fe ff ff    	jbe    40dbf <exception+0x488>
                }
            }
        }
        if (index_page == -1) {
   40f7e:	83 7d fc ff          	cmpl   $0xffffffff,-0x4(%rbp)
   40f82:	0f 84 1f 03 00 00    	je     412a7 <exception+0x970>
            break;
        }
        
        // Set all of the registers to a copy of the parent's (excluding %rax)
        memcpy(&processes[index_proc].p_registers, &current->p_registers, sizeof(x86_64_registers));
   40f88:	48 8b 05 71 d0 00 00 	mov    0xd071(%rip),%rax        # 4e000 <current>
   40f8f:	48 8d 48 08          	lea    0x8(%rax),%rcx
   40f93:	8b 45 ec             	mov    -0x14(%rbp),%eax
   40f96:	48 63 d0             	movslq %eax,%rdx
   40f99:	48 89 d0             	mov    %rdx,%rax
   40f9c:	48 c1 e0 03          	shl    $0x3,%rax
   40fa0:	48 29 d0             	sub    %rdx,%rax
   40fa3:	48 c1 e0 05          	shl    $0x5,%rax
   40fa7:	48 05 20 e0 04 00    	add    $0x4e020,%rax
   40fad:	48 83 c0 08          	add    $0x8,%rax
   40fb1:	ba c0 00 00 00       	mov    $0xc0,%edx
   40fb6:	48 89 ce             	mov    %rcx,%rsi
   40fb9:	48 89 c7             	mov    %rax,%rdi
   40fbc:	e8 09 28 00 00       	call   437ca <memcpy>
        current->p_registers.reg_rax = index_proc;
   40fc1:	48 8b 05 38 d0 00 00 	mov    0xd038(%rip),%rax        # 4e000 <current>
   40fc8:	8b 55 ec             	mov    -0x14(%rbp),%edx
   40fcb:	48 63 d2             	movslq %edx,%rdx
   40fce:	48 89 50 08          	mov    %rdx,0x8(%rax)
        processes[index_proc].p_registers.reg_rax = 0;
   40fd2:	8b 45 ec             	mov    -0x14(%rbp),%eax
   40fd5:	48 63 d0             	movslq %eax,%rdx
   40fd8:	48 89 d0             	mov    %rdx,%rax
   40fdb:	48 c1 e0 03          	shl    $0x3,%rax
   40fdf:	48 29 d0             	sub    %rdx,%rax
   40fe2:	48 c1 e0 05          	shl    $0x5,%rax
   40fe6:	48 05 28 e0 04 00    	add    $0x4e028,%rax
   40fec:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)

        // Find the index and load in the page
        processes[index_proc].p_registers.reg_rsp = MEMSIZE_VIRTUAL;
   40ff3:	8b 45 ec             	mov    -0x14(%rbp),%eax
   40ff6:	48 63 d0             	movslq %eax,%rdx
   40ff9:	48 89 d0             	mov    %rdx,%rax
   40ffc:	48 c1 e0 03          	shl    $0x3,%rax
   41000:	48 29 d0             	sub    %rdx,%rax
   41003:	48 c1 e0 05          	shl    $0x5,%rax
   41007:	48 05 d8 e0 04 00    	add    $0x4e0d8,%rax
   4100d:	48 c7 00 00 00 30 00 	movq   $0x300000,(%rax)
        index_page = find_free_page();
   41014:	b8 00 00 00 00       	mov    $0x0,%eax
   41019:	e8 83 f3 ff ff       	call   403a1 <find_free_page>
   4101e:	89 45 fc             	mov    %eax,-0x4(%rbp)
        if (index_page == -1) {
   41021:	83 7d fc ff          	cmpl   $0xffffffff,-0x4(%rbp)
   41025:	75 71                	jne    41098 <exception+0x761>
            free_process(processes[index_proc].p_pid);
   41027:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4102a:	48 63 d0             	movslq %eax,%rdx
   4102d:	48 89 d0             	mov    %rdx,%rax
   41030:	48 c1 e0 03          	shl    $0x3,%rax
   41034:	48 29 d0             	sub    %rdx,%rax
   41037:	48 c1 e0 05          	shl    $0x5,%rax
   4103b:	48 05 20 e0 04 00    	add    $0x4e020,%rax
   41041:	8b 00                	mov    (%rax),%eax
   41043:	89 c7                	mov    %eax,%edi
   41045:	e8 4a f8 ff ff       	call   40894 <free_process>
            processes[index_proc].p_registers.reg_rax = -1;
   4104a:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4104d:	48 63 d0             	movslq %eax,%rdx
   41050:	48 89 d0             	mov    %rdx,%rax
   41053:	48 c1 e0 03          	shl    $0x3,%rax
   41057:	48 29 d0             	sub    %rdx,%rax
   4105a:	48 c1 e0 05          	shl    $0x5,%rax
   4105e:	48 05 28 e0 04 00    	add    $0x4e028,%rax
   41064:	48 c7 00 ff ff ff ff 	movq   $0xffffffffffffffff,(%rax)
            current->p_registers.reg_rax = -1;
   4106b:	48 8b 05 8e cf 00 00 	mov    0xcf8e(%rip),%rax        # 4e000 <current>
   41072:	48 c7 40 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rax)
   41079:	ff 
            console_printf(CPOS(24, 0), 0x0C00, "Out of physical memory!");
   4107a:	ba 59 41 04 00       	mov    $0x44159,%edx
   4107f:	be 00 0c 00 00       	mov    $0xc00,%esi
   41084:	bf 80 07 00 00       	mov    $0x780,%edi
   41089:	b8 00 00 00 00       	mov    $0x0,%eax
   4108e:	e8 d5 2f 00 00       	call   44068 <console_printf>
            break;
   41093:	e9 10 02 00 00       	jmp    412a8 <exception+0x971>
        }
        assign_physical_page(PAGEADDRESS(index_page), index_proc);
   41098:	8b 45 ec             	mov    -0x14(%rbp),%eax
   4109b:	0f be c0             	movsbl %al,%eax
   4109e:	8b 55 fc             	mov    -0x4(%rbp),%edx
   410a1:	48 63 d2             	movslq %edx,%rdx
   410a4:	48 c1 e2 0c          	shl    $0xc,%rdx
   410a8:	89 c6                	mov    %eax,%esi
   410aa:	48 89 d7             	mov    %rdx,%rdi
   410ad:	e8 f5 f5 ff ff       	call   406a7 <assign_physical_page>
        virtual_memory_map(processes[index_proc].p_pagetable, MEMSIZE_VIRTUAL - PAGESIZE,
                        PAGEADDRESS(index_page), PAGESIZE, PTE_P | PTE_W | PTE_U);
   410b2:	8b 45 fc             	mov    -0x4(%rbp),%eax
   410b5:	48 98                	cltq   
        virtual_memory_map(processes[index_proc].p_pagetable, MEMSIZE_VIRTUAL - PAGESIZE,
   410b7:	48 c1 e0 0c          	shl    $0xc,%rax
   410bb:	48 89 c2             	mov    %rax,%rdx
   410be:	8b 45 ec             	mov    -0x14(%rbp),%eax
   410c1:	48 63 c8             	movslq %eax,%rcx
   410c4:	48 89 c8             	mov    %rcx,%rax
   410c7:	48 c1 e0 03          	shl    $0x3,%rax
   410cb:	48 29 c8             	sub    %rcx,%rax
   410ce:	48 c1 e0 05          	shl    $0x5,%rax
   410d2:	48 05 f0 e0 04 00    	add    $0x4e0f0,%rax
   410d8:	48 8b 00             	mov    (%rax),%rax
   410db:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   410e1:	b9 00 10 00 00       	mov    $0x1000,%ecx
   410e6:	be 00 f0 2f 00       	mov    $0x2ff000,%esi
   410eb:	48 89 c7             	mov    %rax,%rdi
   410ee:	e8 3e 1e 00 00       	call   42f31 <virtual_memory_map>
        processes[index_proc].p_state = P_RUNNABLE;
   410f3:	8b 45 ec             	mov    -0x14(%rbp),%eax
   410f6:	48 63 d0             	movslq %eax,%rdx
   410f9:	48 89 d0             	mov    %rdx,%rax
   410fc:	48 c1 e0 03          	shl    $0x3,%rax
   41100:	48 29 d0             	sub    %rdx,%rax
   41103:	48 c1 e0 05          	shl    $0x5,%rax
   41107:	48 05 e8 e0 04 00    	add    $0x4e0e8,%rax
   4110d:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
        processes[index_proc].display_status = current->display_status;
   41113:	48 8b 05 e6 ce 00 00 	mov    0xcee6(%rip),%rax        # 4e000 <current>
   4111a:	0f b6 90 d8 00 00 00 	movzbl 0xd8(%rax),%edx
   41121:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41124:	48 63 c8             	movslq %eax,%rcx
   41127:	48 89 c8             	mov    %rcx,%rax
   4112a:	48 c1 e0 03          	shl    $0x3,%rax
   4112e:	48 29 c8             	sub    %rcx,%rax
   41131:	48 c1 e0 05          	shl    $0x5,%rax
   41135:	48 05 f8 e0 04 00    	add    $0x4e0f8,%rax
   4113b:	88 10                	mov    %dl,(%rax)
        break;
   4113d:	e9 66 01 00 00       	jmp    412a8 <exception+0x971>
    }

    case INT_SYS_EXIT: {
        free_process(current->p_pid);
   41142:	48 8b 05 b7 ce 00 00 	mov    0xceb7(%rip),%rax        # 4e000 <current>
   41149:	8b 00                	mov    (%rax),%eax
   4114b:	89 c7                	mov    %eax,%edi
   4114d:	e8 42 f7 ff ff       	call   40894 <free_process>
        break;
   41152:	e9 51 01 00 00       	jmp    412a8 <exception+0x971>
    }

    case INT_SYS_MAPPING:
    {
	    syscall_mapping(current);
   41157:	48 8b 05 a2 ce 00 00 	mov    0xcea2(%rip),%rax        # 4e000 <current>
   4115e:	48 89 c7             	mov    %rax,%rdi
   41161:	e8 b5 f5 ff ff       	call   4071b <syscall_mapping>
            break;
   41166:	e9 3d 01 00 00       	jmp    412a8 <exception+0x971>
    }

    case INT_SYS_MEM_TOG:
	{
	    syscall_mem_tog(current);
   4116b:	48 8b 05 8e ce 00 00 	mov    0xce8e(%rip),%rax        # 4e000 <current>
   41172:	48 89 c7             	mov    %rax,%rdi
   41175:	e8 6a f6 ff ff       	call   407e4 <syscall_mem_tog>
	    break;
   4117a:	e9 29 01 00 00       	jmp    412a8 <exception+0x971>
	}

    case INT_TIMER:
        ++ticks;
   4117f:	8b 05 9b dc 00 00    	mov    0xdc9b(%rip),%eax        # 4ee20 <ticks>
   41185:	83 c0 01             	add    $0x1,%eax
   41188:	89 05 92 dc 00 00    	mov    %eax,0xdc92(%rip)        # 4ee20 <ticks>
        schedule();
   4118e:	e8 3e 01 00 00       	call   412d1 <schedule>
        break;                  /* will not be reached */
   41193:	e9 10 01 00 00       	jmp    412a8 <exception+0x971>
    return val;
}

static inline uintptr_t rcr2(void) {
    uintptr_t val;
    asm volatile("movq %%cr2,%0" : "=r" (val));
   41198:	0f 20 d0             	mov    %cr2,%rax
   4119b:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
    return val;
   4119f:	48 8b 45 a8          	mov    -0x58(%rbp),%rax

    case INT_PAGEFAULT: {
        // Analyze faulting address and access type.
        uintptr_t addr = rcr2();
   411a3:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
        const char* operation = reg->reg_err & PFERR_WRITE
   411a7:	48 8b 85 c8 fe ff ff 	mov    -0x138(%rbp),%rax
   411ae:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   411b5:	83 e0 02             	and    $0x2,%eax
                ? "write" : "read";
   411b8:	48 85 c0             	test   %rax,%rax
   411bb:	74 07                	je     411c4 <exception+0x88d>
   411bd:	b8 b4 41 04 00       	mov    $0x441b4,%eax
   411c2:	eb 05                	jmp    411c9 <exception+0x892>
   411c4:	b8 ba 41 04 00       	mov    $0x441ba,%eax
        const char* operation = reg->reg_err & PFERR_WRITE
   411c9:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
        const char* problem = reg->reg_err & PFERR_PRESENT
   411cd:	48 8b 85 c8 fe ff ff 	mov    -0x138(%rbp),%rax
   411d4:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   411db:	83 e0 01             	and    $0x1,%eax
                ? "protection problem" : "missing page";
   411de:	48 85 c0             	test   %rax,%rax
   411e1:	74 07                	je     411ea <exception+0x8b3>
   411e3:	b8 bf 41 04 00       	mov    $0x441bf,%eax
   411e8:	eb 05                	jmp    411ef <exception+0x8b8>
   411ea:	b8 d2 41 04 00       	mov    $0x441d2,%eax
        const char* problem = reg->reg_err & PFERR_PRESENT
   411ef:	48 89 45 b0          	mov    %rax,-0x50(%rbp)

        if (!(reg->reg_err & PFERR_USER)) {
   411f3:	48 8b 85 c8 fe ff ff 	mov    -0x138(%rbp),%rax
   411fa:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   41201:	83 e0 04             	and    $0x4,%eax
   41204:	48 85 c0             	test   %rax,%rax
   41207:	75 2f                	jne    41238 <exception+0x901>
            panic("Kernel page fault for %p (%s %s, rip=%p)!\n",
   41209:	48 8b 85 c8 fe ff ff 	mov    -0x138(%rbp),%rax
   41210:	48 8b b0 98 00 00 00 	mov    0x98(%rax),%rsi
   41217:	48 8b 4d b0          	mov    -0x50(%rbp),%rcx
   4121b:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   4121f:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   41223:	49 89 f0             	mov    %rsi,%r8
   41226:	48 89 c6             	mov    %rax,%rsi
   41229:	bf e0 41 04 00       	mov    $0x441e0,%edi
   4122e:	b8 00 00 00 00       	mov    $0x0,%eax
   41233:	e8 1a 19 00 00       	call   42b52 <panic>
                  addr, operation, problem, reg->reg_rip);
        }
        console_printf(CPOS(24, 0), 0x0C00,
   41238:	48 8b 85 c8 fe ff ff 	mov    -0x138(%rbp),%rax
   4123f:	48 8b 90 98 00 00 00 	mov    0x98(%rax),%rdx
                       "Process %d page fault for %p (%s %s, rip=%p)!\n",
                       current->p_pid, addr, operation, problem, reg->reg_rip);
   41246:	48 8b 05 b3 cd 00 00 	mov    0xcdb3(%rip),%rax        # 4e000 <current>
        console_printf(CPOS(24, 0), 0x0C00,
   4124d:	8b 00                	mov    (%rax),%eax
   4124f:	48 8b 75 b8          	mov    -0x48(%rbp),%rsi
   41253:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   41257:	52                   	push   %rdx
   41258:	ff 75 b0             	push   -0x50(%rbp)
   4125b:	49 89 f1             	mov    %rsi,%r9
   4125e:	49 89 c8             	mov    %rcx,%r8
   41261:	89 c1                	mov    %eax,%ecx
   41263:	ba 10 42 04 00       	mov    $0x44210,%edx
   41268:	be 00 0c 00 00       	mov    $0xc00,%esi
   4126d:	bf 80 07 00 00       	mov    $0x780,%edi
   41272:	b8 00 00 00 00       	mov    $0x0,%eax
   41277:	e8 ec 2d 00 00       	call   44068 <console_printf>
   4127c:	48 83 c4 10          	add    $0x10,%rsp
        current->p_state = P_BROKEN;
   41280:	48 8b 05 79 cd 00 00 	mov    0xcd79(%rip),%rax        # 4e000 <current>
   41287:	c7 80 c8 00 00 00 03 	movl   $0x3,0xc8(%rax)
   4128e:	00 00 00 
        break;
   41291:	eb 15                	jmp    412a8 <exception+0x971>
    }

    default:
        default_exception(current);
   41293:	48 8b 05 66 cd 00 00 	mov    0xcd66(%rip),%rax        # 4e000 <current>
   4129a:	48 89 c7             	mov    %rax,%rdi
   4129d:	e8 c0 19 00 00       	call   42c62 <default_exception>
        break;                  /* will not be reached */
   412a2:	eb 04                	jmp    412a8 <exception+0x971>
            break;
   412a4:	90                   	nop
   412a5:	eb 01                	jmp    412a8 <exception+0x971>
            break;
   412a7:	90                   	nop

    }


    // Return to the current process (or run something else).
    if (current->p_state == P_RUNNABLE) {
   412a8:	48 8b 05 51 cd 00 00 	mov    0xcd51(%rip),%rax        # 4e000 <current>
   412af:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   412b5:	83 f8 01             	cmp    $0x1,%eax
   412b8:	75 0f                	jne    412c9 <exception+0x992>
        run(current);
   412ba:	48 8b 05 3f cd 00 00 	mov    0xcd3f(%rip),%rax        # 4e000 <current>
   412c1:	48 89 c7             	mov    %rax,%rdi
   412c4:	e8 7a 00 00 00       	call   41343 <run>
    } else {
        schedule();
   412c9:	e8 03 00 00 00       	call   412d1 <schedule>
    }
}
   412ce:	90                   	nop
   412cf:	c9                   	leave  
   412d0:	c3                   	ret    

00000000000412d1 <schedule>:

// schedule
//    Pick the next process to run and then run it.
//    If there are no runnable processes, spins forever.

void schedule(void) {
   412d1:	55                   	push   %rbp
   412d2:	48 89 e5             	mov    %rsp,%rbp
   412d5:	48 83 ec 10          	sub    $0x10,%rsp
    pid_t pid = current->p_pid;
   412d9:	48 8b 05 20 cd 00 00 	mov    0xcd20(%rip),%rax        # 4e000 <current>
   412e0:	8b 00                	mov    (%rax),%eax
   412e2:	89 45 fc             	mov    %eax,-0x4(%rbp)
    while (1) {
        pid = (pid + 1) % NPROC;
   412e5:	8b 45 fc             	mov    -0x4(%rbp),%eax
   412e8:	83 c0 01             	add    $0x1,%eax
   412eb:	99                   	cltd   
   412ec:	c1 ea 1c             	shr    $0x1c,%edx
   412ef:	01 d0                	add    %edx,%eax
   412f1:	83 e0 0f             	and    $0xf,%eax
   412f4:	29 d0                	sub    %edx,%eax
   412f6:	89 45 fc             	mov    %eax,-0x4(%rbp)
        if (processes[pid].p_state == P_RUNNABLE) {
   412f9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   412fc:	48 63 d0             	movslq %eax,%rdx
   412ff:	48 89 d0             	mov    %rdx,%rax
   41302:	48 c1 e0 03          	shl    $0x3,%rax
   41306:	48 29 d0             	sub    %rdx,%rax
   41309:	48 c1 e0 05          	shl    $0x5,%rax
   4130d:	48 05 e8 e0 04 00    	add    $0x4e0e8,%rax
   41313:	8b 00                	mov    (%rax),%eax
   41315:	83 f8 01             	cmp    $0x1,%eax
   41318:	75 22                	jne    4133c <schedule+0x6b>
            run(&processes[pid]);
   4131a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4131d:	48 63 d0             	movslq %eax,%rdx
   41320:	48 89 d0             	mov    %rdx,%rax
   41323:	48 c1 e0 03          	shl    $0x3,%rax
   41327:	48 29 d0             	sub    %rdx,%rax
   4132a:	48 c1 e0 05          	shl    $0x5,%rax
   4132e:	48 05 20 e0 04 00    	add    $0x4e020,%rax
   41334:	48 89 c7             	mov    %rax,%rdi
   41337:	e8 07 00 00 00       	call   41343 <run>
        }
        // If Control-C was typed, exit the virtual machine.
        check_keyboard();
   4133c:	e8 d0 16 00 00       	call   42a11 <check_keyboard>
        pid = (pid + 1) % NPROC;
   41341:	eb a2                	jmp    412e5 <schedule+0x14>

0000000000041343 <run>:
//    Run process `p`. This means reloading all the registers from
//    `p->p_registers` using the `popal`, `popl`, and `iret` instructions.
//
//    As a side effect, sets `current = p`.

void run(proc* p) {
   41343:	55                   	push   %rbp
   41344:	48 89 e5             	mov    %rsp,%rbp
   41347:	48 83 ec 10          	sub    $0x10,%rsp
   4134b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    assert(p->p_state == P_RUNNABLE);
   4134f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41353:	8b 80 c8 00 00 00    	mov    0xc8(%rax),%eax
   41359:	83 f8 01             	cmp    $0x1,%eax
   4135c:	74 14                	je     41372 <run+0x2f>
   4135e:	ba 98 43 04 00       	mov    $0x44398,%edx
   41363:	be 30 02 00 00       	mov    $0x230,%esi
   41368:	bf 78 41 04 00       	mov    $0x44178,%edi
   4136d:	e8 c0 18 00 00       	call   42c32 <assert_fail>
    current = p;
   41372:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41376:	48 89 05 83 cc 00 00 	mov    %rax,0xcc83(%rip)        # 4e000 <current>

    // Load the process's current pagetable.
    set_pagetable(p->p_pagetable);
   4137d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41381:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   41388:	48 89 c7             	mov    %rax,%rdi
   4138b:	e8 70 1a 00 00       	call   42e00 <set_pagetable>

    // This function is defined in k-exception.S. It restores the process's
    // registers then jumps back to user mode.
    exception_return(&p->p_registers);
   41390:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41394:	48 83 c0 08          	add    $0x8,%rax
   41398:	48 89 c7             	mov    %rax,%rdi
   4139b:	e8 23 ed ff ff       	call   400c3 <exception_return>

00000000000413a0 <pageinfo_init>:


// pageinfo_init
//    Initialize the `pageinfo[]` array.

void pageinfo_init(void) {
   413a0:	55                   	push   %rbp
   413a1:	48 89 e5             	mov    %rsp,%rbp
   413a4:	48 83 ec 10          	sub    $0x10,%rsp
    extern char end[];

    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   413a8:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   413af:	00 
   413b0:	e9 81 00 00 00       	jmp    41436 <pageinfo_init+0x96>
        int owner;
        if (physical_memory_isreserved(addr)) {
   413b5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   413b9:	48 89 c7             	mov    %rax,%rdi
   413bc:	e8 ef 0e 00 00       	call   422b0 <physical_memory_isreserved>
   413c1:	85 c0                	test   %eax,%eax
   413c3:	74 09                	je     413ce <pageinfo_init+0x2e>
            owner = PO_RESERVED;
   413c5:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%rbp)
   413cc:	eb 2f                	jmp    413fd <pageinfo_init+0x5d>
        } else if ((addr >= KERNEL_START_ADDR && addr < (uintptr_t) end)
   413ce:	48 81 7d f8 ff ff 03 	cmpq   $0x3ffff,-0x8(%rbp)
   413d5:	00 
   413d6:	76 0b                	jbe    413e3 <pageinfo_init+0x43>
   413d8:	b8 08 70 05 00       	mov    $0x57008,%eax
   413dd:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   413e1:	72 0a                	jb     413ed <pageinfo_init+0x4d>
                   || addr == KERNEL_STACK_TOP - PAGESIZE) {
   413e3:	48 81 7d f8 00 f0 07 	cmpq   $0x7f000,-0x8(%rbp)
   413ea:	00 
   413eb:	75 09                	jne    413f6 <pageinfo_init+0x56>
            owner = PO_KERNEL;
   413ed:	c7 45 f4 fe ff ff ff 	movl   $0xfffffffe,-0xc(%rbp)
   413f4:	eb 07                	jmp    413fd <pageinfo_init+0x5d>
        } else {
            owner = PO_FREE;
   413f6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
        }
        pageinfo[PAGENUMBER(addr)].owner = owner;
   413fd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41401:	48 c1 e8 0c          	shr    $0xc,%rax
   41405:	89 c1                	mov    %eax,%ecx
   41407:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4140a:	89 c2                	mov    %eax,%edx
   4140c:	48 63 c1             	movslq %ecx,%rax
   4140f:	88 94 00 40 ee 04 00 	mov    %dl,0x4ee40(%rax,%rax,1)
        pageinfo[PAGENUMBER(addr)].refcount = (owner != PO_FREE);
   41416:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   4141a:	0f 95 c2             	setne  %dl
   4141d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41421:	48 c1 e8 0c          	shr    $0xc,%rax
   41425:	48 98                	cltq   
   41427:	88 94 00 41 ee 04 00 	mov    %dl,0x4ee41(%rax,%rax,1)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   4142e:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   41435:	00 
   41436:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   4143d:	00 
   4143e:	0f 86 71 ff ff ff    	jbe    413b5 <pageinfo_init+0x15>
    }
}
   41444:	90                   	nop
   41445:	90                   	nop
   41446:	c9                   	leave  
   41447:	c3                   	ret    

0000000000041448 <check_page_table_mappings>:

// check_page_table_mappings
//    Check operating system invariants about kernel mappings for page
//    table `pt`. Panic if any of the invariants are false.

void check_page_table_mappings(x86_64_pagetable* pt) {
   41448:	55                   	push   %rbp
   41449:	48 89 e5             	mov    %rsp,%rbp
   4144c:	48 83 ec 50          	sub    $0x50,%rsp
   41450:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    extern char start_data[], end[];
    assert(PTE_ADDR(pt) == (uintptr_t) pt);
   41454:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   41458:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4145e:	48 89 c2             	mov    %rax,%rdx
   41461:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   41465:	48 39 c2             	cmp    %rax,%rdx
   41468:	74 14                	je     4147e <check_page_table_mappings+0x36>
   4146a:	ba b8 43 04 00       	mov    $0x443b8,%edx
   4146f:	be 5a 02 00 00       	mov    $0x25a,%esi
   41474:	bf 78 41 04 00       	mov    $0x44178,%edi
   41479:	e8 b4 17 00 00       	call   42c32 <assert_fail>

    // kernel memory is identity mapped; data is writable
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   4147e:	48 c7 45 f8 00 00 04 	movq   $0x40000,-0x8(%rbp)
   41485:	00 
   41486:	e9 9a 00 00 00       	jmp    41525 <check_page_table_mappings+0xdd>
         va += PAGESIZE) {
        vamapping vam = virtual_memory_lookup(pt, va);
   4148b:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
   4148f:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   41493:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   41497:	48 89 ce             	mov    %rcx,%rsi
   4149a:	48 89 c7             	mov    %rax,%rdi
   4149d:	e8 4a 1e 00 00       	call   432ec <virtual_memory_lookup>
        if (vam.pa != va) {
   414a2:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   414a6:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   414aa:	74 27                	je     414d3 <check_page_table_mappings+0x8b>
            console_printf(CPOS(22, 0), 0xC000, "%p vs %p\n", va, vam.pa);
   414ac:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   414b0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   414b4:	49 89 d0             	mov    %rdx,%r8
   414b7:	48 89 c1             	mov    %rax,%rcx
   414ba:	ba d7 43 04 00       	mov    $0x443d7,%edx
   414bf:	be 00 c0 00 00       	mov    $0xc000,%esi
   414c4:	bf e0 06 00 00       	mov    $0x6e0,%edi
   414c9:	b8 00 00 00 00       	mov    $0x0,%eax
   414ce:	e8 95 2b 00 00       	call   44068 <console_printf>
        }
        assert(vam.pa == va);
   414d3:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   414d7:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   414db:	74 14                	je     414f1 <check_page_table_mappings+0xa9>
   414dd:	ba e1 43 04 00       	mov    $0x443e1,%edx
   414e2:	be 63 02 00 00       	mov    $0x263,%esi
   414e7:	bf 78 41 04 00       	mov    $0x44178,%edi
   414ec:	e8 41 17 00 00       	call   42c32 <assert_fail>
        if (va >= (uintptr_t) start_data) {
   414f1:	b8 00 50 04 00       	mov    $0x45000,%eax
   414f6:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   414fa:	72 21                	jb     4151d <check_page_table_mappings+0xd5>
            assert(vam.perm & PTE_W);
   414fc:	8b 45 d0             	mov    -0x30(%rbp),%eax
   414ff:	48 98                	cltq   
   41501:	83 e0 02             	and    $0x2,%eax
   41504:	48 85 c0             	test   %rax,%rax
   41507:	75 14                	jne    4151d <check_page_table_mappings+0xd5>
   41509:	ba ee 43 04 00       	mov    $0x443ee,%edx
   4150e:	be 65 02 00 00       	mov    $0x265,%esi
   41513:	bf 78 41 04 00       	mov    $0x44178,%edi
   41518:	e8 15 17 00 00       	call   42c32 <assert_fail>
         va += PAGESIZE) {
   4151d:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   41524:	00 
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   41525:	b8 08 70 05 00       	mov    $0x57008,%eax
   4152a:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   4152e:	0f 82 57 ff ff ff    	jb     4148b <check_page_table_mappings+0x43>
        }
    }

    // kernel stack is identity mapped and writable
    uintptr_t kstack = KERNEL_STACK_TOP - PAGESIZE;
   41534:	48 c7 45 f0 00 f0 07 	movq   $0x7f000,-0x10(%rbp)
   4153b:	00 
    vamapping vam = virtual_memory_lookup(pt, kstack);
   4153c:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
   41540:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   41544:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   41548:	48 89 ce             	mov    %rcx,%rsi
   4154b:	48 89 c7             	mov    %rax,%rdi
   4154e:	e8 99 1d 00 00       	call   432ec <virtual_memory_lookup>
    assert(vam.pa == kstack);
   41553:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41557:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   4155b:	74 14                	je     41571 <check_page_table_mappings+0x129>
   4155d:	ba ff 43 04 00       	mov    $0x443ff,%edx
   41562:	be 6c 02 00 00       	mov    $0x26c,%esi
   41567:	bf 78 41 04 00       	mov    $0x44178,%edi
   4156c:	e8 c1 16 00 00       	call   42c32 <assert_fail>
    assert(vam.perm & PTE_W);
   41571:	8b 45 e8             	mov    -0x18(%rbp),%eax
   41574:	48 98                	cltq   
   41576:	83 e0 02             	and    $0x2,%eax
   41579:	48 85 c0             	test   %rax,%rax
   4157c:	75 14                	jne    41592 <check_page_table_mappings+0x14a>
   4157e:	ba ee 43 04 00       	mov    $0x443ee,%edx
   41583:	be 6d 02 00 00       	mov    $0x26d,%esi
   41588:	bf 78 41 04 00       	mov    $0x44178,%edi
   4158d:	e8 a0 16 00 00       	call   42c32 <assert_fail>
}
   41592:	90                   	nop
   41593:	c9                   	leave  
   41594:	c3                   	ret    

0000000000041595 <check_page_table_ownership>:
//    counts for page table `pt`. Panic if any of the invariants are false.

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount);

void check_page_table_ownership(x86_64_pagetable* pt, pid_t pid) {
   41595:	55                   	push   %rbp
   41596:	48 89 e5             	mov    %rsp,%rbp
   41599:	48 83 ec 20          	sub    $0x20,%rsp
   4159d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   415a1:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    // calculate expected reference count for page tables
    int owner = pid;
   415a4:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   415a7:	89 45 fc             	mov    %eax,-0x4(%rbp)
    int expected_refcount = 1;
   415aa:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    if (pt == kernel_pagetable) {
   415b1:	48 8b 05 48 fa 00 00 	mov    0xfa48(%rip),%rax        # 51000 <kernel_pagetable>
   415b8:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   415bc:	75 67                	jne    41625 <check_page_table_ownership+0x90>
        owner = PO_KERNEL;
   415be:	c7 45 fc fe ff ff ff 	movl   $0xfffffffe,-0x4(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   415c5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   415cc:	eb 51                	jmp    4161f <check_page_table_ownership+0x8a>
            if (processes[xpid].p_state != P_FREE
   415ce:	8b 45 f4             	mov    -0xc(%rbp),%eax
   415d1:	48 63 d0             	movslq %eax,%rdx
   415d4:	48 89 d0             	mov    %rdx,%rax
   415d7:	48 c1 e0 03          	shl    $0x3,%rax
   415db:	48 29 d0             	sub    %rdx,%rax
   415de:	48 c1 e0 05          	shl    $0x5,%rax
   415e2:	48 05 e8 e0 04 00    	add    $0x4e0e8,%rax
   415e8:	8b 00                	mov    (%rax),%eax
   415ea:	85 c0                	test   %eax,%eax
   415ec:	74 2d                	je     4161b <check_page_table_ownership+0x86>
                && processes[xpid].p_pagetable == kernel_pagetable) {
   415ee:	8b 45 f4             	mov    -0xc(%rbp),%eax
   415f1:	48 63 d0             	movslq %eax,%rdx
   415f4:	48 89 d0             	mov    %rdx,%rax
   415f7:	48 c1 e0 03          	shl    $0x3,%rax
   415fb:	48 29 d0             	sub    %rdx,%rax
   415fe:	48 c1 e0 05          	shl    $0x5,%rax
   41602:	48 05 f0 e0 04 00    	add    $0x4e0f0,%rax
   41608:	48 8b 10             	mov    (%rax),%rdx
   4160b:	48 8b 05 ee f9 00 00 	mov    0xf9ee(%rip),%rax        # 51000 <kernel_pagetable>
   41612:	48 39 c2             	cmp    %rax,%rdx
   41615:	75 04                	jne    4161b <check_page_table_ownership+0x86>
                ++expected_refcount;
   41617:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   4161b:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   4161f:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
   41623:	7e a9                	jle    415ce <check_page_table_ownership+0x39>
            }
        }
    }
    check_page_table_ownership_level(pt, 0, owner, expected_refcount);
   41625:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   41628:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4162b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4162f:	be 00 00 00 00       	mov    $0x0,%esi
   41634:	48 89 c7             	mov    %rax,%rdi
   41637:	e8 03 00 00 00       	call   4163f <check_page_table_ownership_level>
}
   4163c:	90                   	nop
   4163d:	c9                   	leave  
   4163e:	c3                   	ret    

000000000004163f <check_page_table_ownership_level>:

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount) {
   4163f:	55                   	push   %rbp
   41640:	48 89 e5             	mov    %rsp,%rbp
   41643:	48 83 ec 30          	sub    $0x30,%rsp
   41647:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4164b:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   4164e:	89 55 e0             	mov    %edx,-0x20(%rbp)
   41651:	89 4d dc             	mov    %ecx,-0x24(%rbp)
    assert(PAGENUMBER(pt) < NPAGES);
   41654:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41658:	48 c1 e8 0c          	shr    $0xc,%rax
   4165c:	3d ff 01 00 00       	cmp    $0x1ff,%eax
   41661:	7e 14                	jle    41677 <check_page_table_ownership_level+0x38>
   41663:	ba 10 44 04 00       	mov    $0x44410,%edx
   41668:	be 8a 02 00 00       	mov    $0x28a,%esi
   4166d:	bf 78 41 04 00       	mov    $0x44178,%edi
   41672:	e8 bb 15 00 00       	call   42c32 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].owner == owner);
   41677:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4167b:	48 c1 e8 0c          	shr    $0xc,%rax
   4167f:	48 98                	cltq   
   41681:	0f b6 84 00 40 ee 04 	movzbl 0x4ee40(%rax,%rax,1),%eax
   41688:	00 
   41689:	0f be c0             	movsbl %al,%eax
   4168c:	39 45 e0             	cmp    %eax,-0x20(%rbp)
   4168f:	74 14                	je     416a5 <check_page_table_ownership_level+0x66>
   41691:	ba 28 44 04 00       	mov    $0x44428,%edx
   41696:	be 8b 02 00 00       	mov    $0x28b,%esi
   4169b:	bf 78 41 04 00       	mov    $0x44178,%edi
   416a0:	e8 8d 15 00 00       	call   42c32 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].refcount == refcount);
   416a5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   416a9:	48 c1 e8 0c          	shr    $0xc,%rax
   416ad:	48 98                	cltq   
   416af:	0f b6 84 00 41 ee 04 	movzbl 0x4ee41(%rax,%rax,1),%eax
   416b6:	00 
   416b7:	0f be c0             	movsbl %al,%eax
   416ba:	39 45 dc             	cmp    %eax,-0x24(%rbp)
   416bd:	74 14                	je     416d3 <check_page_table_ownership_level+0x94>
   416bf:	ba 50 44 04 00       	mov    $0x44450,%edx
   416c4:	be 8c 02 00 00       	mov    $0x28c,%esi
   416c9:	bf 78 41 04 00       	mov    $0x44178,%edi
   416ce:	e8 5f 15 00 00       	call   42c32 <assert_fail>
    if (level < 3) {
   416d3:	83 7d e4 02          	cmpl   $0x2,-0x1c(%rbp)
   416d7:	7f 5b                	jg     41734 <check_page_table_ownership_level+0xf5>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   416d9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   416e0:	eb 49                	jmp    4172b <check_page_table_ownership_level+0xec>
            if (pt->entry[index]) {
   416e2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   416e6:	8b 55 fc             	mov    -0x4(%rbp),%edx
   416e9:	48 63 d2             	movslq %edx,%rdx
   416ec:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   416f0:	48 85 c0             	test   %rax,%rax
   416f3:	74 32                	je     41727 <check_page_table_ownership_level+0xe8>
                x86_64_pagetable* nextpt =
                    (x86_64_pagetable*) PTE_ADDR(pt->entry[index]);
   416f5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   416f9:	8b 55 fc             	mov    -0x4(%rbp),%edx
   416fc:	48 63 d2             	movslq %edx,%rdx
   416ff:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   41703:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
                x86_64_pagetable* nextpt =
   41709:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                check_page_table_ownership_level(nextpt, level + 1, owner, 1);
   4170d:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   41710:	8d 70 01             	lea    0x1(%rax),%esi
   41713:	8b 55 e0             	mov    -0x20(%rbp),%edx
   41716:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4171a:	b9 01 00 00 00       	mov    $0x1,%ecx
   4171f:	48 89 c7             	mov    %rax,%rdi
   41722:	e8 18 ff ff ff       	call   4163f <check_page_table_ownership_level>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   41727:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4172b:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   41732:	7e ae                	jle    416e2 <check_page_table_ownership_level+0xa3>
            }
        }
    }
}
   41734:	90                   	nop
   41735:	c9                   	leave  
   41736:	c3                   	ret    

0000000000041737 <check_virtual_memory>:

// check_virtual_memory
//    Check operating system invariants about virtual memory. Panic if any
//    of the invariants are false.

void check_virtual_memory(void) {
   41737:	55                   	push   %rbp
   41738:	48 89 e5             	mov    %rsp,%rbp
   4173b:	48 83 ec 10          	sub    $0x10,%rsp
    // Process 0 must never be used.
    assert(processes[0].p_state == P_FREE);
   4173f:	8b 05 a3 c9 00 00    	mov    0xc9a3(%rip),%eax        # 4e0e8 <processes+0xc8>
   41745:	85 c0                	test   %eax,%eax
   41747:	74 14                	je     4175d <check_virtual_memory+0x26>
   41749:	ba 80 44 04 00       	mov    $0x44480,%edx
   4174e:	be 9f 02 00 00       	mov    $0x29f,%esi
   41753:	bf 78 41 04 00       	mov    $0x44178,%edi
   41758:	e8 d5 14 00 00       	call   42c32 <assert_fail>
    // that don't have their own page tables.
    // Active processes have their own page tables. A process page table
    // should be owned by that process and have reference count 1.
    // All level-2-4 page tables must have reference count 1.

    check_page_table_mappings(kernel_pagetable);
   4175d:	48 8b 05 9c f8 00 00 	mov    0xf89c(%rip),%rax        # 51000 <kernel_pagetable>
   41764:	48 89 c7             	mov    %rax,%rdi
   41767:	e8 dc fc ff ff       	call   41448 <check_page_table_mappings>
    check_page_table_ownership(kernel_pagetable, -1);
   4176c:	48 8b 05 8d f8 00 00 	mov    0xf88d(%rip),%rax        # 51000 <kernel_pagetable>
   41773:	be ff ff ff ff       	mov    $0xffffffff,%esi
   41778:	48 89 c7             	mov    %rax,%rdi
   4177b:	e8 15 fe ff ff       	call   41595 <check_page_table_ownership>

    for (int pid = 0; pid < NPROC; ++pid) {
   41780:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41787:	e9 9c 00 00 00       	jmp    41828 <check_virtual_memory+0xf1>
        if (processes[pid].p_state != P_FREE
   4178c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4178f:	48 63 d0             	movslq %eax,%rdx
   41792:	48 89 d0             	mov    %rdx,%rax
   41795:	48 c1 e0 03          	shl    $0x3,%rax
   41799:	48 29 d0             	sub    %rdx,%rax
   4179c:	48 c1 e0 05          	shl    $0x5,%rax
   417a0:	48 05 e8 e0 04 00    	add    $0x4e0e8,%rax
   417a6:	8b 00                	mov    (%rax),%eax
   417a8:	85 c0                	test   %eax,%eax
   417aa:	74 78                	je     41824 <check_virtual_memory+0xed>
            && processes[pid].p_pagetable != kernel_pagetable) {
   417ac:	8b 45 fc             	mov    -0x4(%rbp),%eax
   417af:	48 63 d0             	movslq %eax,%rdx
   417b2:	48 89 d0             	mov    %rdx,%rax
   417b5:	48 c1 e0 03          	shl    $0x3,%rax
   417b9:	48 29 d0             	sub    %rdx,%rax
   417bc:	48 c1 e0 05          	shl    $0x5,%rax
   417c0:	48 05 f0 e0 04 00    	add    $0x4e0f0,%rax
   417c6:	48 8b 10             	mov    (%rax),%rdx
   417c9:	48 8b 05 30 f8 00 00 	mov    0xf830(%rip),%rax        # 51000 <kernel_pagetable>
   417d0:	48 39 c2             	cmp    %rax,%rdx
   417d3:	74 4f                	je     41824 <check_virtual_memory+0xed>
            check_page_table_mappings(processes[pid].p_pagetable);
   417d5:	8b 45 fc             	mov    -0x4(%rbp),%eax
   417d8:	48 63 d0             	movslq %eax,%rdx
   417db:	48 89 d0             	mov    %rdx,%rax
   417de:	48 c1 e0 03          	shl    $0x3,%rax
   417e2:	48 29 d0             	sub    %rdx,%rax
   417e5:	48 c1 e0 05          	shl    $0x5,%rax
   417e9:	48 05 f0 e0 04 00    	add    $0x4e0f0,%rax
   417ef:	48 8b 00             	mov    (%rax),%rax
   417f2:	48 89 c7             	mov    %rax,%rdi
   417f5:	e8 4e fc ff ff       	call   41448 <check_page_table_mappings>
            check_page_table_ownership(processes[pid].p_pagetable, pid);
   417fa:	8b 45 fc             	mov    -0x4(%rbp),%eax
   417fd:	48 63 d0             	movslq %eax,%rdx
   41800:	48 89 d0             	mov    %rdx,%rax
   41803:	48 c1 e0 03          	shl    $0x3,%rax
   41807:	48 29 d0             	sub    %rdx,%rax
   4180a:	48 c1 e0 05          	shl    $0x5,%rax
   4180e:	48 05 f0 e0 04 00    	add    $0x4e0f0,%rax
   41814:	48 8b 00             	mov    (%rax),%rax
   41817:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4181a:	89 d6                	mov    %edx,%esi
   4181c:	48 89 c7             	mov    %rax,%rdi
   4181f:	e8 71 fd ff ff       	call   41595 <check_page_table_ownership>
    for (int pid = 0; pid < NPROC; ++pid) {
   41824:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41828:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   4182c:	0f 8e 5a ff ff ff    	jle    4178c <check_virtual_memory+0x55>
        }
    }

    // Check that all referenced pages refer to active processes
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41832:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   41839:	eb 67                	jmp    418a2 <check_virtual_memory+0x16b>
        if (pageinfo[pn].refcount > 0 && pageinfo[pn].owner >= 0) {
   4183b:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4183e:	48 98                	cltq   
   41840:	0f b6 84 00 41 ee 04 	movzbl 0x4ee41(%rax,%rax,1),%eax
   41847:	00 
   41848:	84 c0                	test   %al,%al
   4184a:	7e 52                	jle    4189e <check_virtual_memory+0x167>
   4184c:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4184f:	48 98                	cltq   
   41851:	0f b6 84 00 40 ee 04 	movzbl 0x4ee40(%rax,%rax,1),%eax
   41858:	00 
   41859:	84 c0                	test   %al,%al
   4185b:	78 41                	js     4189e <check_virtual_memory+0x167>
            assert(processes[pageinfo[pn].owner].p_state != P_FREE);
   4185d:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41860:	48 98                	cltq   
   41862:	0f b6 84 00 40 ee 04 	movzbl 0x4ee40(%rax,%rax,1),%eax
   41869:	00 
   4186a:	0f be c0             	movsbl %al,%eax
   4186d:	48 63 d0             	movslq %eax,%rdx
   41870:	48 89 d0             	mov    %rdx,%rax
   41873:	48 c1 e0 03          	shl    $0x3,%rax
   41877:	48 29 d0             	sub    %rdx,%rax
   4187a:	48 c1 e0 05          	shl    $0x5,%rax
   4187e:	48 05 e8 e0 04 00    	add    $0x4e0e8,%rax
   41884:	8b 00                	mov    (%rax),%eax
   41886:	85 c0                	test   %eax,%eax
   41888:	75 14                	jne    4189e <check_virtual_memory+0x167>
   4188a:	ba a0 44 04 00       	mov    $0x444a0,%edx
   4188f:	be b6 02 00 00       	mov    $0x2b6,%esi
   41894:	bf 78 41 04 00       	mov    $0x44178,%edi
   41899:	e8 94 13 00 00       	call   42c32 <assert_fail>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   4189e:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   418a2:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
   418a9:	7e 90                	jle    4183b <check_virtual_memory+0x104>
        }
    }
}
   418ab:	90                   	nop
   418ac:	90                   	nop
   418ad:	c9                   	leave  
   418ae:	c3                   	ret    

00000000000418af <memshow_physical>:
    'E' | 0x0E00, 'F' | 0x0F00, 'S'
};
#define SHARED_COLOR memstate_colors[18]
#define SHARED

void memshow_physical(void) {
   418af:	55                   	push   %rbp
   418b0:	48 89 e5             	mov    %rsp,%rbp
   418b3:	48 83 ec 10          	sub    $0x10,%rsp
    console_printf(CPOS(0, 32), 0x0F00, "PHYSICAL MEMORY");
   418b7:	ba 06 45 04 00       	mov    $0x44506,%edx
   418bc:	be 00 0f 00 00       	mov    $0xf00,%esi
   418c1:	bf 20 00 00 00       	mov    $0x20,%edi
   418c6:	b8 00 00 00 00       	mov    $0x0,%eax
   418cb:	e8 98 27 00 00       	call   44068 <console_printf>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   418d0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   418d7:	e9 f4 00 00 00       	jmp    419d0 <memshow_physical+0x121>
        if (pn % 64 == 0) {
   418dc:	8b 45 fc             	mov    -0x4(%rbp),%eax
   418df:	83 e0 3f             	and    $0x3f,%eax
   418e2:	85 c0                	test   %eax,%eax
   418e4:	75 3e                	jne    41924 <memshow_physical+0x75>
            console_printf(CPOS(1 + pn / 64, 3), 0x0F00, "0x%06X ", pn << 12);
   418e6:	8b 45 fc             	mov    -0x4(%rbp),%eax
   418e9:	c1 e0 0c             	shl    $0xc,%eax
   418ec:	89 c2                	mov    %eax,%edx
   418ee:	8b 45 fc             	mov    -0x4(%rbp),%eax
   418f1:	8d 48 3f             	lea    0x3f(%rax),%ecx
   418f4:	85 c0                	test   %eax,%eax
   418f6:	0f 48 c1             	cmovs  %ecx,%eax
   418f9:	c1 f8 06             	sar    $0x6,%eax
   418fc:	8d 48 01             	lea    0x1(%rax),%ecx
   418ff:	89 c8                	mov    %ecx,%eax
   41901:	c1 e0 02             	shl    $0x2,%eax
   41904:	01 c8                	add    %ecx,%eax
   41906:	c1 e0 04             	shl    $0x4,%eax
   41909:	83 c0 03             	add    $0x3,%eax
   4190c:	89 d1                	mov    %edx,%ecx
   4190e:	ba 16 45 04 00       	mov    $0x44516,%edx
   41913:	be 00 0f 00 00       	mov    $0xf00,%esi
   41918:	89 c7                	mov    %eax,%edi
   4191a:	b8 00 00 00 00       	mov    $0x0,%eax
   4191f:	e8 44 27 00 00       	call   44068 <console_printf>
        }

        int owner = pageinfo[pn].owner;
   41924:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41927:	48 98                	cltq   
   41929:	0f b6 84 00 40 ee 04 	movzbl 0x4ee40(%rax,%rax,1),%eax
   41930:	00 
   41931:	0f be c0             	movsbl %al,%eax
   41934:	89 45 f8             	mov    %eax,-0x8(%rbp)
        if (pageinfo[pn].refcount == 0) {
   41937:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4193a:	48 98                	cltq   
   4193c:	0f b6 84 00 41 ee 04 	movzbl 0x4ee41(%rax,%rax,1),%eax
   41943:	00 
   41944:	84 c0                	test   %al,%al
   41946:	75 07                	jne    4194f <memshow_physical+0xa0>
            owner = PO_FREE;
   41948:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
        }
        uint16_t color = memstate_colors[owner - PO_KERNEL];
   4194f:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41952:	83 c0 02             	add    $0x2,%eax
   41955:	48 98                	cltq   
   41957:	0f b7 84 00 e0 44 04 	movzwl 0x444e0(%rax,%rax,1),%eax
   4195e:	00 
   4195f:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
        // darker color for shared pages
        if (pageinfo[pn].refcount > 1 && pn != PAGENUMBER(CONSOLE_ADDR)){
   41963:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41966:	48 98                	cltq   
   41968:	0f b6 84 00 41 ee 04 	movzbl 0x4ee41(%rax,%rax,1),%eax
   4196f:	00 
   41970:	3c 01                	cmp    $0x1,%al
   41972:	7e 1a                	jle    4198e <memshow_physical+0xdf>
   41974:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   41979:	48 c1 e8 0c          	shr    $0xc,%rax
   4197d:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   41980:	74 0c                	je     4198e <memshow_physical+0xdf>
#ifdef SHARED
            color = SHARED_COLOR | 0x0F00;
   41982:	b8 53 00 00 00       	mov    $0x53,%eax
   41987:	80 cc 0f             	or     $0xf,%ah
   4198a:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
#else
	    color &= 0x77FF;
#endif
        }

        console[CPOS(1 + pn / 64, 12 + pn % 64)] = color;
   4198e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41991:	8d 50 3f             	lea    0x3f(%rax),%edx
   41994:	85 c0                	test   %eax,%eax
   41996:	0f 48 c2             	cmovs  %edx,%eax
   41999:	c1 f8 06             	sar    $0x6,%eax
   4199c:	8d 50 01             	lea    0x1(%rax),%edx
   4199f:	89 d0                	mov    %edx,%eax
   419a1:	c1 e0 02             	shl    $0x2,%eax
   419a4:	01 d0                	add    %edx,%eax
   419a6:	c1 e0 04             	shl    $0x4,%eax
   419a9:	89 c1                	mov    %eax,%ecx
   419ab:	8b 45 fc             	mov    -0x4(%rbp),%eax
   419ae:	99                   	cltd   
   419af:	c1 ea 1a             	shr    $0x1a,%edx
   419b2:	01 d0                	add    %edx,%eax
   419b4:	83 e0 3f             	and    $0x3f,%eax
   419b7:	29 d0                	sub    %edx,%eax
   419b9:	83 c0 0c             	add    $0xc,%eax
   419bc:	01 c8                	add    %ecx,%eax
   419be:	48 98                	cltq   
   419c0:	0f b7 55 f6          	movzwl -0xa(%rbp),%edx
   419c4:	66 89 94 00 00 80 0b 	mov    %dx,0xb8000(%rax,%rax,1)
   419cb:	00 
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   419cc:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   419d0:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   419d7:	0f 8e ff fe ff ff    	jle    418dc <memshow_physical+0x2d>
    }
}
   419dd:	90                   	nop
   419de:	90                   	nop
   419df:	c9                   	leave  
   419e0:	c3                   	ret    

00000000000419e1 <memshow_virtual>:

// memshow_virtual(pagetable, name)
//    Draw a picture of the virtual memory map `pagetable` (named `name`) on
//    the CGA console.

void memshow_virtual(x86_64_pagetable* pagetable, const char* name) {
   419e1:	55                   	push   %rbp
   419e2:	48 89 e5             	mov    %rsp,%rbp
   419e5:	48 83 ec 40          	sub    $0x40,%rsp
   419e9:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   419ed:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
    assert((uintptr_t) pagetable == PTE_ADDR(pagetable));
   419f1:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   419f5:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   419fb:	48 89 c2             	mov    %rax,%rdx
   419fe:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41a02:	48 39 c2             	cmp    %rax,%rdx
   41a05:	74 14                	je     41a1b <memshow_virtual+0x3a>
   41a07:	ba 20 45 04 00       	mov    $0x44520,%edx
   41a0c:	be e7 02 00 00       	mov    $0x2e7,%esi
   41a11:	bf 78 41 04 00       	mov    $0x44178,%edi
   41a16:	e8 17 12 00 00       	call   42c32 <assert_fail>

    console_printf(CPOS(10, 26), 0x0F00, "VIRTUAL ADDRESS SPACE FOR %s", name);
   41a1b:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   41a1f:	48 89 c1             	mov    %rax,%rcx
   41a22:	ba 4d 45 04 00       	mov    $0x4454d,%edx
   41a27:	be 00 0f 00 00       	mov    $0xf00,%esi
   41a2c:	bf 3a 03 00 00       	mov    $0x33a,%edi
   41a31:	b8 00 00 00 00       	mov    $0x0,%eax
   41a36:	e8 2d 26 00 00       	call   44068 <console_printf>
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   41a3b:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   41a42:	00 
   41a43:	e9 80 01 00 00       	jmp    41bc8 <memshow_virtual+0x1e7>
        vamapping vam = virtual_memory_lookup(pagetable, va);
   41a48:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   41a4c:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   41a50:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   41a54:	48 89 ce             	mov    %rcx,%rsi
   41a57:	48 89 c7             	mov    %rax,%rdi
   41a5a:	e8 8d 18 00 00       	call   432ec <virtual_memory_lookup>
        uint16_t color;
        if (vam.pn < 0) {
   41a5f:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41a62:	85 c0                	test   %eax,%eax
   41a64:	79 0b                	jns    41a71 <memshow_virtual+0x90>
            color = ' ';
   41a66:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%rbp)
   41a6c:	e9 d7 00 00 00       	jmp    41b48 <memshow_virtual+0x167>
        } else {
            assert(vam.pa < MEMSIZE_PHYSICAL);
   41a71:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   41a75:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   41a7b:	76 14                	jbe    41a91 <memshow_virtual+0xb0>
   41a7d:	ba 6a 45 04 00       	mov    $0x4456a,%edx
   41a82:	be f0 02 00 00       	mov    $0x2f0,%esi
   41a87:	bf 78 41 04 00       	mov    $0x44178,%edi
   41a8c:	e8 a1 11 00 00       	call   42c32 <assert_fail>
            int owner = pageinfo[vam.pn].owner;
   41a91:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41a94:	48 98                	cltq   
   41a96:	0f b6 84 00 40 ee 04 	movzbl 0x4ee40(%rax,%rax,1),%eax
   41a9d:	00 
   41a9e:	0f be c0             	movsbl %al,%eax
   41aa1:	89 45 f0             	mov    %eax,-0x10(%rbp)
            if (pageinfo[vam.pn].refcount == 0) {
   41aa4:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41aa7:	48 98                	cltq   
   41aa9:	0f b6 84 00 41 ee 04 	movzbl 0x4ee41(%rax,%rax,1),%eax
   41ab0:	00 
   41ab1:	84 c0                	test   %al,%al
   41ab3:	75 07                	jne    41abc <memshow_virtual+0xdb>
                owner = PO_FREE;
   41ab5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
            }
            color = memstate_colors[owner - PO_KERNEL];
   41abc:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41abf:	83 c0 02             	add    $0x2,%eax
   41ac2:	48 98                	cltq   
   41ac4:	0f b7 84 00 e0 44 04 	movzwl 0x444e0(%rax,%rax,1),%eax
   41acb:	00 
   41acc:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            // reverse video for user-accessible pages
            if (vam.perm & PTE_U) {
   41ad0:	8b 45 e0             	mov    -0x20(%rbp),%eax
   41ad3:	48 98                	cltq   
   41ad5:	83 e0 04             	and    $0x4,%eax
   41ad8:	48 85 c0             	test   %rax,%rax
   41adb:	74 27                	je     41b04 <memshow_virtual+0x123>
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   41add:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41ae1:	c1 e0 04             	shl    $0x4,%eax
   41ae4:	66 25 00 f0          	and    $0xf000,%ax
   41ae8:	89 c2                	mov    %eax,%edx
   41aea:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41aee:	c1 f8 04             	sar    $0x4,%eax
   41af1:	66 25 00 0f          	and    $0xf00,%ax
   41af5:	09 c2                	or     %eax,%edx
                    | (color & 0x00FF);
   41af7:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41afb:	0f b6 c0             	movzbl %al,%eax
   41afe:	09 d0                	or     %edx,%eax
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   41b00:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            }
            // darker color for shared pages
            if (pageinfo[vam.pn].refcount > 1 && va != CONSOLE_ADDR) {
   41b04:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41b07:	48 98                	cltq   
   41b09:	0f b6 84 00 41 ee 04 	movzbl 0x4ee41(%rax,%rax,1),%eax
   41b10:	00 
   41b11:	3c 01                	cmp    $0x1,%al
   41b13:	7e 33                	jle    41b48 <memshow_virtual+0x167>
   41b15:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   41b1a:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   41b1e:	74 28                	je     41b48 <memshow_virtual+0x167>
#ifdef SHARED
                color = (SHARED_COLOR | (color & 0xF000));
   41b20:	b8 53 00 00 00       	mov    $0x53,%eax
   41b25:	89 c2                	mov    %eax,%edx
   41b27:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41b2b:	66 25 00 f0          	and    $0xf000,%ax
   41b2f:	09 d0                	or     %edx,%eax
   41b31:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
                if(! (vam.perm & PTE_U))
   41b35:	8b 45 e0             	mov    -0x20(%rbp),%eax
   41b38:	48 98                	cltq   
   41b3a:	83 e0 04             	and    $0x4,%eax
   41b3d:	48 85 c0             	test   %rax,%rax
   41b40:	75 06                	jne    41b48 <memshow_virtual+0x167>
                    color = color | 0x0F00;
   41b42:	66 81 4d f6 00 0f    	orw    $0xf00,-0xa(%rbp)
#else
		color &= 0x77FF;
#endif
            }
        }
        uint32_t pn = PAGENUMBER(va);
   41b48:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41b4c:	48 c1 e8 0c          	shr    $0xc,%rax
   41b50:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (pn % 64 == 0) {
   41b53:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41b56:	83 e0 3f             	and    $0x3f,%eax
   41b59:	85 c0                	test   %eax,%eax
   41b5b:	75 34                	jne    41b91 <memshow_virtual+0x1b0>
            console_printf(CPOS(11 + pn / 64, 3), 0x0F00, "0x%06X ", va);
   41b5d:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41b60:	c1 e8 06             	shr    $0x6,%eax
   41b63:	89 c2                	mov    %eax,%edx
   41b65:	89 d0                	mov    %edx,%eax
   41b67:	c1 e0 02             	shl    $0x2,%eax
   41b6a:	01 d0                	add    %edx,%eax
   41b6c:	c1 e0 04             	shl    $0x4,%eax
   41b6f:	05 73 03 00 00       	add    $0x373,%eax
   41b74:	89 c7                	mov    %eax,%edi
   41b76:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41b7a:	48 89 c1             	mov    %rax,%rcx
   41b7d:	ba 16 45 04 00       	mov    $0x44516,%edx
   41b82:	be 00 0f 00 00       	mov    $0xf00,%esi
   41b87:	b8 00 00 00 00       	mov    $0x0,%eax
   41b8c:	e8 d7 24 00 00       	call   44068 <console_printf>
        }
        console[CPOS(11 + pn / 64, 12 + pn % 64)] = color;
   41b91:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41b94:	c1 e8 06             	shr    $0x6,%eax
   41b97:	89 c2                	mov    %eax,%edx
   41b99:	89 d0                	mov    %edx,%eax
   41b9b:	c1 e0 02             	shl    $0x2,%eax
   41b9e:	01 d0                	add    %edx,%eax
   41ba0:	c1 e0 04             	shl    $0x4,%eax
   41ba3:	89 c2                	mov    %eax,%edx
   41ba5:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41ba8:	83 e0 3f             	and    $0x3f,%eax
   41bab:	01 d0                	add    %edx,%eax
   41bad:	05 7c 03 00 00       	add    $0x37c,%eax
   41bb2:	89 c2                	mov    %eax,%edx
   41bb4:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   41bb8:	66 89 84 12 00 80 0b 	mov    %ax,0xb8000(%rdx,%rdx,1)
   41bbf:	00 
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   41bc0:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   41bc7:	00 
   41bc8:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   41bcf:	00 
   41bd0:	0f 86 72 fe ff ff    	jbe    41a48 <memshow_virtual+0x67>
    }
}
   41bd6:	90                   	nop
   41bd7:	90                   	nop
   41bd8:	c9                   	leave  
   41bd9:	c3                   	ret    

0000000000041bda <memshow_virtual_animate>:

// memshow_virtual_animate
//    Draw a picture of process virtual memory maps on the CGA console.
//    Starts with process 1, then switches to a new process every 0.25 sec.

void memshow_virtual_animate(void) {
   41bda:	55                   	push   %rbp
   41bdb:	48 89 e5             	mov    %rsp,%rbp
   41bde:	48 83 ec 10          	sub    $0x10,%rsp
    static unsigned last_ticks = 0;
    static int showing = 1;

    // switch to a new process every 0.25 sec
    if (last_ticks == 0 || ticks - last_ticks >= HZ / 2) {
   41be2:	8b 05 58 d6 00 00    	mov    0xd658(%rip),%eax        # 4f240 <last_ticks.1>
   41be8:	85 c0                	test   %eax,%eax
   41bea:	74 13                	je     41bff <memshow_virtual_animate+0x25>
   41bec:	8b 05 2e d2 00 00    	mov    0xd22e(%rip),%eax        # 4ee20 <ticks>
   41bf2:	8b 15 48 d6 00 00    	mov    0xd648(%rip),%edx        # 4f240 <last_ticks.1>
   41bf8:	29 d0                	sub    %edx,%eax
   41bfa:	83 f8 31             	cmp    $0x31,%eax
   41bfd:	76 2c                	jbe    41c2b <memshow_virtual_animate+0x51>
        last_ticks = ticks;
   41bff:	8b 05 1b d2 00 00    	mov    0xd21b(%rip),%eax        # 4ee20 <ticks>
   41c05:	89 05 35 d6 00 00    	mov    %eax,0xd635(%rip)        # 4f240 <last_ticks.1>
        ++showing;
   41c0b:	8b 05 f3 33 00 00    	mov    0x33f3(%rip),%eax        # 45004 <showing.0>
   41c11:	83 c0 01             	add    $0x1,%eax
   41c14:	89 05 ea 33 00 00    	mov    %eax,0x33ea(%rip)        # 45004 <showing.0>
    }

    // the current process may have died -- don't display it if so
    while (showing <= 2*NPROC
   41c1a:	eb 0f                	jmp    41c2b <memshow_virtual_animate+0x51>
           && processes[showing % NPROC].p_state == P_FREE) {
        ++showing;
   41c1c:	8b 05 e2 33 00 00    	mov    0x33e2(%rip),%eax        # 45004 <showing.0>
   41c22:	83 c0 01             	add    $0x1,%eax
   41c25:	89 05 d9 33 00 00    	mov    %eax,0x33d9(%rip)        # 45004 <showing.0>
    while (showing <= 2*NPROC
   41c2b:	8b 05 d3 33 00 00    	mov    0x33d3(%rip),%eax        # 45004 <showing.0>
           && processes[showing % NPROC].p_state == P_FREE) {
   41c31:	83 f8 20             	cmp    $0x20,%eax
   41c34:	7f 2e                	jg     41c64 <memshow_virtual_animate+0x8a>
   41c36:	8b 05 c8 33 00 00    	mov    0x33c8(%rip),%eax        # 45004 <showing.0>
   41c3c:	99                   	cltd   
   41c3d:	c1 ea 1c             	shr    $0x1c,%edx
   41c40:	01 d0                	add    %edx,%eax
   41c42:	83 e0 0f             	and    $0xf,%eax
   41c45:	29 d0                	sub    %edx,%eax
   41c47:	48 63 d0             	movslq %eax,%rdx
   41c4a:	48 89 d0             	mov    %rdx,%rax
   41c4d:	48 c1 e0 03          	shl    $0x3,%rax
   41c51:	48 29 d0             	sub    %rdx,%rax
   41c54:	48 c1 e0 05          	shl    $0x5,%rax
   41c58:	48 05 e8 e0 04 00    	add    $0x4e0e8,%rax
   41c5e:	8b 00                	mov    (%rax),%eax
   41c60:	85 c0                	test   %eax,%eax
   41c62:	74 b8                	je     41c1c <memshow_virtual_animate+0x42>
    }
    showing = showing % NPROC;
   41c64:	8b 05 9a 33 00 00    	mov    0x339a(%rip),%eax        # 45004 <showing.0>
   41c6a:	99                   	cltd   
   41c6b:	c1 ea 1c             	shr    $0x1c,%edx
   41c6e:	01 d0                	add    %edx,%eax
   41c70:	83 e0 0f             	and    $0xf,%eax
   41c73:	29 d0                	sub    %edx,%eax
   41c75:	89 05 89 33 00 00    	mov    %eax,0x3389(%rip)        # 45004 <showing.0>

    if (processes[showing].p_state != P_FREE) {
   41c7b:	8b 05 83 33 00 00    	mov    0x3383(%rip),%eax        # 45004 <showing.0>
   41c81:	48 63 d0             	movslq %eax,%rdx
   41c84:	48 89 d0             	mov    %rdx,%rax
   41c87:	48 c1 e0 03          	shl    $0x3,%rax
   41c8b:	48 29 d0             	sub    %rdx,%rax
   41c8e:	48 c1 e0 05          	shl    $0x5,%rax
   41c92:	48 05 e8 e0 04 00    	add    $0x4e0e8,%rax
   41c98:	8b 00                	mov    (%rax),%eax
   41c9a:	85 c0                	test   %eax,%eax
   41c9c:	74 52                	je     41cf0 <memshow_virtual_animate+0x116>
        char s[4];
        snprintf(s, 4, "%d ", showing);
   41c9e:	8b 15 60 33 00 00    	mov    0x3360(%rip),%edx        # 45004 <showing.0>
   41ca4:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
   41ca8:	89 d1                	mov    %edx,%ecx
   41caa:	ba 84 45 04 00       	mov    $0x44584,%edx
   41caf:	be 04 00 00 00       	mov    $0x4,%esi
   41cb4:	48 89 c7             	mov    %rax,%rdi
   41cb7:	b8 00 00 00 00       	mov    $0x0,%eax
   41cbc:	e8 25 24 00 00       	call   440e6 <snprintf>
        memshow_virtual(processes[showing].p_pagetable, s);
   41cc1:	8b 05 3d 33 00 00    	mov    0x333d(%rip),%eax        # 45004 <showing.0>
   41cc7:	48 63 d0             	movslq %eax,%rdx
   41cca:	48 89 d0             	mov    %rdx,%rax
   41ccd:	48 c1 e0 03          	shl    $0x3,%rax
   41cd1:	48 29 d0             	sub    %rdx,%rax
   41cd4:	48 c1 e0 05          	shl    $0x5,%rax
   41cd8:	48 05 f0 e0 04 00    	add    $0x4e0f0,%rax
   41cde:	48 8b 00             	mov    (%rax),%rax
   41ce1:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
   41ce5:	48 89 d6             	mov    %rdx,%rsi
   41ce8:	48 89 c7             	mov    %rax,%rdi
   41ceb:	e8 f1 fc ff ff       	call   419e1 <memshow_virtual>
    }
}
   41cf0:	90                   	nop
   41cf1:	c9                   	leave  
   41cf2:	c3                   	ret    

0000000000041cf3 <hardware_init>:

static void segments_init(void);
static void interrupt_init(void);
extern void virtual_memory_init(void);

void hardware_init(void) {
   41cf3:	55                   	push   %rbp
   41cf4:	48 89 e5             	mov    %rsp,%rbp
    segments_init();
   41cf7:	e8 53 01 00 00       	call   41e4f <segments_init>
    interrupt_init();
   41cfc:	e8 d4 03 00 00       	call   420d5 <interrupt_init>
    virtual_memory_init();
   41d01:	e8 e7 0f 00 00       	call   42ced <virtual_memory_init>
}
   41d06:	90                   	nop
   41d07:	5d                   	pop    %rbp
   41d08:	c3                   	ret    

0000000000041d09 <set_app_segment>:
#define SEGSEL_TASKSTATE        0x28            // task state segment

// Segments
static uint64_t segments[7];

static void set_app_segment(uint64_t* segment, uint64_t type, int dpl) {
   41d09:	55                   	push   %rbp
   41d0a:	48 89 e5             	mov    %rsp,%rbp
   41d0d:	48 83 ec 18          	sub    $0x18,%rsp
   41d11:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41d15:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41d19:	89 55 ec             	mov    %edx,-0x14(%rbp)
    *segment = type
        | X86SEG_S                    // code/data segment
        | ((uint64_t) dpl << 45)
   41d1c:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41d1f:	48 98                	cltq   
   41d21:	48 c1 e0 2d          	shl    $0x2d,%rax
   41d25:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | X86SEG_P;                   // segment present
   41d29:	48 ba 00 00 00 00 00 	movabs $0x900000000000,%rdx
   41d30:	90 00 00 
   41d33:	48 09 c2             	or     %rax,%rdx
    *segment = type
   41d36:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41d3a:	48 89 10             	mov    %rdx,(%rax)
}
   41d3d:	90                   	nop
   41d3e:	c9                   	leave  
   41d3f:	c3                   	ret    

0000000000041d40 <set_sys_segment>:

static void set_sys_segment(uint64_t* segment, uint64_t type, int dpl,
                            uintptr_t addr, size_t size) {
   41d40:	55                   	push   %rbp
   41d41:	48 89 e5             	mov    %rsp,%rbp
   41d44:	48 83 ec 28          	sub    $0x28,%rsp
   41d48:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41d4c:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41d50:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41d53:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
   41d57:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41d5b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41d5f:	48 c1 e0 10          	shl    $0x10,%rax
   41d63:	48 89 c2             	mov    %rax,%rdx
   41d66:	48 b8 00 00 ff ff ff 	movabs $0xffffff0000,%rax
   41d6d:	00 00 00 
   41d70:	48 21 c2             	and    %rax,%rdx
        | ((addr & 0x00000000FF000000UL) << 32)
   41d73:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41d77:	48 c1 e0 20          	shl    $0x20,%rax
   41d7b:	48 89 c1             	mov    %rax,%rcx
   41d7e:	48 b8 00 00 00 00 00 	movabs $0xff00000000000000,%rax
   41d85:	00 00 ff 
   41d88:	48 21 c8             	and    %rcx,%rax
   41d8b:	48 09 c2             	or     %rax,%rdx
        | ((size - 1) & 0x0FFFFUL)
   41d8e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   41d92:	48 83 e8 01          	sub    $0x1,%rax
   41d96:	0f b7 c0             	movzwl %ax,%eax
        | (((size - 1) & 0xF0000UL) << 48)
   41d99:	48 09 d0             	or     %rdx,%rax
        | type
   41d9c:	48 0b 45 f0          	or     -0x10(%rbp),%rax
   41da0:	48 89 c2             	mov    %rax,%rdx
        | ((uint64_t) dpl << 45)
   41da3:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41da6:	48 98                	cltq   
   41da8:	48 c1 e0 2d          	shl    $0x2d,%rax
   41dac:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P;                   // segment present
   41daf:	48 b8 00 00 00 00 00 	movabs $0x800000000000,%rax
   41db6:	80 00 00 
   41db9:	48 09 c2             	or     %rax,%rdx
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   41dbc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41dc0:	48 89 10             	mov    %rdx,(%rax)
    segment[1] = addr >> 32;
   41dc3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41dc7:	48 83 c0 08          	add    $0x8,%rax
   41dcb:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   41dcf:	48 c1 ea 20          	shr    $0x20,%rdx
   41dd3:	48 89 10             	mov    %rdx,(%rax)
}
   41dd6:	90                   	nop
   41dd7:	c9                   	leave  
   41dd8:	c3                   	ret    

0000000000041dd9 <set_gate>:

// Processor state for taking an interrupt
static x86_64_taskstate kernel_task_descriptor;

static void set_gate(x86_64_gatedescriptor* gate, uint64_t type, int dpl,
                     uintptr_t function) {
   41dd9:	55                   	push   %rbp
   41dda:	48 89 e5             	mov    %rsp,%rbp
   41ddd:	48 83 ec 20          	sub    $0x20,%rsp
   41de1:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41de5:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41de9:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41dec:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41df0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41df4:	0f b7 c0             	movzwl %ax,%eax
        | (SEGSEL_KERN_CODE << 16)
        | type
   41df7:	48 0b 45 f0          	or     -0x10(%rbp),%rax
   41dfb:	48 89 c2             	mov    %rax,%rdx
        | ((uint64_t) dpl << 45)
   41dfe:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41e01:	48 98                	cltq   
   41e03:	48 c1 e0 2d          	shl    $0x2d,%rax
   41e07:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P
        | ((function & 0x00000000FFFF0000UL) << 32);
   41e0a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41e0e:	48 c1 e0 20          	shl    $0x20,%rax
   41e12:	48 89 c1             	mov    %rax,%rcx
   41e15:	48 b8 00 00 00 00 00 	movabs $0xffff000000000000,%rax
   41e1c:	00 ff ff 
   41e1f:	48 21 c8             	and    %rcx,%rax
   41e22:	48 09 c2             	or     %rax,%rdx
   41e25:	48 b8 00 00 08 00 00 	movabs $0x800000080000,%rax
   41e2c:	80 00 00 
   41e2f:	48 09 c2             	or     %rax,%rdx
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41e32:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e36:	48 89 10             	mov    %rdx,(%rax)
    gate->gd_high = function >> 32;
   41e39:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41e3d:	48 c1 e8 20          	shr    $0x20,%rax
   41e41:	48 89 c2             	mov    %rax,%rdx
   41e44:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e48:	48 89 50 08          	mov    %rdx,0x8(%rax)
}
   41e4c:	90                   	nop
   41e4d:	c9                   	leave  
   41e4e:	c3                   	ret    

0000000000041e4f <segments_init>:
extern void default_int_handler(void);
extern void gpf_int_handler(void);
extern void pagefault_int_handler(void);
extern void timer_int_handler(void);

void segments_init(void) {
   41e4f:	55                   	push   %rbp
   41e50:	48 89 e5             	mov    %rsp,%rbp
   41e53:	48 83 ec 40          	sub    $0x40,%rsp
    // Segments for kernel & user code & data
    // The privilege level, which can be 0 or 3, differentiates between
    // kernel and user code. (Data segments are unused in WeensyOS.)
    segments[0] = 0;
   41e57:	48 c7 05 fe d3 00 00 	movq   $0x0,0xd3fe(%rip)        # 4f260 <segments>
   41e5e:	00 00 00 00 
    set_app_segment(&segments[SEGSEL_KERN_CODE >> 3], X86SEG_X | X86SEG_L, 0);
   41e62:	ba 00 00 00 00       	mov    $0x0,%edx
   41e67:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   41e6e:	08 20 00 
   41e71:	48 89 c6             	mov    %rax,%rsi
   41e74:	bf 68 f2 04 00       	mov    $0x4f268,%edi
   41e79:	e8 8b fe ff ff       	call   41d09 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_CODE >> 3], X86SEG_X | X86SEG_L, 3);
   41e7e:	ba 03 00 00 00       	mov    $0x3,%edx
   41e83:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   41e8a:	08 20 00 
   41e8d:	48 89 c6             	mov    %rax,%rsi
   41e90:	bf 70 f2 04 00       	mov    $0x4f270,%edi
   41e95:	e8 6f fe ff ff       	call   41d09 <set_app_segment>
    set_app_segment(&segments[SEGSEL_KERN_DATA >> 3], X86SEG_W, 0);
   41e9a:	ba 00 00 00 00       	mov    $0x0,%edx
   41e9f:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41ea6:	02 00 00 
   41ea9:	48 89 c6             	mov    %rax,%rsi
   41eac:	bf 78 f2 04 00       	mov    $0x4f278,%edi
   41eb1:	e8 53 fe ff ff       	call   41d09 <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_DATA >> 3], X86SEG_W, 3);
   41eb6:	ba 03 00 00 00       	mov    $0x3,%edx
   41ebb:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   41ec2:	02 00 00 
   41ec5:	48 89 c6             	mov    %rax,%rsi
   41ec8:	bf 80 f2 04 00       	mov    $0x4f280,%edi
   41ecd:	e8 37 fe ff ff       	call   41d09 <set_app_segment>
    set_sys_segment(&segments[SEGSEL_TASKSTATE >> 3], X86SEG_TSS, 0,
   41ed2:	b8 a0 02 05 00       	mov    $0x502a0,%eax
   41ed7:	41 b8 60 00 00 00    	mov    $0x60,%r8d
   41edd:	48 89 c1             	mov    %rax,%rcx
   41ee0:	ba 00 00 00 00       	mov    $0x0,%edx
   41ee5:	48 b8 00 00 00 00 00 	movabs $0x90000000000,%rax
   41eec:	09 00 00 
   41eef:	48 89 c6             	mov    %rax,%rsi
   41ef2:	bf 88 f2 04 00       	mov    $0x4f288,%edi
   41ef7:	e8 44 fe ff ff       	call   41d40 <set_sys_segment>
                    (uintptr_t) &kernel_task_descriptor,
                    sizeof(kernel_task_descriptor));

    x86_64_pseudodescriptor gdt;
    gdt.pseudod_limit = sizeof(segments) - 1;
   41efc:	66 c7 45 d6 37 00    	movw   $0x37,-0x2a(%rbp)
    gdt.pseudod_base = (uint64_t) segments;
   41f02:	b8 60 f2 04 00       	mov    $0x4f260,%eax
   41f07:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

    // Kernel task descriptor lets us receive interrupts
    memset(&kernel_task_descriptor, 0, sizeof(kernel_task_descriptor));
   41f0b:	ba 60 00 00 00       	mov    $0x60,%edx
   41f10:	be 00 00 00 00       	mov    $0x0,%esi
   41f15:	bf a0 02 05 00       	mov    $0x502a0,%edi
   41f1a:	e8 14 19 00 00       	call   43833 <memset>
    kernel_task_descriptor.ts_rsp[0] = KERNEL_STACK_TOP;
   41f1f:	48 c7 05 7a e3 00 00 	movq   $0x80000,0xe37a(%rip)        # 502a4 <kernel_task_descriptor+0x4>
   41f26:	00 00 08 00 

    // Interrupt handler; most interrupts are effectively ignored
    memset(interrupt_descriptors, 0, sizeof(interrupt_descriptors));
   41f2a:	ba 00 10 00 00       	mov    $0x1000,%edx
   41f2f:	be 00 00 00 00       	mov    $0x0,%esi
   41f34:	bf a0 f2 04 00       	mov    $0x4f2a0,%edi
   41f39:	e8 f5 18 00 00       	call   43833 <memset>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41f3e:	c7 45 fc 10 00 00 00 	movl   $0x10,-0x4(%rbp)
   41f45:	eb 30                	jmp    41f77 <segments_init+0x128>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 0,
   41f47:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   41f4c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41f4f:	48 c1 e0 04          	shl    $0x4,%rax
   41f53:	48 05 a0 f2 04 00    	add    $0x4f2a0,%rax
   41f59:	48 89 d1             	mov    %rdx,%rcx
   41f5c:	ba 00 00 00 00       	mov    $0x0,%edx
   41f61:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41f68:	0e 00 00 
   41f6b:	48 89 c7             	mov    %rax,%rdi
   41f6e:	e8 66 fe ff ff       	call   41dd9 <set_gate>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41f73:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41f77:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
   41f7e:	76 c7                	jbe    41f47 <segments_init+0xf8>
                 (uint64_t) default_int_handler);
    }

    // Timer interrupt
    set_gate(&interrupt_descriptors[INT_TIMER], X86GATE_INTERRUPT, 0,
   41f80:	b8 36 00 04 00       	mov    $0x40036,%eax
   41f85:	48 89 c1             	mov    %rax,%rcx
   41f88:	ba 00 00 00 00       	mov    $0x0,%edx
   41f8d:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41f94:	0e 00 00 
   41f97:	48 89 c6             	mov    %rax,%rsi
   41f9a:	bf a0 f4 04 00       	mov    $0x4f4a0,%edi
   41f9f:	e8 35 fe ff ff       	call   41dd9 <set_gate>
             (uint64_t) timer_int_handler);

    // GPF and page fault
    set_gate(&interrupt_descriptors[INT_GPF], X86GATE_INTERRUPT, 0,
   41fa4:	b8 2e 00 04 00       	mov    $0x4002e,%eax
   41fa9:	48 89 c1             	mov    %rax,%rcx
   41fac:	ba 00 00 00 00       	mov    $0x0,%edx
   41fb1:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41fb8:	0e 00 00 
   41fbb:	48 89 c6             	mov    %rax,%rsi
   41fbe:	bf 70 f3 04 00       	mov    $0x4f370,%edi
   41fc3:	e8 11 fe ff ff       	call   41dd9 <set_gate>
             (uint64_t) gpf_int_handler);
    set_gate(&interrupt_descriptors[INT_PAGEFAULT], X86GATE_INTERRUPT, 0,
   41fc8:	b8 32 00 04 00       	mov    $0x40032,%eax
   41fcd:	48 89 c1             	mov    %rax,%rcx
   41fd0:	ba 00 00 00 00       	mov    $0x0,%edx
   41fd5:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41fdc:	0e 00 00 
   41fdf:	48 89 c6             	mov    %rax,%rsi
   41fe2:	bf 80 f3 04 00       	mov    $0x4f380,%edi
   41fe7:	e8 ed fd ff ff       	call   41dd9 <set_gate>
             (uint64_t) pagefault_int_handler);

    // System calls get special handling.
    // Note that the last argument is '3'.  This means that unprivileged
    // (level-3) applications may generate these interrupts.
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41fec:	c7 45 f8 30 00 00 00 	movl   $0x30,-0x8(%rbp)
   41ff3:	eb 3e                	jmp    42033 <segments_init+0x1e4>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
                 (uint64_t) sys_int_handlers[i - INT_SYS]);
   41ff5:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41ff8:	83 e8 30             	sub    $0x30,%eax
   41ffb:	89 c0                	mov    %eax,%eax
   41ffd:	48 8b 04 c5 e7 00 04 	mov    0x400e7(,%rax,8),%rax
   42004:	00 
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
   42005:	48 89 c2             	mov    %rax,%rdx
   42008:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4200b:	48 c1 e0 04          	shl    $0x4,%rax
   4200f:	48 05 a0 f2 04 00    	add    $0x4f2a0,%rax
   42015:	48 89 d1             	mov    %rdx,%rcx
   42018:	ba 03 00 00 00       	mov    $0x3,%edx
   4201d:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   42024:	0e 00 00 
   42027:	48 89 c7             	mov    %rax,%rdi
   4202a:	e8 aa fd ff ff       	call   41dd9 <set_gate>
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   4202f:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   42033:	83 7d f8 3f          	cmpl   $0x3f,-0x8(%rbp)
   42037:	76 bc                	jbe    41ff5 <segments_init+0x1a6>
    }

    x86_64_pseudodescriptor idt;
    idt.pseudod_limit = sizeof(interrupt_descriptors) - 1;
   42039:	66 c7 45 cc ff 0f    	movw   $0xfff,-0x34(%rbp)
    idt.pseudod_base = (uint64_t) interrupt_descriptors;
   4203f:	b8 a0 f2 04 00       	mov    $0x4f2a0,%eax
   42044:	48 89 45 ce          	mov    %rax,-0x32(%rbp)

    // Reload segment pointers
    asm volatile("lgdt %0\n\t"
   42048:	b8 28 00 00 00       	mov    $0x28,%eax
   4204d:	0f 01 55 d6          	lgdt   -0x2a(%rbp)
   42051:	0f 00 d8             	ltr    %ax
   42054:	0f 01 5d cc          	lidt   -0x34(%rbp)
    asm volatile("movq %%cr0,%0" : "=r" (val));
   42058:	0f 20 c0             	mov    %cr0,%rax
   4205b:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    return val;
   4205f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
                     "r" ((uint16_t) SEGSEL_TASKSTATE),
                     "m" (idt)
                 : "memory");

    // Set up control registers: check alignment
    uint32_t cr0 = rcr0();
   42063:	89 45 f4             	mov    %eax,-0xc(%rbp)
    cr0 |= CR0_PE | CR0_PG | CR0_WP | CR0_AM | CR0_MP | CR0_NE;
   42066:	81 4d f4 23 00 05 80 	orl    $0x80050023,-0xc(%rbp)
   4206d:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42070:	89 45 f0             	mov    %eax,-0x10(%rbp)
    uint64_t xval = val;
   42073:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42076:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    asm volatile("movq %0,%%cr0" : : "r" (xval));
   4207a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4207e:	0f 22 c0             	mov    %rax,%cr0
}
   42081:	90                   	nop
    lcr0(cr0);
}
   42082:	90                   	nop
   42083:	c9                   	leave  
   42084:	c3                   	ret    

0000000000042085 <interrupt_mask>:
#define TIMER_FREQ      1193182
#define TIMER_DIV(x)    ((TIMER_FREQ+(x)/2)/(x))

static uint16_t interrupts_enabled;

static void interrupt_mask(void) {
   42085:	55                   	push   %rbp
   42086:	48 89 e5             	mov    %rsp,%rbp
   42089:	48 83 ec 20          	sub    $0x20,%rsp
    uint16_t masked = ~interrupts_enabled;
   4208d:	0f b7 05 6c e2 00 00 	movzwl 0xe26c(%rip),%eax        # 50300 <interrupts_enabled>
   42094:	f7 d0                	not    %eax
   42096:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
    outb(IO_PIC1+1, masked & 0xFF);
   4209a:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   4209e:	0f b6 c0             	movzbl %al,%eax
   420a1:	c7 45 f0 21 00 00 00 	movl   $0x21,-0x10(%rbp)
   420a8:	88 45 ef             	mov    %al,-0x11(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   420ab:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   420af:	8b 55 f0             	mov    -0x10(%rbp),%edx
   420b2:	ee                   	out    %al,(%dx)
}
   420b3:	90                   	nop
    outb(IO_PIC2+1, (masked >> 8) & 0xFF);
   420b4:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   420b8:	66 c1 e8 08          	shr    $0x8,%ax
   420bc:	0f b6 c0             	movzbl %al,%eax
   420bf:	c7 45 f8 a1 00 00 00 	movl   $0xa1,-0x8(%rbp)
   420c6:	88 45 f7             	mov    %al,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   420c9:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   420cd:	8b 55 f8             	mov    -0x8(%rbp),%edx
   420d0:	ee                   	out    %al,(%dx)
}
   420d1:	90                   	nop
}
   420d2:	90                   	nop
   420d3:	c9                   	leave  
   420d4:	c3                   	ret    

00000000000420d5 <interrupt_init>:

void interrupt_init(void) {
   420d5:	55                   	push   %rbp
   420d6:	48 89 e5             	mov    %rsp,%rbp
   420d9:	48 83 ec 60          	sub    $0x60,%rsp
    // mask all interrupts
    interrupts_enabled = 0;
   420dd:	66 c7 05 1a e2 00 00 	movw   $0x0,0xe21a(%rip)        # 50300 <interrupts_enabled>
   420e4:	00 00 
    interrupt_mask();
   420e6:	e8 9a ff ff ff       	call   42085 <interrupt_mask>
   420eb:	c7 45 a4 20 00 00 00 	movl   $0x20,-0x5c(%rbp)
   420f2:	c6 45 a3 11          	movb   $0x11,-0x5d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   420f6:	0f b6 45 a3          	movzbl -0x5d(%rbp),%eax
   420fa:	8b 55 a4             	mov    -0x5c(%rbp),%edx
   420fd:	ee                   	out    %al,(%dx)
}
   420fe:	90                   	nop
   420ff:	c7 45 ac 21 00 00 00 	movl   $0x21,-0x54(%rbp)
   42106:	c6 45 ab 20          	movb   $0x20,-0x55(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4210a:	0f b6 45 ab          	movzbl -0x55(%rbp),%eax
   4210e:	8b 55 ac             	mov    -0x54(%rbp),%edx
   42111:	ee                   	out    %al,(%dx)
}
   42112:	90                   	nop
   42113:	c7 45 b4 21 00 00 00 	movl   $0x21,-0x4c(%rbp)
   4211a:	c6 45 b3 04          	movb   $0x4,-0x4d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4211e:	0f b6 45 b3          	movzbl -0x4d(%rbp),%eax
   42122:	8b 55 b4             	mov    -0x4c(%rbp),%edx
   42125:	ee                   	out    %al,(%dx)
}
   42126:	90                   	nop
   42127:	c7 45 bc 21 00 00 00 	movl   $0x21,-0x44(%rbp)
   4212e:	c6 45 bb 03          	movb   $0x3,-0x45(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42132:	0f b6 45 bb          	movzbl -0x45(%rbp),%eax
   42136:	8b 55 bc             	mov    -0x44(%rbp),%edx
   42139:	ee                   	out    %al,(%dx)
}
   4213a:	90                   	nop
   4213b:	c7 45 c4 a0 00 00 00 	movl   $0xa0,-0x3c(%rbp)
   42142:	c6 45 c3 11          	movb   $0x11,-0x3d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42146:	0f b6 45 c3          	movzbl -0x3d(%rbp),%eax
   4214a:	8b 55 c4             	mov    -0x3c(%rbp),%edx
   4214d:	ee                   	out    %al,(%dx)
}
   4214e:	90                   	nop
   4214f:	c7 45 cc a1 00 00 00 	movl   $0xa1,-0x34(%rbp)
   42156:	c6 45 cb 28          	movb   $0x28,-0x35(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4215a:	0f b6 45 cb          	movzbl -0x35(%rbp),%eax
   4215e:	8b 55 cc             	mov    -0x34(%rbp),%edx
   42161:	ee                   	out    %al,(%dx)
}
   42162:	90                   	nop
   42163:	c7 45 d4 a1 00 00 00 	movl   $0xa1,-0x2c(%rbp)
   4216a:	c6 45 d3 02          	movb   $0x2,-0x2d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4216e:	0f b6 45 d3          	movzbl -0x2d(%rbp),%eax
   42172:	8b 55 d4             	mov    -0x2c(%rbp),%edx
   42175:	ee                   	out    %al,(%dx)
}
   42176:	90                   	nop
   42177:	c7 45 dc a1 00 00 00 	movl   $0xa1,-0x24(%rbp)
   4217e:	c6 45 db 01          	movb   $0x1,-0x25(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42182:	0f b6 45 db          	movzbl -0x25(%rbp),%eax
   42186:	8b 55 dc             	mov    -0x24(%rbp),%edx
   42189:	ee                   	out    %al,(%dx)
}
   4218a:	90                   	nop
   4218b:	c7 45 e4 20 00 00 00 	movl   $0x20,-0x1c(%rbp)
   42192:	c6 45 e3 68          	movb   $0x68,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42196:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   4219a:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   4219d:	ee                   	out    %al,(%dx)
}
   4219e:	90                   	nop
   4219f:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%rbp)
   421a6:	c6 45 eb 0a          	movb   $0xa,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   421aa:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   421ae:	8b 55 ec             	mov    -0x14(%rbp),%edx
   421b1:	ee                   	out    %al,(%dx)
}
   421b2:	90                   	nop
   421b3:	c7 45 f4 a0 00 00 00 	movl   $0xa0,-0xc(%rbp)
   421ba:	c6 45 f3 68          	movb   $0x68,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   421be:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   421c2:	8b 55 f4             	mov    -0xc(%rbp),%edx
   421c5:	ee                   	out    %al,(%dx)
}
   421c6:	90                   	nop
   421c7:	c7 45 fc a0 00 00 00 	movl   $0xa0,-0x4(%rbp)
   421ce:	c6 45 fb 0a          	movb   $0xa,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   421d2:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   421d6:	8b 55 fc             	mov    -0x4(%rbp),%edx
   421d9:	ee                   	out    %al,(%dx)
}
   421da:	90                   	nop

    outb(IO_PIC2, 0x68);               /* OCW3 */
    outb(IO_PIC2, 0x0a);               /* OCW3 */

    // re-disable interrupts
    interrupt_mask();
   421db:	e8 a5 fe ff ff       	call   42085 <interrupt_mask>
}
   421e0:	90                   	nop
   421e1:	c9                   	leave  
   421e2:	c3                   	ret    

00000000000421e3 <timer_init>:

// timer_init(rate)
//    Set the timer interrupt to fire `rate` times a second. Disables the
//    timer interrupt if `rate <= 0`.

void timer_init(int rate) {
   421e3:	55                   	push   %rbp
   421e4:	48 89 e5             	mov    %rsp,%rbp
   421e7:	48 83 ec 28          	sub    $0x28,%rsp
   421eb:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (rate > 0) {
   421ee:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   421f2:	0f 8e 9f 00 00 00    	jle    42297 <timer_init+0xb4>
   421f8:	c7 45 ec 43 00 00 00 	movl   $0x43,-0x14(%rbp)
   421ff:	c6 45 eb 34          	movb   $0x34,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42203:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   42207:	8b 55 ec             	mov    -0x14(%rbp),%edx
   4220a:	ee                   	out    %al,(%dx)
}
   4220b:	90                   	nop
        outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
        outb(IO_TIMER1, TIMER_DIV(rate) % 256);
   4220c:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4220f:	89 c2                	mov    %eax,%edx
   42211:	c1 ea 1f             	shr    $0x1f,%edx
   42214:	01 d0                	add    %edx,%eax
   42216:	d1 f8                	sar    %eax
   42218:	05 de 34 12 00       	add    $0x1234de,%eax
   4221d:	99                   	cltd   
   4221e:	f7 7d dc             	idivl  -0x24(%rbp)
   42221:	89 c2                	mov    %eax,%edx
   42223:	89 d0                	mov    %edx,%eax
   42225:	c1 f8 1f             	sar    $0x1f,%eax
   42228:	c1 e8 18             	shr    $0x18,%eax
   4222b:	89 c1                	mov    %eax,%ecx
   4222d:	8d 04 0a             	lea    (%rdx,%rcx,1),%eax
   42230:	0f b6 c0             	movzbl %al,%eax
   42233:	29 c8                	sub    %ecx,%eax
   42235:	0f b6 c0             	movzbl %al,%eax
   42238:	c7 45 f4 40 00 00 00 	movl   $0x40,-0xc(%rbp)
   4223f:	88 45 f3             	mov    %al,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42242:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   42246:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42249:	ee                   	out    %al,(%dx)
}
   4224a:	90                   	nop
        outb(IO_TIMER1, TIMER_DIV(rate) / 256);
   4224b:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4224e:	89 c2                	mov    %eax,%edx
   42250:	c1 ea 1f             	shr    $0x1f,%edx
   42253:	01 d0                	add    %edx,%eax
   42255:	d1 f8                	sar    %eax
   42257:	05 de 34 12 00       	add    $0x1234de,%eax
   4225c:	99                   	cltd   
   4225d:	f7 7d dc             	idivl  -0x24(%rbp)
   42260:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   42266:	85 c0                	test   %eax,%eax
   42268:	0f 48 c2             	cmovs  %edx,%eax
   4226b:	c1 f8 08             	sar    $0x8,%eax
   4226e:	0f b6 c0             	movzbl %al,%eax
   42271:	c7 45 fc 40 00 00 00 	movl   $0x40,-0x4(%rbp)
   42278:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4227b:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   4227f:	8b 55 fc             	mov    -0x4(%rbp),%edx
   42282:	ee                   	out    %al,(%dx)
}
   42283:	90                   	nop
        interrupts_enabled |= 1 << (INT_TIMER - INT_HARDWARE);
   42284:	0f b7 05 75 e0 00 00 	movzwl 0xe075(%rip),%eax        # 50300 <interrupts_enabled>
   4228b:	83 c8 01             	or     $0x1,%eax
   4228e:	66 89 05 6b e0 00 00 	mov    %ax,0xe06b(%rip)        # 50300 <interrupts_enabled>
   42295:	eb 11                	jmp    422a8 <timer_init+0xc5>
    } else {
        interrupts_enabled &= ~(1 << (INT_TIMER - INT_HARDWARE));
   42297:	0f b7 05 62 e0 00 00 	movzwl 0xe062(%rip),%eax        # 50300 <interrupts_enabled>
   4229e:	83 e0 fe             	and    $0xfffffffe,%eax
   422a1:	66 89 05 58 e0 00 00 	mov    %ax,0xe058(%rip)        # 50300 <interrupts_enabled>
    }
    interrupt_mask();
   422a8:	e8 d8 fd ff ff       	call   42085 <interrupt_mask>
}
   422ad:	90                   	nop
   422ae:	c9                   	leave  
   422af:	c3                   	ret    

00000000000422b0 <physical_memory_isreserved>:
//    Returns non-zero iff `pa` is a reserved physical address.

#define IOPHYSMEM       0x000A0000
#define EXTPHYSMEM      0x00100000

int physical_memory_isreserved(uintptr_t pa) {
   422b0:	55                   	push   %rbp
   422b1:	48 89 e5             	mov    %rsp,%rbp
   422b4:	48 83 ec 08          	sub    $0x8,%rsp
   422b8:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return pa == 0 || (pa >= IOPHYSMEM && pa < EXTPHYSMEM);
   422bc:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   422c1:	74 14                	je     422d7 <physical_memory_isreserved+0x27>
   422c3:	48 81 7d f8 ff ff 09 	cmpq   $0x9ffff,-0x8(%rbp)
   422ca:	00 
   422cb:	76 11                	jbe    422de <physical_memory_isreserved+0x2e>
   422cd:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   422d4:	00 
   422d5:	77 07                	ja     422de <physical_memory_isreserved+0x2e>
   422d7:	b8 01 00 00 00       	mov    $0x1,%eax
   422dc:	eb 05                	jmp    422e3 <physical_memory_isreserved+0x33>
   422de:	b8 00 00 00 00       	mov    $0x0,%eax
}
   422e3:	c9                   	leave  
   422e4:	c3                   	ret    

00000000000422e5 <pci_make_configaddr>:


// pci_make_configaddr(bus, slot, func)
//    Construct a PCI configuration space address from parts.

static int pci_make_configaddr(int bus, int slot, int func) {
   422e5:	55                   	push   %rbp
   422e6:	48 89 e5             	mov    %rsp,%rbp
   422e9:	48 83 ec 10          	sub    $0x10,%rsp
   422ed:	89 7d fc             	mov    %edi,-0x4(%rbp)
   422f0:	89 75 f8             	mov    %esi,-0x8(%rbp)
   422f3:	89 55 f4             	mov    %edx,-0xc(%rbp)
    return (bus << 16) | (slot << 11) | (func << 8);
   422f6:	8b 45 fc             	mov    -0x4(%rbp),%eax
   422f9:	c1 e0 10             	shl    $0x10,%eax
   422fc:	89 c2                	mov    %eax,%edx
   422fe:	8b 45 f8             	mov    -0x8(%rbp),%eax
   42301:	c1 e0 0b             	shl    $0xb,%eax
   42304:	09 c2                	or     %eax,%edx
   42306:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42309:	c1 e0 08             	shl    $0x8,%eax
   4230c:	09 d0                	or     %edx,%eax
}
   4230e:	c9                   	leave  
   4230f:	c3                   	ret    

0000000000042310 <pci_config_readl>:
//    Read a 32-bit word in PCI configuration space.

#define PCI_HOST_BRIDGE_CONFIG_ADDR 0xCF8
#define PCI_HOST_BRIDGE_CONFIG_DATA 0xCFC

static uint32_t pci_config_readl(int configaddr, int offset) {
   42310:	55                   	push   %rbp
   42311:	48 89 e5             	mov    %rsp,%rbp
   42314:	48 83 ec 18          	sub    $0x18,%rsp
   42318:	89 7d ec             	mov    %edi,-0x14(%rbp)
   4231b:	89 75 e8             	mov    %esi,-0x18(%rbp)
    outl(PCI_HOST_BRIDGE_CONFIG_ADDR, 0x80000000 | configaddr | offset);
   4231e:	8b 55 ec             	mov    -0x14(%rbp),%edx
   42321:	8b 45 e8             	mov    -0x18(%rbp),%eax
   42324:	09 d0                	or     %edx,%eax
   42326:	0d 00 00 00 80       	or     $0x80000000,%eax
   4232b:	c7 45 f4 f8 0c 00 00 	movl   $0xcf8,-0xc(%rbp)
   42332:	89 45 f0             	mov    %eax,-0x10(%rbp)
    asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
   42335:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42338:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4233b:	ef                   	out    %eax,(%dx)
}
   4233c:	90                   	nop
   4233d:	c7 45 fc fc 0c 00 00 	movl   $0xcfc,-0x4(%rbp)
    asm volatile("inl %w1,%0" : "=a" (data) : "d" (port));
   42344:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42347:	89 c2                	mov    %eax,%edx
   42349:	ed                   	in     (%dx),%eax
   4234a:	89 45 f8             	mov    %eax,-0x8(%rbp)
    return data;
   4234d:	8b 45 f8             	mov    -0x8(%rbp),%eax
    return inl(PCI_HOST_BRIDGE_CONFIG_DATA);
}
   42350:	c9                   	leave  
   42351:	c3                   	ret    

0000000000042352 <pci_find_device>:

// pci_find_device
//    Search for a PCI device matching `vendor` and `device`. Return
//    the config base address or -1 if no device was found.

static int pci_find_device(int vendor, int device) {
   42352:	55                   	push   %rbp
   42353:	48 89 e5             	mov    %rsp,%rbp
   42356:	48 83 ec 28          	sub    $0x28,%rsp
   4235a:	89 7d dc             	mov    %edi,-0x24(%rbp)
   4235d:	89 75 d8             	mov    %esi,-0x28(%rbp)
    for (int bus = 0; bus != 256; ++bus) {
   42360:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42367:	eb 73                	jmp    423dc <pci_find_device+0x8a>
        for (int slot = 0; slot != 32; ++slot) {
   42369:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   42370:	eb 60                	jmp    423d2 <pci_find_device+0x80>
            for (int func = 0; func != 8; ++func) {
   42372:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   42379:	eb 4a                	jmp    423c5 <pci_find_device+0x73>
                int configaddr = pci_make_configaddr(bus, slot, func);
   4237b:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4237e:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   42381:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42384:	89 ce                	mov    %ecx,%esi
   42386:	89 c7                	mov    %eax,%edi
   42388:	e8 58 ff ff ff       	call   422e5 <pci_make_configaddr>
   4238d:	89 45 f0             	mov    %eax,-0x10(%rbp)
                uint32_t vendor_device = pci_config_readl(configaddr, 0);
   42390:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42393:	be 00 00 00 00       	mov    $0x0,%esi
   42398:	89 c7                	mov    %eax,%edi
   4239a:	e8 71 ff ff ff       	call   42310 <pci_config_readl>
   4239f:	89 45 ec             	mov    %eax,-0x14(%rbp)
                if (vendor_device == (uint32_t) (vendor | (device << 16))) {
   423a2:	8b 45 d8             	mov    -0x28(%rbp),%eax
   423a5:	c1 e0 10             	shl    $0x10,%eax
   423a8:	0b 45 dc             	or     -0x24(%rbp),%eax
   423ab:	39 45 ec             	cmp    %eax,-0x14(%rbp)
   423ae:	75 05                	jne    423b5 <pci_find_device+0x63>
                    return configaddr;
   423b0:	8b 45 f0             	mov    -0x10(%rbp),%eax
   423b3:	eb 35                	jmp    423ea <pci_find_device+0x98>
                } else if (vendor_device == (uint32_t) -1 && func == 0) {
   423b5:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%rbp)
   423b9:	75 06                	jne    423c1 <pci_find_device+0x6f>
   423bb:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   423bf:	74 0c                	je     423cd <pci_find_device+0x7b>
            for (int func = 0; func != 8; ++func) {
   423c1:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   423c5:	83 7d f4 08          	cmpl   $0x8,-0xc(%rbp)
   423c9:	75 b0                	jne    4237b <pci_find_device+0x29>
   423cb:	eb 01                	jmp    423ce <pci_find_device+0x7c>
                    break;
   423cd:	90                   	nop
        for (int slot = 0; slot != 32; ++slot) {
   423ce:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   423d2:	83 7d f8 20          	cmpl   $0x20,-0x8(%rbp)
   423d6:	75 9a                	jne    42372 <pci_find_device+0x20>
    for (int bus = 0; bus != 256; ++bus) {
   423d8:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   423dc:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
   423e3:	75 84                	jne    42369 <pci_find_device+0x17>
                }
            }
        }
    }
    return -1;
   423e5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   423ea:	c9                   	leave  
   423eb:	c3                   	ret    

00000000000423ec <poweroff>:
//    that speaks ACPI; QEMU emulates a PIIX4 Power Management Controller.

#define PCI_VENDOR_ID_INTEL     0x8086
#define PCI_DEVICE_ID_PIIX4     0x7113

void poweroff(void) {
   423ec:	55                   	push   %rbp
   423ed:	48 89 e5             	mov    %rsp,%rbp
   423f0:	48 83 ec 10          	sub    $0x10,%rsp
    int configaddr = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PIIX4);
   423f4:	be 13 71 00 00       	mov    $0x7113,%esi
   423f9:	bf 86 80 00 00       	mov    $0x8086,%edi
   423fe:	e8 4f ff ff ff       	call   42352 <pci_find_device>
   42403:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if (configaddr >= 0) {
   42406:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   4240a:	78 30                	js     4243c <poweroff+0x50>
        // Read I/O base register from controller's PCI configuration space.
        int pm_io_base = pci_config_readl(configaddr, 0x40) & 0xFFC0;
   4240c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4240f:	be 40 00 00 00       	mov    $0x40,%esi
   42414:	89 c7                	mov    %eax,%edi
   42416:	e8 f5 fe ff ff       	call   42310 <pci_config_readl>
   4241b:	25 c0 ff 00 00       	and    $0xffc0,%eax
   42420:	89 45 f8             	mov    %eax,-0x8(%rbp)
        // Write `suspend enable` to the power management control register.
        outw(pm_io_base + 4, 0x2000);
   42423:	8b 45 f8             	mov    -0x8(%rbp),%eax
   42426:	83 c0 04             	add    $0x4,%eax
   42429:	89 45 f4             	mov    %eax,-0xc(%rbp)
   4242c:	66 c7 45 f2 00 20    	movw   $0x2000,-0xe(%rbp)
    asm volatile("outw %0,%w1" : : "a" (data), "d" (port));
   42432:	0f b7 45 f2          	movzwl -0xe(%rbp),%eax
   42436:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42439:	66 ef                	out    %ax,(%dx)
}
   4243b:	90                   	nop
    }
    // No PIIX4; spin.
    console_printf(CPOS(24, 0), 0xC000, "Cannot power off!\n");
   4243c:	ba a0 45 04 00       	mov    $0x445a0,%edx
   42441:	be 00 c0 00 00       	mov    $0xc000,%esi
   42446:	bf 80 07 00 00       	mov    $0x780,%edi
   4244b:	b8 00 00 00 00       	mov    $0x0,%eax
   42450:	e8 13 1c 00 00       	call   44068 <console_printf>
 spinloop: goto spinloop;
   42455:	eb fe                	jmp    42455 <poweroff+0x69>

0000000000042457 <reboot>:


// reboot
//    Reboot the virtual machine.

void reboot(void) {
   42457:	55                   	push   %rbp
   42458:	48 89 e5             	mov    %rsp,%rbp
   4245b:	48 83 ec 10          	sub    $0x10,%rsp
   4245f:	c7 45 fc 92 00 00 00 	movl   $0x92,-0x4(%rbp)
   42466:	c6 45 fb 03          	movb   $0x3,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4246a:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   4246e:	8b 55 fc             	mov    -0x4(%rbp),%edx
   42471:	ee                   	out    %al,(%dx)
}
   42472:	90                   	nop
    outb(0x92, 3);
 spinloop: goto spinloop;
   42473:	eb fe                	jmp    42473 <reboot+0x1c>

0000000000042475 <process_init>:


// process_init(p, flags)
//    Initialize special-purpose registers for process `p`.

void process_init(proc* p, int flags) {
   42475:	55                   	push   %rbp
   42476:	48 89 e5             	mov    %rsp,%rbp
   42479:	48 83 ec 10          	sub    $0x10,%rsp
   4247d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42481:	89 75 f4             	mov    %esi,-0xc(%rbp)
    memset(&p->p_registers, 0, sizeof(p->p_registers));
   42484:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42488:	48 83 c0 08          	add    $0x8,%rax
   4248c:	ba c0 00 00 00       	mov    $0xc0,%edx
   42491:	be 00 00 00 00       	mov    $0x0,%esi
   42496:	48 89 c7             	mov    %rax,%rdi
   42499:	e8 95 13 00 00       	call   43833 <memset>
    p->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
   4249e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   424a2:	66 c7 80 a8 00 00 00 	movw   $0x13,0xa8(%rax)
   424a9:	13 00 
    p->p_registers.reg_fs = SEGSEL_APP_DATA | 3;
   424ab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   424af:	48 c7 80 80 00 00 00 	movq   $0x23,0x80(%rax)
   424b6:	23 00 00 00 
    p->p_registers.reg_gs = SEGSEL_APP_DATA | 3;
   424ba:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   424be:	48 c7 80 88 00 00 00 	movq   $0x23,0x88(%rax)
   424c5:	23 00 00 00 
    p->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
   424c9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   424cd:	66 c7 80 c0 00 00 00 	movw   $0x23,0xc0(%rax)
   424d4:	23 00 
    p->p_registers.reg_rflags = EFLAGS_IF;
   424d6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   424da:	48 c7 80 b0 00 00 00 	movq   $0x200,0xb0(%rax)
   424e1:	00 02 00 00 

    if (flags & PROCINIT_ALLOW_PROGRAMMED_IO) {
   424e5:	8b 45 f4             	mov    -0xc(%rbp),%eax
   424e8:	83 e0 01             	and    $0x1,%eax
   424eb:	85 c0                	test   %eax,%eax
   424ed:	74 1c                	je     4250b <process_init+0x96>
        p->p_registers.reg_rflags |= EFLAGS_IOPL_3;
   424ef:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   424f3:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   424fa:	80 cc 30             	or     $0x30,%ah
   424fd:	48 89 c2             	mov    %rax,%rdx
   42500:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42504:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
    if (flags & PROCINIT_DISABLE_INTERRUPTS) {
   4250b:	8b 45 f4             	mov    -0xc(%rbp),%eax
   4250e:	83 e0 02             	and    $0x2,%eax
   42511:	85 c0                	test   %eax,%eax
   42513:	74 1c                	je     42531 <process_init+0xbc>
        p->p_registers.reg_rflags &= ~EFLAGS_IF;
   42515:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42519:	48 8b 80 b0 00 00 00 	mov    0xb0(%rax),%rax
   42520:	80 e4 fd             	and    $0xfd,%ah
   42523:	48 89 c2             	mov    %rax,%rdx
   42526:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4252a:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    }
}
   42531:	90                   	nop
   42532:	c9                   	leave  
   42533:	c3                   	ret    

0000000000042534 <console_show_cursor>:

// console_show_cursor(cpos)
//    Move the console cursor to position `cpos`, which should be between 0
//    and 80 * 25.

void console_show_cursor(int cpos) {
   42534:	55                   	push   %rbp
   42535:	48 89 e5             	mov    %rsp,%rbp
   42538:	48 83 ec 28          	sub    $0x28,%rsp
   4253c:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (cpos < 0 || cpos > CONSOLE_ROWS * CONSOLE_COLUMNS) {
   4253f:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   42543:	78 09                	js     4254e <console_show_cursor+0x1a>
   42545:	81 7d dc d0 07 00 00 	cmpl   $0x7d0,-0x24(%rbp)
   4254c:	7e 07                	jle    42555 <console_show_cursor+0x21>
        cpos = 0;
   4254e:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
   42555:	c7 45 e4 d4 03 00 00 	movl   $0x3d4,-0x1c(%rbp)
   4255c:	c6 45 e3 0e          	movb   $0xe,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42560:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   42564:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   42567:	ee                   	out    %al,(%dx)
}
   42568:	90                   	nop
    }
    outb(0x3D4, 14);
    outb(0x3D5, cpos / 256);
   42569:	8b 45 dc             	mov    -0x24(%rbp),%eax
   4256c:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   42572:	85 c0                	test   %eax,%eax
   42574:	0f 48 c2             	cmovs  %edx,%eax
   42577:	c1 f8 08             	sar    $0x8,%eax
   4257a:	0f b6 c0             	movzbl %al,%eax
   4257d:	c7 45 ec d5 03 00 00 	movl   $0x3d5,-0x14(%rbp)
   42584:	88 45 eb             	mov    %al,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42587:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   4258b:	8b 55 ec             	mov    -0x14(%rbp),%edx
   4258e:	ee                   	out    %al,(%dx)
}
   4258f:	90                   	nop
   42590:	c7 45 f4 d4 03 00 00 	movl   $0x3d4,-0xc(%rbp)
   42597:	c6 45 f3 0f          	movb   $0xf,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   4259b:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   4259f:	8b 55 f4             	mov    -0xc(%rbp),%edx
   425a2:	ee                   	out    %al,(%dx)
}
   425a3:	90                   	nop
    outb(0x3D4, 15);
    outb(0x3D5, cpos % 256);
   425a4:	8b 45 dc             	mov    -0x24(%rbp),%eax
   425a7:	99                   	cltd   
   425a8:	c1 ea 18             	shr    $0x18,%edx
   425ab:	01 d0                	add    %edx,%eax
   425ad:	0f b6 c0             	movzbl %al,%eax
   425b0:	29 d0                	sub    %edx,%eax
   425b2:	0f b6 c0             	movzbl %al,%eax
   425b5:	c7 45 fc d5 03 00 00 	movl   $0x3d5,-0x4(%rbp)
   425bc:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   425bf:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   425c3:	8b 55 fc             	mov    -0x4(%rbp),%edx
   425c6:	ee                   	out    %al,(%dx)
}
   425c7:	90                   	nop
}
   425c8:	90                   	nop
   425c9:	c9                   	leave  
   425ca:	c3                   	ret    

00000000000425cb <keyboard_readc>:
    /*CKEY(16)*/ {{'\'', '"', 0, 0}},  /*CKEY(17)*/ {{'`', '~', 0, 0}},
    /*CKEY(18)*/ {{'\\', '|', 034, 0}},  /*CKEY(19)*/ {{',', '<', 0, 0}},
    /*CKEY(20)*/ {{'.', '>', 0, 0}},  /*CKEY(21)*/ {{'/', '?', 0, 0}}
};

int keyboard_readc(void) {
   425cb:	55                   	push   %rbp
   425cc:	48 89 e5             	mov    %rsp,%rbp
   425cf:	48 83 ec 20          	sub    $0x20,%rsp
   425d3:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   425da:	8b 45 f0             	mov    -0x10(%rbp),%eax
   425dd:	89 c2                	mov    %eax,%edx
   425df:	ec                   	in     (%dx),%al
   425e0:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   425e3:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
    static uint8_t modifiers;
    static uint8_t last_escape;

    if ((inb(KEYBOARD_STATUSREG) & KEYBOARD_STATUS_READY) == 0) {
   425e7:	0f b6 c0             	movzbl %al,%eax
   425ea:	83 e0 01             	and    $0x1,%eax
   425ed:	85 c0                	test   %eax,%eax
   425ef:	75 0a                	jne    425fb <keyboard_readc+0x30>
        return -1;
   425f1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   425f6:	e9 e7 01 00 00       	jmp    427e2 <keyboard_readc+0x217>
   425fb:	c7 45 e8 60 00 00 00 	movl   $0x60,-0x18(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42602:	8b 45 e8             	mov    -0x18(%rbp),%eax
   42605:	89 c2                	mov    %eax,%edx
   42607:	ec                   	in     (%dx),%al
   42608:	88 45 e7             	mov    %al,-0x19(%rbp)
    return data;
   4260b:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
    }

    uint8_t data = inb(KEYBOARD_DATAREG);
   4260f:	88 45 fb             	mov    %al,-0x5(%rbp)
    uint8_t escape = last_escape;
   42612:	0f b6 05 e9 dc 00 00 	movzbl 0xdce9(%rip),%eax        # 50302 <last_escape.2>
   42619:	88 45 fa             	mov    %al,-0x6(%rbp)
    last_escape = 0;
   4261c:	c6 05 df dc 00 00 00 	movb   $0x0,0xdcdf(%rip)        # 50302 <last_escape.2>

    if (data == 0xE0) {         // mode shift
   42623:	80 7d fb e0          	cmpb   $0xe0,-0x5(%rbp)
   42627:	75 11                	jne    4263a <keyboard_readc+0x6f>
        last_escape = 0x80;
   42629:	c6 05 d2 dc 00 00 80 	movb   $0x80,0xdcd2(%rip)        # 50302 <last_escape.2>
        return 0;
   42630:	b8 00 00 00 00       	mov    $0x0,%eax
   42635:	e9 a8 01 00 00       	jmp    427e2 <keyboard_readc+0x217>
    } else if (data & 0x80) {   // key release: matters only for modifier keys
   4263a:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   4263e:	84 c0                	test   %al,%al
   42640:	79 60                	jns    426a2 <keyboard_readc+0xd7>
        int ch = keymap[(data & 0x7F) | escape];
   42642:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   42646:	83 e0 7f             	and    $0x7f,%eax
   42649:	89 c2                	mov    %eax,%edx
   4264b:	0f b6 45 fa          	movzbl -0x6(%rbp),%eax
   4264f:	09 d0                	or     %edx,%eax
   42651:	48 98                	cltq   
   42653:	0f b6 80 c0 45 04 00 	movzbl 0x445c0(%rax),%eax
   4265a:	0f b6 c0             	movzbl %al,%eax
   4265d:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (ch >= KEY_SHIFT && ch < KEY_CAPSLOCK) {
   42660:	81 7d f4 f9 00 00 00 	cmpl   $0xf9,-0xc(%rbp)
   42667:	7e 2f                	jle    42698 <keyboard_readc+0xcd>
   42669:	81 7d f4 fc 00 00 00 	cmpl   $0xfc,-0xc(%rbp)
   42670:	7f 26                	jg     42698 <keyboard_readc+0xcd>
            modifiers &= ~(1 << (ch - KEY_SHIFT));
   42672:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42675:	2d fa 00 00 00       	sub    $0xfa,%eax
   4267a:	ba 01 00 00 00       	mov    $0x1,%edx
   4267f:	89 c1                	mov    %eax,%ecx
   42681:	d3 e2                	shl    %cl,%edx
   42683:	89 d0                	mov    %edx,%eax
   42685:	f7 d0                	not    %eax
   42687:	89 c2                	mov    %eax,%edx
   42689:	0f b6 05 73 dc 00 00 	movzbl 0xdc73(%rip),%eax        # 50303 <modifiers.1>
   42690:	21 d0                	and    %edx,%eax
   42692:	88 05 6b dc 00 00    	mov    %al,0xdc6b(%rip)        # 50303 <modifiers.1>
        }
        return 0;
   42698:	b8 00 00 00 00       	mov    $0x0,%eax
   4269d:	e9 40 01 00 00       	jmp    427e2 <keyboard_readc+0x217>
    }

    int ch = (unsigned char) keymap[data | escape];
   426a2:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   426a6:	0a 45 fa             	or     -0x6(%rbp),%al
   426a9:	0f b6 c0             	movzbl %al,%eax
   426ac:	48 98                	cltq   
   426ae:	0f b6 80 c0 45 04 00 	movzbl 0x445c0(%rax),%eax
   426b5:	0f b6 c0             	movzbl %al,%eax
   426b8:	89 45 fc             	mov    %eax,-0x4(%rbp)

    if (ch >= 'a' && ch <= 'z') {
   426bb:	83 7d fc 60          	cmpl   $0x60,-0x4(%rbp)
   426bf:	7e 57                	jle    42718 <keyboard_readc+0x14d>
   426c1:	83 7d fc 7a          	cmpl   $0x7a,-0x4(%rbp)
   426c5:	7f 51                	jg     42718 <keyboard_readc+0x14d>
        if (modifiers & MOD_CONTROL) {
   426c7:	0f b6 05 35 dc 00 00 	movzbl 0xdc35(%rip),%eax        # 50303 <modifiers.1>
   426ce:	0f b6 c0             	movzbl %al,%eax
   426d1:	83 e0 02             	and    $0x2,%eax
   426d4:	85 c0                	test   %eax,%eax
   426d6:	74 09                	je     426e1 <keyboard_readc+0x116>
            ch -= 0x60;
   426d8:	83 6d fc 60          	subl   $0x60,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   426dc:	e9 fd 00 00 00       	jmp    427de <keyboard_readc+0x213>
        } else if (!(modifiers & MOD_SHIFT) != !(modifiers & MOD_CAPSLOCK)) {
   426e1:	0f b6 05 1b dc 00 00 	movzbl 0xdc1b(%rip),%eax        # 50303 <modifiers.1>
   426e8:	0f b6 c0             	movzbl %al,%eax
   426eb:	83 e0 01             	and    $0x1,%eax
   426ee:	85 c0                	test   %eax,%eax
   426f0:	0f 94 c2             	sete   %dl
   426f3:	0f b6 05 09 dc 00 00 	movzbl 0xdc09(%rip),%eax        # 50303 <modifiers.1>
   426fa:	0f b6 c0             	movzbl %al,%eax
   426fd:	83 e0 08             	and    $0x8,%eax
   42700:	85 c0                	test   %eax,%eax
   42702:	0f 94 c0             	sete   %al
   42705:	31 d0                	xor    %edx,%eax
   42707:	84 c0                	test   %al,%al
   42709:	0f 84 cf 00 00 00    	je     427de <keyboard_readc+0x213>
            ch -= 0x20;
   4270f:	83 6d fc 20          	subl   $0x20,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   42713:	e9 c6 00 00 00       	jmp    427de <keyboard_readc+0x213>
        }
    } else if (ch >= KEY_CAPSLOCK) {
   42718:	81 7d fc fc 00 00 00 	cmpl   $0xfc,-0x4(%rbp)
   4271f:	7e 30                	jle    42751 <keyboard_readc+0x186>
        modifiers ^= 1 << (ch - KEY_SHIFT);
   42721:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42724:	2d fa 00 00 00       	sub    $0xfa,%eax
   42729:	ba 01 00 00 00       	mov    $0x1,%edx
   4272e:	89 c1                	mov    %eax,%ecx
   42730:	d3 e2                	shl    %cl,%edx
   42732:	89 d0                	mov    %edx,%eax
   42734:	89 c2                	mov    %eax,%edx
   42736:	0f b6 05 c6 db 00 00 	movzbl 0xdbc6(%rip),%eax        # 50303 <modifiers.1>
   4273d:	31 d0                	xor    %edx,%eax
   4273f:	88 05 be db 00 00    	mov    %al,0xdbbe(%rip)        # 50303 <modifiers.1>
        ch = 0;
   42745:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4274c:	e9 8e 00 00 00       	jmp    427df <keyboard_readc+0x214>
    } else if (ch >= KEY_SHIFT) {
   42751:	81 7d fc f9 00 00 00 	cmpl   $0xf9,-0x4(%rbp)
   42758:	7e 2d                	jle    42787 <keyboard_readc+0x1bc>
        modifiers |= 1 << (ch - KEY_SHIFT);
   4275a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4275d:	2d fa 00 00 00       	sub    $0xfa,%eax
   42762:	ba 01 00 00 00       	mov    $0x1,%edx
   42767:	89 c1                	mov    %eax,%ecx
   42769:	d3 e2                	shl    %cl,%edx
   4276b:	89 d0                	mov    %edx,%eax
   4276d:	89 c2                	mov    %eax,%edx
   4276f:	0f b6 05 8d db 00 00 	movzbl 0xdb8d(%rip),%eax        # 50303 <modifiers.1>
   42776:	09 d0                	or     %edx,%eax
   42778:	88 05 85 db 00 00    	mov    %al,0xdb85(%rip)        # 50303 <modifiers.1>
        ch = 0;
   4277e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42785:	eb 58                	jmp    427df <keyboard_readc+0x214>
    } else if (ch >= CKEY(0) && ch <= CKEY(21)) {
   42787:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   4278b:	7e 31                	jle    427be <keyboard_readc+0x1f3>
   4278d:	81 7d fc 95 00 00 00 	cmpl   $0x95,-0x4(%rbp)
   42794:	7f 28                	jg     427be <keyboard_readc+0x1f3>
        ch = complex_keymap[ch - CKEY(0)].map[modifiers & 3];
   42796:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42799:	8d 50 80             	lea    -0x80(%rax),%edx
   4279c:	0f b6 05 60 db 00 00 	movzbl 0xdb60(%rip),%eax        # 50303 <modifiers.1>
   427a3:	0f b6 c0             	movzbl %al,%eax
   427a6:	83 e0 03             	and    $0x3,%eax
   427a9:	48 98                	cltq   
   427ab:	48 63 d2             	movslq %edx,%rdx
   427ae:	0f b6 84 90 c0 46 04 	movzbl 0x446c0(%rax,%rdx,4),%eax
   427b5:	00 
   427b6:	0f b6 c0             	movzbl %al,%eax
   427b9:	89 45 fc             	mov    %eax,-0x4(%rbp)
   427bc:	eb 21                	jmp    427df <keyboard_readc+0x214>
    } else if (ch < 0x80 && (modifiers & MOD_CONTROL)) {
   427be:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   427c2:	7f 1b                	jg     427df <keyboard_readc+0x214>
   427c4:	0f b6 05 38 db 00 00 	movzbl 0xdb38(%rip),%eax        # 50303 <modifiers.1>
   427cb:	0f b6 c0             	movzbl %al,%eax
   427ce:	83 e0 02             	and    $0x2,%eax
   427d1:	85 c0                	test   %eax,%eax
   427d3:	74 0a                	je     427df <keyboard_readc+0x214>
        ch = 0;
   427d5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   427dc:	eb 01                	jmp    427df <keyboard_readc+0x214>
        if (modifiers & MOD_CONTROL) {
   427de:	90                   	nop
    }

    return ch;
   427df:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
   427e2:	c9                   	leave  
   427e3:	c3                   	ret    

00000000000427e4 <delay>:
#define IO_PARALLEL1_CONTROL    0x37A
# define IO_PARALLEL_CONTROL_SELECT     0x08
# define IO_PARALLEL_CONTROL_INIT       0x04
# define IO_PARALLEL_CONTROL_STROBE     0x01

static void delay(void) {
   427e4:	55                   	push   %rbp
   427e5:	48 89 e5             	mov    %rsp,%rbp
   427e8:	48 83 ec 20          	sub    $0x20,%rsp
   427ec:	c7 45 e4 84 00 00 00 	movl   $0x84,-0x1c(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   427f3:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   427f6:	89 c2                	mov    %eax,%edx
   427f8:	ec                   	in     (%dx),%al
   427f9:	88 45 e3             	mov    %al,-0x1d(%rbp)
   427fc:	c7 45 ec 84 00 00 00 	movl   $0x84,-0x14(%rbp)
   42803:	8b 45 ec             	mov    -0x14(%rbp),%eax
   42806:	89 c2                	mov    %eax,%edx
   42808:	ec                   	in     (%dx),%al
   42809:	88 45 eb             	mov    %al,-0x15(%rbp)
   4280c:	c7 45 f4 84 00 00 00 	movl   $0x84,-0xc(%rbp)
   42813:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42816:	89 c2                	mov    %eax,%edx
   42818:	ec                   	in     (%dx),%al
   42819:	88 45 f3             	mov    %al,-0xd(%rbp)
   4281c:	c7 45 fc 84 00 00 00 	movl   $0x84,-0x4(%rbp)
   42823:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42826:	89 c2                	mov    %eax,%edx
   42828:	ec                   	in     (%dx),%al
   42829:	88 45 fb             	mov    %al,-0x5(%rbp)
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
}
   4282c:	90                   	nop
   4282d:	c9                   	leave  
   4282e:	c3                   	ret    

000000000004282f <parallel_port_putc>:

static void parallel_port_putc(printer* p, unsigned char c, int color) {
   4282f:	55                   	push   %rbp
   42830:	48 89 e5             	mov    %rsp,%rbp
   42833:	48 83 ec 40          	sub    $0x40,%rsp
   42837:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   4283b:	89 f0                	mov    %esi,%eax
   4283d:	89 55 c0             	mov    %edx,-0x40(%rbp)
   42840:	88 45 c4             	mov    %al,-0x3c(%rbp)
    static int initialized;
    (void) p, (void) color;
    if (!initialized) {
   42843:	8b 05 bb da 00 00    	mov    0xdabb(%rip),%eax        # 50304 <initialized.0>
   42849:	85 c0                	test   %eax,%eax
   4284b:	75 1e                	jne    4286b <parallel_port_putc+0x3c>
   4284d:	c7 45 f8 7a 03 00 00 	movl   $0x37a,-0x8(%rbp)
   42854:	c6 45 f7 00          	movb   $0x0,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42858:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   4285c:	8b 55 f8             	mov    -0x8(%rbp),%edx
   4285f:	ee                   	out    %al,(%dx)
}
   42860:	90                   	nop
        outb(IO_PARALLEL1_CONTROL, 0);
        initialized = 1;
   42861:	c7 05 99 da 00 00 01 	movl   $0x1,0xda99(%rip)        # 50304 <initialized.0>
   42868:	00 00 00 
    }

    for (int i = 0;
   4286b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42872:	eb 09                	jmp    4287d <parallel_port_putc+0x4e>
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
         ++i) {
        delay();
   42874:	e8 6b ff ff ff       	call   427e4 <delay>
         ++i) {
   42879:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
   4287d:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%rbp)
   42884:	7f 18                	jg     4289e <parallel_port_putc+0x6f>
   42886:	c7 45 f0 79 03 00 00 	movl   $0x379,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   4288d:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42890:	89 c2                	mov    %eax,%edx
   42892:	ec                   	in     (%dx),%al
   42893:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   42896:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   4289a:	84 c0                	test   %al,%al
   4289c:	79 d6                	jns    42874 <parallel_port_putc+0x45>
    }
    outb(IO_PARALLEL1_DATA, c);
   4289e:	0f b6 45 c4          	movzbl -0x3c(%rbp),%eax
   428a2:	c7 45 d8 78 03 00 00 	movl   $0x378,-0x28(%rbp)
   428a9:	88 45 d7             	mov    %al,-0x29(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   428ac:	0f b6 45 d7          	movzbl -0x29(%rbp),%eax
   428b0:	8b 55 d8             	mov    -0x28(%rbp),%edx
   428b3:	ee                   	out    %al,(%dx)
}
   428b4:	90                   	nop
   428b5:	c7 45 e0 7a 03 00 00 	movl   $0x37a,-0x20(%rbp)
   428bc:	c6 45 df 0d          	movb   $0xd,-0x21(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   428c0:	0f b6 45 df          	movzbl -0x21(%rbp),%eax
   428c4:	8b 55 e0             	mov    -0x20(%rbp),%edx
   428c7:	ee                   	out    %al,(%dx)
}
   428c8:	90                   	nop
   428c9:	c7 45 e8 7a 03 00 00 	movl   $0x37a,-0x18(%rbp)
   428d0:	c6 45 e7 0c          	movb   $0xc,-0x19(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   428d4:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
   428d8:	8b 55 e8             	mov    -0x18(%rbp),%edx
   428db:	ee                   	out    %al,(%dx)
}
   428dc:	90                   	nop
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT | IO_PARALLEL_CONTROL_STROBE);
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT);
}
   428dd:	90                   	nop
   428de:	c9                   	leave  
   428df:	c3                   	ret    

00000000000428e0 <log_vprintf>:

void log_vprintf(const char* format, va_list val) {
   428e0:	55                   	push   %rbp
   428e1:	48 89 e5             	mov    %rsp,%rbp
   428e4:	48 83 ec 20          	sub    $0x20,%rsp
   428e8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   428ec:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    printer p;
    p.putc = parallel_port_putc;
   428f0:	48 c7 45 f8 2f 28 04 	movq   $0x4282f,-0x8(%rbp)
   428f7:	00 
    printer_vprintf(&p, 0, format, val);
   428f8:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   428fc:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   42900:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
   42904:	be 00 00 00 00       	mov    $0x0,%esi
   42909:	48 89 c7             	mov    %rax,%rdi
   4290c:	e8 33 10 00 00       	call   43944 <printer_vprintf>
}
   42911:	90                   	nop
   42912:	c9                   	leave  
   42913:	c3                   	ret    

0000000000042914 <log_printf>:

void log_printf(const char* format, ...) {
   42914:	55                   	push   %rbp
   42915:	48 89 e5             	mov    %rsp,%rbp
   42918:	48 83 ec 60          	sub    $0x60,%rsp
   4291c:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42920:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42924:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   42928:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   4292c:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42930:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42934:	c7 45 b8 08 00 00 00 	movl   $0x8,-0x48(%rbp)
   4293b:	48 8d 45 10          	lea    0x10(%rbp),%rax
   4293f:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   42943:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42947:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    log_vprintf(format, val);
   4294b:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   4294f:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42953:	48 89 d6             	mov    %rdx,%rsi
   42956:	48 89 c7             	mov    %rax,%rdi
   42959:	e8 82 ff ff ff       	call   428e0 <log_vprintf>
    va_end(val);
}
   4295e:	90                   	nop
   4295f:	c9                   	leave  
   42960:	c3                   	ret    

0000000000042961 <error_vprintf>:

// error_printf, error_vprintf
//    Print debugging messages to the console and to the host's
//    `log.txt` file via `log_printf`.

int error_vprintf(int cpos, int color, const char* format, va_list val) {
   42961:	55                   	push   %rbp
   42962:	48 89 e5             	mov    %rsp,%rbp
   42965:	48 83 ec 40          	sub    $0x40,%rsp
   42969:	89 7d dc             	mov    %edi,-0x24(%rbp)
   4296c:	89 75 d8             	mov    %esi,-0x28(%rbp)
   4296f:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
   42973:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    va_list val2;
    __builtin_va_copy(val2, val);
   42977:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   4297b:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   4297f:	48 8b 0a             	mov    (%rdx),%rcx
   42982:	48 89 08             	mov    %rcx,(%rax)
   42985:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
   42989:	48 89 48 08          	mov    %rcx,0x8(%rax)
   4298d:	48 8b 52 10          	mov    0x10(%rdx),%rdx
   42991:	48 89 50 10          	mov    %rdx,0x10(%rax)
    log_vprintf(format, val2);
   42995:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
   42999:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   4299d:	48 89 d6             	mov    %rdx,%rsi
   429a0:	48 89 c7             	mov    %rax,%rdi
   429a3:	e8 38 ff ff ff       	call   428e0 <log_vprintf>
    va_end(val2);
    return console_vprintf(cpos, color, format, val);
   429a8:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   429ac:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   429b0:	8b 75 d8             	mov    -0x28(%rbp),%esi
   429b3:	8b 45 dc             	mov    -0x24(%rbp),%eax
   429b6:	89 c7                	mov    %eax,%edi
   429b8:	e8 66 16 00 00       	call   44023 <console_vprintf>
}
   429bd:	c9                   	leave  
   429be:	c3                   	ret    

00000000000429bf <error_printf>:

int error_printf(int cpos, int color, const char* format, ...) {
   429bf:	55                   	push   %rbp
   429c0:	48 89 e5             	mov    %rsp,%rbp
   429c3:	48 83 ec 60          	sub    $0x60,%rsp
   429c7:	89 7d ac             	mov    %edi,-0x54(%rbp)
   429ca:	89 75 a8             	mov    %esi,-0x58(%rbp)
   429cd:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   429d1:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   429d5:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   429d9:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   429dd:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   429e4:	48 8d 45 10          	lea    0x10(%rbp),%rax
   429e8:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   429ec:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   429f0:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = error_vprintf(cpos, color, format, val);
   429f4:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   429f8:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   429fc:	8b 75 a8             	mov    -0x58(%rbp),%esi
   429ff:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42a02:	89 c7                	mov    %eax,%edi
   42a04:	e8 58 ff ff ff       	call   42961 <error_vprintf>
   42a09:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   42a0c:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   42a0f:	c9                   	leave  
   42a10:	c3                   	ret    

0000000000042a11 <check_keyboard>:
//    Check for the user typing a control key. 'a', 'f', and 'e' cause a soft
//    reboot where the kernel runs the allocator programs, "fork", or
//    "forkexit", respectively. Control-C or 'q' exit the virtual machine.
//    Returns key typed or -1 for no key.

int check_keyboard(void) {
   42a11:	55                   	push   %rbp
   42a12:	48 89 e5             	mov    %rsp,%rbp
   42a15:	53                   	push   %rbx
   42a16:	48 83 ec 48          	sub    $0x48,%rsp
    int c = keyboard_readc();
   42a1a:	e8 ac fb ff ff       	call   425cb <keyboard_readc>
   42a1f:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   42a22:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   42a26:	74 1c                	je     42a44 <check_keyboard+0x33>
   42a28:	83 7d e4 66          	cmpl   $0x66,-0x1c(%rbp)
   42a2c:	74 16                	je     42a44 <check_keyboard+0x33>
   42a2e:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   42a32:	74 10                	je     42a44 <check_keyboard+0x33>
   42a34:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   42a38:	74 0a                	je     42a44 <check_keyboard+0x33>
   42a3a:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   42a3e:	0f 85 e9 00 00 00    	jne    42b2d <check_keyboard+0x11c>
        // Install a temporary page table to carry us through the
        // process of reinitializing memory. This replicates work the
        // bootloader does.
        x86_64_pagetable* pt = (x86_64_pagetable*) 0x8000;
   42a44:	48 c7 45 d8 00 80 00 	movq   $0x8000,-0x28(%rbp)
   42a4b:	00 
        memset(pt, 0, PAGESIZE * 3);
   42a4c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42a50:	ba 00 30 00 00       	mov    $0x3000,%edx
   42a55:	be 00 00 00 00       	mov    $0x0,%esi
   42a5a:	48 89 c7             	mov    %rax,%rdi
   42a5d:	e8 d1 0d 00 00       	call   43833 <memset>
        pt[0].entry[0] = 0x9000 | PTE_P | PTE_W | PTE_U;
   42a62:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42a66:	48 c7 00 07 90 00 00 	movq   $0x9007,(%rax)
        pt[1].entry[0] = 0xA000 | PTE_P | PTE_W | PTE_U;
   42a6d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42a71:	48 05 00 10 00 00    	add    $0x1000,%rax
   42a77:	48 c7 00 07 a0 00 00 	movq   $0xa007,(%rax)
        pt[2].entry[0] = PTE_P | PTE_W | PTE_U | PTE_PS;
   42a7e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42a82:	48 05 00 20 00 00    	add    $0x2000,%rax
   42a88:	48 c7 00 87 00 00 00 	movq   $0x87,(%rax)
        lcr3((uintptr_t) pt);
   42a8f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42a93:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
}

static inline void lcr3(uintptr_t val) {
    asm volatile("" : : : "memory");
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   42a97:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42a9b:	0f 22 d8             	mov    %rax,%cr3
}
   42a9e:	90                   	nop
        // The soft reboot process doesn't modify memory, so it's
        // safe to pass `multiboot_info` on the kernel stack, even
        // though it will get overwritten as the kernel runs.
        uint32_t multiboot_info[5];
        multiboot_info[0] = 4;
   42a9f:	c7 45 b4 04 00 00 00 	movl   $0x4,-0x4c(%rbp)
        const char* argument = "fork";
   42aa6:	48 c7 45 e8 18 47 04 	movq   $0x44718,-0x18(%rbp)
   42aad:	00 
        if (c == 'a') {
   42aae:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   42ab2:	75 0a                	jne    42abe <check_keyboard+0xad>
            argument = "allocator";
   42ab4:	48 c7 45 e8 1d 47 04 	movq   $0x4471d,-0x18(%rbp)
   42abb:	00 
   42abc:	eb 2e                	jmp    42aec <check_keyboard+0xdb>
        } else if (c == 'e') {
   42abe:	83 7d e4 65          	cmpl   $0x65,-0x1c(%rbp)
   42ac2:	75 0a                	jne    42ace <check_keyboard+0xbd>
            argument = "forkexit";
   42ac4:	48 c7 45 e8 27 47 04 	movq   $0x44727,-0x18(%rbp)
   42acb:	00 
   42acc:	eb 1e                	jmp    42aec <check_keyboard+0xdb>
        }
        else if (c == 't'){
   42ace:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   42ad2:	75 0a                	jne    42ade <check_keyboard+0xcd>
            argument = "test";
   42ad4:	48 c7 45 e8 30 47 04 	movq   $0x44730,-0x18(%rbp)
   42adb:	00 
   42adc:	eb 0e                	jmp    42aec <check_keyboard+0xdb>
        }
        else if(c == '2'){
   42ade:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   42ae2:	75 08                	jne    42aec <check_keyboard+0xdb>
            argument = "test2";
   42ae4:	48 c7 45 e8 35 47 04 	movq   $0x44735,-0x18(%rbp)
   42aeb:	00 
        }
        uintptr_t argument_ptr = (uintptr_t) argument;
   42aec:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42af0:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        assert(argument_ptr < 0x100000000L);
   42af4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42af9:	48 39 45 d0          	cmp    %rax,-0x30(%rbp)
   42afd:	76 14                	jbe    42b13 <check_keyboard+0x102>
   42aff:	ba 3b 47 04 00       	mov    $0x4473b,%edx
   42b04:	be 5c 02 00 00       	mov    $0x25c,%esi
   42b09:	bf 57 47 04 00       	mov    $0x44757,%edi
   42b0e:	e8 1f 01 00 00       	call   42c32 <assert_fail>
        multiboot_info[4] = (uint32_t) argument_ptr;
   42b13:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42b17:	89 45 c4             	mov    %eax,-0x3c(%rbp)
        asm volatile("movl $0x2BADB002, %%eax; jmp entry_from_boot"
   42b1a:	48 8d 45 b4          	lea    -0x4c(%rbp),%rax
   42b1e:	48 89 c3             	mov    %rax,%rbx
   42b21:	b8 02 b0 ad 2b       	mov    $0x2badb002,%eax
   42b26:	e9 d5 d4 ff ff       	jmp    40000 <entry_from_boot>
    if (c == 'a' || c == 'f' || c == 'e' || c == 't' || c =='2') {
   42b2b:	eb 11                	jmp    42b3e <check_keyboard+0x12d>
                     : : "b" (multiboot_info) : "memory");
    } else if (c == 0x03 || c == 'q') {
   42b2d:	83 7d e4 03          	cmpl   $0x3,-0x1c(%rbp)
   42b31:	74 06                	je     42b39 <check_keyboard+0x128>
   42b33:	83 7d e4 71          	cmpl   $0x71,-0x1c(%rbp)
   42b37:	75 05                	jne    42b3e <check_keyboard+0x12d>
        poweroff();
   42b39:	e8 ae f8 ff ff       	call   423ec <poweroff>
    }
    return c;
   42b3e:	8b 45 e4             	mov    -0x1c(%rbp),%eax
}
   42b41:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   42b45:	c9                   	leave  
   42b46:	c3                   	ret    

0000000000042b47 <fail>:

// fail
//    Loop until user presses Control-C, then poweroff.

static void fail(void) __attribute__((noreturn));
static void fail(void) {
   42b47:	55                   	push   %rbp
   42b48:	48 89 e5             	mov    %rsp,%rbp
    while (1) {
        check_keyboard();
   42b4b:	e8 c1 fe ff ff       	call   42a11 <check_keyboard>
   42b50:	eb f9                	jmp    42b4b <fail+0x4>

0000000000042b52 <panic>:

// panic, assert_fail
//    Use console_printf() to print a failure message and then wait for
//    control-C. Also write the failure message to the log.

void panic(const char* format, ...) {
   42b52:	55                   	push   %rbp
   42b53:	48 89 e5             	mov    %rsp,%rbp
   42b56:	48 83 ec 60          	sub    $0x60,%rsp
   42b5a:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42b5e:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42b62:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   42b66:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42b6a:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42b6e:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42b72:	c7 45 b0 08 00 00 00 	movl   $0x8,-0x50(%rbp)
   42b79:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42b7d:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   42b81:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42b85:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

    if (format) {
   42b89:	48 83 7d a8 00       	cmpq   $0x0,-0x58(%rbp)
   42b8e:	0f 84 80 00 00 00    	je     42c14 <panic+0xc2>
        // Print panic message to both the screen and the log
        int cpos = error_printf(CPOS(23, 0), 0xC000, "PANIC: ");
   42b94:	ba 64 47 04 00       	mov    $0x44764,%edx
   42b99:	be 00 c0 00 00       	mov    $0xc000,%esi
   42b9e:	bf 30 07 00 00       	mov    $0x730,%edi
   42ba3:	b8 00 00 00 00       	mov    $0x0,%eax
   42ba8:	e8 12 fe ff ff       	call   429bf <error_printf>
   42bad:	89 45 cc             	mov    %eax,-0x34(%rbp)
        cpos = error_vprintf(cpos, 0xC000, format, val);
   42bb0:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   42bb4:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   42bb8:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42bbb:	be 00 c0 00 00       	mov    $0xc000,%esi
   42bc0:	89 c7                	mov    %eax,%edi
   42bc2:	e8 9a fd ff ff       	call   42961 <error_vprintf>
   42bc7:	89 45 cc             	mov    %eax,-0x34(%rbp)
        if (CCOL(cpos)) {
   42bca:	8b 4d cc             	mov    -0x34(%rbp),%ecx
   42bcd:	48 63 c1             	movslq %ecx,%rax
   42bd0:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
   42bd7:	48 c1 e8 20          	shr    $0x20,%rax
   42bdb:	c1 f8 05             	sar    $0x5,%eax
   42bde:	89 ce                	mov    %ecx,%esi
   42be0:	c1 fe 1f             	sar    $0x1f,%esi
   42be3:	29 f0                	sub    %esi,%eax
   42be5:	89 c2                	mov    %eax,%edx
   42be7:	89 d0                	mov    %edx,%eax
   42be9:	c1 e0 02             	shl    $0x2,%eax
   42bec:	01 d0                	add    %edx,%eax
   42bee:	c1 e0 04             	shl    $0x4,%eax
   42bf1:	29 c1                	sub    %eax,%ecx
   42bf3:	89 ca                	mov    %ecx,%edx
   42bf5:	85 d2                	test   %edx,%edx
   42bf7:	74 34                	je     42c2d <panic+0xdb>
            error_printf(cpos, 0xC000, "\n");
   42bf9:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42bfc:	ba 6c 47 04 00       	mov    $0x4476c,%edx
   42c01:	be 00 c0 00 00       	mov    $0xc000,%esi
   42c06:	89 c7                	mov    %eax,%edi
   42c08:	b8 00 00 00 00       	mov    $0x0,%eax
   42c0d:	e8 ad fd ff ff       	call   429bf <error_printf>
   42c12:	eb 19                	jmp    42c2d <panic+0xdb>
        }
    } else {
        error_printf(CPOS(23, 0), 0xC000, "PANIC");
   42c14:	ba 6e 47 04 00       	mov    $0x4476e,%edx
   42c19:	be 00 c0 00 00       	mov    $0xc000,%esi
   42c1e:	bf 30 07 00 00       	mov    $0x730,%edi
   42c23:	b8 00 00 00 00       	mov    $0x0,%eax
   42c28:	e8 92 fd ff ff       	call   429bf <error_printf>
    }

    va_end(val);
    fail();
   42c2d:	e8 15 ff ff ff       	call   42b47 <fail>

0000000000042c32 <assert_fail>:
}

void assert_fail(const char* file, int line, const char* msg) {
   42c32:	55                   	push   %rbp
   42c33:	48 89 e5             	mov    %rsp,%rbp
   42c36:	48 83 ec 20          	sub    $0x20,%rsp
   42c3a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42c3e:	89 75 f4             	mov    %esi,-0xc(%rbp)
   42c41:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    panic("%s:%d: assertion '%s' failed\n", file, line, msg);
   42c45:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   42c49:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42c4c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42c50:	48 89 c6             	mov    %rax,%rsi
   42c53:	bf 74 47 04 00       	mov    $0x44774,%edi
   42c58:	b8 00 00 00 00       	mov    $0x0,%eax
   42c5d:	e8 f0 fe ff ff       	call   42b52 <panic>

0000000000042c62 <default_exception>:
}

void default_exception(proc* p){
   42c62:	55                   	push   %rbp
   42c63:	48 89 e5             	mov    %rsp,%rbp
   42c66:	48 83 ec 20          	sub    $0x20,%rsp
   42c6a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    x86_64_registers * reg = &(p->p_registers);
   42c6e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42c72:	48 83 c0 08          	add    $0x8,%rax
   42c76:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    panic("Unexpected exception %d!\n", reg->reg_intno);
   42c7a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42c7e:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   42c85:	48 89 c6             	mov    %rax,%rsi
   42c88:	bf 92 47 04 00       	mov    $0x44792,%edi
   42c8d:	b8 00 00 00 00       	mov    $0x0,%eax
   42c92:	e8 bb fe ff ff       	call   42b52 <panic>

0000000000042c97 <pageindex>:
static inline int pageindex(uintptr_t addr, int level) {
   42c97:	55                   	push   %rbp
   42c98:	48 89 e5             	mov    %rsp,%rbp
   42c9b:	48 83 ec 10          	sub    $0x10,%rsp
   42c9f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   42ca3:	89 75 f4             	mov    %esi,-0xc(%rbp)
    assert(level >= 0 && level <= 3);
   42ca6:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   42caa:	78 06                	js     42cb2 <pageindex+0x1b>
   42cac:	83 7d f4 03          	cmpl   $0x3,-0xc(%rbp)
   42cb0:	7e 14                	jle    42cc6 <pageindex+0x2f>
   42cb2:	ba b0 47 04 00       	mov    $0x447b0,%edx
   42cb7:	be 1e 00 00 00       	mov    $0x1e,%esi
   42cbc:	bf c9 47 04 00       	mov    $0x447c9,%edi
   42cc1:	e8 6c ff ff ff       	call   42c32 <assert_fail>
    return (int) (addr >> (PAGEOFFBITS + (3 - level) * PAGEINDEXBITS)) & 0x1FF;
   42cc6:	b8 03 00 00 00       	mov    $0x3,%eax
   42ccb:	2b 45 f4             	sub    -0xc(%rbp),%eax
   42cce:	89 c2                	mov    %eax,%edx
   42cd0:	89 d0                	mov    %edx,%eax
   42cd2:	c1 e0 03             	shl    $0x3,%eax
   42cd5:	01 d0                	add    %edx,%eax
   42cd7:	83 c0 0c             	add    $0xc,%eax
   42cda:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42cde:	89 c1                	mov    %eax,%ecx
   42ce0:	48 d3 ea             	shr    %cl,%rdx
   42ce3:	48 89 d0             	mov    %rdx,%rax
   42ce6:	25 ff 01 00 00       	and    $0x1ff,%eax
}
   42ceb:	c9                   	leave  
   42cec:	c3                   	ret    

0000000000042ced <virtual_memory_init>:

static x86_64_pagetable kernel_pagetables[5];
x86_64_pagetable* kernel_pagetable;


void virtual_memory_init(void) {
   42ced:	55                   	push   %rbp
   42cee:	48 89 e5             	mov    %rsp,%rbp
   42cf1:	48 83 ec 20          	sub    $0x20,%rsp
    kernel_pagetable = &kernel_pagetables[0];
   42cf5:	48 c7 05 00 e3 00 00 	movq   $0x52000,0xe300(%rip)        # 51000 <kernel_pagetable>
   42cfc:	00 20 05 00 
    memset(kernel_pagetables, 0, sizeof(kernel_pagetables));
   42d00:	ba 00 50 00 00       	mov    $0x5000,%edx
   42d05:	be 00 00 00 00       	mov    $0x0,%esi
   42d0a:	bf 00 20 05 00       	mov    $0x52000,%edi
   42d0f:	e8 1f 0b 00 00       	call   43833 <memset>

    // connect the pagetable pages
    kernel_pagetables[0].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[1] | PTE_P | PTE_W | PTE_U;
   42d14:	b8 00 30 05 00       	mov    $0x53000,%eax
   42d19:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[0].entry[0] =
   42d1d:	48 89 05 dc f2 00 00 	mov    %rax,0xf2dc(%rip)        # 52000 <kernel_pagetables>
    kernel_pagetables[1].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[2] | PTE_P | PTE_W | PTE_U;
   42d24:	b8 00 40 05 00       	mov    $0x54000,%eax
   42d29:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[1].entry[0] =
   42d2d:	48 89 05 cc 02 01 00 	mov    %rax,0x102cc(%rip)        # 53000 <kernel_pagetables+0x1000>
    kernel_pagetables[2].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[3] | PTE_P | PTE_W | PTE_U;
   42d34:	b8 00 50 05 00       	mov    $0x55000,%eax
   42d39:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[0] =
   42d3d:	48 89 05 bc 12 01 00 	mov    %rax,0x112bc(%rip)        # 54000 <kernel_pagetables+0x2000>
    kernel_pagetables[2].entry[1] =
        (x86_64_pageentry_t) &kernel_pagetables[4] | PTE_P | PTE_W | PTE_U;
   42d44:	b8 00 60 05 00       	mov    $0x56000,%eax
   42d49:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[1] =
   42d4d:	48 89 05 b4 12 01 00 	mov    %rax,0x112b4(%rip)        # 54008 <kernel_pagetables+0x2008>

    // identity map the page table
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   42d54:	48 8b 05 a5 e2 00 00 	mov    0xe2a5(%rip),%rax        # 51000 <kernel_pagetable>
   42d5b:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   42d61:	b9 00 00 20 00       	mov    $0x200000,%ecx
   42d66:	ba 00 00 00 00       	mov    $0x0,%edx
   42d6b:	be 00 00 00 00       	mov    $0x0,%esi
   42d70:	48 89 c7             	mov    %rax,%rdi
   42d73:	e8 b9 01 00 00       	call   42f31 <virtual_memory_map>
                       MEMSIZE_PHYSICAL, PTE_P | PTE_W | PTE_U);

    // check if kernel is identity mapped
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   42d78:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   42d7f:	00 
   42d80:	eb 62                	jmp    42de4 <virtual_memory_init+0xf7>
        vamapping vmap = virtual_memory_lookup(kernel_pagetable, addr);
   42d82:	48 8b 0d 77 e2 00 00 	mov    0xe277(%rip),%rcx        # 51000 <kernel_pagetable>
   42d89:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   42d8d:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42d91:	48 89 ce             	mov    %rcx,%rsi
   42d94:	48 89 c7             	mov    %rax,%rdi
   42d97:	e8 50 05 00 00       	call   432ec <virtual_memory_lookup>
        // this assert will probably fail initially!
        // have you implemented virtual_memory_map and lookup_l1pagetable ?
        assert(vmap.pa == addr);
   42d9c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42da0:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   42da4:	74 14                	je     42dba <virtual_memory_init+0xcd>
   42da6:	ba d2 47 04 00       	mov    $0x447d2,%edx
   42dab:	be 2d 00 00 00       	mov    $0x2d,%esi
   42db0:	bf e2 47 04 00       	mov    $0x447e2,%edi
   42db5:	e8 78 fe ff ff       	call   42c32 <assert_fail>
        assert((vmap.perm & (PTE_P|PTE_W)) == (PTE_P|PTE_W));
   42dba:	8b 45 f0             	mov    -0x10(%rbp),%eax
   42dbd:	48 98                	cltq   
   42dbf:	83 e0 03             	and    $0x3,%eax
   42dc2:	48 83 f8 03          	cmp    $0x3,%rax
   42dc6:	74 14                	je     42ddc <virtual_memory_init+0xef>
   42dc8:	ba e8 47 04 00       	mov    $0x447e8,%edx
   42dcd:	be 2e 00 00 00       	mov    $0x2e,%esi
   42dd2:	bf e2 47 04 00       	mov    $0x447e2,%edi
   42dd7:	e8 56 fe ff ff       	call   42c32 <assert_fail>
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   42ddc:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   42de3:	00 
   42de4:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   42deb:	00 
   42dec:	76 94                	jbe    42d82 <virtual_memory_init+0x95>
    }

    // set pointer to this pagetable in the CR3 register
    // set_pagetable also does several checks for a valid pagetable
    set_pagetable(kernel_pagetable);
   42dee:	48 8b 05 0b e2 00 00 	mov    0xe20b(%rip),%rax        # 51000 <kernel_pagetable>
   42df5:	48 89 c7             	mov    %rax,%rdi
   42df8:	e8 03 00 00 00       	call   42e00 <set_pagetable>
}
   42dfd:	90                   	nop
   42dfe:	c9                   	leave  
   42dff:	c3                   	ret    

0000000000042e00 <set_pagetable>:
// set_pagetable
//    Change page directory. lcr3() is the hardware instruction;
//    set_pagetable() additionally checks that important kernel procedures are
//    mappable in `pagetable`, and calls panic() if they aren't.

void set_pagetable(x86_64_pagetable* pagetable) {
   42e00:	55                   	push   %rbp
   42e01:	48 89 e5             	mov    %rsp,%rbp
   42e04:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   42e08:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
    assert(PAGEOFFSET(pagetable) == 0); // must be page aligned
   42e0c:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42e10:	25 ff 0f 00 00       	and    $0xfff,%eax
   42e15:	48 85 c0             	test   %rax,%rax
   42e18:	74 14                	je     42e2e <set_pagetable+0x2e>
   42e1a:	ba 15 48 04 00       	mov    $0x44815,%edx
   42e1f:	be 3d 00 00 00       	mov    $0x3d,%esi
   42e24:	bf e2 47 04 00       	mov    $0x447e2,%edi
   42e29:	e8 04 fe ff ff       	call   42c32 <assert_fail>
    // check for kernel space being mapped in pagetable
    assert(virtual_memory_lookup(pagetable, (uintptr_t) default_int_handler).pa
   42e2e:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   42e33:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   42e37:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42e3b:	48 89 ce             	mov    %rcx,%rsi
   42e3e:	48 89 c7             	mov    %rax,%rdi
   42e41:	e8 a6 04 00 00       	call   432ec <virtual_memory_lookup>
   42e46:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42e4a:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   42e4f:	48 39 d0             	cmp    %rdx,%rax
   42e52:	74 14                	je     42e68 <set_pagetable+0x68>
   42e54:	ba 30 48 04 00       	mov    $0x44830,%edx
   42e59:	be 3f 00 00 00       	mov    $0x3f,%esi
   42e5e:	bf e2 47 04 00       	mov    $0x447e2,%edi
   42e63:	e8 ca fd ff ff       	call   42c32 <assert_fail>
           == (uintptr_t) default_int_handler);
    assert(virtual_memory_lookup(kernel_pagetable, (uintptr_t) pagetable).pa
   42e68:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
   42e6c:	48 8b 0d 8d e1 00 00 	mov    0xe18d(%rip),%rcx        # 51000 <kernel_pagetable>
   42e73:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   42e77:	48 89 ce             	mov    %rcx,%rsi
   42e7a:	48 89 c7             	mov    %rax,%rdi
   42e7d:	e8 6a 04 00 00       	call   432ec <virtual_memory_lookup>
   42e82:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42e86:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42e8a:	48 39 c2             	cmp    %rax,%rdx
   42e8d:	74 14                	je     42ea3 <set_pagetable+0xa3>
   42e8f:	ba 98 48 04 00       	mov    $0x44898,%edx
   42e94:	be 41 00 00 00       	mov    $0x41,%esi
   42e99:	bf e2 47 04 00       	mov    $0x447e2,%edi
   42e9e:	e8 8f fd ff ff       	call   42c32 <assert_fail>
           == (uintptr_t) pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) kernel_pagetable).pa
   42ea3:	48 8b 05 56 e1 00 00 	mov    0xe156(%rip),%rax        # 51000 <kernel_pagetable>
   42eaa:	48 89 c2             	mov    %rax,%rdx
   42ead:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
   42eb1:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42eb5:	48 89 ce             	mov    %rcx,%rsi
   42eb8:	48 89 c7             	mov    %rax,%rdi
   42ebb:	e8 2c 04 00 00       	call   432ec <virtual_memory_lookup>
   42ec0:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42ec4:	48 8b 15 35 e1 00 00 	mov    0xe135(%rip),%rdx        # 51000 <kernel_pagetable>
   42ecb:	48 39 d0             	cmp    %rdx,%rax
   42ece:	74 14                	je     42ee4 <set_pagetable+0xe4>
   42ed0:	ba f8 48 04 00       	mov    $0x448f8,%edx
   42ed5:	be 43 00 00 00       	mov    $0x43,%esi
   42eda:	bf e2 47 04 00       	mov    $0x447e2,%edi
   42edf:	e8 4e fd ff ff       	call   42c32 <assert_fail>
           == (uintptr_t) kernel_pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) virtual_memory_map).pa
   42ee4:	ba 31 2f 04 00       	mov    $0x42f31,%edx
   42ee9:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   42eed:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42ef1:	48 89 ce             	mov    %rcx,%rsi
   42ef4:	48 89 c7             	mov    %rax,%rdi
   42ef7:	e8 f0 03 00 00       	call   432ec <virtual_memory_lookup>
   42efc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f00:	ba 31 2f 04 00       	mov    $0x42f31,%edx
   42f05:	48 39 d0             	cmp    %rdx,%rax
   42f08:	74 14                	je     42f1e <set_pagetable+0x11e>
   42f0a:	ba 60 49 04 00       	mov    $0x44960,%edx
   42f0f:	be 45 00 00 00       	mov    $0x45,%esi
   42f14:	bf e2 47 04 00       	mov    $0x447e2,%edi
   42f19:	e8 14 fd ff ff       	call   42c32 <assert_fail>
           == (uintptr_t) virtual_memory_map);
    lcr3((uintptr_t) pagetable);
   42f1e:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42f22:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   42f26:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42f2a:	0f 22 d8             	mov    %rax,%cr3
}
   42f2d:	90                   	nop
}
   42f2e:	90                   	nop
   42f2f:	c9                   	leave  
   42f30:	c3                   	ret    

0000000000042f31 <virtual_memory_map>:
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm);

int virtual_memory_map(x86_64_pagetable* pagetable, uintptr_t va,
                       uintptr_t pa, size_t sz, int perm) {
   42f31:	55                   	push   %rbp
   42f32:	48 89 e5             	mov    %rsp,%rbp
   42f35:	53                   	push   %rbx
   42f36:	48 83 ec 58          	sub    $0x58,%rsp
   42f3a:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42f3e:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   42f42:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
   42f46:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
   42f4a:	44 89 45 ac          	mov    %r8d,-0x54(%rbp)

    // sanity checks for virtual address, size, and permisions
    assert(va % PAGESIZE == 0); // virtual address is page-aligned
   42f4e:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42f52:	25 ff 0f 00 00       	and    $0xfff,%eax
   42f57:	48 85 c0             	test   %rax,%rax
   42f5a:	74 14                	je     42f70 <virtual_memory_map+0x3f>
   42f5c:	ba c6 49 04 00       	mov    $0x449c6,%edx
   42f61:	be 66 00 00 00       	mov    $0x66,%esi
   42f66:	bf e2 47 04 00       	mov    $0x447e2,%edi
   42f6b:	e8 c2 fc ff ff       	call   42c32 <assert_fail>
    assert(sz % PAGESIZE == 0); // size is a multiple of PAGESIZE
   42f70:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42f74:	25 ff 0f 00 00       	and    $0xfff,%eax
   42f79:	48 85 c0             	test   %rax,%rax
   42f7c:	74 14                	je     42f92 <virtual_memory_map+0x61>
   42f7e:	ba d9 49 04 00       	mov    $0x449d9,%edx
   42f83:	be 67 00 00 00       	mov    $0x67,%esi
   42f88:	bf e2 47 04 00       	mov    $0x447e2,%edi
   42f8d:	e8 a0 fc ff ff       	call   42c32 <assert_fail>
    assert(va + sz >= va || va + sz == 0); // va range does not wrap
   42f92:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   42f96:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42f9a:	48 01 d0             	add    %rdx,%rax
   42f9d:	48 39 45 c0          	cmp    %rax,-0x40(%rbp)
   42fa1:	76 24                	jbe    42fc7 <virtual_memory_map+0x96>
   42fa3:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   42fa7:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42fab:	48 01 d0             	add    %rdx,%rax
   42fae:	48 85 c0             	test   %rax,%rax
   42fb1:	74 14                	je     42fc7 <virtual_memory_map+0x96>
   42fb3:	ba ec 49 04 00       	mov    $0x449ec,%edx
   42fb8:	be 68 00 00 00       	mov    $0x68,%esi
   42fbd:	bf e2 47 04 00       	mov    $0x447e2,%edi
   42fc2:	e8 6b fc ff ff       	call   42c32 <assert_fail>
    if (perm & PTE_P) {
   42fc7:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42fca:	48 98                	cltq   
   42fcc:	83 e0 01             	and    $0x1,%eax
   42fcf:	48 85 c0             	test   %rax,%rax
   42fd2:	74 6e                	je     43042 <virtual_memory_map+0x111>
        assert(pa % PAGESIZE == 0); // physical addr is page-aligned
   42fd4:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42fd8:	25 ff 0f 00 00       	and    $0xfff,%eax
   42fdd:	48 85 c0             	test   %rax,%rax
   42fe0:	74 14                	je     42ff6 <virtual_memory_map+0xc5>
   42fe2:	ba 0a 4a 04 00       	mov    $0x44a0a,%edx
   42fe7:	be 6a 00 00 00       	mov    $0x6a,%esi
   42fec:	bf e2 47 04 00       	mov    $0x447e2,%edi
   42ff1:	e8 3c fc ff ff       	call   42c32 <assert_fail>
        assert(pa + sz >= pa);      // physical address range does not wrap
   42ff6:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42ffa:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42ffe:	48 01 d0             	add    %rdx,%rax
   43001:	48 39 45 b8          	cmp    %rax,-0x48(%rbp)
   43005:	76 14                	jbe    4301b <virtual_memory_map+0xea>
   43007:	ba 1d 4a 04 00       	mov    $0x44a1d,%edx
   4300c:	be 6b 00 00 00       	mov    $0x6b,%esi
   43011:	bf e2 47 04 00       	mov    $0x447e2,%edi
   43016:	e8 17 fc ff ff       	call   42c32 <assert_fail>
        assert(pa + sz <= MEMSIZE_PHYSICAL); // physical addresses exist
   4301b:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   4301f:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   43023:	48 01 d0             	add    %rdx,%rax
   43026:	48 3d 00 00 20 00    	cmp    $0x200000,%rax
   4302c:	76 14                	jbe    43042 <virtual_memory_map+0x111>
   4302e:	ba 2b 4a 04 00       	mov    $0x44a2b,%edx
   43033:	be 6c 00 00 00       	mov    $0x6c,%esi
   43038:	bf e2 47 04 00       	mov    $0x447e2,%edi
   4303d:	e8 f0 fb ff ff       	call   42c32 <assert_fail>
    }
    assert(perm >= 0 && perm < 0x1000); // `perm` makes sense (perm can only be 12 bits)
   43042:	83 7d ac 00          	cmpl   $0x0,-0x54(%rbp)
   43046:	78 09                	js     43051 <virtual_memory_map+0x120>
   43048:	81 7d ac ff 0f 00 00 	cmpl   $0xfff,-0x54(%rbp)
   4304f:	7e 14                	jle    43065 <virtual_memory_map+0x134>
   43051:	ba 47 4a 04 00       	mov    $0x44a47,%edx
   43056:	be 6e 00 00 00       	mov    $0x6e,%esi
   4305b:	bf e2 47 04 00       	mov    $0x447e2,%edi
   43060:	e8 cd fb ff ff       	call   42c32 <assert_fail>
    assert((uintptr_t) pagetable % PAGESIZE == 0); // `pagetable` page-aligned
   43065:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   43069:	25 ff 0f 00 00       	and    $0xfff,%eax
   4306e:	48 85 c0             	test   %rax,%rax
   43071:	74 14                	je     43087 <virtual_memory_map+0x156>
   43073:	ba 68 4a 04 00       	mov    $0x44a68,%edx
   43078:	be 6f 00 00 00       	mov    $0x6f,%esi
   4307d:	bf e2 47 04 00       	mov    $0x447e2,%edi
   43082:	e8 ab fb ff ff       	call   42c32 <assert_fail>

    int last_index123 = -1;
   43087:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,-0x14(%rbp)
    x86_64_pagetable* l1pagetable = (x86_64_pagetable *)NULL;
   4308e:	48 c7 45 e0 00 00 00 	movq   $0x0,-0x20(%rbp)
   43095:	00 

    // for each page-aligned address, set the appropriate page entry
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   43096:	e9 e1 00 00 00       	jmp    4317c <virtual_memory_map+0x24b>
        int cur_index123 = (va >> (PAGEOFFBITS + PAGEINDEXBITS));
   4309b:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4309f:	48 c1 e8 15          	shr    $0x15,%rax
   430a3:	89 45 dc             	mov    %eax,-0x24(%rbp)
        if (cur_index123 != last_index123) {
   430a6:	8b 45 dc             	mov    -0x24(%rbp),%eax
   430a9:	3b 45 ec             	cmp    -0x14(%rbp),%eax
   430ac:	74 20                	je     430ce <virtual_memory_map+0x19d>
            // TODO
            // find pointer to last level pagetable for current va
            l1pagetable = lookup_l1pagetable(pagetable, va, perm);
   430ae:	8b 55 ac             	mov    -0x54(%rbp),%edx
   430b1:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   430b5:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   430b9:	48 89 ce             	mov    %rcx,%rsi
   430bc:	48 89 c7             	mov    %rax,%rdi
   430bf:	e8 ce 00 00 00       	call   43192 <lookup_l1pagetable>
   430c4:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            last_index123 = cur_index123;
   430c8:	8b 45 dc             	mov    -0x24(%rbp),%eax
   430cb:	89 45 ec             	mov    %eax,-0x14(%rbp)
        }
        if ((perm & PTE_P) && l1pagetable) { // if page is marked present
   430ce:	8b 45 ac             	mov    -0x54(%rbp),%eax
   430d1:	48 98                	cltq   
   430d3:	83 e0 01             	and    $0x1,%eax
   430d6:	48 85 c0             	test   %rax,%rax
   430d9:	74 34                	je     4310f <virtual_memory_map+0x1de>
   430db:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   430e0:	74 2d                	je     4310f <virtual_memory_map+0x1de>
            // TODO
            // map `pa` at appropriate entry with permissions `perm`
            l1pagetable->entry[L1PAGEINDEX(va)] = pa | perm;
   430e2:	8b 45 ac             	mov    -0x54(%rbp),%eax
   430e5:	48 63 d8             	movslq %eax,%rbx
   430e8:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   430ec:	be 03 00 00 00       	mov    $0x3,%esi
   430f1:	48 89 c7             	mov    %rax,%rdi
   430f4:	e8 9e fb ff ff       	call   42c97 <pageindex>
   430f9:	89 c2                	mov    %eax,%edx
   430fb:	48 0b 5d b8          	or     -0x48(%rbp),%rbx
   430ff:	48 89 d9             	mov    %rbx,%rcx
   43102:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43106:	48 63 d2             	movslq %edx,%rdx
   43109:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   4310d:	eb 55                	jmp    43164 <virtual_memory_map+0x233>
        } else if (l1pagetable) { // if page is NOT marked present
   4310f:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   43114:	74 26                	je     4313c <virtual_memory_map+0x20b>
            // TODO
            // map to address 0 with `perm`
            l1pagetable->entry[L1PAGEINDEX(va)] = 0 | perm;
   43116:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4311a:	be 03 00 00 00       	mov    $0x3,%esi
   4311f:	48 89 c7             	mov    %rax,%rdi
   43122:	e8 70 fb ff ff       	call   42c97 <pageindex>
   43127:	89 c2                	mov    %eax,%edx
   43129:	8b 45 ac             	mov    -0x54(%rbp),%eax
   4312c:	48 63 c8             	movslq %eax,%rcx
   4312f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43133:	48 63 d2             	movslq %edx,%rdx
   43136:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   4313a:	eb 28                	jmp    43164 <virtual_memory_map+0x233>
        } else if (perm & PTE_P) {
   4313c:	8b 45 ac             	mov    -0x54(%rbp),%eax
   4313f:	48 98                	cltq   
   43141:	83 e0 01             	and    $0x1,%eax
   43144:	48 85 c0             	test   %rax,%rax
   43147:	74 1b                	je     43164 <virtual_memory_map+0x233>
            // error, no allocated l1 page found for va
            log_printf("[Kern Info] failed to find l1pagetable address at " __FILE__ ": %d\n", __LINE__);
   43149:	be 87 00 00 00       	mov    $0x87,%esi
   4314e:	bf 90 4a 04 00       	mov    $0x44a90,%edi
   43153:	b8 00 00 00 00       	mov    $0x0,%eax
   43158:	e8 b7 f7 ff ff       	call   42914 <log_printf>
            return -1;
   4315d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43162:	eb 28                	jmp    4318c <virtual_memory_map+0x25b>
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   43164:	48 81 45 c0 00 10 00 	addq   $0x1000,-0x40(%rbp)
   4316b:	00 
   4316c:	48 81 45 b8 00 10 00 	addq   $0x1000,-0x48(%rbp)
   43173:	00 
   43174:	48 81 6d b0 00 10 00 	subq   $0x1000,-0x50(%rbp)
   4317b:	00 
   4317c:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   43181:	0f 85 14 ff ff ff    	jne    4309b <virtual_memory_map+0x16a>
        }
    }
    return 0;
   43187:	b8 00 00 00 00       	mov    $0x0,%eax
}
   4318c:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   43190:	c9                   	leave  
   43191:	c3                   	ret    

0000000000043192 <lookup_l1pagetable>:
//
//    Returns an x86_64_pagetable pointer to the last level pagetable
//    if it exists and can be accessed with the given permissions
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l1pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm) {
   43192:	55                   	push   %rbp
   43193:	48 89 e5             	mov    %rsp,%rbp
   43196:	48 83 ec 40          	sub    $0x40,%rsp
   4319a:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   4319e:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   431a2:	89 55 cc             	mov    %edx,-0x34(%rbp)
    x86_64_pagetable* pt = pagetable;
   431a5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   431a9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    // 1. Find index to the next pagetable entry using the `va`
    // 2. Check if this entry has the appropriate requested permissions
    // 3. Repeat the steps till you reach the l1 pagetable (i.e thrice)
    // 4. return the pagetable address

    for (int i = 0; i <= 2; ++i) {
   431ad:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   431b4:	e9 23 01 00 00       	jmp    432dc <lookup_l1pagetable+0x14a>
        // TODO
        // find page entry by finding `ith` level index of va to index pagetable entries of `pt`
        // you should read x86-64.h to understand relevant structs and macros to make this part easier
        x86_64_pageentry_t pe = pt->entry[PAGEINDEX(va, i)]; // replace this
   431b9:	8b 55 f4             	mov    -0xc(%rbp),%edx
   431bc:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   431c0:	89 d6                	mov    %edx,%esi
   431c2:	48 89 c7             	mov    %rax,%rdi
   431c5:	e8 cd fa ff ff       	call   42c97 <pageindex>
   431ca:	89 c2                	mov    %eax,%edx
   431cc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   431d0:	48 63 d2             	movslq %edx,%rdx
   431d3:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   431d7:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

        if (!(pe & PTE_P)) { // address of next level should be present AND PTE_P should be set, error otherwise
   431db:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   431df:	83 e0 01             	and    $0x1,%eax
   431e2:	48 85 c0             	test   %rax,%rax
   431e5:	75 63                	jne    4324a <lookup_l1pagetable+0xb8>
            log_printf("[Kern Info] Error looking up l1pagetable: Pagetable address: 0x%x perm: 0x%x."
   431e7:	8b 45 f4             	mov    -0xc(%rbp),%eax
   431ea:	8d 48 02             	lea    0x2(%rax),%ecx
   431ed:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   431f1:	25 ff 0f 00 00       	and    $0xfff,%eax
   431f6:	48 89 c2             	mov    %rax,%rdx
   431f9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   431fd:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43203:	48 89 c6             	mov    %rax,%rsi
   43206:	bf d0 4a 04 00       	mov    $0x44ad0,%edi
   4320b:	b8 00 00 00 00       	mov    $0x0,%eax
   43210:	e8 ff f6 ff ff       	call   42914 <log_printf>
                    " Failed to get level (%d)\n",
                    PTE_ADDR(pe), PTE_FLAGS(pe), (i+2));
            if (!(perm & PTE_P)) {
   43215:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43218:	48 98                	cltq   
   4321a:	83 e0 01             	and    $0x1,%eax
   4321d:	48 85 c0             	test   %rax,%rax
   43220:	75 0a                	jne    4322c <lookup_l1pagetable+0x9a>
                return (x86_64_pagetable *)NULL; // this was NULL initially
   43222:	b8 00 00 00 00       	mov    $0x0,%eax
   43227:	e9 be 00 00 00       	jmp    432ea <lookup_l1pagetable+0x158>
            }
            log_printf("[Kern Info] failed to find pagetable address at " __FILE__ ": %d\n", __LINE__);
   4322c:	be ab 00 00 00       	mov    $0xab,%esi
   43231:	bf 38 4b 04 00       	mov    $0x44b38,%edi
   43236:	b8 00 00 00 00       	mov    $0x0,%eax
   4323b:	e8 d4 f6 ff ff       	call   42914 <log_printf>
            return (x86_64_pagetable *)NULL;
   43240:	b8 00 00 00 00       	mov    $0x0,%eax
   43245:	e9 a0 00 00 00       	jmp    432ea <lookup_l1pagetable+0x158>
        }

        // sanity-check page entry and permissions
        assert(PTE_ADDR(pe) < MEMSIZE_PHYSICAL); // at sensible address
   4324a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4324e:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43254:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   4325a:	76 14                	jbe    43270 <lookup_l1pagetable+0xde>
   4325c:	ba 78 4b 04 00       	mov    $0x44b78,%edx
   43261:	be b0 00 00 00       	mov    $0xb0,%esi
   43266:	bf e2 47 04 00       	mov    $0x447e2,%edi
   4326b:	e8 c2 f9 ff ff       	call   42c32 <assert_fail>
        if (perm & PTE_W) {       // if requester wants PTE_W,
   43270:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43273:	48 98                	cltq   
   43275:	83 e0 02             	and    $0x2,%eax
   43278:	48 85 c0             	test   %rax,%rax
   4327b:	74 20                	je     4329d <lookup_l1pagetable+0x10b>
            assert(pe & PTE_W);   //   entry must allow PTE_W
   4327d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43281:	83 e0 02             	and    $0x2,%eax
   43284:	48 85 c0             	test   %rax,%rax
   43287:	75 14                	jne    4329d <lookup_l1pagetable+0x10b>
   43289:	ba 98 4b 04 00       	mov    $0x44b98,%edx
   4328e:	be b2 00 00 00       	mov    $0xb2,%esi
   43293:	bf e2 47 04 00       	mov    $0x447e2,%edi
   43298:	e8 95 f9 ff ff       	call   42c32 <assert_fail>
        }
        if (perm & PTE_U) {       // if requester wants PTE_U,
   4329d:	8b 45 cc             	mov    -0x34(%rbp),%eax
   432a0:	48 98                	cltq   
   432a2:	83 e0 04             	and    $0x4,%eax
   432a5:	48 85 c0             	test   %rax,%rax
   432a8:	74 20                	je     432ca <lookup_l1pagetable+0x138>
            assert(pe & PTE_U);   //   entry must allow PTE_U
   432aa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   432ae:	83 e0 04             	and    $0x4,%eax
   432b1:	48 85 c0             	test   %rax,%rax
   432b4:	75 14                	jne    432ca <lookup_l1pagetable+0x138>
   432b6:	ba a3 4b 04 00       	mov    $0x44ba3,%edx
   432bb:	be b5 00 00 00       	mov    $0xb5,%esi
   432c0:	bf e2 47 04 00       	mov    $0x447e2,%edi
   432c5:	e8 68 f9 ff ff       	call   42c32 <assert_fail>
        }

        // TODO
        // set pt to physical address to next pagetable using `pe`
        pt = (x86_64_pagetable *)PTE_ADDR(pe); // replace this
   432ca:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   432ce:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   432d4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 2; ++i) {
   432d8:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   432dc:	83 7d f4 02          	cmpl   $0x2,-0xc(%rbp)
   432e0:	0f 8e d3 fe ff ff    	jle    431b9 <lookup_l1pagetable+0x27>
    }
    return pt;
   432e6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   432ea:	c9                   	leave  
   432eb:	c3                   	ret    

00000000000432ec <virtual_memory_lookup>:

// virtual_memory_lookup(pagetable, va)
//    Returns information about the mapping of the virtual address `va` in
//    `pagetable`. The information is returned as a `vamapping` object.

vamapping virtual_memory_lookup(x86_64_pagetable* pagetable, uintptr_t va) {
   432ec:	55                   	push   %rbp
   432ed:	48 89 e5             	mov    %rsp,%rbp
   432f0:	48 83 ec 50          	sub    $0x50,%rsp
   432f4:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   432f8:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   432fc:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
    x86_64_pagetable* pt = pagetable;
   43300:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43304:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    x86_64_pageentry_t pe = PTE_W | PTE_U | PTE_P;
   43308:	48 c7 45 f0 07 00 00 	movq   $0x7,-0x10(%rbp)
   4330f:	00 
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   43310:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
   43317:	eb 41                	jmp    4335a <virtual_memory_lookup+0x6e>
        pe = pt->entry[PAGEINDEX(va, i)] & ~(pe & (PTE_W | PTE_U));
   43319:	8b 55 ec             	mov    -0x14(%rbp),%edx
   4331c:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   43320:	89 d6                	mov    %edx,%esi
   43322:	48 89 c7             	mov    %rax,%rdi
   43325:	e8 6d f9 ff ff       	call   42c97 <pageindex>
   4332a:	89 c2                	mov    %eax,%edx
   4332c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43330:	48 63 d2             	movslq %edx,%rdx
   43333:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
   43337:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4333b:	83 e0 06             	and    $0x6,%eax
   4333e:	48 f7 d0             	not    %rax
   43341:	48 21 d0             	and    %rdx,%rax
   43344:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   43348:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4334c:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43352:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   43356:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
   4335a:	83 7d ec 03          	cmpl   $0x3,-0x14(%rbp)
   4335e:	7f 0c                	jg     4336c <virtual_memory_lookup+0x80>
   43360:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43364:	83 e0 01             	and    $0x1,%eax
   43367:	48 85 c0             	test   %rax,%rax
   4336a:	75 ad                	jne    43319 <virtual_memory_lookup+0x2d>
    }
    vamapping vam = { -1, (uintptr_t) -1, 0 };
   4336c:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%rbp)
   43373:	48 c7 45 d8 ff ff ff 	movq   $0xffffffffffffffff,-0x28(%rbp)
   4337a:	ff 
   4337b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
    if (pe & PTE_P) {
   43382:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43386:	83 e0 01             	and    $0x1,%eax
   43389:	48 85 c0             	test   %rax,%rax
   4338c:	74 34                	je     433c2 <virtual_memory_lookup+0xd6>
        vam.pn = PAGENUMBER(pe);
   4338e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43392:	48 c1 e8 0c          	shr    $0xc,%rax
   43396:	89 45 d0             	mov    %eax,-0x30(%rbp)
        vam.pa = PTE_ADDR(pe) + PAGEOFFSET(va);
   43399:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4339d:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   433a3:	48 89 c2             	mov    %rax,%rdx
   433a6:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   433aa:	25 ff 0f 00 00       	and    $0xfff,%eax
   433af:	48 09 d0             	or     %rdx,%rax
   433b2:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        vam.perm = PTE_FLAGS(pe);
   433b6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   433ba:	25 ff 0f 00 00       	and    $0xfff,%eax
   433bf:	89 45 e0             	mov    %eax,-0x20(%rbp)
    }
    return vam;
   433c2:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   433c6:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   433ca:	48 89 10             	mov    %rdx,(%rax)
   433cd:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   433d1:	48 89 50 08          	mov    %rdx,0x8(%rax)
   433d5:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   433d9:	48 89 50 10          	mov    %rdx,0x10(%rax)
}
   433dd:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   433e1:	c9                   	leave  
   433e2:	c3                   	ret    

00000000000433e3 <program_load>:
//    `assign_physical_page` to as required. Returns 0 on success and
//    -1 on failure (e.g. out-of-memory). `allocator` is passed to
//    `virtual_memory_map`.

int program_load(proc* p, int programnumber,
                 x86_64_pagetable* (*allocator)(void)) {
   433e3:	55                   	push   %rbp
   433e4:	48 89 e5             	mov    %rsp,%rbp
   433e7:	48 83 ec 40          	sub    $0x40,%rsp
   433eb:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   433ef:	89 75 d4             	mov    %esi,-0x2c(%rbp)
   433f2:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
    // is this a valid program?
    int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);
   433f6:	c7 45 f8 07 00 00 00 	movl   $0x7,-0x8(%rbp)
    assert(programnumber >= 0 && programnumber < nprograms);
   433fd:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   43401:	78 08                	js     4340b <program_load+0x28>
   43403:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   43406:	3b 45 f8             	cmp    -0x8(%rbp),%eax
   43409:	7c 14                	jl     4341f <program_load+0x3c>
   4340b:	ba b0 4b 04 00       	mov    $0x44bb0,%edx
   43410:	be 37 00 00 00       	mov    $0x37,%esi
   43415:	bf e0 4b 04 00       	mov    $0x44be0,%edi
   4341a:	e8 13 f8 ff ff       	call   42c32 <assert_fail>
    elf_header* eh = (elf_header*) ramimages[programnumber].begin;
   4341f:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   43422:	48 98                	cltq   
   43424:	48 c1 e0 04          	shl    $0x4,%rax
   43428:	48 05 20 50 04 00    	add    $0x45020,%rax
   4342e:	48 8b 00             	mov    (%rax),%rax
   43431:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assert(eh->e_magic == ELF_MAGIC);
   43435:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43439:	8b 00                	mov    (%rax),%eax
   4343b:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
   43440:	74 14                	je     43456 <program_load+0x73>
   43442:	ba eb 4b 04 00       	mov    $0x44beb,%edx
   43447:	be 39 00 00 00       	mov    $0x39,%esi
   4344c:	bf e0 4b 04 00       	mov    $0x44be0,%edi
   43451:	e8 dc f7 ff ff       	call   42c32 <assert_fail>

    // load each loadable program segment into memory
    elf_program* ph = (elf_program*) ((const uint8_t*) eh + eh->e_phoff);
   43456:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4345a:	48 8b 50 20          	mov    0x20(%rax),%rdx
   4345e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43462:	48 01 d0             	add    %rdx,%rax
   43465:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    for (int i = 0; i < eh->e_phnum; ++i) {
   43469:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   43470:	e9 94 00 00 00       	jmp    43509 <program_load+0x126>
        if (ph[i].p_type == ELF_PTYPE_LOAD) {
   43475:	8b 45 fc             	mov    -0x4(%rbp),%eax
   43478:	48 63 d0             	movslq %eax,%rdx
   4347b:	48 89 d0             	mov    %rdx,%rax
   4347e:	48 c1 e0 03          	shl    $0x3,%rax
   43482:	48 29 d0             	sub    %rdx,%rax
   43485:	48 c1 e0 03          	shl    $0x3,%rax
   43489:	48 89 c2             	mov    %rax,%rdx
   4348c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43490:	48 01 d0             	add    %rdx,%rax
   43493:	8b 00                	mov    (%rax),%eax
   43495:	83 f8 01             	cmp    $0x1,%eax
   43498:	75 6b                	jne    43505 <program_load+0x122>
            const uint8_t* pdata = (const uint8_t*) eh + ph[i].p_offset;
   4349a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4349d:	48 63 d0             	movslq %eax,%rdx
   434a0:	48 89 d0             	mov    %rdx,%rax
   434a3:	48 c1 e0 03          	shl    $0x3,%rax
   434a7:	48 29 d0             	sub    %rdx,%rax
   434aa:	48 c1 e0 03          	shl    $0x3,%rax
   434ae:	48 89 c2             	mov    %rax,%rdx
   434b1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   434b5:	48 01 d0             	add    %rdx,%rax
   434b8:	48 8b 50 08          	mov    0x8(%rax),%rdx
   434bc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   434c0:	48 01 d0             	add    %rdx,%rax
   434c3:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            if (program_load_segment(p, &ph[i], pdata, allocator) < 0) {
   434c7:	8b 45 fc             	mov    -0x4(%rbp),%eax
   434ca:	48 63 d0             	movslq %eax,%rdx
   434cd:	48 89 d0             	mov    %rdx,%rax
   434d0:	48 c1 e0 03          	shl    $0x3,%rax
   434d4:	48 29 d0             	sub    %rdx,%rax
   434d7:	48 c1 e0 03          	shl    $0x3,%rax
   434db:	48 89 c2             	mov    %rax,%rdx
   434de:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   434e2:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
   434e6:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   434ea:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   434ee:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   434f2:	48 89 c7             	mov    %rax,%rdi
   434f5:	e8 3d 00 00 00       	call   43537 <program_load_segment>
   434fa:	85 c0                	test   %eax,%eax
   434fc:	79 07                	jns    43505 <program_load+0x122>
                return -1;
   434fe:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43503:	eb 30                	jmp    43535 <program_load+0x152>
    for (int i = 0; i < eh->e_phnum; ++i) {
   43505:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   43509:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4350d:	0f b7 40 38          	movzwl 0x38(%rax),%eax
   43511:	0f b7 c0             	movzwl %ax,%eax
   43514:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   43517:	0f 8c 58 ff ff ff    	jl     43475 <program_load+0x92>
            }
        }
    }

    // set the entry point from the ELF header
    p->p_registers.reg_rip = eh->e_entry;
   4351d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43521:	48 8b 50 18          	mov    0x18(%rax),%rdx
   43525:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43529:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
    return 0;
   43530:	b8 00 00 00 00       	mov    $0x0,%eax
}
   43535:	c9                   	leave  
   43536:	c3                   	ret    

0000000000043537 <program_load_segment>:
//    Calls `assign_physical_page` to allocate pages and `virtual_memory_map`
//    to map them in `p->p_pagetable`. Returns 0 on success and -1 on failure.

static int program_load_segment(proc* p, const elf_program* ph,
                                const uint8_t* src,
                                x86_64_pagetable* (*allocator)(void)) {
   43537:	55                   	push   %rbp
   43538:	48 89 e5             	mov    %rsp,%rbp
   4353b:	48 83 ec 70          	sub    $0x70,%rsp
   4353f:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   43543:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   43547:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   4354b:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    uintptr_t va = (uintptr_t) ph->p_va;
   4354f:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   43553:	48 8b 40 10          	mov    0x10(%rax),%rax
   43557:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    uintptr_t end_file = va + ph->p_filesz, end_mem = va + ph->p_memsz;
   4355b:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   4355f:	48 8b 50 20          	mov    0x20(%rax),%rdx
   43563:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43567:	48 01 d0             	add    %rdx,%rax
   4356a:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   4356e:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   43572:	48 8b 50 28          	mov    0x28(%rax),%rdx
   43576:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4357a:	48 01 d0             	add    %rdx,%rax
   4357d:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    va &= ~(PAGESIZE - 1);                // round to page boundary
   43581:	48 81 65 e8 00 f0 ff 	andq   $0xfffffffffffff000,-0x18(%rbp)
   43588:	ff 

    // allocate memory
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   43589:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4358d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43591:	e9 b9 00 00 00       	jmp    4364f <program_load_segment+0x118>
        int index = find_free_page();
   43596:	b8 00 00 00 00       	mov    $0x0,%eax
   4359b:	e8 01 ce ff ff       	call   403a1 <find_free_page>
   435a0:	89 45 d4             	mov    %eax,-0x2c(%rbp)
        if (index == -1) {
   435a3:	83 7d d4 ff          	cmpl   $0xffffffff,-0x2c(%rbp)
   435a7:	75 19                	jne    435c2 <program_load_segment+0x8b>
            console_printf(CPOS(24, 0), 0x0C00, "Out of physical memory!");
   435a9:	ba 04 4c 04 00       	mov    $0x44c04,%edx
   435ae:	be 00 0c 00 00       	mov    $0xc00,%esi
   435b3:	bf 80 07 00 00       	mov    $0x780,%edi
   435b8:	b8 00 00 00 00       	mov    $0x0,%eax
   435bd:	e8 a6 0a 00 00       	call   44068 <console_printf>
        }
        if (assign_physical_page(PAGEADDRESS(index), p->p_pid) < 0
   435c2:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   435c6:	8b 00                	mov    (%rax),%eax
   435c8:	0f be c0             	movsbl %al,%eax
   435cb:	8b 55 d4             	mov    -0x2c(%rbp),%edx
   435ce:	48 63 d2             	movslq %edx,%rdx
   435d1:	48 c1 e2 0c          	shl    $0xc,%rdx
   435d5:	89 c6                	mov    %eax,%esi
   435d7:	48 89 d7             	mov    %rdx,%rdi
   435da:	e8 c8 d0 ff ff       	call   406a7 <assign_physical_page>
   435df:	85 c0                	test   %eax,%eax
   435e1:	78 32                	js     43615 <program_load_segment+0xde>
            || virtual_memory_map(p->p_pagetable, addr, PAGEADDRESS(index), PAGESIZE,
   435e3:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   435e6:	48 98                	cltq   
   435e8:	48 c1 e0 0c          	shl    $0xc,%rax
   435ec:	48 89 c2             	mov    %rax,%rdx
   435ef:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   435f3:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   435fa:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   435fe:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   43604:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43609:	48 89 c7             	mov    %rax,%rdi
   4360c:	e8 20 f9 ff ff       	call   42f31 <virtual_memory_map>
   43611:	85 c0                	test   %eax,%eax
   43613:	79 32                	jns    43647 <program_load_segment+0x110>
                                  PTE_P | PTE_W | PTE_U) < 0) {
            console_printf(CPOS(22, 0), 0xC000, "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
   43615:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43619:	8b 00                	mov    (%rax),%eax
   4361b:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4361f:	49 89 d0             	mov    %rdx,%r8
   43622:	89 c1                	mov    %eax,%ecx
   43624:	ba 20 4c 04 00       	mov    $0x44c20,%edx
   43629:	be 00 c0 00 00       	mov    $0xc000,%esi
   4362e:	bf e0 06 00 00       	mov    $0x6e0,%edi
   43633:	b8 00 00 00 00       	mov    $0x0,%eax
   43638:	e8 2b 0a 00 00       	call   44068 <console_printf>
            return -1;
   4363d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43642:	e9 e5 00 00 00       	jmp    4372c <program_load_segment+0x1f5>
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   43647:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   4364e:	00 
   4364f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43653:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   43657:	0f 82 39 ff ff ff    	jb     43596 <program_load_segment+0x5f>
        }
    }

    // ensure new memory mappings are active
    set_pagetable(p->p_pagetable);
   4365d:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43661:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   43668:	48 89 c7             	mov    %rax,%rdi
   4366b:	e8 90 f7 ff ff       	call   42e00 <set_pagetable>

    // copy data from executable image into process memory
    memcpy((uint8_t*) va, src, end_file - va);
   43670:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43674:	48 2b 45 e8          	sub    -0x18(%rbp),%rax
   43678:	48 89 c2             	mov    %rax,%rdx
   4367b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4367f:	48 8b 4d 98          	mov    -0x68(%rbp),%rcx
   43683:	48 89 ce             	mov    %rcx,%rsi
   43686:	48 89 c7             	mov    %rax,%rdi
   43689:	e8 3c 01 00 00       	call   437ca <memcpy>
    memset((uint8_t*) end_file, 0, end_mem - end_file);
   4368e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43692:	48 2b 45 e0          	sub    -0x20(%rbp),%rax
   43696:	48 89 c2             	mov    %rax,%rdx
   43699:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   4369d:	be 00 00 00 00       	mov    $0x0,%esi
   436a2:	48 89 c7             	mov    %rax,%rdi
   436a5:	e8 89 01 00 00       	call   43833 <memset>

    // restore kernel pagetable
    set_pagetable(kernel_pagetable);
   436aa:	48 8b 05 4f d9 00 00 	mov    0xd94f(%rip),%rax        # 51000 <kernel_pagetable>
   436b1:	48 89 c7             	mov    %rax,%rdi
   436b4:	e8 47 f7 ff ff       	call   42e00 <set_pagetable>

    // Check to see which segments are read-only for applications
    if ((ph->p_flags & ELF_PFLAG_WRITE) == 0) {
   436b9:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   436bd:	8b 40 04             	mov    0x4(%rax),%eax
   436c0:	83 e0 02             	and    $0x2,%eax
   436c3:	85 c0                	test   %eax,%eax
   436c5:	75 60                	jne    43727 <program_load_segment+0x1f0>
        for (uintptr_t i = va; i < end_mem; i += PAGESIZE) {
   436c7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   436cb:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   436cf:	eb 4c                	jmp    4371d <program_load_segment+0x1e6>
            // Look up corresponding segments and map them accordingly
            vamapping vamap = virtual_memory_lookup(p->p_pagetable, i);
   436d1:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   436d5:	48 8b 88 d0 00 00 00 	mov    0xd0(%rax),%rcx
   436dc:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   436e0:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   436e4:	48 89 ce             	mov    %rcx,%rsi
   436e7:	48 89 c7             	mov    %rax,%rdi
   436ea:	e8 fd fb ff ff       	call   432ec <virtual_memory_lookup>
            virtual_memory_map(p->p_pagetable, i, vamap.pa, PAGESIZE,
   436ef:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   436f3:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   436f7:	48 8b 80 d0 00 00 00 	mov    0xd0(%rax),%rax
   436fe:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   43702:	41 b8 05 00 00 00    	mov    $0x5,%r8d
   43708:	b9 00 10 00 00       	mov    $0x1000,%ecx
   4370d:	48 89 c7             	mov    %rax,%rdi
   43710:	e8 1c f8 ff ff       	call   42f31 <virtual_memory_map>
        for (uintptr_t i = va; i < end_mem; i += PAGESIZE) {
   43715:	48 81 45 f0 00 10 00 	addq   $0x1000,-0x10(%rbp)
   4371c:	00 
   4371d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43721:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   43725:	72 aa                	jb     436d1 <program_load_segment+0x19a>
                    PTE_P | PTE_U);
        }
    }

    return 0;
   43727:	b8 00 00 00 00       	mov    $0x0,%eax
}
   4372c:	c9                   	leave  
   4372d:	c3                   	ret    

000000000004372e <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
   4372e:	48 89 f9             	mov    %rdi,%rcx
   43731:	89 d7                	mov    %edx,%edi
    console_printer* cp = (console_printer*) p;
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
   43733:	48 81 79 08 a0 8f 0b 	cmpq   $0xb8fa0,0x8(%rcx)
   4373a:	00 
   4373b:	72 08                	jb     43745 <console_putc+0x17>
        cp->cursor = console;
   4373d:	48 c7 41 08 00 80 0b 	movq   $0xb8000,0x8(%rcx)
   43744:	00 
    }
    if (c == '\n') {
   43745:	40 80 fe 0a          	cmp    $0xa,%sil
   43749:	74 16                	je     43761 <console_putc+0x33>
        int pos = (cp->cursor - console) % 80;
        for (; pos != 80; pos++) {
            *cp->cursor++ = ' ' | color;
        }
    } else {
        *cp->cursor++ = c | color;
   4374b:	48 8b 41 08          	mov    0x8(%rcx),%rax
   4374f:	48 8d 50 02          	lea    0x2(%rax),%rdx
   43753:	48 89 51 08          	mov    %rdx,0x8(%rcx)
   43757:	40 0f b6 f6          	movzbl %sil,%esi
   4375b:	09 fe                	or     %edi,%esi
   4375d:	66 89 30             	mov    %si,(%rax)
    }
}
   43760:	c3                   	ret    
        int pos = (cp->cursor - console) % 80;
   43761:	4c 8b 41 08          	mov    0x8(%rcx),%r8
   43765:	49 81 e8 00 80 0b 00 	sub    $0xb8000,%r8
   4376c:	4c 89 c6             	mov    %r8,%rsi
   4376f:	48 d1 fe             	sar    %rsi
   43772:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
   43779:	66 66 66 
   4377c:	48 89 f0             	mov    %rsi,%rax
   4377f:	48 f7 ea             	imul   %rdx
   43782:	48 c1 fa 05          	sar    $0x5,%rdx
   43786:	49 c1 f8 3f          	sar    $0x3f,%r8
   4378a:	4c 29 c2             	sub    %r8,%rdx
   4378d:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
   43791:	48 c1 e2 04          	shl    $0x4,%rdx
   43795:	89 f0                	mov    %esi,%eax
   43797:	29 d0                	sub    %edx,%eax
            *cp->cursor++ = ' ' | color;
   43799:	83 cf 20             	or     $0x20,%edi
   4379c:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   437a0:	48 8d 72 02          	lea    0x2(%rdx),%rsi
   437a4:	48 89 71 08          	mov    %rsi,0x8(%rcx)
   437a8:	66 89 3a             	mov    %di,(%rdx)
        for (; pos != 80; pos++) {
   437ab:	83 c0 01             	add    $0x1,%eax
   437ae:	83 f8 50             	cmp    $0x50,%eax
   437b1:	75 e9                	jne    4379c <console_putc+0x6e>
   437b3:	c3                   	ret    

00000000000437b4 <string_putc>:
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
    string_printer* sp = (string_printer*) p;
    if (sp->s < sp->end) {
   437b4:	48 8b 47 08          	mov    0x8(%rdi),%rax
   437b8:	48 3b 47 10          	cmp    0x10(%rdi),%rax
   437bc:	73 0b                	jae    437c9 <string_putc+0x15>
        *sp->s++ = c;
   437be:	48 8d 50 01          	lea    0x1(%rax),%rdx
   437c2:	48 89 57 08          	mov    %rdx,0x8(%rdi)
   437c6:	40 88 30             	mov    %sil,(%rax)
    }
    (void) color;
}
   437c9:	c3                   	ret    

00000000000437ca <memcpy>:
void* memcpy(void* dst, const void* src, size_t n) {
   437ca:	48 89 f8             	mov    %rdi,%rax
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   437cd:	48 85 d2             	test   %rdx,%rdx
   437d0:	74 17                	je     437e9 <memcpy+0x1f>
   437d2:	b9 00 00 00 00       	mov    $0x0,%ecx
        *d = *s;
   437d7:	44 0f b6 04 0e       	movzbl (%rsi,%rcx,1),%r8d
   437dc:	44 88 04 08          	mov    %r8b,(%rax,%rcx,1)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   437e0:	48 83 c1 01          	add    $0x1,%rcx
   437e4:	48 39 d1             	cmp    %rdx,%rcx
   437e7:	75 ee                	jne    437d7 <memcpy+0xd>
}
   437e9:	c3                   	ret    

00000000000437ea <memmove>:
void* memmove(void* dst, const void* src, size_t n) {
   437ea:	48 89 f8             	mov    %rdi,%rax
    if (s < d && s + n > d) {
   437ed:	48 39 fe             	cmp    %rdi,%rsi
   437f0:	72 1d                	jb     4380f <memmove+0x25>
        while (n-- > 0) {
   437f2:	b9 00 00 00 00       	mov    $0x0,%ecx
   437f7:	48 85 d2             	test   %rdx,%rdx
   437fa:	74 12                	je     4380e <memmove+0x24>
            *d++ = *s++;
   437fc:	0f b6 3c 0e          	movzbl (%rsi,%rcx,1),%edi
   43800:	40 88 3c 08          	mov    %dil,(%rax,%rcx,1)
        while (n-- > 0) {
   43804:	48 83 c1 01          	add    $0x1,%rcx
   43808:	48 39 ca             	cmp    %rcx,%rdx
   4380b:	75 ef                	jne    437fc <memmove+0x12>
}
   4380d:	c3                   	ret    
   4380e:	c3                   	ret    
    if (s < d && s + n > d) {
   4380f:	48 8d 0c 16          	lea    (%rsi,%rdx,1),%rcx
   43813:	48 39 cf             	cmp    %rcx,%rdi
   43816:	73 da                	jae    437f2 <memmove+0x8>
        while (n-- > 0) {
   43818:	48 8d 4a ff          	lea    -0x1(%rdx),%rcx
   4381c:	48 85 d2             	test   %rdx,%rdx
   4381f:	74 ec                	je     4380d <memmove+0x23>
            *--d = *--s;
   43821:	0f b6 14 0e          	movzbl (%rsi,%rcx,1),%edx
   43825:	88 14 08             	mov    %dl,(%rax,%rcx,1)
        while (n-- > 0) {
   43828:	48 83 e9 01          	sub    $0x1,%rcx
   4382c:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
   43830:	75 ef                	jne    43821 <memmove+0x37>
   43832:	c3                   	ret    

0000000000043833 <memset>:
void* memset(void* v, int c, size_t n) {
   43833:	48 89 f8             	mov    %rdi,%rax
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43836:	48 85 d2             	test   %rdx,%rdx
   43839:	74 12                	je     4384d <memset+0x1a>
   4383b:	48 01 fa             	add    %rdi,%rdx
   4383e:	48 89 f9             	mov    %rdi,%rcx
        *p = c;
   43841:	40 88 31             	mov    %sil,(%rcx)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43844:	48 83 c1 01          	add    $0x1,%rcx
   43848:	48 39 ca             	cmp    %rcx,%rdx
   4384b:	75 f4                	jne    43841 <memset+0xe>
}
   4384d:	c3                   	ret    

000000000004384e <strlen>:
    for (n = 0; *s != '\0'; ++s) {
   4384e:	80 3f 00             	cmpb   $0x0,(%rdi)
   43851:	74 10                	je     43863 <strlen+0x15>
   43853:	b8 00 00 00 00       	mov    $0x0,%eax
        ++n;
   43858:	48 83 c0 01          	add    $0x1,%rax
    for (n = 0; *s != '\0'; ++s) {
   4385c:	80 3c 07 00          	cmpb   $0x0,(%rdi,%rax,1)
   43860:	75 f6                	jne    43858 <strlen+0xa>
   43862:	c3                   	ret    
   43863:	b8 00 00 00 00       	mov    $0x0,%eax
}
   43868:	c3                   	ret    

0000000000043869 <strnlen>:
size_t strnlen(const char* s, size_t maxlen) {
   43869:	48 89 f0             	mov    %rsi,%rax
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   4386c:	ba 00 00 00 00       	mov    $0x0,%edx
   43871:	48 85 f6             	test   %rsi,%rsi
   43874:	74 11                	je     43887 <strnlen+0x1e>
   43876:	80 3c 17 00          	cmpb   $0x0,(%rdi,%rdx,1)
   4387a:	74 0c                	je     43888 <strnlen+0x1f>
        ++n;
   4387c:	48 83 c2 01          	add    $0x1,%rdx
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   43880:	48 39 d0             	cmp    %rdx,%rax
   43883:	75 f1                	jne    43876 <strnlen+0xd>
   43885:	eb 04                	jmp    4388b <strnlen+0x22>
   43887:	c3                   	ret    
   43888:	48 89 d0             	mov    %rdx,%rax
}
   4388b:	c3                   	ret    

000000000004388c <strcpy>:
char* strcpy(char* dst, const char* src) {
   4388c:	48 89 f8             	mov    %rdi,%rax
   4388f:	ba 00 00 00 00       	mov    $0x0,%edx
        *d++ = *src++;
   43894:	0f b6 0c 16          	movzbl (%rsi,%rdx,1),%ecx
   43898:	88 0c 10             	mov    %cl,(%rax,%rdx,1)
    } while (d[-1]);
   4389b:	48 83 c2 01          	add    $0x1,%rdx
   4389f:	84 c9                	test   %cl,%cl
   438a1:	75 f1                	jne    43894 <strcpy+0x8>
}
   438a3:	c3                   	ret    

00000000000438a4 <strcmp>:
    while (*a && *b && *a == *b) {
   438a4:	0f b6 07             	movzbl (%rdi),%eax
   438a7:	84 c0                	test   %al,%al
   438a9:	74 1a                	je     438c5 <strcmp+0x21>
   438ab:	0f b6 16             	movzbl (%rsi),%edx
   438ae:	38 c2                	cmp    %al,%dl
   438b0:	75 13                	jne    438c5 <strcmp+0x21>
   438b2:	84 d2                	test   %dl,%dl
   438b4:	74 0f                	je     438c5 <strcmp+0x21>
        ++a, ++b;
   438b6:	48 83 c7 01          	add    $0x1,%rdi
   438ba:	48 83 c6 01          	add    $0x1,%rsi
    while (*a && *b && *a == *b) {
   438be:	0f b6 07             	movzbl (%rdi),%eax
   438c1:	84 c0                	test   %al,%al
   438c3:	75 e6                	jne    438ab <strcmp+0x7>
    return ((unsigned char) *a > (unsigned char) *b)
   438c5:	3a 06                	cmp    (%rsi),%al
   438c7:	0f 97 c0             	seta   %al
   438ca:	0f b6 c0             	movzbl %al,%eax
        - ((unsigned char) *a < (unsigned char) *b);
   438cd:	83 d8 00             	sbb    $0x0,%eax
}
   438d0:	c3                   	ret    

00000000000438d1 <strchr>:
    while (*s && *s != (char) c) {
   438d1:	0f b6 07             	movzbl (%rdi),%eax
   438d4:	84 c0                	test   %al,%al
   438d6:	74 10                	je     438e8 <strchr+0x17>
   438d8:	40 38 f0             	cmp    %sil,%al
   438db:	74 18                	je     438f5 <strchr+0x24>
        ++s;
   438dd:	48 83 c7 01          	add    $0x1,%rdi
    while (*s && *s != (char) c) {
   438e1:	0f b6 07             	movzbl (%rdi),%eax
   438e4:	84 c0                	test   %al,%al
   438e6:	75 f0                	jne    438d8 <strchr+0x7>
        return NULL;
   438e8:	40 84 f6             	test   %sil,%sil
   438eb:	b8 00 00 00 00       	mov    $0x0,%eax
   438f0:	48 0f 44 c7          	cmove  %rdi,%rax
}
   438f4:	c3                   	ret    
   438f5:	48 89 f8             	mov    %rdi,%rax
   438f8:	c3                   	ret    

00000000000438f9 <rand>:
    if (!rand_seed_set) {
   438f9:	83 3d 04 37 01 00 00 	cmpl   $0x0,0x13704(%rip)        # 57004 <rand_seed_set>
   43900:	74 1b                	je     4391d <rand+0x24>
    rand_seed = rand_seed * 1664525U + 1013904223U;
   43902:	69 05 f4 36 01 00 0d 	imul   $0x19660d,0x136f4(%rip),%eax        # 57000 <rand_seed>
   43909:	66 19 00 
   4390c:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
   43911:	89 05 e9 36 01 00    	mov    %eax,0x136e9(%rip)        # 57000 <rand_seed>
    return rand_seed & RAND_MAX;
   43917:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
   4391c:	c3                   	ret    
    rand_seed = seed;
   4391d:	c7 05 d9 36 01 00 9e 	movl   $0x30d4879e,0x136d9(%rip)        # 57000 <rand_seed>
   43924:	87 d4 30 
    rand_seed_set = 1;
   43927:	c7 05 d3 36 01 00 01 	movl   $0x1,0x136d3(%rip)        # 57004 <rand_seed_set>
   4392e:	00 00 00 
}
   43931:	eb cf                	jmp    43902 <rand+0x9>

0000000000043933 <srand>:
    rand_seed = seed;
   43933:	89 3d c7 36 01 00    	mov    %edi,0x136c7(%rip)        # 57000 <rand_seed>
    rand_seed_set = 1;
   43939:	c7 05 c1 36 01 00 01 	movl   $0x1,0x136c1(%rip)        # 57004 <rand_seed_set>
   43940:	00 00 00 
}
   43943:	c3                   	ret    

0000000000043944 <printer_vprintf>:
void printer_vprintf(printer* p, int color, const char* format, va_list val) {
   43944:	55                   	push   %rbp
   43945:	48 89 e5             	mov    %rsp,%rbp
   43948:	41 57                	push   %r15
   4394a:	41 56                	push   %r14
   4394c:	41 55                	push   %r13
   4394e:	41 54                	push   %r12
   43950:	53                   	push   %rbx
   43951:	48 83 ec 58          	sub    $0x58,%rsp
   43955:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    for (; *format; ++format) {
   43959:	0f b6 02             	movzbl (%rdx),%eax
   4395c:	84 c0                	test   %al,%al
   4395e:	0f 84 b0 06 00 00    	je     44014 <printer_vprintf+0x6d0>
   43964:	49 89 fe             	mov    %rdi,%r14
   43967:	49 89 d4             	mov    %rdx,%r12
            length = 1;
   4396a:	41 89 f7             	mov    %esi,%r15d
   4396d:	e9 a4 04 00 00       	jmp    43e16 <printer_vprintf+0x4d2>
        for (++format; *format; ++format) {
   43972:	49 8d 5c 24 01       	lea    0x1(%r12),%rbx
   43977:	45 0f b6 64 24 01    	movzbl 0x1(%r12),%r12d
   4397d:	45 84 e4             	test   %r12b,%r12b
   43980:	0f 84 82 06 00 00    	je     44008 <printer_vprintf+0x6c4>
        int flags = 0;
   43986:	41 bd 00 00 00 00    	mov    $0x0,%r13d
            const char* flagc = strchr(flag_chars, *format);
   4398c:	41 0f be f4          	movsbl %r12b,%esi
   43990:	bf 61 4e 04 00       	mov    $0x44e61,%edi
   43995:	e8 37 ff ff ff       	call   438d1 <strchr>
   4399a:	48 89 c1             	mov    %rax,%rcx
            if (flagc) {
   4399d:	48 85 c0             	test   %rax,%rax
   439a0:	74 55                	je     439f7 <printer_vprintf+0xb3>
                flags |= 1 << (flagc - flag_chars);
   439a2:	48 81 e9 61 4e 04 00 	sub    $0x44e61,%rcx
   439a9:	b8 01 00 00 00       	mov    $0x1,%eax
   439ae:	d3 e0                	shl    %cl,%eax
   439b0:	41 09 c5             	or     %eax,%r13d
        for (++format; *format; ++format) {
   439b3:	48 83 c3 01          	add    $0x1,%rbx
   439b7:	44 0f b6 23          	movzbl (%rbx),%r12d
   439bb:	45 84 e4             	test   %r12b,%r12b
   439be:	75 cc                	jne    4398c <printer_vprintf+0x48>
   439c0:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
        int width = -1;
   439c4:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
        int precision = -1;
   439ca:	c7 45 9c ff ff ff ff 	movl   $0xffffffff,-0x64(%rbp)
        if (*format == '.') {
   439d1:	80 3b 2e             	cmpb   $0x2e,(%rbx)
   439d4:	0f 84 a9 00 00 00    	je     43a83 <printer_vprintf+0x13f>
        int length = 0;
   439da:	b9 00 00 00 00       	mov    $0x0,%ecx
        switch (*format) {
   439df:	0f b6 13             	movzbl (%rbx),%edx
   439e2:	8d 42 bd             	lea    -0x43(%rdx),%eax
   439e5:	3c 37                	cmp    $0x37,%al
   439e7:	0f 87 c4 04 00 00    	ja     43eb1 <printer_vprintf+0x56d>
   439ed:	0f b6 c0             	movzbl %al,%eax
   439f0:	ff 24 c5 70 4c 04 00 	jmp    *0x44c70(,%rax,8)
        if (*format >= '1' && *format <= '9') {
   439f7:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
   439fb:	41 8d 44 24 cf       	lea    -0x31(%r12),%eax
   43a00:	3c 08                	cmp    $0x8,%al
   43a02:	77 2f                	ja     43a33 <printer_vprintf+0xef>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   43a04:	0f b6 03             	movzbl (%rbx),%eax
   43a07:	8d 50 d0             	lea    -0x30(%rax),%edx
   43a0a:	80 fa 09             	cmp    $0x9,%dl
   43a0d:	77 5e                	ja     43a6d <printer_vprintf+0x129>
   43a0f:	41 bd 00 00 00 00    	mov    $0x0,%r13d
                width = 10 * width + *format++ - '0';
   43a15:	48 83 c3 01          	add    $0x1,%rbx
   43a19:	43 8d 54 ad 00       	lea    0x0(%r13,%r13,4),%edx
   43a1e:	0f be c0             	movsbl %al,%eax
   43a21:	44 8d 6c 50 d0       	lea    -0x30(%rax,%rdx,2),%r13d
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   43a26:	0f b6 03             	movzbl (%rbx),%eax
   43a29:	8d 50 d0             	lea    -0x30(%rax),%edx
   43a2c:	80 fa 09             	cmp    $0x9,%dl
   43a2f:	76 e4                	jbe    43a15 <printer_vprintf+0xd1>
   43a31:	eb 97                	jmp    439ca <printer_vprintf+0x86>
        } else if (*format == '*') {
   43a33:	41 80 fc 2a          	cmp    $0x2a,%r12b
   43a37:	75 3f                	jne    43a78 <printer_vprintf+0x134>
            width = va_arg(val, int);
   43a39:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43a3d:	8b 07                	mov    (%rdi),%eax
   43a3f:	83 f8 2f             	cmp    $0x2f,%eax
   43a42:	77 17                	ja     43a5b <printer_vprintf+0x117>
   43a44:	89 c2                	mov    %eax,%edx
   43a46:	48 03 57 10          	add    0x10(%rdi),%rdx
   43a4a:	83 c0 08             	add    $0x8,%eax
   43a4d:	89 07                	mov    %eax,(%rdi)
   43a4f:	44 8b 2a             	mov    (%rdx),%r13d
            ++format;
   43a52:	48 83 c3 01          	add    $0x1,%rbx
   43a56:	e9 6f ff ff ff       	jmp    439ca <printer_vprintf+0x86>
            width = va_arg(val, int);
   43a5b:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   43a5f:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   43a63:	48 8d 42 08          	lea    0x8(%rdx),%rax
   43a67:	48 89 41 08          	mov    %rax,0x8(%rcx)
   43a6b:	eb e2                	jmp    43a4f <printer_vprintf+0x10b>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   43a6d:	41 bd 00 00 00 00    	mov    $0x0,%r13d
   43a73:	e9 52 ff ff ff       	jmp    439ca <printer_vprintf+0x86>
        int width = -1;
   43a78:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
   43a7e:	e9 47 ff ff ff       	jmp    439ca <printer_vprintf+0x86>
            ++format;
   43a83:	48 8d 53 01          	lea    0x1(%rbx),%rdx
            if (*format >= '0' && *format <= '9') {
   43a87:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
   43a8b:	8d 48 d0             	lea    -0x30(%rax),%ecx
   43a8e:	80 f9 09             	cmp    $0x9,%cl
   43a91:	76 13                	jbe    43aa6 <printer_vprintf+0x162>
            } else if (*format == '*') {
   43a93:	3c 2a                	cmp    $0x2a,%al
   43a95:	74 33                	je     43aca <printer_vprintf+0x186>
            ++format;
   43a97:	48 89 d3             	mov    %rdx,%rbx
                precision = 0;
   43a9a:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
   43aa1:	e9 34 ff ff ff       	jmp    439da <printer_vprintf+0x96>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   43aa6:	b9 00 00 00 00       	mov    $0x0,%ecx
                    precision = 10 * precision + *format++ - '0';
   43aab:	48 83 c2 01          	add    $0x1,%rdx
   43aaf:	8d 0c 89             	lea    (%rcx,%rcx,4),%ecx
   43ab2:	0f be c0             	movsbl %al,%eax
   43ab5:	8d 4c 48 d0          	lea    -0x30(%rax,%rcx,2),%ecx
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   43ab9:	0f b6 02             	movzbl (%rdx),%eax
   43abc:	8d 70 d0             	lea    -0x30(%rax),%esi
   43abf:	40 80 fe 09          	cmp    $0x9,%sil
   43ac3:	76 e6                	jbe    43aab <printer_vprintf+0x167>
                    precision = 10 * precision + *format++ - '0';
   43ac5:	48 89 d3             	mov    %rdx,%rbx
   43ac8:	eb 1c                	jmp    43ae6 <printer_vprintf+0x1a2>
                precision = va_arg(val, int);
   43aca:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43ace:	8b 07                	mov    (%rdi),%eax
   43ad0:	83 f8 2f             	cmp    $0x2f,%eax
   43ad3:	77 23                	ja     43af8 <printer_vprintf+0x1b4>
   43ad5:	89 c2                	mov    %eax,%edx
   43ad7:	48 03 57 10          	add    0x10(%rdi),%rdx
   43adb:	83 c0 08             	add    $0x8,%eax
   43ade:	89 07                	mov    %eax,(%rdi)
   43ae0:	8b 0a                	mov    (%rdx),%ecx
                ++format;
   43ae2:	48 83 c3 02          	add    $0x2,%rbx
            if (precision < 0) {
   43ae6:	85 c9                	test   %ecx,%ecx
   43ae8:	b8 00 00 00 00       	mov    $0x0,%eax
   43aed:	0f 49 c1             	cmovns %ecx,%eax
   43af0:	89 45 9c             	mov    %eax,-0x64(%rbp)
   43af3:	e9 e2 fe ff ff       	jmp    439da <printer_vprintf+0x96>
                precision = va_arg(val, int);
   43af8:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   43afc:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   43b00:	48 8d 42 08          	lea    0x8(%rdx),%rax
   43b04:	48 89 41 08          	mov    %rax,0x8(%rcx)
   43b08:	eb d6                	jmp    43ae0 <printer_vprintf+0x19c>
        switch (*format) {
   43b0a:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
   43b0f:	e9 f3 00 00 00       	jmp    43c07 <printer_vprintf+0x2c3>
            ++format;
   43b14:	48 83 c3 01          	add    $0x1,%rbx
            length = 1;
   43b18:	b9 01 00 00 00       	mov    $0x1,%ecx
            goto again;
   43b1d:	e9 bd fe ff ff       	jmp    439df <printer_vprintf+0x9b>
            long x = length ? va_arg(val, long) : va_arg(val, int);
   43b22:	85 c9                	test   %ecx,%ecx
   43b24:	74 55                	je     43b7b <printer_vprintf+0x237>
   43b26:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43b2a:	8b 07                	mov    (%rdi),%eax
   43b2c:	83 f8 2f             	cmp    $0x2f,%eax
   43b2f:	77 38                	ja     43b69 <printer_vprintf+0x225>
   43b31:	89 c2                	mov    %eax,%edx
   43b33:	48 03 57 10          	add    0x10(%rdi),%rdx
   43b37:	83 c0 08             	add    $0x8,%eax
   43b3a:	89 07                	mov    %eax,(%rdi)
   43b3c:	48 8b 12             	mov    (%rdx),%rdx
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
   43b3f:	48 89 d0             	mov    %rdx,%rax
   43b42:	48 c1 f8 38          	sar    $0x38,%rax
            num = negative ? -x : x;
   43b46:	49 89 d0             	mov    %rdx,%r8
   43b49:	49 f7 d8             	neg    %r8
   43b4c:	25 80 00 00 00       	and    $0x80,%eax
   43b51:	4c 0f 44 c2          	cmove  %rdx,%r8
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
   43b55:	0b 45 a8             	or     -0x58(%rbp),%eax
   43b58:	83 c8 60             	or     $0x60,%eax
   43b5b:	89 45 a8             	mov    %eax,-0x58(%rbp)
        char* data = "";
   43b5e:	41 bc 5f 4c 04 00    	mov    $0x44c5f,%r12d
            break;
   43b64:	e9 35 01 00 00       	jmp    43c9e <printer_vprintf+0x35a>
            long x = length ? va_arg(val, long) : va_arg(val, int);
   43b69:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   43b6d:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   43b71:	48 8d 42 08          	lea    0x8(%rdx),%rax
   43b75:	48 89 41 08          	mov    %rax,0x8(%rcx)
   43b79:	eb c1                	jmp    43b3c <printer_vprintf+0x1f8>
   43b7b:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43b7f:	8b 07                	mov    (%rdi),%eax
   43b81:	83 f8 2f             	cmp    $0x2f,%eax
   43b84:	77 10                	ja     43b96 <printer_vprintf+0x252>
   43b86:	89 c2                	mov    %eax,%edx
   43b88:	48 03 57 10          	add    0x10(%rdi),%rdx
   43b8c:	83 c0 08             	add    $0x8,%eax
   43b8f:	89 07                	mov    %eax,(%rdi)
   43b91:	48 63 12             	movslq (%rdx),%rdx
   43b94:	eb a9                	jmp    43b3f <printer_vprintf+0x1fb>
   43b96:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43b9a:	48 8b 57 08          	mov    0x8(%rdi),%rdx
   43b9e:	48 8d 42 08          	lea    0x8(%rdx),%rax
   43ba2:	48 89 47 08          	mov    %rax,0x8(%rdi)
   43ba6:	eb e9                	jmp    43b91 <printer_vprintf+0x24d>
        int base = 10;
   43ba8:	be 0a 00 00 00       	mov    $0xa,%esi
   43bad:	eb 58                	jmp    43c07 <printer_vprintf+0x2c3>
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   43baf:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   43bb3:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   43bb7:	48 8d 42 08          	lea    0x8(%rdx),%rax
   43bbb:	48 89 41 08          	mov    %rax,0x8(%rcx)
   43bbf:	eb 60                	jmp    43c21 <printer_vprintf+0x2dd>
   43bc1:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43bc5:	8b 07                	mov    (%rdi),%eax
   43bc7:	83 f8 2f             	cmp    $0x2f,%eax
   43bca:	77 10                	ja     43bdc <printer_vprintf+0x298>
   43bcc:	89 c2                	mov    %eax,%edx
   43bce:	48 03 57 10          	add    0x10(%rdi),%rdx
   43bd2:	83 c0 08             	add    $0x8,%eax
   43bd5:	89 07                	mov    %eax,(%rdi)
   43bd7:	44 8b 02             	mov    (%rdx),%r8d
   43bda:	eb 48                	jmp    43c24 <printer_vprintf+0x2e0>
   43bdc:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   43be0:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   43be4:	48 8d 42 08          	lea    0x8(%rdx),%rax
   43be8:	48 89 41 08          	mov    %rax,0x8(%rcx)
   43bec:	eb e9                	jmp    43bd7 <printer_vprintf+0x293>
   43bee:	41 89 f1             	mov    %esi,%r9d
        if (flags & FLAG_NUMERIC) {
   43bf1:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
    const char* digits = upper_digits;
   43bf8:	bf 50 4e 04 00       	mov    $0x44e50,%edi
   43bfd:	e9 e2 02 00 00       	jmp    43ee4 <printer_vprintf+0x5a0>
            base = 16;
   43c02:	be 10 00 00 00       	mov    $0x10,%esi
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   43c07:	85 c9                	test   %ecx,%ecx
   43c09:	74 b6                	je     43bc1 <printer_vprintf+0x27d>
   43c0b:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   43c0f:	8b 01                	mov    (%rcx),%eax
   43c11:	83 f8 2f             	cmp    $0x2f,%eax
   43c14:	77 99                	ja     43baf <printer_vprintf+0x26b>
   43c16:	89 c2                	mov    %eax,%edx
   43c18:	48 03 51 10          	add    0x10(%rcx),%rdx
   43c1c:	83 c0 08             	add    $0x8,%eax
   43c1f:	89 01                	mov    %eax,(%rcx)
   43c21:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_NUMERIC;
   43c24:	83 4d a8 20          	orl    $0x20,-0x58(%rbp)
    if (base < 0) {
   43c28:	85 f6                	test   %esi,%esi
   43c2a:	79 c2                	jns    43bee <printer_vprintf+0x2aa>
        base = -base;
   43c2c:	41 89 f1             	mov    %esi,%r9d
   43c2f:	f7 de                	neg    %esi
   43c31:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
        digits = lower_digits;
   43c38:	bf 30 4e 04 00       	mov    $0x44e30,%edi
   43c3d:	e9 a2 02 00 00       	jmp    43ee4 <printer_vprintf+0x5a0>
            num = (uintptr_t) va_arg(val, void*);
   43c42:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43c46:	8b 07                	mov    (%rdi),%eax
   43c48:	83 f8 2f             	cmp    $0x2f,%eax
   43c4b:	77 1c                	ja     43c69 <printer_vprintf+0x325>
   43c4d:	89 c2                	mov    %eax,%edx
   43c4f:	48 03 57 10          	add    0x10(%rdi),%rdx
   43c53:	83 c0 08             	add    $0x8,%eax
   43c56:	89 07                	mov    %eax,(%rdi)
   43c58:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
   43c5b:	81 4d a8 21 01 00 00 	orl    $0x121,-0x58(%rbp)
            base = -16;
   43c62:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
   43c67:	eb c3                	jmp    43c2c <printer_vprintf+0x2e8>
            num = (uintptr_t) va_arg(val, void*);
   43c69:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   43c6d:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   43c71:	48 8d 42 08          	lea    0x8(%rdx),%rax
   43c75:	48 89 41 08          	mov    %rax,0x8(%rcx)
   43c79:	eb dd                	jmp    43c58 <printer_vprintf+0x314>
            data = va_arg(val, char*);
   43c7b:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   43c7f:	8b 01                	mov    (%rcx),%eax
   43c81:	83 f8 2f             	cmp    $0x2f,%eax
   43c84:	0f 87 a5 01 00 00    	ja     43e2f <printer_vprintf+0x4eb>
   43c8a:	89 c2                	mov    %eax,%edx
   43c8c:	48 03 51 10          	add    0x10(%rcx),%rdx
   43c90:	83 c0 08             	add    $0x8,%eax
   43c93:	89 01                	mov    %eax,(%rcx)
   43c95:	4c 8b 22             	mov    (%rdx),%r12
        unsigned long num = 0;
   43c98:	41 b8 00 00 00 00    	mov    $0x0,%r8d
        if (flags & FLAG_NUMERIC) {
   43c9e:	8b 45 a8             	mov    -0x58(%rbp),%eax
   43ca1:	83 e0 20             	and    $0x20,%eax
   43ca4:	89 45 8c             	mov    %eax,-0x74(%rbp)
   43ca7:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
   43cad:	0f 85 21 02 00 00    	jne    43ed4 <printer_vprintf+0x590>
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
   43cb3:	8b 45 a8             	mov    -0x58(%rbp),%eax
   43cb6:	89 45 88             	mov    %eax,-0x78(%rbp)
   43cb9:	83 e0 60             	and    $0x60,%eax
   43cbc:	83 f8 60             	cmp    $0x60,%eax
   43cbf:	0f 84 54 02 00 00    	je     43f19 <printer_vprintf+0x5d5>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   43cc5:	8b 45 a8             	mov    -0x58(%rbp),%eax
   43cc8:	83 e0 21             	and    $0x21,%eax
        const char* prefix = "";
   43ccb:	48 c7 45 a0 5f 4c 04 	movq   $0x44c5f,-0x60(%rbp)
   43cd2:	00 
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   43cd3:	83 f8 21             	cmp    $0x21,%eax
   43cd6:	0f 84 79 02 00 00    	je     43f55 <printer_vprintf+0x611>
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
   43cdc:	8b 7d 9c             	mov    -0x64(%rbp),%edi
   43cdf:	89 f8                	mov    %edi,%eax
   43ce1:	f7 d0                	not    %eax
   43ce3:	c1 e8 1f             	shr    $0x1f,%eax
   43ce6:	89 45 84             	mov    %eax,-0x7c(%rbp)
   43ce9:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
   43ced:	0f 85 9e 02 00 00    	jne    43f91 <printer_vprintf+0x64d>
   43cf3:	84 c0                	test   %al,%al
   43cf5:	0f 84 96 02 00 00    	je     43f91 <printer_vprintf+0x64d>
            len = strnlen(data, precision);
   43cfb:	48 63 f7             	movslq %edi,%rsi
   43cfe:	4c 89 e7             	mov    %r12,%rdi
   43d01:	e8 63 fb ff ff       	call   43869 <strnlen>
   43d06:	89 45 98             	mov    %eax,-0x68(%rbp)
                   && !(flags & FLAG_LEFTJUSTIFY)
   43d09:	8b 45 88             	mov    -0x78(%rbp),%eax
   43d0c:	83 e0 26             	and    $0x26,%eax
            zeros = 0;
   43d0f:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
   43d16:	83 f8 22             	cmp    $0x22,%eax
   43d19:	0f 84 aa 02 00 00    	je     43fc9 <printer_vprintf+0x685>
        width -= len + zeros + strlen(prefix);
   43d1f:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
   43d23:	e8 26 fb ff ff       	call   4384e <strlen>
   43d28:	8b 55 9c             	mov    -0x64(%rbp),%edx
   43d2b:	03 55 98             	add    -0x68(%rbp),%edx
   43d2e:	44 89 e9             	mov    %r13d,%ecx
   43d31:	29 d1                	sub    %edx,%ecx
   43d33:	29 c1                	sub    %eax,%ecx
   43d35:	89 4d 8c             	mov    %ecx,-0x74(%rbp)
   43d38:	41 89 cd             	mov    %ecx,%r13d
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   43d3b:	f6 45 a8 04          	testb  $0x4,-0x58(%rbp)
   43d3f:	75 2d                	jne    43d6e <printer_vprintf+0x42a>
   43d41:	85 c9                	test   %ecx,%ecx
   43d43:	7e 29                	jle    43d6e <printer_vprintf+0x42a>
            p->putc(p, ' ', color);
   43d45:	44 89 fa             	mov    %r15d,%edx
   43d48:	be 20 00 00 00       	mov    $0x20,%esi
   43d4d:	4c 89 f7             	mov    %r14,%rdi
   43d50:	41 ff 16             	call   *(%r14)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   43d53:	41 83 ed 01          	sub    $0x1,%r13d
   43d57:	45 85 ed             	test   %r13d,%r13d
   43d5a:	7f e9                	jg     43d45 <printer_vprintf+0x401>
   43d5c:	8b 7d 8c             	mov    -0x74(%rbp),%edi
   43d5f:	85 ff                	test   %edi,%edi
   43d61:	b8 01 00 00 00       	mov    $0x1,%eax
   43d66:	0f 4f c7             	cmovg  %edi,%eax
   43d69:	29 c7                	sub    %eax,%edi
   43d6b:	41 89 fd             	mov    %edi,%r13d
        for (; *prefix; ++prefix) {
   43d6e:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
   43d72:	0f b6 07             	movzbl (%rdi),%eax
   43d75:	84 c0                	test   %al,%al
   43d77:	74 22                	je     43d9b <printer_vprintf+0x457>
   43d79:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
   43d7d:	48 89 fb             	mov    %rdi,%rbx
            p->putc(p, *prefix, color);
   43d80:	0f b6 f0             	movzbl %al,%esi
   43d83:	44 89 fa             	mov    %r15d,%edx
   43d86:	4c 89 f7             	mov    %r14,%rdi
   43d89:	41 ff 16             	call   *(%r14)
        for (; *prefix; ++prefix) {
   43d8c:	48 83 c3 01          	add    $0x1,%rbx
   43d90:	0f b6 03             	movzbl (%rbx),%eax
   43d93:	84 c0                	test   %al,%al
   43d95:	75 e9                	jne    43d80 <printer_vprintf+0x43c>
   43d97:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; zeros > 0; --zeros) {
   43d9b:	8b 45 9c             	mov    -0x64(%rbp),%eax
   43d9e:	85 c0                	test   %eax,%eax
   43da0:	7e 1d                	jle    43dbf <printer_vprintf+0x47b>
   43da2:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
   43da6:	89 c3                	mov    %eax,%ebx
            p->putc(p, '0', color);
   43da8:	44 89 fa             	mov    %r15d,%edx
   43dab:	be 30 00 00 00       	mov    $0x30,%esi
   43db0:	4c 89 f7             	mov    %r14,%rdi
   43db3:	41 ff 16             	call   *(%r14)
        for (; zeros > 0; --zeros) {
   43db6:	83 eb 01             	sub    $0x1,%ebx
   43db9:	75 ed                	jne    43da8 <printer_vprintf+0x464>
   43dbb:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; len > 0; ++data, --len) {
   43dbf:	8b 45 98             	mov    -0x68(%rbp),%eax
   43dc2:	85 c0                	test   %eax,%eax
   43dc4:	7e 27                	jle    43ded <printer_vprintf+0x4a9>
   43dc6:	89 c0                	mov    %eax,%eax
   43dc8:	4c 01 e0             	add    %r12,%rax
   43dcb:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
   43dcf:	48 89 c3             	mov    %rax,%rbx
            p->putc(p, *data, color);
   43dd2:	41 0f b6 34 24       	movzbl (%r12),%esi
   43dd7:	44 89 fa             	mov    %r15d,%edx
   43dda:	4c 89 f7             	mov    %r14,%rdi
   43ddd:	41 ff 16             	call   *(%r14)
        for (; len > 0; ++data, --len) {
   43de0:	49 83 c4 01          	add    $0x1,%r12
   43de4:	49 39 dc             	cmp    %rbx,%r12
   43de7:	75 e9                	jne    43dd2 <printer_vprintf+0x48e>
   43de9:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; width > 0; --width) {
   43ded:	45 85 ed             	test   %r13d,%r13d
   43df0:	7e 14                	jle    43e06 <printer_vprintf+0x4c2>
            p->putc(p, ' ', color);
   43df2:	44 89 fa             	mov    %r15d,%edx
   43df5:	be 20 00 00 00       	mov    $0x20,%esi
   43dfa:	4c 89 f7             	mov    %r14,%rdi
   43dfd:	41 ff 16             	call   *(%r14)
        for (; width > 0; --width) {
   43e00:	41 83 ed 01          	sub    $0x1,%r13d
   43e04:	75 ec                	jne    43df2 <printer_vprintf+0x4ae>
    for (; *format; ++format) {
   43e06:	4c 8d 63 01          	lea    0x1(%rbx),%r12
   43e0a:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
   43e0e:	84 c0                	test   %al,%al
   43e10:	0f 84 fe 01 00 00    	je     44014 <printer_vprintf+0x6d0>
        if (*format != '%') {
   43e16:	3c 25                	cmp    $0x25,%al
   43e18:	0f 84 54 fb ff ff    	je     43972 <printer_vprintf+0x2e>
            p->putc(p, *format, color);
   43e1e:	0f b6 f0             	movzbl %al,%esi
   43e21:	44 89 fa             	mov    %r15d,%edx
   43e24:	4c 89 f7             	mov    %r14,%rdi
   43e27:	41 ff 16             	call   *(%r14)
            continue;
   43e2a:	4c 89 e3             	mov    %r12,%rbx
   43e2d:	eb d7                	jmp    43e06 <printer_vprintf+0x4c2>
            data = va_arg(val, char*);
   43e2f:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43e33:	48 8b 57 08          	mov    0x8(%rdi),%rdx
   43e37:	48 8d 42 08          	lea    0x8(%rdx),%rax
   43e3b:	48 89 47 08          	mov    %rax,0x8(%rdi)
   43e3f:	e9 51 fe ff ff       	jmp    43c95 <printer_vprintf+0x351>
            color = va_arg(val, int);
   43e44:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43e48:	8b 07                	mov    (%rdi),%eax
   43e4a:	83 f8 2f             	cmp    $0x2f,%eax
   43e4d:	77 10                	ja     43e5f <printer_vprintf+0x51b>
   43e4f:	89 c2                	mov    %eax,%edx
   43e51:	48 03 57 10          	add    0x10(%rdi),%rdx
   43e55:	83 c0 08             	add    $0x8,%eax
   43e58:	89 07                	mov    %eax,(%rdi)
   43e5a:	44 8b 3a             	mov    (%rdx),%r15d
            goto done;
   43e5d:	eb a7                	jmp    43e06 <printer_vprintf+0x4c2>
            color = va_arg(val, int);
   43e5f:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   43e63:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   43e67:	48 8d 42 08          	lea    0x8(%rdx),%rax
   43e6b:	48 89 41 08          	mov    %rax,0x8(%rcx)
   43e6f:	eb e9                	jmp    43e5a <printer_vprintf+0x516>
            numbuf[0] = va_arg(val, int);
   43e71:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   43e75:	8b 01                	mov    (%rcx),%eax
   43e77:	83 f8 2f             	cmp    $0x2f,%eax
   43e7a:	77 23                	ja     43e9f <printer_vprintf+0x55b>
   43e7c:	89 c2                	mov    %eax,%edx
   43e7e:	48 03 51 10          	add    0x10(%rcx),%rdx
   43e82:	83 c0 08             	add    $0x8,%eax
   43e85:	89 01                	mov    %eax,(%rcx)
   43e87:	8b 02                	mov    (%rdx),%eax
   43e89:	88 45 b8             	mov    %al,-0x48(%rbp)
            numbuf[1] = '\0';
   43e8c:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
   43e90:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
   43e94:	41 b8 00 00 00 00    	mov    $0x0,%r8d
            break;
   43e9a:	e9 ff fd ff ff       	jmp    43c9e <printer_vprintf+0x35a>
            numbuf[0] = va_arg(val, int);
   43e9f:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43ea3:	48 8b 57 08          	mov    0x8(%rdi),%rdx
   43ea7:	48 8d 42 08          	lea    0x8(%rdx),%rax
   43eab:	48 89 47 08          	mov    %rax,0x8(%rdi)
   43eaf:	eb d6                	jmp    43e87 <printer_vprintf+0x543>
            numbuf[0] = (*format ? *format : '%');
   43eb1:	84 d2                	test   %dl,%dl
   43eb3:	0f 85 39 01 00 00    	jne    43ff2 <printer_vprintf+0x6ae>
   43eb9:	c6 45 b8 25          	movb   $0x25,-0x48(%rbp)
            numbuf[1] = '\0';
   43ebd:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
                format--;
   43ec1:	48 83 eb 01          	sub    $0x1,%rbx
            data = numbuf;
   43ec5:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
   43ec9:	41 b8 00 00 00 00    	mov    $0x0,%r8d
   43ecf:	e9 ca fd ff ff       	jmp    43c9e <printer_vprintf+0x35a>
        if (flags & FLAG_NUMERIC) {
   43ed4:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
    const char* digits = upper_digits;
   43eda:	bf 50 4e 04 00       	mov    $0x44e50,%edi
        if (flags & FLAG_NUMERIC) {
   43edf:	be 0a 00 00 00       	mov    $0xa,%esi
    *--numbuf_end = '\0';
   43ee4:	c6 45 cf 00          	movb   $0x0,-0x31(%rbp)
   43ee8:	4c 89 c1             	mov    %r8,%rcx
   43eeb:	4c 8d 65 cf          	lea    -0x31(%rbp),%r12
        *--numbuf_end = digits[val % base];
   43eef:	48 63 f6             	movslq %esi,%rsi
   43ef2:	49 83 ec 01          	sub    $0x1,%r12
   43ef6:	48 89 c8             	mov    %rcx,%rax
   43ef9:	ba 00 00 00 00       	mov    $0x0,%edx
   43efe:	48 f7 f6             	div    %rsi
   43f01:	0f b6 14 17          	movzbl (%rdi,%rdx,1),%edx
   43f05:	41 88 14 24          	mov    %dl,(%r12)
        val /= base;
   43f09:	48 89 ca             	mov    %rcx,%rdx
   43f0c:	48 89 c1             	mov    %rax,%rcx
    } while (val != 0);
   43f0f:	48 39 d6             	cmp    %rdx,%rsi
   43f12:	76 de                	jbe    43ef2 <printer_vprintf+0x5ae>
   43f14:	e9 9a fd ff ff       	jmp    43cb3 <printer_vprintf+0x36f>
                prefix = "-";
   43f19:	48 c7 45 a0 5c 4c 04 	movq   $0x44c5c,-0x60(%rbp)
   43f20:	00 
            if (flags & FLAG_NEGATIVE) {
   43f21:	8b 45 a8             	mov    -0x58(%rbp),%eax
   43f24:	a8 80                	test   $0x80,%al
   43f26:	0f 85 b0 fd ff ff    	jne    43cdc <printer_vprintf+0x398>
                prefix = "+";
   43f2c:	48 c7 45 a0 57 4c 04 	movq   $0x44c57,-0x60(%rbp)
   43f33:	00 
            } else if (flags & FLAG_PLUSPOSITIVE) {
   43f34:	a8 10                	test   $0x10,%al
   43f36:	0f 85 a0 fd ff ff    	jne    43cdc <printer_vprintf+0x398>
                prefix = " ";
   43f3c:	a8 08                	test   $0x8,%al
   43f3e:	ba 5f 4c 04 00       	mov    $0x44c5f,%edx
   43f43:	b8 5e 4c 04 00       	mov    $0x44c5e,%eax
   43f48:	48 0f 44 c2          	cmove  %rdx,%rax
   43f4c:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   43f50:	e9 87 fd ff ff       	jmp    43cdc <printer_vprintf+0x398>
                   && (base == 16 || base == -16)
   43f55:	41 8d 41 10          	lea    0x10(%r9),%eax
   43f59:	a9 df ff ff ff       	test   $0xffffffdf,%eax
   43f5e:	0f 85 78 fd ff ff    	jne    43cdc <printer_vprintf+0x398>
                   && (num || (flags & FLAG_ALT2))) {
   43f64:	4d 85 c0             	test   %r8,%r8
   43f67:	75 0d                	jne    43f76 <printer_vprintf+0x632>
   43f69:	f7 45 a8 00 01 00 00 	testl  $0x100,-0x58(%rbp)
   43f70:	0f 84 66 fd ff ff    	je     43cdc <printer_vprintf+0x398>
            prefix = (base == -16 ? "0x" : "0X");
   43f76:	41 83 f9 f0          	cmp    $0xfffffff0,%r9d
   43f7a:	ba 60 4c 04 00       	mov    $0x44c60,%edx
   43f7f:	b8 59 4c 04 00       	mov    $0x44c59,%eax
   43f84:	48 0f 44 c2          	cmove  %rdx,%rax
   43f88:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   43f8c:	e9 4b fd ff ff       	jmp    43cdc <printer_vprintf+0x398>
            len = strlen(data);
   43f91:	4c 89 e7             	mov    %r12,%rdi
   43f94:	e8 b5 f8 ff ff       	call   4384e <strlen>
   43f99:	89 45 98             	mov    %eax,-0x68(%rbp)
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
   43f9c:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
   43fa0:	0f 84 63 fd ff ff    	je     43d09 <printer_vprintf+0x3c5>
   43fa6:	80 7d 84 00          	cmpb   $0x0,-0x7c(%rbp)
   43faa:	0f 84 59 fd ff ff    	je     43d09 <printer_vprintf+0x3c5>
            zeros = precision > len ? precision - len : 0;
   43fb0:	8b 4d 9c             	mov    -0x64(%rbp),%ecx
   43fb3:	89 ca                	mov    %ecx,%edx
   43fb5:	29 c2                	sub    %eax,%edx
   43fb7:	39 c1                	cmp    %eax,%ecx
   43fb9:	b8 00 00 00 00       	mov    $0x0,%eax
   43fbe:	0f 4e d0             	cmovle %eax,%edx
   43fc1:	89 55 9c             	mov    %edx,-0x64(%rbp)
   43fc4:	e9 56 fd ff ff       	jmp    43d1f <printer_vprintf+0x3db>
                   && len + (int) strlen(prefix) < width) {
   43fc9:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
   43fcd:	e8 7c f8 ff ff       	call   4384e <strlen>
   43fd2:	8b 7d 98             	mov    -0x68(%rbp),%edi
   43fd5:	8d 14 07             	lea    (%rdi,%rax,1),%edx
            zeros = width - len - strlen(prefix);
   43fd8:	44 89 e9             	mov    %r13d,%ecx
   43fdb:	29 f9                	sub    %edi,%ecx
   43fdd:	29 c1                	sub    %eax,%ecx
   43fdf:	44 39 ea             	cmp    %r13d,%edx
   43fe2:	b8 00 00 00 00       	mov    $0x0,%eax
   43fe7:	0f 4d c8             	cmovge %eax,%ecx
   43fea:	89 4d 9c             	mov    %ecx,-0x64(%rbp)
   43fed:	e9 2d fd ff ff       	jmp    43d1f <printer_vprintf+0x3db>
            numbuf[0] = (*format ? *format : '%');
   43ff2:	88 55 b8             	mov    %dl,-0x48(%rbp)
            numbuf[1] = '\0';
   43ff5:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
   43ff9:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
   43ffd:	41 b8 00 00 00 00    	mov    $0x0,%r8d
   44003:	e9 96 fc ff ff       	jmp    43c9e <printer_vprintf+0x35a>
        int flags = 0;
   44008:	c7 45 a8 00 00 00 00 	movl   $0x0,-0x58(%rbp)
   4400f:	e9 b0 f9 ff ff       	jmp    439c4 <printer_vprintf+0x80>
}
   44014:	48 83 c4 58          	add    $0x58,%rsp
   44018:	5b                   	pop    %rbx
   44019:	41 5c                	pop    %r12
   4401b:	41 5d                	pop    %r13
   4401d:	41 5e                	pop    %r14
   4401f:	41 5f                	pop    %r15
   44021:	5d                   	pop    %rbp
   44022:	c3                   	ret    

0000000000044023 <console_vprintf>:
int console_vprintf(int cpos, int color, const char* format, va_list val) {
   44023:	55                   	push   %rbp
   44024:	48 89 e5             	mov    %rsp,%rbp
   44027:	48 83 ec 10          	sub    $0x10,%rsp
    cp.p.putc = console_putc;
   4402b:	48 c7 45 f0 2e 37 04 	movq   $0x4372e,-0x10(%rbp)
   44032:	00 
        cpos = 0;
   44033:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
   44039:	b8 00 00 00 00       	mov    $0x0,%eax
   4403e:	0f 43 f8             	cmovae %eax,%edi
    cp.cursor = console + cpos;
   44041:	48 63 ff             	movslq %edi,%rdi
   44044:	48 8d 84 3f 00 80 0b 	lea    0xb8000(%rdi,%rdi,1),%rax
   4404b:	00 
   4404c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
   44050:	48 8d 7d f0          	lea    -0x10(%rbp),%rdi
   44054:	e8 eb f8 ff ff       	call   43944 <printer_vprintf>
    return cp.cursor - console;
   44059:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4405d:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   44063:	48 d1 f8             	sar    %rax
}
   44066:	c9                   	leave  
   44067:	c3                   	ret    

0000000000044068 <console_printf>:
int console_printf(int cpos, int color, const char* format, ...) {
   44068:	55                   	push   %rbp
   44069:	48 89 e5             	mov    %rsp,%rbp
   4406c:	48 83 ec 50          	sub    $0x50,%rsp
   44070:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   44074:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   44078:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_start(val, format);
   4407c:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   44083:	48 8d 45 10          	lea    0x10(%rbp),%rax
   44087:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   4408b:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4408f:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
   44093:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   44097:	e8 87 ff ff ff       	call   44023 <console_vprintf>
}
   4409c:	c9                   	leave  
   4409d:	c3                   	ret    

000000000004409e <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
   4409e:	55                   	push   %rbp
   4409f:	48 89 e5             	mov    %rsp,%rbp
   440a2:	53                   	push   %rbx
   440a3:	48 83 ec 28          	sub    $0x28,%rsp
   440a7:	48 89 fb             	mov    %rdi,%rbx
    string_printer sp;
    sp.p.putc = string_putc;
   440aa:	48 c7 45 d8 b4 37 04 	movq   $0x437b4,-0x28(%rbp)
   440b1:	00 
    sp.s = s;
   440b2:	48 89 7d e0          	mov    %rdi,-0x20(%rbp)
    if (size) {
   440b6:	48 85 f6             	test   %rsi,%rsi
   440b9:	75 0b                	jne    440c6 <vsnprintf+0x28>
        sp.end = s + size - 1;
        printer_vprintf(&sp.p, 0, format, val);
        *sp.s = 0;
    }
    return sp.s - s;
   440bb:	8b 45 e0             	mov    -0x20(%rbp),%eax
   440be:	29 d8                	sub    %ebx,%eax
}
   440c0:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   440c4:	c9                   	leave  
   440c5:	c3                   	ret    
        sp.end = s + size - 1;
   440c6:	48 8d 44 37 ff       	lea    -0x1(%rdi,%rsi,1),%rax
   440cb:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
   440cf:	be 00 00 00 00       	mov    $0x0,%esi
   440d4:	48 8d 7d d8          	lea    -0x28(%rbp),%rdi
   440d8:	e8 67 f8 ff ff       	call   43944 <printer_vprintf>
        *sp.s = 0;
   440dd:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   440e1:	c6 00 00             	movb   $0x0,(%rax)
   440e4:	eb d5                	jmp    440bb <vsnprintf+0x1d>

00000000000440e6 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
   440e6:	55                   	push   %rbp
   440e7:	48 89 e5             	mov    %rsp,%rbp
   440ea:	48 83 ec 50          	sub    $0x50,%rsp
   440ee:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   440f2:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   440f6:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   440fa:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   44101:	48 8d 45 10          	lea    0x10(%rbp),%rax
   44105:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   44109:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4410d:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    int n = vsnprintf(s, size, format, val);
   44111:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   44115:	e8 84 ff ff ff       	call   4409e <vsnprintf>
    va_end(val);
    return n;
}
   4411a:	c9                   	leave  
   4411b:	c3                   	ret    

000000000004411c <console_clear>:

// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   4411c:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   44121:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
        console[i] = ' ' | 0x0700;
   44126:	66 c7 00 20 07       	movw   $0x720,(%rax)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   4412b:	48 83 c0 02          	add    $0x2,%rax
   4412f:	48 39 d0             	cmp    %rdx,%rax
   44132:	75 f2                	jne    44126 <console_clear+0xa>
    }
    cursorpos = 0;
   44134:	c7 05 be 4e 07 00 00 	movl   $0x0,0x74ebe(%rip)        # b8ffc <cursorpos>
   4413b:	00 00 00 
}
   4413e:	c3                   	ret    
