
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
   400be:	e8 34 05 00 00       	call   405f7 <exception>

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

// kernel(command)
//    Initialize the hardware and processes and start running. The `command`
//    string is an optional string passed from the boot loader.

void kernel(const char* command) {
   40167:	55                   	push   %rbp
   40168:	48 89 e5             	mov    %rsp,%rbp
   4016b:	48 83 ec 20          	sub    $0x20,%rsp
   4016f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    hardware_init();
   40173:	e8 af 14 00 00       	call   41627 <hardware_init>
    pageinfo_init();
   40178:	e8 33 0b 00 00       	call   40cb0 <pageinfo_init>
    console_clear();
   4017d:	e8 d9 38 00 00       	call   43a5b <console_clear>
    timer_init(HZ);
   40182:	bf 64 00 00 00       	mov    $0x64,%edi
   40187:	e8 8b 19 00 00       	call   41b17 <timer_init>

    // Set up process descriptors
    memset(processes, 0, sizeof(processes));
   4018c:	ba 00 0f 00 00       	mov    $0xf00,%edx
   40191:	be 00 00 00 00       	mov    $0x0,%esi
   40196:	bf 00 10 05 00       	mov    $0x51000,%edi
   4019b:	e8 d2 2f 00 00       	call   43172 <memset>
    for (pid_t i = 0; i < NPROC; i++) {
   401a0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   401a7:	eb 44                	jmp    401ed <kernel+0x86>
        processes[i].p_pid = i;
   401a9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401ac:	48 63 d0             	movslq %eax,%rdx
   401af:	48 89 d0             	mov    %rdx,%rax
   401b2:	48 c1 e0 04          	shl    $0x4,%rax
   401b6:	48 29 d0             	sub    %rdx,%rax
   401b9:	48 c1 e0 04          	shl    $0x4,%rax
   401bd:	48 8d 90 00 10 05 00 	lea    0x51000(%rax),%rdx
   401c4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401c7:	89 02                	mov    %eax,(%rdx)
        processes[i].p_state = P_FREE;
   401c9:	8b 45 fc             	mov    -0x4(%rbp),%eax
   401cc:	48 63 d0             	movslq %eax,%rdx
   401cf:	48 89 d0             	mov    %rdx,%rax
   401d2:	48 c1 e0 04          	shl    $0x4,%rax
   401d6:	48 29 d0             	sub    %rdx,%rax
   401d9:	48 c1 e0 04          	shl    $0x4,%rax
   401dd:	48 05 d8 10 05 00    	add    $0x510d8,%rax
   401e3:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
    for (pid_t i = 0; i < NPROC; i++) {
   401e9:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   401ed:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   401f1:	7e b6                	jle    401a9 <kernel+0x42>
    }

    if (command && strcmp(command, "malloc") == 0) {
   401f3:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   401f8:	74 29                	je     40223 <kernel+0xbc>
   401fa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   401fe:	be e6 45 04 00       	mov    $0x445e6,%esi
   40203:	48 89 c7             	mov    %rax,%rdi
   40206:	e8 d8 2f 00 00       	call   431e3 <strcmp>
   4020b:	85 c0                	test   %eax,%eax
   4020d:	75 14                	jne    40223 <kernel+0xbc>
        process_setup(1, 4);
   4020f:	be 04 00 00 00       	mov    $0x4,%esi
   40214:	bf 01 00 00 00       	mov    $0x1,%edi
   40219:	e8 b8 00 00 00       	call   402d6 <process_setup>
   4021e:	e9 a9 00 00 00       	jmp    402cc <kernel+0x165>
    } else if (command && strcmp(command, "alloctests") == 0) {
   40223:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40228:	74 26                	je     40250 <kernel+0xe9>
   4022a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4022e:	be ed 45 04 00       	mov    $0x445ed,%esi
   40233:	48 89 c7             	mov    %rax,%rdi
   40236:	e8 a8 2f 00 00       	call   431e3 <strcmp>
   4023b:	85 c0                	test   %eax,%eax
   4023d:	75 11                	jne    40250 <kernel+0xe9>
        process_setup(1, 5);
   4023f:	be 05 00 00 00       	mov    $0x5,%esi
   40244:	bf 01 00 00 00       	mov    $0x1,%edi
   40249:	e8 88 00 00 00       	call   402d6 <process_setup>
   4024e:	eb 7c                	jmp    402cc <kernel+0x165>
    } else if (command && strcmp(command, "test") == 0){
   40250:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40255:	74 26                	je     4027d <kernel+0x116>
   40257:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4025b:	be f8 45 04 00       	mov    $0x445f8,%esi
   40260:	48 89 c7             	mov    %rax,%rdi
   40263:	e8 7b 2f 00 00       	call   431e3 <strcmp>
   40268:	85 c0                	test   %eax,%eax
   4026a:	75 11                	jne    4027d <kernel+0x116>
        process_setup(1, 6);
   4026c:	be 06 00 00 00       	mov    $0x6,%esi
   40271:	bf 01 00 00 00       	mov    $0x1,%edi
   40276:	e8 5b 00 00 00       	call   402d6 <process_setup>
   4027b:	eb 4f                	jmp    402cc <kernel+0x165>
    } else if (command && strcmp(command, "test2") == 0) {
   4027d:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   40282:	74 39                	je     402bd <kernel+0x156>
   40284:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40288:	be fd 45 04 00       	mov    $0x445fd,%esi
   4028d:	48 89 c7             	mov    %rax,%rdi
   40290:	e8 4e 2f 00 00       	call   431e3 <strcmp>
   40295:	85 c0                	test   %eax,%eax
   40297:	75 24                	jne    402bd <kernel+0x156>
        for (pid_t i = 1; i <= 2; ++i) {
   40299:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
   402a0:	eb 13                	jmp    402b5 <kernel+0x14e>
            process_setup(i, 6);
   402a2:	8b 45 f8             	mov    -0x8(%rbp),%eax
   402a5:	be 06 00 00 00       	mov    $0x6,%esi
   402aa:	89 c7                	mov    %eax,%edi
   402ac:	e8 25 00 00 00       	call   402d6 <process_setup>
        for (pid_t i = 1; i <= 2; ++i) {
   402b1:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   402b5:	83 7d f8 02          	cmpl   $0x2,-0x8(%rbp)
   402b9:	7e e7                	jle    402a2 <kernel+0x13b>
   402bb:	eb 0f                	jmp    402cc <kernel+0x165>
        }
    } else {
        process_setup(1, 0);
   402bd:	be 00 00 00 00       	mov    $0x0,%esi
   402c2:	bf 01 00 00 00       	mov    $0x1,%edi
   402c7:	e8 0a 00 00 00       	call   402d6 <process_setup>
    }

    // Switch to the first process using run()
    run(&processes[1]);
   402cc:	bf f0 10 05 00       	mov    $0x510f0,%edi
   402d1:	e8 49 09 00 00       	call   40c1f <run>

00000000000402d6 <process_setup>:
// process_setup(pid, program_number)
//    Load application program `program_number` as process number `pid`.
//    This loads the application's code and data into memory, sets its
//    %rip and %rsp, gives it a stack page, and marks it as runnable.

void process_setup(pid_t pid, int program_number) {
   402d6:	55                   	push   %rbp
   402d7:	48 89 e5             	mov    %rsp,%rbp
   402da:	48 83 ec 10          	sub    $0x10,%rsp
   402de:	89 7d fc             	mov    %edi,-0x4(%rbp)
   402e1:	89 75 f8             	mov    %esi,-0x8(%rbp)
    process_init(&processes[pid], 0);
   402e4:	8b 45 fc             	mov    -0x4(%rbp),%eax
   402e7:	48 63 d0             	movslq %eax,%rdx
   402ea:	48 89 d0             	mov    %rdx,%rax
   402ed:	48 c1 e0 04          	shl    $0x4,%rax
   402f1:	48 29 d0             	sub    %rdx,%rax
   402f4:	48 c1 e0 04          	shl    $0x4,%rax
   402f8:	48 05 00 10 05 00    	add    $0x51000,%rax
   402fe:	be 00 00 00 00       	mov    $0x0,%esi
   40303:	48 89 c7             	mov    %rax,%rdi
   40306:	e8 9e 1a 00 00       	call   41da9 <process_init>
    assert(process_config_tables(pid) == 0);
   4030b:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4030e:	89 c7                	mov    %eax,%edi
   40310:	e8 64 3b 00 00       	call   43e79 <process_config_tables>
   40315:	85 c0                	test   %eax,%eax
   40317:	74 14                	je     4032d <process_setup+0x57>
   40319:	ba 08 46 04 00       	mov    $0x44608,%edx
   4031e:	be 77 00 00 00       	mov    $0x77,%esi
   40323:	bf 28 46 04 00       	mov    $0x44628,%edi
   40328:	e8 44 22 00 00       	call   42571 <assert_fail>

    /* Calls program_load in k-loader */
    assert(process_load(&processes[pid], program_number) >= 0);
   4032d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40330:	48 63 d0             	movslq %eax,%rdx
   40333:	48 89 d0             	mov    %rdx,%rax
   40336:	48 c1 e0 04          	shl    $0x4,%rax
   4033a:	48 29 d0             	sub    %rdx,%rax
   4033d:	48 c1 e0 04          	shl    $0x4,%rax
   40341:	48 8d 90 00 10 05 00 	lea    0x51000(%rax),%rdx
   40348:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4034b:	89 c6                	mov    %eax,%esi
   4034d:	48 89 d7             	mov    %rdx,%rdi
   40350:	e8 72 3e 00 00       	call   441c7 <process_load>
   40355:	85 c0                	test   %eax,%eax
   40357:	79 14                	jns    4036d <process_setup+0x97>
   40359:	ba 38 46 04 00       	mov    $0x44638,%edx
   4035e:	be 7a 00 00 00       	mov    $0x7a,%esi
   40363:	bf 28 46 04 00       	mov    $0x44628,%edi
   40368:	e8 04 22 00 00       	call   42571 <assert_fail>

    process_setup_stack(&processes[pid]);
   4036d:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40370:	48 63 d0             	movslq %eax,%rdx
   40373:	48 89 d0             	mov    %rdx,%rax
   40376:	48 c1 e0 04          	shl    $0x4,%rax
   4037a:	48 29 d0             	sub    %rdx,%rax
   4037d:	48 c1 e0 04          	shl    $0x4,%rax
   40381:	48 05 00 10 05 00    	add    $0x51000,%rax
   40387:	48 89 c7             	mov    %rax,%rdi
   4038a:	e8 70 3e 00 00       	call   441ff <process_setup_stack>

    processes[pid].p_state = P_RUNNABLE;
   4038f:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40392:	48 63 d0             	movslq %eax,%rdx
   40395:	48 89 d0             	mov    %rdx,%rax
   40398:	48 c1 e0 04          	shl    $0x4,%rax
   4039c:	48 29 d0             	sub    %rdx,%rax
   4039f:	48 c1 e0 04          	shl    $0x4,%rax
   403a3:	48 05 d8 10 05 00    	add    $0x510d8,%rax
   403a9:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
}
   403af:	90                   	nop
   403b0:	c9                   	leave  
   403b1:	c3                   	ret    

00000000000403b2 <assign_physical_page>:
// assign_physical_page(addr, owner)
//    Allocates the page with physical address `addr` to the given owner.
//    Fails if physical page `addr` was already allocated. Returns 0 on
//    success and -1 on failure. Used by the program loader.

int assign_physical_page(uintptr_t addr, int8_t owner) {
   403b2:	55                   	push   %rbp
   403b3:	48 89 e5             	mov    %rsp,%rbp
   403b6:	48 83 ec 10          	sub    $0x10,%rsp
   403ba:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   403be:	89 f0                	mov    %esi,%eax
   403c0:	88 45 f4             	mov    %al,-0xc(%rbp)
    if ((addr & 0xFFF) != 0
   403c3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   403c7:	25 ff 0f 00 00       	and    $0xfff,%eax
   403cc:	48 85 c0             	test   %rax,%rax
   403cf:	75 20                	jne    403f1 <assign_physical_page+0x3f>
        || addr >= MEMSIZE_PHYSICAL
   403d1:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   403d8:	00 
   403d9:	77 16                	ja     403f1 <assign_physical_page+0x3f>
        || pageinfo[PAGENUMBER(addr)].refcount != 0) {
   403db:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   403df:	48 c1 e8 0c          	shr    $0xc,%rax
   403e3:	48 98                	cltq   
   403e5:	0f b6 84 00 21 1f 05 	movzbl 0x51f21(%rax,%rax,1),%eax
   403ec:	00 
   403ed:	84 c0                	test   %al,%al
   403ef:	74 07                	je     403f8 <assign_physical_page+0x46>
        return -1;
   403f1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   403f6:	eb 2c                	jmp    40424 <assign_physical_page+0x72>
    } else {
        pageinfo[PAGENUMBER(addr)].refcount = 1;
   403f8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   403fc:	48 c1 e8 0c          	shr    $0xc,%rax
   40400:	48 98                	cltq   
   40402:	c6 84 00 21 1f 05 00 	movb   $0x1,0x51f21(%rax,%rax,1)
   40409:	01 
        pageinfo[PAGENUMBER(addr)].owner = owner;
   4040a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4040e:	48 c1 e8 0c          	shr    $0xc,%rax
   40412:	48 98                	cltq   
   40414:	0f b6 55 f4          	movzbl -0xc(%rbp),%edx
   40418:	88 94 00 20 1f 05 00 	mov    %dl,0x51f20(%rax,%rax,1)
        return 0;
   4041f:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
   40424:	c9                   	leave  
   40425:	c3                   	ret    

0000000000040426 <syscall_fork>:

pid_t syscall_fork() {
   40426:	55                   	push   %rbp
   40427:	48 89 e5             	mov    %rsp,%rbp
    return process_fork(current);
   4042a:	48 8b 05 cf 1a 01 00 	mov    0x11acf(%rip),%rax        # 51f00 <current>
   40431:	48 89 c7             	mov    %rax,%rdi
   40434:	e8 79 3e 00 00       	call   442b2 <process_fork>
}
   40439:	5d                   	pop    %rbp
   4043a:	c3                   	ret    

000000000004043b <syscall_exit>:


void syscall_exit() {
   4043b:	55                   	push   %rbp
   4043c:	48 89 e5             	mov    %rsp,%rbp
    process_free(current->p_pid);
   4043f:	48 8b 05 ba 1a 01 00 	mov    0x11aba(%rip),%rax        # 51f00 <current>
   40446:	8b 00                	mov    (%rax),%eax
   40448:	89 c7                	mov    %eax,%edi
   4044a:	e8 48 37 00 00       	call   43b97 <process_free>
}
   4044f:	90                   	nop
   40450:	5d                   	pop    %rbp
   40451:	c3                   	ret    

0000000000040452 <syscall_page_alloc>:

int syscall_page_alloc(uintptr_t addr) {
   40452:	55                   	push   %rbp
   40453:	48 89 e5             	mov    %rsp,%rbp
   40456:	48 83 ec 10          	sub    $0x10,%rsp
   4045a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return process_page_alloc(current, addr);
   4045e:	48 8b 05 9b 1a 01 00 	mov    0x11a9b(%rip),%rax        # 51f00 <current>
   40465:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40469:	48 89 d6             	mov    %rdx,%rsi
   4046c:	48 89 c7             	mov    %rax,%rdi
   4046f:	e8 d0 40 00 00       	call   44544 <process_page_alloc>
}
   40474:	c9                   	leave  
   40475:	c3                   	ret    

0000000000040476 <syscall_mapping>:


void syscall_mapping(proc* p){
   40476:	55                   	push   %rbp
   40477:	48 89 e5             	mov    %rsp,%rbp
   4047a:	48 83 ec 70          	sub    $0x70,%rsp
   4047e:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)

    uintptr_t mapping_ptr = p->p_registers.reg_rdi;
   40482:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40486:	48 8b 40 48          	mov    0x48(%rax),%rax
   4048a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    uintptr_t ptr = p->p_registers.reg_rsi;
   4048e:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40492:	48 8b 40 40          	mov    0x40(%rax),%rax
   40496:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

    // convert to physical address so kernel can write to it
    vamapping map = virtual_memory_lookup(p->p_pagetable, mapping_ptr);
   4049a:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   4049e:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   404a5:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   404a9:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   404ad:	48 89 ce             	mov    %rcx,%rsi
   404b0:	48 89 c7             	mov    %rax,%rdi
   404b3:	e8 7b 27 00 00       	call   42c33 <virtual_memory_lookup>

    // check for write access
    if((map.perm & (PTE_W|PTE_U)) != (PTE_W|PTE_U))
   404b8:	8b 45 e0             	mov    -0x20(%rbp),%eax
   404bb:	48 98                	cltq   
   404bd:	83 e0 06             	and    $0x6,%eax
   404c0:	48 83 f8 06          	cmp    $0x6,%rax
   404c4:	75 73                	jne    40539 <syscall_mapping+0xc3>
	return;
    uintptr_t endaddr = map.pa + sizeof(vamapping) - 1;
   404c6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   404ca:	48 83 c0 17          	add    $0x17,%rax
   404ce:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    // check for write access for end address
    vamapping end_map = virtual_memory_lookup(p->p_pagetable, endaddr);
   404d2:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   404d6:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   404dd:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   404e1:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   404e5:	48 89 ce             	mov    %rcx,%rsi
   404e8:	48 89 c7             	mov    %rax,%rdi
   404eb:	e8 43 27 00 00       	call   42c33 <virtual_memory_lookup>
    if((end_map.perm & (PTE_W|PTE_P)) != (PTE_W|PTE_P))
   404f0:	8b 45 c8             	mov    -0x38(%rbp),%eax
   404f3:	48 98                	cltq   
   404f5:	83 e0 03             	and    $0x3,%eax
   404f8:	48 83 f8 03          	cmp    $0x3,%rax
   404fc:	75 3e                	jne    4053c <syscall_mapping+0xc6>
	return;
    // find the actual mapping now
    vamapping ptr_lookup = virtual_memory_lookup(p->p_pagetable, ptr);
   404fe:	48 8b 45 98          	mov    -0x68(%rbp),%rax
   40502:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   40509:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   4050d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40511:	48 89 ce             	mov    %rcx,%rsi
   40514:	48 89 c7             	mov    %rax,%rdi
   40517:	e8 17 27 00 00       	call   42c33 <virtual_memory_lookup>
    memcpy((void *)map.pa, &ptr_lookup, sizeof(vamapping));
   4051c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40520:	48 89 c1             	mov    %rax,%rcx
   40523:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
   40527:	ba 18 00 00 00       	mov    $0x18,%edx
   4052c:	48 89 c6             	mov    %rax,%rsi
   4052f:	48 89 cf             	mov    %rcx,%rdi
   40532:	e8 d2 2b 00 00       	call   43109 <memcpy>
   40537:	eb 04                	jmp    4053d <syscall_mapping+0xc7>
	return;
   40539:	90                   	nop
   4053a:	eb 01                	jmp    4053d <syscall_mapping+0xc7>
	return;
   4053c:	90                   	nop
}
   4053d:	c9                   	leave  
   4053e:	c3                   	ret    

000000000004053f <syscall_mem_tog>:

void syscall_mem_tog(proc* process){
   4053f:	55                   	push   %rbp
   40540:	48 89 e5             	mov    %rsp,%rbp
   40543:	48 83 ec 18          	sub    $0x18,%rsp
   40547:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)

    pid_t p = process->p_registers.reg_rdi;
   4054b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4054f:	48 8b 40 48          	mov    0x48(%rax),%rax
   40553:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if(p == 0) {
   40556:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   4055a:	75 14                	jne    40570 <syscall_mem_tog+0x31>
        disp_global = !disp_global;
   4055c:	0f b6 05 9d 5a 00 00 	movzbl 0x5a9d(%rip),%eax        # 46000 <disp_global>
   40563:	84 c0                	test   %al,%al
   40565:	0f 94 c0             	sete   %al
   40568:	88 05 92 5a 00 00    	mov    %al,0x5a92(%rip)        # 46000 <disp_global>
   4056e:	eb 36                	jmp    405a6 <syscall_mem_tog+0x67>
    }
    else {
        if(p < 0 || p > NPROC || p != process->p_pid)
   40570:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   40574:	78 2f                	js     405a5 <syscall_mem_tog+0x66>
   40576:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
   4057a:	7f 29                	jg     405a5 <syscall_mem_tog+0x66>
   4057c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40580:	8b 00                	mov    (%rax),%eax
   40582:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   40585:	75 1e                	jne    405a5 <syscall_mem_tog+0x66>
            return;
        process->display_status = !(process->display_status);
   40587:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4058b:	0f b6 80 e8 00 00 00 	movzbl 0xe8(%rax),%eax
   40592:	84 c0                	test   %al,%al
   40594:	0f 94 c0             	sete   %al
   40597:	89 c2                	mov    %eax,%edx
   40599:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4059d:	88 90 e8 00 00 00    	mov    %dl,0xe8(%rax)
   405a3:	eb 01                	jmp    405a6 <syscall_mem_tog+0x67>
            return;
   405a5:	90                   	nop
    }
}
   405a6:	c9                   	leave  
   405a7:	c3                   	ret    

00000000000405a8 <phys_mem_avail>:

// phys_mem_avail()
//    Returns a boolean variable indicating whether or not physical memory is
//    still available.

size_t phys_mem_avail() {
   405a8:	55                   	push   %rbp
   405a9:	48 89 e5             	mov    %rsp,%rbp
   405ac:	48 83 ec 10          	sub    $0x10,%rsp
    for (size_t i = 0; i < PAGENUMBER(MEMSIZE_PHYSICAL); i++) {
   405b0:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   405b7:	00 
   405b8:	eb 2c                	jmp    405e6 <phys_mem_avail+0x3e>
        if (pageinfo[i].owner == 0 && pageinfo[i].refcount == 0 ) {
   405ba:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   405be:	0f b6 84 00 20 1f 05 	movzbl 0x51f20(%rax,%rax,1),%eax
   405c5:	00 
   405c6:	84 c0                	test   %al,%al
   405c8:	75 17                	jne    405e1 <phys_mem_avail+0x39>
   405ca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   405ce:	0f b6 84 00 21 1f 05 	movzbl 0x51f21(%rax,%rax,1),%eax
   405d5:	00 
   405d6:	84 c0                	test   %al,%al
   405d8:	75 07                	jne    405e1 <phys_mem_avail+0x39>
            return 1;
   405da:	b8 01 00 00 00       	mov    $0x1,%eax
   405df:	eb 14                	jmp    405f5 <phys_mem_avail+0x4d>
    for (size_t i = 0; i < PAGENUMBER(MEMSIZE_PHYSICAL); i++) {
   405e1:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
   405e6:	48 81 7d f8 ff 01 00 	cmpq   $0x1ff,-0x8(%rbp)
   405ed:	00 
   405ee:	76 ca                	jbe    405ba <phys_mem_avail+0x12>
        }
    }
    return 0;
   405f0:	b8 00 00 00 00       	mov    $0x0,%eax
}
   405f5:	c9                   	leave  
   405f6:	c3                   	ret    

00000000000405f7 <exception>:
//    k-exception.S). That code saves more registers on the kernel's stack,
//    then calls exception().
//
//    Note that hardware interrupts are disabled whenever the kernel is running.

void exception(x86_64_registers* reg) {
   405f7:	55                   	push   %rbp
   405f8:	48 89 e5             	mov    %rsp,%rbp
   405fb:	48 81 ec 60 01 00 00 	sub    $0x160,%rsp
   40602:	48 89 bd c8 fe ff ff 	mov    %rdi,-0x138(%rbp)
    // Copy the saved registers into the `current` process descriptor
    // and always use the kernel's page table.
    current->p_registers = *reg;
   40609:	48 8b 05 f0 18 01 00 	mov    0x118f0(%rip),%rax        # 51f00 <current>
   40610:	48 8b 95 c8 fe ff ff 	mov    -0x138(%rbp),%rdx
   40617:	48 83 c0 18          	add    $0x18,%rax
   4061b:	48 89 d6             	mov    %rdx,%rsi
   4061e:	ba 18 00 00 00       	mov    $0x18,%edx
   40623:	48 89 c7             	mov    %rax,%rdi
   40626:	48 89 d1             	mov    %rdx,%rcx
   40629:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
    set_pagetable(kernel_pagetable);
   4062c:	48 8b 05 cd 39 01 00 	mov    0x139cd(%rip),%rax        # 54000 <kernel_pagetable>
   40633:	48 89 c7             	mov    %rax,%rdi
   40636:	e8 04 21 00 00       	call   4273f <set_pagetable>
    // Events logged this way are stored in the host's `log.txt` file.
    /*log_printf("proc %d: exception %d\n", current->p_pid, reg->reg_intno);*/

    // Show the current cursor location and memory state
    // (unless this is a kernel fault).
    console_show_cursor(cursorpos);
   4063b:	8b 05 bb 89 07 00    	mov    0x789bb(%rip),%eax        # b8ffc <cursorpos>
   40641:	89 c7                	mov    %eax,%edi
   40643:	e8 2b 18 00 00       	call   41e73 <console_show_cursor>
    if ((reg->reg_intno != INT_PAGEFAULT
   40648:	48 8b 85 c8 fe ff ff 	mov    -0x138(%rbp),%rax
   4064f:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   40656:	48 83 f8 0e          	cmp    $0xe,%rax
   4065a:	74 14                	je     40670 <exception+0x79>
	    && reg->reg_intno != INT_GPF)
   4065c:	48 8b 85 c8 fe ff ff 	mov    -0x138(%rbp),%rax
   40663:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   4066a:	48 83 f8 0d          	cmp    $0xd,%rax
   4066e:	75 16                	jne    40686 <exception+0x8f>
            || (reg->reg_err & PFERR_USER)) {
   40670:	48 8b 85 c8 fe ff ff 	mov    -0x138(%rbp),%rax
   40677:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
   4067e:	83 e0 04             	and    $0x4,%eax
   40681:	48 85 c0             	test   %rax,%rax
   40684:	74 1a                	je     406a0 <exception+0xa9>
        check_virtual_memory();
   40686:	e8 bc 09 00 00       	call   41047 <check_virtual_memory>
        if(disp_global){
   4068b:	0f b6 05 6e 59 00 00 	movzbl 0x596e(%rip),%eax        # 46000 <disp_global>
   40692:	84 c0                	test   %al,%al
   40694:	74 0a                	je     406a0 <exception+0xa9>
            memshow_physical();
   40696:	e8 24 0b 00 00       	call   411bf <memshow_physical>
            memshow_virtual_animate();
   4069b:	e8 4a 0e 00 00       	call   414ea <memshow_virtual_animate>
        }
    }

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();
   406a0:	e8 ab 1c 00 00       	call   42350 <check_keyboard>


    // Actually handle the exception.
    switch (reg->reg_intno) {
   406a5:	48 8b 85 c8 fe ff ff 	mov    -0x138(%rbp),%rax
   406ac:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   406b3:	48 83 e8 0e          	sub    $0xe,%rax
   406b7:	48 83 f8 2c          	cmp    $0x2c,%rax
   406bb:	0f 87 b1 04 00 00    	ja     40b72 <exception+0x57b>
   406c1:	48 8b 04 c5 70 46 04 	mov    0x44670(,%rax,8),%rax
   406c8:	00 
   406c9:	ff e0                	jmp    *%rax
        case INT_SYS_PANIC:
            {
                // rdi stores pointer for msg string
                {
                    char msg[160];
                    uintptr_t addr = current->p_registers.reg_rdi;
   406cb:	48 8b 05 2e 18 01 00 	mov    0x1182e(%rip),%rax        # 51f00 <current>
   406d2:	48 8b 40 48          	mov    0x48(%rax),%rax
   406d6:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
                    if((void *)addr == NULL)
   406da:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
   406df:	75 0f                	jne    406f0 <exception+0xf9>
                        kernel_panic(NULL);
   406e1:	bf 00 00 00 00       	mov    $0x0,%edi
   406e6:	b8 00 00 00 00       	mov    $0x0,%eax
   406eb:	e8 a1 1d 00 00       	call   42491 <kernel_panic>
                    vamapping map = virtual_memory_lookup(current->p_pagetable, addr);
   406f0:	48 8b 05 09 18 01 00 	mov    0x11809(%rip),%rax        # 51f00 <current>
   406f7:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   406fe:	48 8d 45 a8          	lea    -0x58(%rbp),%rax
   40702:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   40706:	48 89 ce             	mov    %rcx,%rsi
   40709:	48 89 c7             	mov    %rax,%rdi
   4070c:	e8 22 25 00 00       	call   42c33 <virtual_memory_lookup>
                    memcpy(msg, (void *)map.pa, 160);
   40711:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   40715:	48 89 c1             	mov    %rax,%rcx
   40718:	48 8d 85 d8 fe ff ff 	lea    -0x128(%rbp),%rax
   4071f:	ba a0 00 00 00       	mov    $0xa0,%edx
   40724:	48 89 ce             	mov    %rcx,%rsi
   40727:	48 89 c7             	mov    %rax,%rdi
   4072a:	e8 da 29 00 00       	call   43109 <memcpy>
                    kernel_panic(msg);
   4072f:	48 8d 85 d8 fe ff ff 	lea    -0x128(%rbp),%rax
   40736:	48 89 c7             	mov    %rax,%rdi
   40739:	b8 00 00 00 00       	mov    $0x0,%eax
   4073e:	e8 4e 1d 00 00       	call   42491 <kernel_panic>
                kernel_panic(NULL);
                break;                  // will not be reached
            }
        case INT_SYS_GETPID:
            {
                current->p_registers.reg_rax = current->p_pid;
   40743:	48 8b 05 b6 17 01 00 	mov    0x117b6(%rip),%rax        # 51f00 <current>
   4074a:	8b 10                	mov    (%rax),%edx
   4074c:	48 8b 05 ad 17 01 00 	mov    0x117ad(%rip),%rax        # 51f00 <current>
   40753:	48 63 d2             	movslq %edx,%rdx
   40756:	48 89 50 18          	mov    %rdx,0x18(%rax)
                break;
   4075a:	e9 25 04 00 00       	jmp    40b84 <exception+0x58d>
            }
        case INT_SYS_FORK:
            {
                current->p_registers.reg_rax = syscall_fork();
   4075f:	b8 00 00 00 00       	mov    $0x0,%eax
   40764:	e8 bd fc ff ff       	call   40426 <syscall_fork>
   40769:	89 c2                	mov    %eax,%edx
   4076b:	48 8b 05 8e 17 01 00 	mov    0x1178e(%rip),%rax        # 51f00 <current>
   40772:	48 63 d2             	movslq %edx,%rdx
   40775:	48 89 50 18          	mov    %rdx,0x18(%rax)
                break;
   40779:	e9 06 04 00 00       	jmp    40b84 <exception+0x58d>
            }
        case INT_SYS_MAPPING:
            {
                syscall_mapping(current);
   4077e:	48 8b 05 7b 17 01 00 	mov    0x1177b(%rip),%rax        # 51f00 <current>
   40785:	48 89 c7             	mov    %rax,%rdi
   40788:	e8 e9 fc ff ff       	call   40476 <syscall_mapping>
                break;
   4078d:	e9 f2 03 00 00       	jmp    40b84 <exception+0x58d>
            }
        case INT_SYS_EXIT:
            {
                syscall_exit();
   40792:	b8 00 00 00 00       	mov    $0x0,%eax
   40797:	e8 9f fc ff ff       	call   4043b <syscall_exit>
                schedule();
   4079c:	e8 0c 04 00 00       	call   40bad <schedule>
                break;
   407a1:	e9 de 03 00 00       	jmp    40b84 <exception+0x58d>
            }
        case INT_SYS_YIELD:
            {
                schedule();
   407a6:	e8 02 04 00 00       	call   40bad <schedule>
                break;                  /* will not be reached */
   407ab:	e9 d4 03 00 00       	jmp    40b84 <exception+0x58d>
            }
        case INT_SYS_BRK:
            {
                uintptr_t rdi = current->p_registers.reg_rdi;
   407b0:	48 8b 05 49 17 01 00 	mov    0x11749(%rip),%rax        # 51f00 <current>
   407b7:	48 8b 40 48          	mov    0x48(%rax),%rax
   407bb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

                if (rdi < current->original_break || rdi > MEMSIZE_VIRTUAL
   407bf:	48 8b 05 3a 17 01 00 	mov    0x1173a(%rip),%rax        # 51f00 <current>
   407c6:	48 8b 40 10          	mov    0x10(%rax),%rax
   407ca:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   407ce:	72 0a                	jb     407da <exception+0x1e3>
   407d0:	48 81 7d f8 00 f0 2f 	cmpq   $0x2ff000,-0x8(%rbp)
   407d7:	00 
   407d8:	76 14                	jbe    407ee <exception+0x1f7>
                     - PAGESIZE) {
                    current->p_registers.reg_rax = (uintptr_t)-1;
   407da:	48 8b 05 1f 17 01 00 	mov    0x1171f(%rip),%rax        # 51f00 <current>
   407e1:	48 c7 40 18 ff ff ff 	movq   $0xffffffffffffffff,0x18(%rax)
   407e8:	ff 
                    break;
   407e9:	e9 96 03 00 00       	jmp    40b84 <exception+0x58d>
                }

                current->p_registers.reg_rax = (uintptr_t)0;
   407ee:	48 8b 05 0b 17 01 00 	mov    0x1170b(%rip),%rax        # 51f00 <current>
   407f5:	48 c7 40 18 00 00 00 	movq   $0x0,0x18(%rax)
   407fc:	00 

                if (rdi < current->program_break) {
   407fd:	48 8b 05 fc 16 01 00 	mov    0x116fc(%rip),%rax        # 51f00 <current>
   40804:	48 8b 40 08          	mov    0x8(%rax),%rax
   40808:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   4080c:	0f 83 df 00 00 00    	jae    408f1 <exception+0x2fa>
                    if (rdi % PAGESIZE != 0) {
   40812:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40816:	25 ff 0f 00 00       	and    $0xfff,%eax
   4081b:	48 85 c0             	test   %rax,%rax
   4081e:	74 10                	je     40830 <exception+0x239>
                        rdi &= ~(PAGESIZE - 1);
   40820:	48 81 65 f8 00 f0 ff 	andq   $0xfffffffffffff000,-0x8(%rbp)
   40827:	ff 
                        rdi += PAGESIZE;
   40828:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   4082f:	00 
                    }

                    vamapping vmap = 
                        virtual_memory_lookup(current->p_pagetable, rdi);
   40830:	48 8b 05 c9 16 01 00 	mov    0x116c9(%rip),%rax        # 51f00 <current>
   40837:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   4083e:	48 8d 45 90          	lea    -0x70(%rbp),%rax
   40842:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40846:	48 89 ce             	mov    %rcx,%rsi
   40849:	48 89 c7             	mov    %rax,%rdi
   4084c:	e8 e2 23 00 00       	call   42c33 <virtual_memory_lookup>
                    for (; vmap.perm != 0; rdi += PAGESIZE) {
   40851:	e9 90 00 00 00       	jmp    408e6 <exception+0x2ef>
                        vmap = 
                            virtual_memory_lookup(current->p_pagetable, rdi);
   40856:	48 8b 05 a3 16 01 00 	mov    0x116a3(%rip),%rax        # 51f00 <current>
   4085d:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   40864:	48 8d 85 a0 fe ff ff 	lea    -0x160(%rbp),%rax
   4086b:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4086f:	48 89 ce             	mov    %rcx,%rsi
   40872:	48 89 c7             	mov    %rax,%rdi
   40875:	e8 b9 23 00 00       	call   42c33 <virtual_memory_lookup>
   4087a:	48 8b 85 a0 fe ff ff 	mov    -0x160(%rbp),%rax
   40881:	48 89 45 90          	mov    %rax,-0x70(%rbp)
   40885:	48 8b 85 a8 fe ff ff 	mov    -0x158(%rbp),%rax
   4088c:	48 89 45 98          	mov    %rax,-0x68(%rbp)
   40890:	48 8b 85 b0 fe ff ff 	mov    -0x150(%rbp),%rax
   40897:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
                        pageinfo[vmap.pn].owner = PO_FREE;
   4089b:	8b 45 90             	mov    -0x70(%rbp),%eax
   4089e:	48 98                	cltq   
   408a0:	c6 84 00 20 1f 05 00 	movb   $0x0,0x51f20(%rax,%rax,1)
   408a7:	00 
                        pageinfo[vmap.pn].refcount = 0;
   408a8:	8b 45 90             	mov    -0x70(%rbp),%eax
   408ab:	48 98                	cltq   
   408ad:	c6 84 00 21 1f 05 00 	movb   $0x0,0x51f21(%rax,%rax,1)
   408b4:	00 
                        virtual_memory_map(current->p_pagetable, rdi,
   408b5:	48 8b 55 98          	mov    -0x68(%rbp),%rdx
   408b9:	48 8b 05 40 16 01 00 	mov    0x11640(%rip),%rax        # 51f00 <current>
   408c0:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   408c7:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   408cb:	41 b8 00 00 00 00    	mov    $0x0,%r8d
   408d1:	b9 00 10 00 00       	mov    $0x1000,%ecx
   408d6:	48 89 c7             	mov    %rax,%rdi
   408d9:	e8 92 1f 00 00       	call   42870 <virtual_memory_map>
                    for (; vmap.perm != 0; rdi += PAGESIZE) {
   408de:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   408e5:	00 
   408e6:	8b 45 a0             	mov    -0x60(%rbp),%eax
   408e9:	85 c0                	test   %eax,%eax
   408eb:	0f 85 65 ff ff ff    	jne    40856 <exception+0x25f>
                                           vmap.pa, PAGESIZE, 0);
                    }
                }

                current->program_break = current->p_registers.reg_rdi;
   408f1:	48 8b 15 08 16 01 00 	mov    0x11608(%rip),%rdx        # 51f00 <current>
   408f8:	48 8b 05 01 16 01 00 	mov    0x11601(%rip),%rax        # 51f00 <current>
   408ff:	48 8b 52 48          	mov    0x48(%rdx),%rdx
   40903:	48 89 50 08          	mov    %rdx,0x8(%rax)
                break;
   40907:	e9 78 02 00 00       	jmp    40b84 <exception+0x58d>
            }
        case INT_SYS_SBRK:
            {
                intptr_t rdi = (intptr_t)current->p_registers.reg_rdi;
   4090c:	48 8b 05 ed 15 01 00 	mov    0x115ed(%rip),%rax        # 51f00 <current>
   40913:	48 8b 40 48          	mov    0x48(%rax),%rax
   40917:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
                uintptr_t new_break = current->program_break + rdi;
   4091b:	48 8b 05 de 15 01 00 	mov    0x115de(%rip),%rax        # 51f00 <current>
   40922:	48 8b 50 08          	mov    0x8(%rax),%rdx
   40926:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4092a:	48 01 d0             	add    %rdx,%rax
   4092d:	48 89 45 e0          	mov    %rax,-0x20(%rbp)

                if (new_break < current->original_break || new_break >=
   40931:	48 8b 05 c8 15 01 00 	mov    0x115c8(%rip),%rax        # 51f00 <current>
   40938:	48 8b 40 10          	mov    0x10(%rax),%rax
   4093c:	48 39 45 e0          	cmp    %rax,-0x20(%rbp)
   40940:	72 0a                	jb     4094c <exception+0x355>
   40942:	48 81 7d e0 ff ef 2f 	cmpq   $0x2fefff,-0x20(%rbp)
   40949:	00 
   4094a:	76 0f                	jbe    4095b <exception+0x364>
                    MEMSIZE_VIRTUAL - PAGESIZE) {
                    current->p_registers.reg_rax = (uintptr_t)-1;
   4094c:	48 8b 05 ad 15 01 00 	mov    0x115ad(%rip),%rax        # 51f00 <current>
   40953:	48 c7 40 18 ff ff ff 	movq   $0xffffffffffffffff,0x18(%rax)
   4095a:	ff 
                }

                current->p_registers.reg_rax = current->program_break;
   4095b:	48 8b 15 9e 15 01 00 	mov    0x1159e(%rip),%rdx        # 51f00 <current>
   40962:	48 8b 05 97 15 01 00 	mov    0x11597(%rip),%rax        # 51f00 <current>
   40969:	48 8b 52 08          	mov    0x8(%rdx),%rdx
   4096d:	48 89 50 18          	mov    %rdx,0x18(%rax)
                current->program_break += rdi;
   40971:	48 8b 05 88 15 01 00 	mov    0x11588(%rip),%rax        # 51f00 <current>
   40978:	48 8b 48 08          	mov    0x8(%rax),%rcx
   4097c:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   40980:	48 8b 05 79 15 01 00 	mov    0x11579(%rip),%rax        # 51f00 <current>
   40987:	48 01 ca             	add    %rcx,%rdx
   4098a:	48 89 50 08          	mov    %rdx,0x8(%rax)
                uintptr_t va = current->program_break;
   4098e:	48 8b 05 6b 15 01 00 	mov    0x1156b(%rip),%rax        # 51f00 <current>
   40995:	48 8b 40 08          	mov    0x8(%rax),%rax
   40999:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

                if (rdi < 0) {
   4099d:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   409a2:	0f 89 db 01 00 00    	jns    40b83 <exception+0x58c>
                    if (va % PAGESIZE != 0) {
   409a8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   409ac:	25 ff 0f 00 00       	and    $0xfff,%eax
   409b1:	48 85 c0             	test   %rax,%rax
   409b4:	74 10                	je     409c6 <exception+0x3cf>
                        va &= ~(PAGESIZE - 1);
   409b6:	48 81 65 f0 00 f0 ff 	andq   $0xfffffffffffff000,-0x10(%rbp)
   409bd:	ff 
                        va += PAGESIZE;
   409be:	48 81 45 f0 00 10 00 	addq   $0x1000,-0x10(%rbp)
   409c5:	00 
                    }

                    vamapping vmap = 
                        virtual_memory_lookup(current->p_pagetable, va);   
   409c6:	48 8b 05 33 15 01 00 	mov    0x11533(%rip),%rax        # 51f00 <current>
   409cd:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   409d4:	48 8d 85 78 ff ff ff 	lea    -0x88(%rbp),%rax
   409db:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   409df:	48 89 ce             	mov    %rcx,%rsi
   409e2:	48 89 c7             	mov    %rax,%rdi
   409e5:	e8 49 22 00 00       	call   42c33 <virtual_memory_lookup>
                    for (; vmap.perm != 0; va += PAGESIZE) {
   409ea:	e9 99 00 00 00       	jmp    40a88 <exception+0x491>
                        vmap = 
                            virtual_memory_lookup(current->p_pagetable, va);
   409ef:	48 8b 05 0a 15 01 00 	mov    0x1150a(%rip),%rax        # 51f00 <current>
   409f6:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   409fd:	48 8d 85 a0 fe ff ff 	lea    -0x160(%rbp),%rax
   40a04:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40a08:	48 89 ce             	mov    %rcx,%rsi
   40a0b:	48 89 c7             	mov    %rax,%rdi
   40a0e:	e8 20 22 00 00       	call   42c33 <virtual_memory_lookup>
   40a13:	48 8b 85 a0 fe ff ff 	mov    -0x160(%rbp),%rax
   40a1a:	48 89 85 78 ff ff ff 	mov    %rax,-0x88(%rbp)
   40a21:	48 8b 85 a8 fe ff ff 	mov    -0x158(%rbp),%rax
   40a28:	48 89 45 80          	mov    %rax,-0x80(%rbp)
   40a2c:	48 8b 85 b0 fe ff ff 	mov    -0x150(%rbp),%rax
   40a33:	48 89 45 88          	mov    %rax,-0x78(%rbp)
                        pageinfo[vmap.pn].owner = PO_FREE;
   40a37:	8b 85 78 ff ff ff    	mov    -0x88(%rbp),%eax
   40a3d:	48 98                	cltq   
   40a3f:	c6 84 00 20 1f 05 00 	movb   $0x0,0x51f20(%rax,%rax,1)
   40a46:	00 
                        pageinfo[vmap.pn].refcount = 0;
   40a47:	8b 85 78 ff ff ff    	mov    -0x88(%rbp),%eax
   40a4d:	48 98                	cltq   
   40a4f:	c6 84 00 21 1f 05 00 	movb   $0x0,0x51f21(%rax,%rax,1)
   40a56:	00 
                        virtual_memory_map(current->p_pagetable, va,
   40a57:	48 8b 55 80          	mov    -0x80(%rbp),%rdx
   40a5b:	48 8b 05 9e 14 01 00 	mov    0x1149e(%rip),%rax        # 51f00 <current>
   40a62:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   40a69:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   40a6d:	41 b8 00 00 00 00    	mov    $0x0,%r8d
   40a73:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40a78:	48 89 c7             	mov    %rax,%rdi
   40a7b:	e8 f0 1d 00 00       	call   42870 <virtual_memory_map>
                    for (; vmap.perm != 0; va += PAGESIZE) {
   40a80:	48 81 45 f0 00 10 00 	addq   $0x1000,-0x10(%rbp)
   40a87:	00 
   40a88:	8b 45 88             	mov    -0x78(%rbp),%eax
   40a8b:	85 c0                	test   %eax,%eax
   40a8d:	0f 85 5c ff ff ff    	jne    409ef <exception+0x3f8>
                                           vmap.pa, PAGESIZE, 0);
                    }
                }

                break;
   40a93:	e9 eb 00 00 00       	jmp    40b83 <exception+0x58c>
            }
	case INT_SYS_PAGE_ALLOC:
	    {
		intptr_t addr = reg->reg_rdi;
   40a98:	48 8b 85 c8 fe ff ff 	mov    -0x138(%rbp),%rax
   40a9f:	48 8b 40 30          	mov    0x30(%rax),%rax
   40aa3:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
		syscall_page_alloc(addr);
   40aa7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   40aab:	48 89 c7             	mov    %rax,%rdi
   40aae:	e8 9f f9 ff ff       	call   40452 <syscall_page_alloc>
		break;
   40ab3:	e9 cc 00 00 00       	jmp    40b84 <exception+0x58d>
	    }
        case INT_SYS_MEM_TOG:
            {
                syscall_mem_tog(current);
   40ab8:	48 8b 05 41 14 01 00 	mov    0x11441(%rip),%rax        # 51f00 <current>
   40abf:	48 89 c7             	mov    %rax,%rdi
   40ac2:	e8 78 fa ff ff       	call   4053f <syscall_mem_tog>
                break;
   40ac7:	e9 b8 00 00 00       	jmp    40b84 <exception+0x58d>
            }
        case INT_TIMER:
            {
                ++ticks;
   40acc:	8b 05 4e 18 01 00    	mov    0x1184e(%rip),%eax        # 52320 <ticks>
   40ad2:	83 c0 01             	add    $0x1,%eax
   40ad5:	89 05 45 18 01 00    	mov    %eax,0x11845(%rip)        # 52320 <ticks>
                schedule();
   40adb:	e8 cd 00 00 00       	call   40bad <schedule>
                break;                  /* will not be reached */
   40ae0:	e9 9f 00 00 00       	jmp    40b84 <exception+0x58d>
    return val;
}

static inline uintptr_t rcr2(void) {
    uintptr_t val;
    asm volatile("movq %%cr2,%0" : "=r" (val));
   40ae5:	0f 20 d0             	mov    %cr2,%rax
   40ae8:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    return val;
   40aec:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
            }
        case INT_PAGEFAULT: 
            {
                // Analyze faulting address and access type.
                uintptr_t addr = rcr2();
   40af0:	48 89 45 c8          	mov    %rax,-0x38(%rbp)

                if (addr >= current->original_break && addr < MEMSIZE_VIRTUAL 
   40af4:	48 8b 05 05 14 01 00 	mov    0x11405(%rip),%rax        # 51f00 <current>
   40afb:	48 8b 40 10          	mov    0x10(%rax),%rax
   40aff:	48 39 45 c8          	cmp    %rax,-0x38(%rbp)
   40b03:	72 5b                	jb     40b60 <exception+0x569>
   40b05:	48 81 7d c8 ff ef 2f 	cmpq   $0x2fefff,-0x38(%rbp)
   40b0c:	00 
   40b0d:	77 51                	ja     40b60 <exception+0x569>
                    - PAGESIZE && phys_mem_avail()) {
   40b0f:	b8 00 00 00 00       	mov    $0x0,%eax
   40b14:	e8 8f fa ff ff       	call   405a8 <phys_mem_avail>
   40b19:	48 85 c0             	test   %rax,%rax
   40b1c:	74 42                	je     40b60 <exception+0x569>
                    addr &= ~(PAGESIZE - 1);
   40b1e:	48 81 65 c8 00 f0 ff 	andq   $0xfffffffffffff000,-0x38(%rbp)
   40b25:	ff 
                    virtual_memory_map(current->p_pagetable, addr,
                                       (uintptr_t)palloc(current->p_pid),
   40b26:	48 8b 05 d3 13 01 00 	mov    0x113d3(%rip),%rax        # 51f00 <current>
   40b2d:	8b 00                	mov    (%rax),%eax
   40b2f:	89 c7                	mov    %eax,%edi
   40b31:	e8 48 2f 00 00       	call   43a7e <palloc>
                    virtual_memory_map(current->p_pagetable, addr,
   40b36:	48 89 c2             	mov    %rax,%rdx
   40b39:	48 8b 05 c0 13 01 00 	mov    0x113c0(%rip),%rax        # 51f00 <current>
   40b40:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   40b47:	48 8b 75 c8          	mov    -0x38(%rbp),%rsi
   40b4b:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   40b51:	b9 00 10 00 00       	mov    $0x1000,%ecx
   40b56:	48 89 c7             	mov    %rax,%rdi
   40b59:	e8 12 1d 00 00       	call   42870 <virtual_memory_map>
                                       PAGESIZE, PTE_P | PTE_W | PTE_U);
                    break;
   40b5e:	eb 24                	jmp    40b84 <exception+0x58d>
                } else {
                    process_free(current->p_pid);
   40b60:	48 8b 05 99 13 01 00 	mov    0x11399(%rip),%rax        # 51f00 <current>
   40b67:	8b 00                	mov    (%rax),%eax
   40b69:	89 c7                	mov    %eax,%edi
   40b6b:	e8 27 30 00 00       	call   43b97 <process_free>
                    break;
   40b70:	eb 12                	jmp    40b84 <exception+0x58d>
                current->p_state = P_BROKEN;
                syscall_exit();
                break;
            }   
        default:
            default_exception(current);
   40b72:	48 8b 05 87 13 01 00 	mov    0x11387(%rip),%rax        # 51f00 <current>
   40b79:	48 89 c7             	mov    %rax,%rdi
   40b7c:	e8 20 1a 00 00       	call   425a1 <default_exception>
            break;                  /* will not be reached */
   40b81:	eb 01                	jmp    40b84 <exception+0x58d>
                break;
   40b83:	90                   	nop

    }
    // Return to the current process (or run something else).
    if (current->p_state == P_RUNNABLE) {
   40b84:	48 8b 05 75 13 01 00 	mov    0x11375(%rip),%rax        # 51f00 <current>
   40b8b:	8b 80 d8 00 00 00    	mov    0xd8(%rax),%eax
   40b91:	83 f8 01             	cmp    $0x1,%eax
   40b94:	75 0f                	jne    40ba5 <exception+0x5ae>
        run(current);
   40b96:	48 8b 05 63 13 01 00 	mov    0x11363(%rip),%rax        # 51f00 <current>
   40b9d:	48 89 c7             	mov    %rax,%rdi
   40ba0:	e8 7a 00 00 00       	call   40c1f <run>
    } else {
        schedule();
   40ba5:	e8 03 00 00 00       	call   40bad <schedule>
    }
}
   40baa:	90                   	nop
   40bab:	c9                   	leave  
   40bac:	c3                   	ret    

0000000000040bad <schedule>:

// schedule
//    Pick the next process to run and then run it.
//    If there are no runnable processes, spins forever.

void schedule(void) {
   40bad:	55                   	push   %rbp
   40bae:	48 89 e5             	mov    %rsp,%rbp
   40bb1:	48 83 ec 10          	sub    $0x10,%rsp
    pid_t pid = current->p_pid;
   40bb5:	48 8b 05 44 13 01 00 	mov    0x11344(%rip),%rax        # 51f00 <current>
   40bbc:	8b 00                	mov    (%rax),%eax
   40bbe:	89 45 fc             	mov    %eax,-0x4(%rbp)
    while (1) {
        pid = (pid + 1) % NPROC;
   40bc1:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40bc4:	83 c0 01             	add    $0x1,%eax
   40bc7:	99                   	cltd   
   40bc8:	c1 ea 1c             	shr    $0x1c,%edx
   40bcb:	01 d0                	add    %edx,%eax
   40bcd:	83 e0 0f             	and    $0xf,%eax
   40bd0:	29 d0                	sub    %edx,%eax
   40bd2:	89 45 fc             	mov    %eax,-0x4(%rbp)
        if (processes[pid].p_state == P_RUNNABLE) {
   40bd5:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40bd8:	48 63 d0             	movslq %eax,%rdx
   40bdb:	48 89 d0             	mov    %rdx,%rax
   40bde:	48 c1 e0 04          	shl    $0x4,%rax
   40be2:	48 29 d0             	sub    %rdx,%rax
   40be5:	48 c1 e0 04          	shl    $0x4,%rax
   40be9:	48 05 d8 10 05 00    	add    $0x510d8,%rax
   40bef:	8b 00                	mov    (%rax),%eax
   40bf1:	83 f8 01             	cmp    $0x1,%eax
   40bf4:	75 22                	jne    40c18 <schedule+0x6b>
            run(&processes[pid]);
   40bf6:	8b 45 fc             	mov    -0x4(%rbp),%eax
   40bf9:	48 63 d0             	movslq %eax,%rdx
   40bfc:	48 89 d0             	mov    %rdx,%rax
   40bff:	48 c1 e0 04          	shl    $0x4,%rax
   40c03:	48 29 d0             	sub    %rdx,%rax
   40c06:	48 c1 e0 04          	shl    $0x4,%rax
   40c0a:	48 05 00 10 05 00    	add    $0x51000,%rax
   40c10:	48 89 c7             	mov    %rax,%rdi
   40c13:	e8 07 00 00 00       	call   40c1f <run>
        }
        // If Control-C was typed, exit the virtual machine.
        check_keyboard();
   40c18:	e8 33 17 00 00       	call   42350 <check_keyboard>
        pid = (pid + 1) % NPROC;
   40c1d:	eb a2                	jmp    40bc1 <schedule+0x14>

0000000000040c1f <run>:
//    Run process `p`. This means reloading all the registers from
//    `p->p_registers` using the `popal`, `popl`, and `iret` instructions.
//
//    As a side effect, sets `current = p`.

void run(proc* p) {
   40c1f:	55                   	push   %rbp
   40c20:	48 89 e5             	mov    %rsp,%rbp
   40c23:	48 83 ec 10          	sub    $0x10,%rsp
   40c27:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    assert(p->p_state == P_RUNNABLE);
   40c2b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40c2f:	8b 80 d8 00 00 00    	mov    0xd8(%rax),%eax
   40c35:	83 f8 01             	cmp    $0x1,%eax
   40c38:	74 14                	je     40c4e <run+0x2f>
   40c3a:	ba d8 47 04 00       	mov    $0x447d8,%edx
   40c3f:	be bf 01 00 00       	mov    $0x1bf,%esi
   40c44:	bf 28 46 04 00       	mov    $0x44628,%edi
   40c49:	e8 23 19 00 00       	call   42571 <assert_fail>
    current = p;
   40c4e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40c52:	48 89 05 a7 12 01 00 	mov    %rax,0x112a7(%rip)        # 51f00 <current>

    // display running process in CONSOLE last value
    console_printf(CPOS(24, 79),
   40c59:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40c5d:	8b 10                	mov    (%rax),%edx
            memstate_colors[p->p_pid - PO_KERNEL], "%d", p->p_pid);
   40c5f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40c63:	8b 00                	mov    (%rax),%eax
   40c65:	83 c0 02             	add    $0x2,%eax
   40c68:	48 98                	cltq   
   40c6a:	0f b7 84 00 c0 45 04 	movzwl 0x445c0(%rax,%rax,1),%eax
   40c71:	00 
    console_printf(CPOS(24, 79),
   40c72:	0f b7 c0             	movzwl %ax,%eax
   40c75:	89 d1                	mov    %edx,%ecx
   40c77:	ba f1 47 04 00       	mov    $0x447f1,%edx
   40c7c:	89 c6                	mov    %eax,%esi
   40c7e:	bf cf 07 00 00       	mov    $0x7cf,%edi
   40c83:	b8 00 00 00 00       	mov    $0x0,%eax
   40c88:	e8 1a 2d 00 00       	call   439a7 <console_printf>

    // Load the process's current pagetable.
    set_pagetable(p->p_pagetable);
   40c8d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40c91:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   40c98:	48 89 c7             	mov    %rax,%rdi
   40c9b:	e8 9f 1a 00 00       	call   4273f <set_pagetable>

    // This function is defined in k-exception.S. It restores the process's
    // registers then jumps back to user mode.
    exception_return(&p->p_registers);
   40ca0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40ca4:	48 83 c0 18          	add    $0x18,%rax
   40ca8:	48 89 c7             	mov    %rax,%rdi
   40cab:	e8 13 f4 ff ff       	call   400c3 <exception_return>

0000000000040cb0 <pageinfo_init>:


// pageinfo_init
//    Initialize the `pageinfo[]` array.

void pageinfo_init(void) {
   40cb0:	55                   	push   %rbp
   40cb1:	48 89 e5             	mov    %rsp,%rbp
   40cb4:	48 83 ec 10          	sub    $0x10,%rsp
    extern char end[];

    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40cb8:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   40cbf:	00 
   40cc0:	e9 81 00 00 00       	jmp    40d46 <pageinfo_init+0x96>
        int owner;
        if (physical_memory_isreserved(addr)) {
   40cc5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40cc9:	48 89 c7             	mov    %rax,%rdi
   40ccc:	e8 13 0f 00 00       	call   41be4 <physical_memory_isreserved>
   40cd1:	85 c0                	test   %eax,%eax
   40cd3:	74 09                	je     40cde <pageinfo_init+0x2e>
            owner = PO_RESERVED;
   40cd5:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%rbp)
   40cdc:	eb 2f                	jmp    40d0d <pageinfo_init+0x5d>
        } else if ((addr >= KERNEL_START_ADDR && addr < (uintptr_t) end)
   40cde:	48 81 7d f8 ff ff 03 	cmpq   $0x3ffff,-0x8(%rbp)
   40ce5:	00 
   40ce6:	76 0b                	jbe    40cf3 <pageinfo_init+0x43>
   40ce8:	b8 10 a0 05 00       	mov    $0x5a010,%eax
   40ced:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40cf1:	72 0a                	jb     40cfd <pageinfo_init+0x4d>
                   || addr == KERNEL_STACK_TOP - PAGESIZE) {
   40cf3:	48 81 7d f8 00 f0 07 	cmpq   $0x7f000,-0x8(%rbp)
   40cfa:	00 
   40cfb:	75 09                	jne    40d06 <pageinfo_init+0x56>
            owner = PO_KERNEL;
   40cfd:	c7 45 f4 fe ff ff ff 	movl   $0xfffffffe,-0xc(%rbp)
   40d04:	eb 07                	jmp    40d0d <pageinfo_init+0x5d>
        } else {
            owner = PO_FREE;
   40d06:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
        }
        pageinfo[PAGENUMBER(addr)].owner = owner;
   40d0d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d11:	48 c1 e8 0c          	shr    $0xc,%rax
   40d15:	89 c1                	mov    %eax,%ecx
   40d17:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40d1a:	89 c2                	mov    %eax,%edx
   40d1c:	48 63 c1             	movslq %ecx,%rax
   40d1f:	88 94 00 20 1f 05 00 	mov    %dl,0x51f20(%rax,%rax,1)
        pageinfo[PAGENUMBER(addr)].refcount = (owner != PO_FREE);
   40d26:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   40d2a:	0f 95 c2             	setne  %dl
   40d2d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40d31:	48 c1 e8 0c          	shr    $0xc,%rax
   40d35:	48 98                	cltq   
   40d37:	88 94 00 21 1f 05 00 	mov    %dl,0x51f21(%rax,%rax,1)
    for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
   40d3e:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40d45:	00 
   40d46:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   40d4d:	00 
   40d4e:	0f 86 71 ff ff ff    	jbe    40cc5 <pageinfo_init+0x15>
    }
}
   40d54:	90                   	nop
   40d55:	90                   	nop
   40d56:	c9                   	leave  
   40d57:	c3                   	ret    

0000000000040d58 <check_page_table_mappings>:

// check_page_table_mappings
//    Check operating system invariants about kernel mappings for page
//    table `pt`. Panic if any of the invariants are false.

void check_page_table_mappings(x86_64_pagetable* pt) {
   40d58:	55                   	push   %rbp
   40d59:	48 89 e5             	mov    %rsp,%rbp
   40d5c:	48 83 ec 50          	sub    $0x50,%rsp
   40d60:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    extern char start_data[], end[];
    assert(PTE_ADDR(pt) == (uintptr_t) pt);
   40d64:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40d68:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   40d6e:	48 89 c2             	mov    %rax,%rdx
   40d71:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   40d75:	48 39 c2             	cmp    %rax,%rdx
   40d78:	74 14                	je     40d8e <check_page_table_mappings+0x36>
   40d7a:	ba f8 47 04 00       	mov    $0x447f8,%edx
   40d7f:	be ed 01 00 00       	mov    $0x1ed,%esi
   40d84:	bf 28 46 04 00       	mov    $0x44628,%edi
   40d89:	e8 e3 17 00 00       	call   42571 <assert_fail>

    // kernel memory is identity mapped; data is writable
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40d8e:	48 c7 45 f8 00 00 04 	movq   $0x40000,-0x8(%rbp)
   40d95:	00 
   40d96:	e9 9a 00 00 00       	jmp    40e35 <check_page_table_mappings+0xdd>
         va += PAGESIZE) {
        vamapping vam = virtual_memory_lookup(pt, va);
   40d9b:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
   40d9f:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   40da3:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40da7:	48 89 ce             	mov    %rcx,%rsi
   40daa:	48 89 c7             	mov    %rax,%rdi
   40dad:	e8 81 1e 00 00       	call   42c33 <virtual_memory_lookup>
        if (vam.pa != va) {
   40db2:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40db6:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40dba:	74 27                	je     40de3 <check_page_table_mappings+0x8b>
            console_printf(CPOS(22, 0), 0xC000, "%p vs %p\n", va, vam.pa);
   40dbc:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   40dc0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   40dc4:	49 89 d0             	mov    %rdx,%r8
   40dc7:	48 89 c1             	mov    %rax,%rcx
   40dca:	ba 17 48 04 00       	mov    $0x44817,%edx
   40dcf:	be 00 c0 00 00       	mov    $0xc000,%esi
   40dd4:	bf e0 06 00 00       	mov    $0x6e0,%edi
   40dd9:	b8 00 00 00 00       	mov    $0x0,%eax
   40dde:	e8 c4 2b 00 00       	call   439a7 <console_printf>
        }
        assert(vam.pa == va);
   40de3:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   40de7:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40deb:	74 14                	je     40e01 <check_page_table_mappings+0xa9>
   40ded:	ba 21 48 04 00       	mov    $0x44821,%edx
   40df2:	be f6 01 00 00       	mov    $0x1f6,%esi
   40df7:	bf 28 46 04 00       	mov    $0x44628,%edi
   40dfc:	e8 70 17 00 00       	call   42571 <assert_fail>
        if (va >= (uintptr_t) start_data) {
   40e01:	b8 00 60 04 00       	mov    $0x46000,%eax
   40e06:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40e0a:	72 21                	jb     40e2d <check_page_table_mappings+0xd5>
            assert(vam.perm & PTE_W);
   40e0c:	8b 45 d0             	mov    -0x30(%rbp),%eax
   40e0f:	48 98                	cltq   
   40e11:	83 e0 02             	and    $0x2,%eax
   40e14:	48 85 c0             	test   %rax,%rax
   40e17:	75 14                	jne    40e2d <check_page_table_mappings+0xd5>
   40e19:	ba 2e 48 04 00       	mov    $0x4482e,%edx
   40e1e:	be f8 01 00 00       	mov    $0x1f8,%esi
   40e23:	bf 28 46 04 00       	mov    $0x44628,%edi
   40e28:	e8 44 17 00 00       	call   42571 <assert_fail>
         va += PAGESIZE) {
   40e2d:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   40e34:	00 
    for (uintptr_t va = KERNEL_START_ADDR; va < (uintptr_t) end;
   40e35:	b8 10 a0 05 00       	mov    $0x5a010,%eax
   40e3a:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   40e3e:	0f 82 57 ff ff ff    	jb     40d9b <check_page_table_mappings+0x43>
        }
    }

    // kernel stack is identity mapped and writable
    uintptr_t kstack = KERNEL_STACK_TOP - PAGESIZE;
   40e44:	48 c7 45 f0 00 f0 07 	movq   $0x7f000,-0x10(%rbp)
   40e4b:	00 
    vamapping vam = virtual_memory_lookup(pt, kstack);
   40e4c:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
   40e50:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   40e54:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   40e58:	48 89 ce             	mov    %rcx,%rsi
   40e5b:	48 89 c7             	mov    %rax,%rdi
   40e5e:	e8 d0 1d 00 00       	call   42c33 <virtual_memory_lookup>
    assert(vam.pa == kstack);
   40e63:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   40e67:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
   40e6b:	74 14                	je     40e81 <check_page_table_mappings+0x129>
   40e6d:	ba 3f 48 04 00       	mov    $0x4483f,%edx
   40e72:	be ff 01 00 00       	mov    $0x1ff,%esi
   40e77:	bf 28 46 04 00       	mov    $0x44628,%edi
   40e7c:	e8 f0 16 00 00       	call   42571 <assert_fail>
    assert(vam.perm & PTE_W);
   40e81:	8b 45 e8             	mov    -0x18(%rbp),%eax
   40e84:	48 98                	cltq   
   40e86:	83 e0 02             	and    $0x2,%eax
   40e89:	48 85 c0             	test   %rax,%rax
   40e8c:	75 14                	jne    40ea2 <check_page_table_mappings+0x14a>
   40e8e:	ba 2e 48 04 00       	mov    $0x4482e,%edx
   40e93:	be 00 02 00 00       	mov    $0x200,%esi
   40e98:	bf 28 46 04 00       	mov    $0x44628,%edi
   40e9d:	e8 cf 16 00 00       	call   42571 <assert_fail>
}
   40ea2:	90                   	nop
   40ea3:	c9                   	leave  
   40ea4:	c3                   	ret    

0000000000040ea5 <check_page_table_ownership>:
//    counts for page table `pt`. Panic if any of the invariants are false.

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount);

void check_page_table_ownership(x86_64_pagetable* pt, pid_t pid) {
   40ea5:	55                   	push   %rbp
   40ea6:	48 89 e5             	mov    %rsp,%rbp
   40ea9:	48 83 ec 20          	sub    $0x20,%rsp
   40ead:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   40eb1:	89 75 e4             	mov    %esi,-0x1c(%rbp)
    // calculate expected reference count for page tables
    int owner = pid;
   40eb4:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   40eb7:	89 45 fc             	mov    %eax,-0x4(%rbp)
    int expected_refcount = 1;
   40eba:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    if (pt == kernel_pagetable) {
   40ec1:	48 8b 05 38 31 01 00 	mov    0x13138(%rip),%rax        # 54000 <kernel_pagetable>
   40ec8:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
   40ecc:	75 67                	jne    40f35 <check_page_table_ownership+0x90>
        owner = PO_KERNEL;
   40ece:	c7 45 fc fe ff ff ff 	movl   $0xfffffffe,-0x4(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   40ed5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   40edc:	eb 51                	jmp    40f2f <check_page_table_ownership+0x8a>
            if (processes[xpid].p_state != P_FREE
   40ede:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40ee1:	48 63 d0             	movslq %eax,%rdx
   40ee4:	48 89 d0             	mov    %rdx,%rax
   40ee7:	48 c1 e0 04          	shl    $0x4,%rax
   40eeb:	48 29 d0             	sub    %rdx,%rax
   40eee:	48 c1 e0 04          	shl    $0x4,%rax
   40ef2:	48 05 d8 10 05 00    	add    $0x510d8,%rax
   40ef8:	8b 00                	mov    (%rax),%eax
   40efa:	85 c0                	test   %eax,%eax
   40efc:	74 2d                	je     40f2b <check_page_table_ownership+0x86>
                && processes[xpid].p_pagetable == kernel_pagetable) {
   40efe:	8b 45 f4             	mov    -0xc(%rbp),%eax
   40f01:	48 63 d0             	movslq %eax,%rdx
   40f04:	48 89 d0             	mov    %rdx,%rax
   40f07:	48 c1 e0 04          	shl    $0x4,%rax
   40f0b:	48 29 d0             	sub    %rdx,%rax
   40f0e:	48 c1 e0 04          	shl    $0x4,%rax
   40f12:	48 05 e0 10 05 00    	add    $0x510e0,%rax
   40f18:	48 8b 10             	mov    (%rax),%rdx
   40f1b:	48 8b 05 de 30 01 00 	mov    0x130de(%rip),%rax        # 54000 <kernel_pagetable>
   40f22:	48 39 c2             	cmp    %rax,%rdx
   40f25:	75 04                	jne    40f2b <check_page_table_ownership+0x86>
                ++expected_refcount;
   40f27:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
        for (int xpid = 0; xpid < NPROC; ++xpid) {
   40f2b:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   40f2f:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
   40f33:	7e a9                	jle    40ede <check_page_table_ownership+0x39>
            }
        }
    }
    check_page_table_ownership_level(pt, 0, owner, expected_refcount);
   40f35:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   40f38:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40f3b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40f3f:	be 00 00 00 00       	mov    $0x0,%esi
   40f44:	48 89 c7             	mov    %rax,%rdi
   40f47:	e8 03 00 00 00       	call   40f4f <check_page_table_ownership_level>
}
   40f4c:	90                   	nop
   40f4d:	c9                   	leave  
   40f4e:	c3                   	ret    

0000000000040f4f <check_page_table_ownership_level>:

static void check_page_table_ownership_level(x86_64_pagetable* pt, int level,
                                             int owner, int refcount) {
   40f4f:	55                   	push   %rbp
   40f50:	48 89 e5             	mov    %rsp,%rbp
   40f53:	48 83 ec 30          	sub    $0x30,%rsp
   40f57:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   40f5b:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   40f5e:	89 55 e0             	mov    %edx,-0x20(%rbp)
   40f61:	89 4d dc             	mov    %ecx,-0x24(%rbp)
    assert(PAGENUMBER(pt) < NPAGES);
   40f64:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40f68:	48 c1 e8 0c          	shr    $0xc,%rax
   40f6c:	3d ff 01 00 00       	cmp    $0x1ff,%eax
   40f71:	7e 14                	jle    40f87 <check_page_table_ownership_level+0x38>
   40f73:	ba 50 48 04 00       	mov    $0x44850,%edx
   40f78:	be 1d 02 00 00       	mov    $0x21d,%esi
   40f7d:	bf 28 46 04 00       	mov    $0x44628,%edi
   40f82:	e8 ea 15 00 00       	call   42571 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].owner == owner);
   40f87:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40f8b:	48 c1 e8 0c          	shr    $0xc,%rax
   40f8f:	48 98                	cltq   
   40f91:	0f b6 84 00 20 1f 05 	movzbl 0x51f20(%rax,%rax,1),%eax
   40f98:	00 
   40f99:	0f be c0             	movsbl %al,%eax
   40f9c:	39 45 e0             	cmp    %eax,-0x20(%rbp)
   40f9f:	74 14                	je     40fb5 <check_page_table_ownership_level+0x66>
   40fa1:	ba 68 48 04 00       	mov    $0x44868,%edx
   40fa6:	be 1e 02 00 00       	mov    $0x21e,%esi
   40fab:	bf 28 46 04 00       	mov    $0x44628,%edi
   40fb0:	e8 bc 15 00 00       	call   42571 <assert_fail>
    assert(pageinfo[PAGENUMBER(pt)].refcount == refcount);
   40fb5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40fb9:	48 c1 e8 0c          	shr    $0xc,%rax
   40fbd:	48 98                	cltq   
   40fbf:	0f b6 84 00 21 1f 05 	movzbl 0x51f21(%rax,%rax,1),%eax
   40fc6:	00 
   40fc7:	0f be c0             	movsbl %al,%eax
   40fca:	39 45 dc             	cmp    %eax,-0x24(%rbp)
   40fcd:	74 14                	je     40fe3 <check_page_table_ownership_level+0x94>
   40fcf:	ba 90 48 04 00       	mov    $0x44890,%edx
   40fd4:	be 1f 02 00 00       	mov    $0x21f,%esi
   40fd9:	bf 28 46 04 00       	mov    $0x44628,%edi
   40fde:	e8 8e 15 00 00       	call   42571 <assert_fail>
    if (level < 3) {
   40fe3:	83 7d e4 02          	cmpl   $0x2,-0x1c(%rbp)
   40fe7:	7f 5b                	jg     41044 <check_page_table_ownership_level+0xf5>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   40fe9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   40ff0:	eb 49                	jmp    4103b <check_page_table_ownership_level+0xec>
            if (pt->entry[index]) {
   40ff2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   40ff6:	8b 55 fc             	mov    -0x4(%rbp),%edx
   40ff9:	48 63 d2             	movslq %edx,%rdx
   40ffc:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   41000:	48 85 c0             	test   %rax,%rax
   41003:	74 32                	je     41037 <check_page_table_ownership_level+0xe8>
                x86_64_pagetable* nextpt =
                    (x86_64_pagetable*) PTE_ADDR(pt->entry[index]);
   41005:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   41009:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4100c:	48 63 d2             	movslq %edx,%rdx
   4100f:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   41013:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
                x86_64_pagetable* nextpt =
   41019:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
                check_page_table_ownership_level(nextpt, level + 1, owner, 1);
   4101d:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   41020:	8d 70 01             	lea    0x1(%rax),%esi
   41023:	8b 55 e0             	mov    -0x20(%rbp),%edx
   41026:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4102a:	b9 01 00 00 00       	mov    $0x1,%ecx
   4102f:	48 89 c7             	mov    %rax,%rdi
   41032:	e8 18 ff ff ff       	call   40f4f <check_page_table_ownership_level>
        for (int index = 0; index < NPAGETABLEENTRIES; ++index) {
   41037:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   4103b:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   41042:	7e ae                	jle    40ff2 <check_page_table_ownership_level+0xa3>
            }
        }
    }
}
   41044:	90                   	nop
   41045:	c9                   	leave  
   41046:	c3                   	ret    

0000000000041047 <check_virtual_memory>:

// check_virtual_memory
//    Check operating system invariants about virtual memory. Panic if any
//    of the invariants are false.

void check_virtual_memory(void) {
   41047:	55                   	push   %rbp
   41048:	48 89 e5             	mov    %rsp,%rbp
   4104b:	48 83 ec 10          	sub    $0x10,%rsp
    // Process 0 must never be used.
    assert(processes[0].p_state == P_FREE);
   4104f:	8b 05 83 00 01 00    	mov    0x10083(%rip),%eax        # 510d8 <processes+0xd8>
   41055:	85 c0                	test   %eax,%eax
   41057:	74 14                	je     4106d <check_virtual_memory+0x26>
   41059:	ba c0 48 04 00       	mov    $0x448c0,%edx
   4105e:	be 32 02 00 00       	mov    $0x232,%esi
   41063:	bf 28 46 04 00       	mov    $0x44628,%edi
   41068:	e8 04 15 00 00       	call   42571 <assert_fail>
    // that don't have their own page tables.
    // Active processes have their own page tables. A process page table
    // should be owned by that process and have reference count 1.
    // All level-2-4 page tables must have reference count 1.

    check_page_table_mappings(kernel_pagetable);
   4106d:	48 8b 05 8c 2f 01 00 	mov    0x12f8c(%rip),%rax        # 54000 <kernel_pagetable>
   41074:	48 89 c7             	mov    %rax,%rdi
   41077:	e8 dc fc ff ff       	call   40d58 <check_page_table_mappings>
    check_page_table_ownership(kernel_pagetable, -1);
   4107c:	48 8b 05 7d 2f 01 00 	mov    0x12f7d(%rip),%rax        # 54000 <kernel_pagetable>
   41083:	be ff ff ff ff       	mov    $0xffffffff,%esi
   41088:	48 89 c7             	mov    %rax,%rdi
   4108b:	e8 15 fe ff ff       	call   40ea5 <check_page_table_ownership>

    for (int pid = 0; pid < NPROC; ++pid) {
   41090:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41097:	e9 9c 00 00 00       	jmp    41138 <check_virtual_memory+0xf1>
        if (processes[pid].p_state != P_FREE
   4109c:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4109f:	48 63 d0             	movslq %eax,%rdx
   410a2:	48 89 d0             	mov    %rdx,%rax
   410a5:	48 c1 e0 04          	shl    $0x4,%rax
   410a9:	48 29 d0             	sub    %rdx,%rax
   410ac:	48 c1 e0 04          	shl    $0x4,%rax
   410b0:	48 05 d8 10 05 00    	add    $0x510d8,%rax
   410b6:	8b 00                	mov    (%rax),%eax
   410b8:	85 c0                	test   %eax,%eax
   410ba:	74 78                	je     41134 <check_virtual_memory+0xed>
            && processes[pid].p_pagetable != kernel_pagetable) {
   410bc:	8b 45 fc             	mov    -0x4(%rbp),%eax
   410bf:	48 63 d0             	movslq %eax,%rdx
   410c2:	48 89 d0             	mov    %rdx,%rax
   410c5:	48 c1 e0 04          	shl    $0x4,%rax
   410c9:	48 29 d0             	sub    %rdx,%rax
   410cc:	48 c1 e0 04          	shl    $0x4,%rax
   410d0:	48 05 e0 10 05 00    	add    $0x510e0,%rax
   410d6:	48 8b 10             	mov    (%rax),%rdx
   410d9:	48 8b 05 20 2f 01 00 	mov    0x12f20(%rip),%rax        # 54000 <kernel_pagetable>
   410e0:	48 39 c2             	cmp    %rax,%rdx
   410e3:	74 4f                	je     41134 <check_virtual_memory+0xed>
            check_page_table_mappings(processes[pid].p_pagetable);
   410e5:	8b 45 fc             	mov    -0x4(%rbp),%eax
   410e8:	48 63 d0             	movslq %eax,%rdx
   410eb:	48 89 d0             	mov    %rdx,%rax
   410ee:	48 c1 e0 04          	shl    $0x4,%rax
   410f2:	48 29 d0             	sub    %rdx,%rax
   410f5:	48 c1 e0 04          	shl    $0x4,%rax
   410f9:	48 05 e0 10 05 00    	add    $0x510e0,%rax
   410ff:	48 8b 00             	mov    (%rax),%rax
   41102:	48 89 c7             	mov    %rax,%rdi
   41105:	e8 4e fc ff ff       	call   40d58 <check_page_table_mappings>
            check_page_table_ownership(processes[pid].p_pagetable, pid);
   4110a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4110d:	48 63 d0             	movslq %eax,%rdx
   41110:	48 89 d0             	mov    %rdx,%rax
   41113:	48 c1 e0 04          	shl    $0x4,%rax
   41117:	48 29 d0             	sub    %rdx,%rax
   4111a:	48 c1 e0 04          	shl    $0x4,%rax
   4111e:	48 05 e0 10 05 00    	add    $0x510e0,%rax
   41124:	48 8b 00             	mov    (%rax),%rax
   41127:	8b 55 fc             	mov    -0x4(%rbp),%edx
   4112a:	89 d6                	mov    %edx,%esi
   4112c:	48 89 c7             	mov    %rax,%rdi
   4112f:	e8 71 fd ff ff       	call   40ea5 <check_page_table_ownership>
    for (int pid = 0; pid < NPROC; ++pid) {
   41134:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41138:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   4113c:	0f 8e 5a ff ff ff    	jle    4109c <check_virtual_memory+0x55>
        }
    }

    // Check that all referenced pages refer to active processes
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   41142:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   41149:	eb 67                	jmp    411b2 <check_virtual_memory+0x16b>
        if (pageinfo[pn].refcount > 0 && pageinfo[pn].owner >= 0) {
   4114b:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4114e:	48 98                	cltq   
   41150:	0f b6 84 00 21 1f 05 	movzbl 0x51f21(%rax,%rax,1),%eax
   41157:	00 
   41158:	84 c0                	test   %al,%al
   4115a:	7e 52                	jle    411ae <check_virtual_memory+0x167>
   4115c:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4115f:	48 98                	cltq   
   41161:	0f b6 84 00 20 1f 05 	movzbl 0x51f20(%rax,%rax,1),%eax
   41168:	00 
   41169:	84 c0                	test   %al,%al
   4116b:	78 41                	js     411ae <check_virtual_memory+0x167>
            assert(processes[pageinfo[pn].owner].p_state != P_FREE);
   4116d:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41170:	48 98                	cltq   
   41172:	0f b6 84 00 20 1f 05 	movzbl 0x51f20(%rax,%rax,1),%eax
   41179:	00 
   4117a:	0f be c0             	movsbl %al,%eax
   4117d:	48 63 d0             	movslq %eax,%rdx
   41180:	48 89 d0             	mov    %rdx,%rax
   41183:	48 c1 e0 04          	shl    $0x4,%rax
   41187:	48 29 d0             	sub    %rdx,%rax
   4118a:	48 c1 e0 04          	shl    $0x4,%rax
   4118e:	48 05 d8 10 05 00    	add    $0x510d8,%rax
   41194:	8b 00                	mov    (%rax),%eax
   41196:	85 c0                	test   %eax,%eax
   41198:	75 14                	jne    411ae <check_virtual_memory+0x167>
   4119a:	ba e0 48 04 00       	mov    $0x448e0,%edx
   4119f:	be 49 02 00 00       	mov    $0x249,%esi
   411a4:	bf 28 46 04 00       	mov    $0x44628,%edi
   411a9:	e8 c3 13 00 00       	call   42571 <assert_fail>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   411ae:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   411b2:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
   411b9:	7e 90                	jle    4114b <check_virtual_memory+0x104>
        }
    }
}
   411bb:	90                   	nop
   411bc:	90                   	nop
   411bd:	c9                   	leave  
   411be:	c3                   	ret    

00000000000411bf <memshow_physical>:
    'E' | 0x0E00, 'F' | 0x0F00, 'S'
};
#define SHARED_COLOR memstate_colors[18]
#define SHARED

void memshow_physical(void) {
   411bf:	55                   	push   %rbp
   411c0:	48 89 e5             	mov    %rsp,%rbp
   411c3:	48 83 ec 10          	sub    $0x10,%rsp
    console_printf(CPOS(0, 32), 0x0F00, "PHYSICAL MEMORY");
   411c7:	ba 10 49 04 00       	mov    $0x44910,%edx
   411cc:	be 00 0f 00 00       	mov    $0xf00,%esi
   411d1:	bf 20 00 00 00       	mov    $0x20,%edi
   411d6:	b8 00 00 00 00       	mov    $0x0,%eax
   411db:	e8 c7 27 00 00       	call   439a7 <console_printf>
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   411e0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   411e7:	e9 f4 00 00 00       	jmp    412e0 <memshow_physical+0x121>
        if (pn % 64 == 0) {
   411ec:	8b 45 fc             	mov    -0x4(%rbp),%eax
   411ef:	83 e0 3f             	and    $0x3f,%eax
   411f2:	85 c0                	test   %eax,%eax
   411f4:	75 3e                	jne    41234 <memshow_physical+0x75>
            console_printf(CPOS(1 + pn / 64, 3), 0x0F00, "0x%06X ", pn << 12);
   411f6:	8b 45 fc             	mov    -0x4(%rbp),%eax
   411f9:	c1 e0 0c             	shl    $0xc,%eax
   411fc:	89 c2                	mov    %eax,%edx
   411fe:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41201:	8d 48 3f             	lea    0x3f(%rax),%ecx
   41204:	85 c0                	test   %eax,%eax
   41206:	0f 48 c1             	cmovs  %ecx,%eax
   41209:	c1 f8 06             	sar    $0x6,%eax
   4120c:	8d 48 01             	lea    0x1(%rax),%ecx
   4120f:	89 c8                	mov    %ecx,%eax
   41211:	c1 e0 02             	shl    $0x2,%eax
   41214:	01 c8                	add    %ecx,%eax
   41216:	c1 e0 04             	shl    $0x4,%eax
   41219:	83 c0 03             	add    $0x3,%eax
   4121c:	89 d1                	mov    %edx,%ecx
   4121e:	ba 20 49 04 00       	mov    $0x44920,%edx
   41223:	be 00 0f 00 00       	mov    $0xf00,%esi
   41228:	89 c7                	mov    %eax,%edi
   4122a:	b8 00 00 00 00       	mov    $0x0,%eax
   4122f:	e8 73 27 00 00       	call   439a7 <console_printf>
        }

        int owner = pageinfo[pn].owner;
   41234:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41237:	48 98                	cltq   
   41239:	0f b6 84 00 20 1f 05 	movzbl 0x51f20(%rax,%rax,1),%eax
   41240:	00 
   41241:	0f be c0             	movsbl %al,%eax
   41244:	89 45 f8             	mov    %eax,-0x8(%rbp)
        if (pageinfo[pn].refcount == 0) {
   41247:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4124a:	48 98                	cltq   
   4124c:	0f b6 84 00 21 1f 05 	movzbl 0x51f21(%rax,%rax,1),%eax
   41253:	00 
   41254:	84 c0                	test   %al,%al
   41256:	75 07                	jne    4125f <memshow_physical+0xa0>
            owner = PO_FREE;
   41258:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
        }
        uint16_t color = memstate_colors[owner - PO_KERNEL];
   4125f:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41262:	83 c0 02             	add    $0x2,%eax
   41265:	48 98                	cltq   
   41267:	0f b7 84 00 c0 45 04 	movzwl 0x445c0(%rax,%rax,1),%eax
   4126e:	00 
   4126f:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
        // darker color for shared pages
        if (pageinfo[pn].refcount > 1 && pn != PAGENUMBER(CONSOLE_ADDR)){
   41273:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41276:	48 98                	cltq   
   41278:	0f b6 84 00 21 1f 05 	movzbl 0x51f21(%rax,%rax,1),%eax
   4127f:	00 
   41280:	3c 01                	cmp    $0x1,%al
   41282:	7e 1a                	jle    4129e <memshow_physical+0xdf>
   41284:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   41289:	48 c1 e8 0c          	shr    $0xc,%rax
   4128d:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   41290:	74 0c                	je     4129e <memshow_physical+0xdf>
#ifdef SHARED
            color = SHARED_COLOR | 0x0F00;
   41292:	b8 53 00 00 00       	mov    $0x53,%eax
   41297:	80 cc 0f             	or     $0xf,%ah
   4129a:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
#else
	    color &= 0x77FF;
#endif
        }

        console[CPOS(1 + pn / 64, 12 + pn % 64)] = color;
   4129e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   412a1:	8d 50 3f             	lea    0x3f(%rax),%edx
   412a4:	85 c0                	test   %eax,%eax
   412a6:	0f 48 c2             	cmovs  %edx,%eax
   412a9:	c1 f8 06             	sar    $0x6,%eax
   412ac:	8d 50 01             	lea    0x1(%rax),%edx
   412af:	89 d0                	mov    %edx,%eax
   412b1:	c1 e0 02             	shl    $0x2,%eax
   412b4:	01 d0                	add    %edx,%eax
   412b6:	c1 e0 04             	shl    $0x4,%eax
   412b9:	89 c1                	mov    %eax,%ecx
   412bb:	8b 45 fc             	mov    -0x4(%rbp),%eax
   412be:	99                   	cltd   
   412bf:	c1 ea 1a             	shr    $0x1a,%edx
   412c2:	01 d0                	add    %edx,%eax
   412c4:	83 e0 3f             	and    $0x3f,%eax
   412c7:	29 d0                	sub    %edx,%eax
   412c9:	83 c0 0c             	add    $0xc,%eax
   412cc:	01 c8                	add    %ecx,%eax
   412ce:	48 98                	cltq   
   412d0:	0f b7 55 f6          	movzwl -0xa(%rbp),%edx
   412d4:	66 89 94 00 00 80 0b 	mov    %dx,0xb8000(%rax,%rax,1)
   412db:	00 
    for (int pn = 0; pn < PAGENUMBER(MEMSIZE_PHYSICAL); ++pn) {
   412dc:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   412e0:	81 7d fc ff 01 00 00 	cmpl   $0x1ff,-0x4(%rbp)
   412e7:	0f 8e ff fe ff ff    	jle    411ec <memshow_physical+0x2d>
    }
}
   412ed:	90                   	nop
   412ee:	90                   	nop
   412ef:	c9                   	leave  
   412f0:	c3                   	ret    

00000000000412f1 <memshow_virtual>:

// memshow_virtual(pagetable, name)
//    Draw a picture of the virtual memory map `pagetable` (named `name`) on
//    the CGA console.

void memshow_virtual(x86_64_pagetable* pagetable, const char* name) {
   412f1:	55                   	push   %rbp
   412f2:	48 89 e5             	mov    %rsp,%rbp
   412f5:	48 83 ec 40          	sub    $0x40,%rsp
   412f9:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   412fd:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
    assert((uintptr_t) pagetable == PTE_ADDR(pagetable));
   41301:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41305:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   4130b:	48 89 c2             	mov    %rax,%rdx
   4130e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   41312:	48 39 c2             	cmp    %rax,%rdx
   41315:	74 14                	je     4132b <memshow_virtual+0x3a>
   41317:	ba 28 49 04 00       	mov    $0x44928,%edx
   4131c:	be 7a 02 00 00       	mov    $0x27a,%esi
   41321:	bf 28 46 04 00       	mov    $0x44628,%edi
   41326:	e8 46 12 00 00       	call   42571 <assert_fail>

    console_printf(CPOS(10, 26), 0x0F00, "VIRTUAL ADDRESS SPACE FOR %s", name);
   4132b:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   4132f:	48 89 c1             	mov    %rax,%rcx
   41332:	ba 55 49 04 00       	mov    $0x44955,%edx
   41337:	be 00 0f 00 00       	mov    $0xf00,%esi
   4133c:	bf 3a 03 00 00       	mov    $0x33a,%edi
   41341:	b8 00 00 00 00       	mov    $0x0,%eax
   41346:	e8 5c 26 00 00       	call   439a7 <console_printf>
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   4134b:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   41352:	00 
   41353:	e9 80 01 00 00       	jmp    414d8 <memshow_virtual+0x1e7>
        vamapping vam = virtual_memory_lookup(pagetable, va);
   41358:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4135c:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   41360:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   41364:	48 89 ce             	mov    %rcx,%rsi
   41367:	48 89 c7             	mov    %rax,%rdi
   4136a:	e8 c4 18 00 00       	call   42c33 <virtual_memory_lookup>
        uint16_t color;
        if (vam.pn < 0) {
   4136f:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41372:	85 c0                	test   %eax,%eax
   41374:	79 0b                	jns    41381 <memshow_virtual+0x90>
            color = ' ';
   41376:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%rbp)
   4137c:	e9 d7 00 00 00       	jmp    41458 <memshow_virtual+0x167>
        } else {
            assert(vam.pa < MEMSIZE_PHYSICAL);
   41381:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   41385:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   4138b:	76 14                	jbe    413a1 <memshow_virtual+0xb0>
   4138d:	ba 72 49 04 00       	mov    $0x44972,%edx
   41392:	be 83 02 00 00       	mov    $0x283,%esi
   41397:	bf 28 46 04 00       	mov    $0x44628,%edi
   4139c:	e8 d0 11 00 00       	call   42571 <assert_fail>
            int owner = pageinfo[vam.pn].owner;
   413a1:	8b 45 d0             	mov    -0x30(%rbp),%eax
   413a4:	48 98                	cltq   
   413a6:	0f b6 84 00 20 1f 05 	movzbl 0x51f20(%rax,%rax,1),%eax
   413ad:	00 
   413ae:	0f be c0             	movsbl %al,%eax
   413b1:	89 45 f0             	mov    %eax,-0x10(%rbp)
            if (pageinfo[vam.pn].refcount == 0) {
   413b4:	8b 45 d0             	mov    -0x30(%rbp),%eax
   413b7:	48 98                	cltq   
   413b9:	0f b6 84 00 21 1f 05 	movzbl 0x51f21(%rax,%rax,1),%eax
   413c0:	00 
   413c1:	84 c0                	test   %al,%al
   413c3:	75 07                	jne    413cc <memshow_virtual+0xdb>
                owner = PO_FREE;
   413c5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
            }
            color = memstate_colors[owner - PO_KERNEL];
   413cc:	8b 45 f0             	mov    -0x10(%rbp),%eax
   413cf:	83 c0 02             	add    $0x2,%eax
   413d2:	48 98                	cltq   
   413d4:	0f b7 84 00 c0 45 04 	movzwl 0x445c0(%rax,%rax,1),%eax
   413db:	00 
   413dc:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            // reverse video for user-accessible pages
            if (vam.perm & PTE_U) {
   413e0:	8b 45 e0             	mov    -0x20(%rbp),%eax
   413e3:	48 98                	cltq   
   413e5:	83 e0 04             	and    $0x4,%eax
   413e8:	48 85 c0             	test   %rax,%rax
   413eb:	74 27                	je     41414 <memshow_virtual+0x123>
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   413ed:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   413f1:	c1 e0 04             	shl    $0x4,%eax
   413f4:	66 25 00 f0          	and    $0xf000,%ax
   413f8:	89 c2                	mov    %eax,%edx
   413fa:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   413fe:	c1 f8 04             	sar    $0x4,%eax
   41401:	66 25 00 0f          	and    $0xf00,%ax
   41405:	09 c2                	or     %eax,%edx
                    | (color & 0x00FF);
   41407:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   4140b:	0f b6 c0             	movzbl %al,%eax
   4140e:	09 d0                	or     %edx,%eax
                color = ((color & 0x0F00) << 4) | ((color & 0xF000) >> 4)
   41410:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
            }
            // darker color for shared pages
            if (pageinfo[vam.pn].refcount > 1 && va != CONSOLE_ADDR) {
   41414:	8b 45 d0             	mov    -0x30(%rbp),%eax
   41417:	48 98                	cltq   
   41419:	0f b6 84 00 21 1f 05 	movzbl 0x51f21(%rax,%rax,1),%eax
   41420:	00 
   41421:	3c 01                	cmp    $0x1,%al
   41423:	7e 33                	jle    41458 <memshow_virtual+0x167>
   41425:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   4142a:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   4142e:	74 28                	je     41458 <memshow_virtual+0x167>
#ifdef SHARED
                color = (SHARED_COLOR | (color & 0xF000));
   41430:	b8 53 00 00 00       	mov    $0x53,%eax
   41435:	89 c2                	mov    %eax,%edx
   41437:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   4143b:	66 25 00 f0          	and    $0xf000,%ax
   4143f:	09 d0                	or     %edx,%eax
   41441:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
                if(! (vam.perm & PTE_U))
   41445:	8b 45 e0             	mov    -0x20(%rbp),%eax
   41448:	48 98                	cltq   
   4144a:	83 e0 04             	and    $0x4,%eax
   4144d:	48 85 c0             	test   %rax,%rax
   41450:	75 06                	jne    41458 <memshow_virtual+0x167>
                    color = color | 0x0F00;
   41452:	66 81 4d f6 00 0f    	orw    $0xf00,-0xa(%rbp)
#else
		color &= 0x77FF;
#endif
            }
        }
        uint32_t pn = PAGENUMBER(va);
   41458:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4145c:	48 c1 e8 0c          	shr    $0xc,%rax
   41460:	89 45 ec             	mov    %eax,-0x14(%rbp)
        if (pn % 64 == 0) {
   41463:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41466:	83 e0 3f             	and    $0x3f,%eax
   41469:	85 c0                	test   %eax,%eax
   4146b:	75 34                	jne    414a1 <memshow_virtual+0x1b0>
            console_printf(CPOS(11 + pn / 64, 3), 0x0F00, "0x%06X ", va);
   4146d:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41470:	c1 e8 06             	shr    $0x6,%eax
   41473:	89 c2                	mov    %eax,%edx
   41475:	89 d0                	mov    %edx,%eax
   41477:	c1 e0 02             	shl    $0x2,%eax
   4147a:	01 d0                	add    %edx,%eax
   4147c:	c1 e0 04             	shl    $0x4,%eax
   4147f:	05 73 03 00 00       	add    $0x373,%eax
   41484:	89 c7                	mov    %eax,%edi
   41486:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4148a:	48 89 c1             	mov    %rax,%rcx
   4148d:	ba 20 49 04 00       	mov    $0x44920,%edx
   41492:	be 00 0f 00 00       	mov    $0xf00,%esi
   41497:	b8 00 00 00 00       	mov    $0x0,%eax
   4149c:	e8 06 25 00 00       	call   439a7 <console_printf>
        }
        console[CPOS(11 + pn / 64, 12 + pn % 64)] = color;
   414a1:	8b 45 ec             	mov    -0x14(%rbp),%eax
   414a4:	c1 e8 06             	shr    $0x6,%eax
   414a7:	89 c2                	mov    %eax,%edx
   414a9:	89 d0                	mov    %edx,%eax
   414ab:	c1 e0 02             	shl    $0x2,%eax
   414ae:	01 d0                	add    %edx,%eax
   414b0:	c1 e0 04             	shl    $0x4,%eax
   414b3:	89 c2                	mov    %eax,%edx
   414b5:	8b 45 ec             	mov    -0x14(%rbp),%eax
   414b8:	83 e0 3f             	and    $0x3f,%eax
   414bb:	01 d0                	add    %edx,%eax
   414bd:	05 7c 03 00 00       	add    $0x37c,%eax
   414c2:	89 c2                	mov    %eax,%edx
   414c4:	0f b7 45 f6          	movzwl -0xa(%rbp),%eax
   414c8:	66 89 84 12 00 80 0b 	mov    %ax,0xb8000(%rdx,%rdx,1)
   414cf:	00 
    for (uintptr_t va = 0; va < MEMSIZE_VIRTUAL; va += PAGESIZE) {
   414d0:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   414d7:	00 
   414d8:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   414df:	00 
   414e0:	0f 86 72 fe ff ff    	jbe    41358 <memshow_virtual+0x67>
    }
}
   414e6:	90                   	nop
   414e7:	90                   	nop
   414e8:	c9                   	leave  
   414e9:	c3                   	ret    

00000000000414ea <memshow_virtual_animate>:

// memshow_virtual_animate
//    Draw a picture of process virtual memory maps on the CGA console.
//    Starts with process 1, then switches to a new process every 0.25 sec.

void memshow_virtual_animate(void) {
   414ea:	55                   	push   %rbp
   414eb:	48 89 e5             	mov    %rsp,%rbp
   414ee:	48 83 ec 10          	sub    $0x10,%rsp
    static unsigned last_ticks = 0;
    static int showing = 1;

    // switch to a new process every 0.25 sec
    if (last_ticks == 0 || ticks - last_ticks >= HZ / 2) {
   414f2:	8b 05 2c 0e 01 00    	mov    0x10e2c(%rip),%eax        # 52324 <last_ticks.1>
   414f8:	85 c0                	test   %eax,%eax
   414fa:	74 13                	je     4150f <memshow_virtual_animate+0x25>
   414fc:	8b 05 1e 0e 01 00    	mov    0x10e1e(%rip),%eax        # 52320 <ticks>
   41502:	8b 15 1c 0e 01 00    	mov    0x10e1c(%rip),%edx        # 52324 <last_ticks.1>
   41508:	29 d0                	sub    %edx,%eax
   4150a:	83 f8 31             	cmp    $0x31,%eax
   4150d:	76 2c                	jbe    4153b <memshow_virtual_animate+0x51>
        last_ticks = ticks;
   4150f:	8b 05 0b 0e 01 00    	mov    0x10e0b(%rip),%eax        # 52320 <ticks>
   41515:	89 05 09 0e 01 00    	mov    %eax,0x10e09(%rip)        # 52324 <last_ticks.1>
        ++showing;
   4151b:	8b 05 e3 4a 00 00    	mov    0x4ae3(%rip),%eax        # 46004 <showing.0>
   41521:	83 c0 01             	add    $0x1,%eax
   41524:	89 05 da 4a 00 00    	mov    %eax,0x4ada(%rip)        # 46004 <showing.0>
    }

    // the current process may have died -- don't display it if so
    while (showing <= 2*NPROC
   4152a:	eb 0f                	jmp    4153b <memshow_virtual_animate+0x51>
           && processes[showing % NPROC].p_state == P_FREE) {
        ++showing;
   4152c:	8b 05 d2 4a 00 00    	mov    0x4ad2(%rip),%eax        # 46004 <showing.0>
   41532:	83 c0 01             	add    $0x1,%eax
   41535:	89 05 c9 4a 00 00    	mov    %eax,0x4ac9(%rip)        # 46004 <showing.0>
    while (showing <= 2*NPROC
   4153b:	8b 05 c3 4a 00 00    	mov    0x4ac3(%rip),%eax        # 46004 <showing.0>
           && processes[showing % NPROC].p_state == P_FREE) {
   41541:	83 f8 20             	cmp    $0x20,%eax
   41544:	7f 2e                	jg     41574 <memshow_virtual_animate+0x8a>
   41546:	8b 05 b8 4a 00 00    	mov    0x4ab8(%rip),%eax        # 46004 <showing.0>
   4154c:	99                   	cltd   
   4154d:	c1 ea 1c             	shr    $0x1c,%edx
   41550:	01 d0                	add    %edx,%eax
   41552:	83 e0 0f             	and    $0xf,%eax
   41555:	29 d0                	sub    %edx,%eax
   41557:	48 63 d0             	movslq %eax,%rdx
   4155a:	48 89 d0             	mov    %rdx,%rax
   4155d:	48 c1 e0 04          	shl    $0x4,%rax
   41561:	48 29 d0             	sub    %rdx,%rax
   41564:	48 c1 e0 04          	shl    $0x4,%rax
   41568:	48 05 d8 10 05 00    	add    $0x510d8,%rax
   4156e:	8b 00                	mov    (%rax),%eax
   41570:	85 c0                	test   %eax,%eax
   41572:	74 b8                	je     4152c <memshow_virtual_animate+0x42>
    }
    showing = showing % NPROC;
   41574:	8b 05 8a 4a 00 00    	mov    0x4a8a(%rip),%eax        # 46004 <showing.0>
   4157a:	99                   	cltd   
   4157b:	c1 ea 1c             	shr    $0x1c,%edx
   4157e:	01 d0                	add    %edx,%eax
   41580:	83 e0 0f             	and    $0xf,%eax
   41583:	29 d0                	sub    %edx,%eax
   41585:	89 05 79 4a 00 00    	mov    %eax,0x4a79(%rip)        # 46004 <showing.0>

    if (processes[showing].p_state != P_FREE && processes[showing].display_status) {
   4158b:	8b 05 73 4a 00 00    	mov    0x4a73(%rip),%eax        # 46004 <showing.0>
   41591:	48 63 d0             	movslq %eax,%rdx
   41594:	48 89 d0             	mov    %rdx,%rax
   41597:	48 c1 e0 04          	shl    $0x4,%rax
   4159b:	48 29 d0             	sub    %rdx,%rax
   4159e:	48 c1 e0 04          	shl    $0x4,%rax
   415a2:	48 05 d8 10 05 00    	add    $0x510d8,%rax
   415a8:	8b 00                	mov    (%rax),%eax
   415aa:	85 c0                	test   %eax,%eax
   415ac:	74 76                	je     41624 <memshow_virtual_animate+0x13a>
   415ae:	8b 05 50 4a 00 00    	mov    0x4a50(%rip),%eax        # 46004 <showing.0>
   415b4:	48 63 d0             	movslq %eax,%rdx
   415b7:	48 89 d0             	mov    %rdx,%rax
   415ba:	48 c1 e0 04          	shl    $0x4,%rax
   415be:	48 29 d0             	sub    %rdx,%rax
   415c1:	48 c1 e0 04          	shl    $0x4,%rax
   415c5:	48 05 e8 10 05 00    	add    $0x510e8,%rax
   415cb:	0f b6 00             	movzbl (%rax),%eax
   415ce:	84 c0                	test   %al,%al
   415d0:	74 52                	je     41624 <memshow_virtual_animate+0x13a>
        char s[4];
        snprintf(s, 4, "%d ", showing);
   415d2:	8b 15 2c 4a 00 00    	mov    0x4a2c(%rip),%edx        # 46004 <showing.0>
   415d8:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
   415dc:	89 d1                	mov    %edx,%ecx
   415de:	ba 8c 49 04 00       	mov    $0x4498c,%edx
   415e3:	be 04 00 00 00       	mov    $0x4,%esi
   415e8:	48 89 c7             	mov    %rax,%rdi
   415eb:	b8 00 00 00 00       	mov    $0x0,%eax
   415f0:	e8 30 24 00 00       	call   43a25 <snprintf>
        memshow_virtual(processes[showing].p_pagetable, s);
   415f5:	8b 05 09 4a 00 00    	mov    0x4a09(%rip),%eax        # 46004 <showing.0>
   415fb:	48 63 d0             	movslq %eax,%rdx
   415fe:	48 89 d0             	mov    %rdx,%rax
   41601:	48 c1 e0 04          	shl    $0x4,%rax
   41605:	48 29 d0             	sub    %rdx,%rax
   41608:	48 c1 e0 04          	shl    $0x4,%rax
   4160c:	48 05 e0 10 05 00    	add    $0x510e0,%rax
   41612:	48 8b 00             	mov    (%rax),%rax
   41615:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
   41619:	48 89 d6             	mov    %rdx,%rsi
   4161c:	48 89 c7             	mov    %rax,%rdi
   4161f:	e8 cd fc ff ff       	call   412f1 <memshow_virtual>
    }
}
   41624:	90                   	nop
   41625:	c9                   	leave  
   41626:	c3                   	ret    

0000000000041627 <hardware_init>:

static void segments_init(void);
static void interrupt_init(void);
extern void virtual_memory_init(void);

void hardware_init(void) {
   41627:	55                   	push   %rbp
   41628:	48 89 e5             	mov    %rsp,%rbp
    segments_init();
   4162b:	e8 53 01 00 00       	call   41783 <segments_init>
    interrupt_init();
   41630:	e8 d4 03 00 00       	call   41a09 <interrupt_init>
    virtual_memory_init();
   41635:	e8 f2 0f 00 00       	call   4262c <virtual_memory_init>
}
   4163a:	90                   	nop
   4163b:	5d                   	pop    %rbp
   4163c:	c3                   	ret    

000000000004163d <set_app_segment>:
#define SEGSEL_TASKSTATE        0x28            // task state segment

// Segments
static uint64_t segments[7];

static void set_app_segment(uint64_t* segment, uint64_t type, int dpl) {
   4163d:	55                   	push   %rbp
   4163e:	48 89 e5             	mov    %rsp,%rbp
   41641:	48 83 ec 18          	sub    $0x18,%rsp
   41645:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41649:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   4164d:	89 55 ec             	mov    %edx,-0x14(%rbp)
    *segment = type
        | X86SEG_S                    // code/data segment
        | ((uint64_t) dpl << 45)
   41650:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41653:	48 98                	cltq   
   41655:	48 c1 e0 2d          	shl    $0x2d,%rax
   41659:	48 0b 45 f0          	or     -0x10(%rbp),%rax
        | X86SEG_P;                   // segment present
   4165d:	48 ba 00 00 00 00 00 	movabs $0x900000000000,%rdx
   41664:	90 00 00 
   41667:	48 09 c2             	or     %rax,%rdx
    *segment = type
   4166a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4166e:	48 89 10             	mov    %rdx,(%rax)
}
   41671:	90                   	nop
   41672:	c9                   	leave  
   41673:	c3                   	ret    

0000000000041674 <set_sys_segment>:

static void set_sys_segment(uint64_t* segment, uint64_t type, int dpl,
                            uintptr_t addr, size_t size) {
   41674:	55                   	push   %rbp
   41675:	48 89 e5             	mov    %rsp,%rbp
   41678:	48 83 ec 28          	sub    $0x28,%rsp
   4167c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41680:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   41684:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41687:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
   4168b:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   4168f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41693:	48 c1 e0 10          	shl    $0x10,%rax
   41697:	48 89 c2             	mov    %rax,%rdx
   4169a:	48 b8 00 00 ff ff ff 	movabs $0xffffff0000,%rax
   416a1:	00 00 00 
   416a4:	48 21 c2             	and    %rax,%rdx
        | ((addr & 0x00000000FF000000UL) << 32)
   416a7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   416ab:	48 c1 e0 20          	shl    $0x20,%rax
   416af:	48 89 c1             	mov    %rax,%rcx
   416b2:	48 b8 00 00 00 00 00 	movabs $0xff00000000000000,%rax
   416b9:	00 00 ff 
   416bc:	48 21 c8             	and    %rcx,%rax
   416bf:	48 09 c2             	or     %rax,%rdx
        | ((size - 1) & 0x0FFFFUL)
   416c2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   416c6:	48 83 e8 01          	sub    $0x1,%rax
   416ca:	0f b7 c0             	movzwl %ax,%eax
        | (((size - 1) & 0xF0000UL) << 48)
   416cd:	48 09 d0             	or     %rdx,%rax
        | type
   416d0:	48 0b 45 f0          	or     -0x10(%rbp),%rax
   416d4:	48 89 c2             	mov    %rax,%rdx
        | ((uint64_t) dpl << 45)
   416d7:	8b 45 ec             	mov    -0x14(%rbp),%eax
   416da:	48 98                	cltq   
   416dc:	48 c1 e0 2d          	shl    $0x2d,%rax
   416e0:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P;                   // segment present
   416e3:	48 b8 00 00 00 00 00 	movabs $0x800000000000,%rax
   416ea:	80 00 00 
   416ed:	48 09 c2             	or     %rax,%rdx
    segment[0] = ((addr & 0x0000000000FFFFFFUL) << 16)
   416f0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   416f4:	48 89 10             	mov    %rdx,(%rax)
    segment[1] = addr >> 32;
   416f7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   416fb:	48 83 c0 08          	add    $0x8,%rax
   416ff:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   41703:	48 c1 ea 20          	shr    $0x20,%rdx
   41707:	48 89 10             	mov    %rdx,(%rax)
}
   4170a:	90                   	nop
   4170b:	c9                   	leave  
   4170c:	c3                   	ret    

000000000004170d <set_gate>:

// Processor state for taking an interrupt
static x86_64_taskstate kernel_task_descriptor;

static void set_gate(x86_64_gatedescriptor* gate, uint64_t type, int dpl,
                     uintptr_t function) {
   4170d:	55                   	push   %rbp
   4170e:	48 89 e5             	mov    %rsp,%rbp
   41711:	48 83 ec 20          	sub    $0x20,%rsp
   41715:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41719:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
   4171d:	89 55 ec             	mov    %edx,-0x14(%rbp)
   41720:	48 89 4d e0          	mov    %rcx,-0x20(%rbp)
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41724:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41728:	0f b7 c0             	movzwl %ax,%eax
        | (SEGSEL_KERN_CODE << 16)
        | type
   4172b:	48 0b 45 f0          	or     -0x10(%rbp),%rax
   4172f:	48 89 c2             	mov    %rax,%rdx
        | ((uint64_t) dpl << 45)
   41732:	8b 45 ec             	mov    -0x14(%rbp),%eax
   41735:	48 98                	cltq   
   41737:	48 c1 e0 2d          	shl    $0x2d,%rax
   4173b:	48 09 c2             	or     %rax,%rdx
        | X86SEG_P
        | ((function & 0x00000000FFFF0000UL) << 32);
   4173e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41742:	48 c1 e0 20          	shl    $0x20,%rax
   41746:	48 89 c1             	mov    %rax,%rcx
   41749:	48 b8 00 00 00 00 00 	movabs $0xffff000000000000,%rax
   41750:	00 ff ff 
   41753:	48 21 c8             	and    %rcx,%rax
   41756:	48 09 c2             	or     %rax,%rdx
   41759:	48 b8 00 00 08 00 00 	movabs $0x800000080000,%rax
   41760:	80 00 00 
   41763:	48 09 c2             	or     %rax,%rdx
    gate->gd_low = (function & 0x000000000000FFFFUL)
   41766:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4176a:	48 89 10             	mov    %rdx,(%rax)
    gate->gd_high = function >> 32;
   4176d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   41771:	48 c1 e8 20          	shr    $0x20,%rax
   41775:	48 89 c2             	mov    %rax,%rdx
   41778:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4177c:	48 89 50 08          	mov    %rdx,0x8(%rax)
}
   41780:	90                   	nop
   41781:	c9                   	leave  
   41782:	c3                   	ret    

0000000000041783 <segments_init>:
extern void default_int_handler(void);
extern void gpf_int_handler(void);
extern void pagefault_int_handler(void);
extern void timer_int_handler(void);

void segments_init(void) {
   41783:	55                   	push   %rbp
   41784:	48 89 e5             	mov    %rsp,%rbp
   41787:	48 83 ec 40          	sub    $0x40,%rsp
    // Segments for kernel & user code & data
    // The privilege level, which can be 0 or 3, differentiates between
    // kernel and user code. (Data segments are unused in WeensyOS.)
    segments[0] = 0;
   4178b:	48 c7 05 aa 0b 01 00 	movq   $0x0,0x10baa(%rip)        # 52340 <segments>
   41792:	00 00 00 00 
    set_app_segment(&segments[SEGSEL_KERN_CODE >> 3], X86SEG_X | X86SEG_L, 0);
   41796:	ba 00 00 00 00       	mov    $0x0,%edx
   4179b:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   417a2:	08 20 00 
   417a5:	48 89 c6             	mov    %rax,%rsi
   417a8:	bf 48 23 05 00       	mov    $0x52348,%edi
   417ad:	e8 8b fe ff ff       	call   4163d <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_CODE >> 3], X86SEG_X | X86SEG_L, 3);
   417b2:	ba 03 00 00 00       	mov    $0x3,%edx
   417b7:	48 b8 00 00 00 00 00 	movabs $0x20080000000000,%rax
   417be:	08 20 00 
   417c1:	48 89 c6             	mov    %rax,%rsi
   417c4:	bf 50 23 05 00       	mov    $0x52350,%edi
   417c9:	e8 6f fe ff ff       	call   4163d <set_app_segment>
    set_app_segment(&segments[SEGSEL_KERN_DATA >> 3], X86SEG_W, 0);
   417ce:	ba 00 00 00 00       	mov    $0x0,%edx
   417d3:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   417da:	02 00 00 
   417dd:	48 89 c6             	mov    %rax,%rsi
   417e0:	bf 58 23 05 00       	mov    $0x52358,%edi
   417e5:	e8 53 fe ff ff       	call   4163d <set_app_segment>
    set_app_segment(&segments[SEGSEL_APP_DATA >> 3], X86SEG_W, 3);
   417ea:	ba 03 00 00 00       	mov    $0x3,%edx
   417ef:	48 b8 00 00 00 00 00 	movabs $0x20000000000,%rax
   417f6:	02 00 00 
   417f9:	48 89 c6             	mov    %rax,%rsi
   417fc:	bf 60 23 05 00       	mov    $0x52360,%edi
   41801:	e8 37 fe ff ff       	call   4163d <set_app_segment>
    set_sys_segment(&segments[SEGSEL_TASKSTATE >> 3], X86SEG_TSS, 0,
   41806:	b8 80 33 05 00       	mov    $0x53380,%eax
   4180b:	41 b8 60 00 00 00    	mov    $0x60,%r8d
   41811:	48 89 c1             	mov    %rax,%rcx
   41814:	ba 00 00 00 00       	mov    $0x0,%edx
   41819:	48 b8 00 00 00 00 00 	movabs $0x90000000000,%rax
   41820:	09 00 00 
   41823:	48 89 c6             	mov    %rax,%rsi
   41826:	bf 68 23 05 00       	mov    $0x52368,%edi
   4182b:	e8 44 fe ff ff       	call   41674 <set_sys_segment>
                    (uintptr_t) &kernel_task_descriptor,
                    sizeof(kernel_task_descriptor));

    x86_64_pseudodescriptor gdt;
    gdt.pseudod_limit = sizeof(segments) - 1;
   41830:	66 c7 45 d6 37 00    	movw   $0x37,-0x2a(%rbp)
    gdt.pseudod_base = (uint64_t) segments;
   41836:	b8 40 23 05 00       	mov    $0x52340,%eax
   4183b:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

    // Kernel task descriptor lets us receive interrupts
    memset(&kernel_task_descriptor, 0, sizeof(kernel_task_descriptor));
   4183f:	ba 60 00 00 00       	mov    $0x60,%edx
   41844:	be 00 00 00 00       	mov    $0x0,%esi
   41849:	bf 80 33 05 00       	mov    $0x53380,%edi
   4184e:	e8 1f 19 00 00       	call   43172 <memset>
    kernel_task_descriptor.ts_rsp[0] = KERNEL_STACK_TOP;
   41853:	48 c7 05 26 1b 01 00 	movq   $0x80000,0x11b26(%rip)        # 53384 <kernel_task_descriptor+0x4>
   4185a:	00 00 08 00 

    // Interrupt handler; most interrupts are effectively ignored
    memset(interrupt_descriptors, 0, sizeof(interrupt_descriptors));
   4185e:	ba 00 10 00 00       	mov    $0x1000,%edx
   41863:	be 00 00 00 00       	mov    $0x0,%esi
   41868:	bf 80 23 05 00       	mov    $0x52380,%edi
   4186d:	e8 00 19 00 00       	call   43172 <memset>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   41872:	c7 45 fc 10 00 00 00 	movl   $0x10,-0x4(%rbp)
   41879:	eb 30                	jmp    418ab <segments_init+0x128>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 0,
   4187b:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   41880:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41883:	48 c1 e0 04          	shl    $0x4,%rax
   41887:	48 05 80 23 05 00    	add    $0x52380,%rax
   4188d:	48 89 d1             	mov    %rdx,%rcx
   41890:	ba 00 00 00 00       	mov    $0x0,%edx
   41895:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   4189c:	0e 00 00 
   4189f:	48 89 c7             	mov    %rax,%rdi
   418a2:	e8 66 fe ff ff       	call   4170d <set_gate>
    for (unsigned i = 16; i < arraysize(interrupt_descriptors); ++i) {
   418a7:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   418ab:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
   418b2:	76 c7                	jbe    4187b <segments_init+0xf8>
                 (uint64_t) default_int_handler);
    }

    // Timer interrupt
    set_gate(&interrupt_descriptors[INT_TIMER], X86GATE_INTERRUPT, 0,
   418b4:	b8 36 00 04 00       	mov    $0x40036,%eax
   418b9:	48 89 c1             	mov    %rax,%rcx
   418bc:	ba 00 00 00 00       	mov    $0x0,%edx
   418c1:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   418c8:	0e 00 00 
   418cb:	48 89 c6             	mov    %rax,%rsi
   418ce:	bf 80 25 05 00       	mov    $0x52580,%edi
   418d3:	e8 35 fe ff ff       	call   4170d <set_gate>
             (uint64_t) timer_int_handler);

    // GPF and page fault
    set_gate(&interrupt_descriptors[INT_GPF], X86GATE_INTERRUPT, 0,
   418d8:	b8 2e 00 04 00       	mov    $0x4002e,%eax
   418dd:	48 89 c1             	mov    %rax,%rcx
   418e0:	ba 00 00 00 00       	mov    $0x0,%edx
   418e5:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   418ec:	0e 00 00 
   418ef:	48 89 c6             	mov    %rax,%rsi
   418f2:	bf 50 24 05 00       	mov    $0x52450,%edi
   418f7:	e8 11 fe ff ff       	call   4170d <set_gate>
             (uint64_t) gpf_int_handler);
    set_gate(&interrupt_descriptors[INT_PAGEFAULT], X86GATE_INTERRUPT, 0,
   418fc:	b8 32 00 04 00       	mov    $0x40032,%eax
   41901:	48 89 c1             	mov    %rax,%rcx
   41904:	ba 00 00 00 00       	mov    $0x0,%edx
   41909:	48 b8 00 00 00 00 00 	movabs $0xe0000000000,%rax
   41910:	0e 00 00 
   41913:	48 89 c6             	mov    %rax,%rsi
   41916:	bf 60 24 05 00       	mov    $0x52460,%edi
   4191b:	e8 ed fd ff ff       	call   4170d <set_gate>
             (uint64_t) pagefault_int_handler);

    // System calls get special handling.
    // Note that the last argument is '3'.  This means that unprivileged
    // (level-3) applications may generate these interrupts.
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41920:	c7 45 f8 30 00 00 00 	movl   $0x30,-0x8(%rbp)
   41927:	eb 3e                	jmp    41967 <segments_init+0x1e4>
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
                 (uint64_t) sys_int_handlers[i - INT_SYS]);
   41929:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4192c:	83 e8 30             	sub    $0x30,%eax
   4192f:	89 c0                	mov    %eax,%eax
   41931:	48 8b 04 c5 e7 00 04 	mov    0x400e7(,%rax,8),%rax
   41938:	00 
        set_gate(&interrupt_descriptors[i], X86GATE_INTERRUPT, 3,
   41939:	48 89 c2             	mov    %rax,%rdx
   4193c:	8b 45 f8             	mov    -0x8(%rbp),%eax
   4193f:	48 c1 e0 04          	shl    $0x4,%rax
   41943:	48 05 80 23 05 00    	add    $0x52380,%rax
   41949:	48 89 d1             	mov    %rdx,%rcx
   4194c:	ba 03 00 00 00       	mov    $0x3,%edx
   41951:	48 be 00 00 00 00 00 	movabs $0xe0000000000,%rsi
   41958:	0e 00 00 
   4195b:	48 89 c7             	mov    %rax,%rdi
   4195e:	e8 aa fd ff ff       	call   4170d <set_gate>
    for (unsigned i = INT_SYS; i < INT_SYS + 16; ++i) {
   41963:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41967:	83 7d f8 3f          	cmpl   $0x3f,-0x8(%rbp)
   4196b:	76 bc                	jbe    41929 <segments_init+0x1a6>
    }

    x86_64_pseudodescriptor idt;
    idt.pseudod_limit = sizeof(interrupt_descriptors) - 1;
   4196d:	66 c7 45 cc ff 0f    	movw   $0xfff,-0x34(%rbp)
    idt.pseudod_base = (uint64_t) interrupt_descriptors;
   41973:	b8 80 23 05 00       	mov    $0x52380,%eax
   41978:	48 89 45 ce          	mov    %rax,-0x32(%rbp)

    // Reload segment pointers
    asm volatile("lgdt %0\n\t"
   4197c:	b8 28 00 00 00       	mov    $0x28,%eax
   41981:	0f 01 55 d6          	lgdt   -0x2a(%rbp)
   41985:	0f 00 d8             	ltr    %ax
   41988:	0f 01 5d cc          	lidt   -0x34(%rbp)
    asm volatile("movq %%cr0,%0" : "=r" (val));
   4198c:	0f 20 c0             	mov    %cr0,%rax
   4198f:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    return val;
   41993:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
                     "r" ((uint16_t) SEGSEL_TASKSTATE),
                     "m" (idt)
                 : "memory");

    // Set up control registers: check alignment
    uint32_t cr0 = rcr0();
   41997:	89 45 f4             	mov    %eax,-0xc(%rbp)
    cr0 |= CR0_PE | CR0_PG | CR0_WP | CR0_AM | CR0_MP | CR0_NE;
   4199a:	81 4d f4 23 00 05 80 	orl    $0x80050023,-0xc(%rbp)
   419a1:	8b 45 f4             	mov    -0xc(%rbp),%eax
   419a4:	89 45 f0             	mov    %eax,-0x10(%rbp)
    uint64_t xval = val;
   419a7:	8b 45 f0             	mov    -0x10(%rbp),%eax
   419aa:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    asm volatile("movq %0,%%cr0" : : "r" (xval));
   419ae:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   419b2:	0f 22 c0             	mov    %rax,%cr0
}
   419b5:	90                   	nop
    lcr0(cr0);
}
   419b6:	90                   	nop
   419b7:	c9                   	leave  
   419b8:	c3                   	ret    

00000000000419b9 <interrupt_mask>:
#define TIMER_FREQ      1193182
#define TIMER_DIV(x)    ((TIMER_FREQ+(x)/2)/(x))

static uint16_t interrupts_enabled;

static void interrupt_mask(void) {
   419b9:	55                   	push   %rbp
   419ba:	48 89 e5             	mov    %rsp,%rbp
   419bd:	48 83 ec 20          	sub    $0x20,%rsp
    uint16_t masked = ~interrupts_enabled;
   419c1:	0f b7 05 18 1a 01 00 	movzwl 0x11a18(%rip),%eax        # 533e0 <interrupts_enabled>
   419c8:	f7 d0                	not    %eax
   419ca:	66 89 45 fe          	mov    %ax,-0x2(%rbp)
    outb(IO_PIC1+1, masked & 0xFF);
   419ce:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   419d2:	0f b6 c0             	movzbl %al,%eax
   419d5:	c7 45 f0 21 00 00 00 	movl   $0x21,-0x10(%rbp)
   419dc:	88 45 ef             	mov    %al,-0x11(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   419df:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   419e3:	8b 55 f0             	mov    -0x10(%rbp),%edx
   419e6:	ee                   	out    %al,(%dx)
}
   419e7:	90                   	nop
    outb(IO_PIC2+1, (masked >> 8) & 0xFF);
   419e8:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
   419ec:	66 c1 e8 08          	shr    $0x8,%ax
   419f0:	0f b6 c0             	movzbl %al,%eax
   419f3:	c7 45 f8 a1 00 00 00 	movl   $0xa1,-0x8(%rbp)
   419fa:	88 45 f7             	mov    %al,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   419fd:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   41a01:	8b 55 f8             	mov    -0x8(%rbp),%edx
   41a04:	ee                   	out    %al,(%dx)
}
   41a05:	90                   	nop
}
   41a06:	90                   	nop
   41a07:	c9                   	leave  
   41a08:	c3                   	ret    

0000000000041a09 <interrupt_init>:

void interrupt_init(void) {
   41a09:	55                   	push   %rbp
   41a0a:	48 89 e5             	mov    %rsp,%rbp
   41a0d:	48 83 ec 60          	sub    $0x60,%rsp
    // mask all interrupts
    interrupts_enabled = 0;
   41a11:	66 c7 05 c6 19 01 00 	movw   $0x0,0x119c6(%rip)        # 533e0 <interrupts_enabled>
   41a18:	00 00 
    interrupt_mask();
   41a1a:	e8 9a ff ff ff       	call   419b9 <interrupt_mask>
   41a1f:	c7 45 a4 20 00 00 00 	movl   $0x20,-0x5c(%rbp)
   41a26:	c6 45 a3 11          	movb   $0x11,-0x5d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a2a:	0f b6 45 a3          	movzbl -0x5d(%rbp),%eax
   41a2e:	8b 55 a4             	mov    -0x5c(%rbp),%edx
   41a31:	ee                   	out    %al,(%dx)
}
   41a32:	90                   	nop
   41a33:	c7 45 ac 21 00 00 00 	movl   $0x21,-0x54(%rbp)
   41a3a:	c6 45 ab 20          	movb   $0x20,-0x55(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a3e:	0f b6 45 ab          	movzbl -0x55(%rbp),%eax
   41a42:	8b 55 ac             	mov    -0x54(%rbp),%edx
   41a45:	ee                   	out    %al,(%dx)
}
   41a46:	90                   	nop
   41a47:	c7 45 b4 21 00 00 00 	movl   $0x21,-0x4c(%rbp)
   41a4e:	c6 45 b3 04          	movb   $0x4,-0x4d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a52:	0f b6 45 b3          	movzbl -0x4d(%rbp),%eax
   41a56:	8b 55 b4             	mov    -0x4c(%rbp),%edx
   41a59:	ee                   	out    %al,(%dx)
}
   41a5a:	90                   	nop
   41a5b:	c7 45 bc 21 00 00 00 	movl   $0x21,-0x44(%rbp)
   41a62:	c6 45 bb 03          	movb   $0x3,-0x45(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a66:	0f b6 45 bb          	movzbl -0x45(%rbp),%eax
   41a6a:	8b 55 bc             	mov    -0x44(%rbp),%edx
   41a6d:	ee                   	out    %al,(%dx)
}
   41a6e:	90                   	nop
   41a6f:	c7 45 c4 a0 00 00 00 	movl   $0xa0,-0x3c(%rbp)
   41a76:	c6 45 c3 11          	movb   $0x11,-0x3d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a7a:	0f b6 45 c3          	movzbl -0x3d(%rbp),%eax
   41a7e:	8b 55 c4             	mov    -0x3c(%rbp),%edx
   41a81:	ee                   	out    %al,(%dx)
}
   41a82:	90                   	nop
   41a83:	c7 45 cc a1 00 00 00 	movl   $0xa1,-0x34(%rbp)
   41a8a:	c6 45 cb 28          	movb   $0x28,-0x35(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41a8e:	0f b6 45 cb          	movzbl -0x35(%rbp),%eax
   41a92:	8b 55 cc             	mov    -0x34(%rbp),%edx
   41a95:	ee                   	out    %al,(%dx)
}
   41a96:	90                   	nop
   41a97:	c7 45 d4 a1 00 00 00 	movl   $0xa1,-0x2c(%rbp)
   41a9e:	c6 45 d3 02          	movb   $0x2,-0x2d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41aa2:	0f b6 45 d3          	movzbl -0x2d(%rbp),%eax
   41aa6:	8b 55 d4             	mov    -0x2c(%rbp),%edx
   41aa9:	ee                   	out    %al,(%dx)
}
   41aaa:	90                   	nop
   41aab:	c7 45 dc a1 00 00 00 	movl   $0xa1,-0x24(%rbp)
   41ab2:	c6 45 db 01          	movb   $0x1,-0x25(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ab6:	0f b6 45 db          	movzbl -0x25(%rbp),%eax
   41aba:	8b 55 dc             	mov    -0x24(%rbp),%edx
   41abd:	ee                   	out    %al,(%dx)
}
   41abe:	90                   	nop
   41abf:	c7 45 e4 20 00 00 00 	movl   $0x20,-0x1c(%rbp)
   41ac6:	c6 45 e3 68          	movb   $0x68,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41aca:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   41ace:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   41ad1:	ee                   	out    %al,(%dx)
}
   41ad2:	90                   	nop
   41ad3:	c7 45 ec 20 00 00 00 	movl   $0x20,-0x14(%rbp)
   41ada:	c6 45 eb 0a          	movb   $0xa,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ade:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41ae2:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41ae5:	ee                   	out    %al,(%dx)
}
   41ae6:	90                   	nop
   41ae7:	c7 45 f4 a0 00 00 00 	movl   $0xa0,-0xc(%rbp)
   41aee:	c6 45 f3 68          	movb   $0x68,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41af2:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41af6:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41af9:	ee                   	out    %al,(%dx)
}
   41afa:	90                   	nop
   41afb:	c7 45 fc a0 00 00 00 	movl   $0xa0,-0x4(%rbp)
   41b02:	c6 45 fb 0a          	movb   $0xa,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b06:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41b0a:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41b0d:	ee                   	out    %al,(%dx)
}
   41b0e:	90                   	nop

    outb(IO_PIC2, 0x68);               /* OCW3 */
    outb(IO_PIC2, 0x0a);               /* OCW3 */

    // re-disable interrupts
    interrupt_mask();
   41b0f:	e8 a5 fe ff ff       	call   419b9 <interrupt_mask>
}
   41b14:	90                   	nop
   41b15:	c9                   	leave  
   41b16:	c3                   	ret    

0000000000041b17 <timer_init>:

// timer_init(rate)
//    Set the timer interrupt to fire `rate` times a second. Disables the
//    timer interrupt if `rate <= 0`.

void timer_init(int rate) {
   41b17:	55                   	push   %rbp
   41b18:	48 89 e5             	mov    %rsp,%rbp
   41b1b:	48 83 ec 28          	sub    $0x28,%rsp
   41b1f:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (rate > 0) {
   41b22:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41b26:	0f 8e 9f 00 00 00    	jle    41bcb <timer_init+0xb4>
   41b2c:	c7 45 ec 43 00 00 00 	movl   $0x43,-0x14(%rbp)
   41b33:	c6 45 eb 34          	movb   $0x34,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b37:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41b3b:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41b3e:	ee                   	out    %al,(%dx)
}
   41b3f:	90                   	nop
        outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
        outb(IO_TIMER1, TIMER_DIV(rate) % 256);
   41b40:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41b43:	89 c2                	mov    %eax,%edx
   41b45:	c1 ea 1f             	shr    $0x1f,%edx
   41b48:	01 d0                	add    %edx,%eax
   41b4a:	d1 f8                	sar    %eax
   41b4c:	05 de 34 12 00       	add    $0x1234de,%eax
   41b51:	99                   	cltd   
   41b52:	f7 7d dc             	idivl  -0x24(%rbp)
   41b55:	89 c2                	mov    %eax,%edx
   41b57:	89 d0                	mov    %edx,%eax
   41b59:	c1 f8 1f             	sar    $0x1f,%eax
   41b5c:	c1 e8 18             	shr    $0x18,%eax
   41b5f:	89 c1                	mov    %eax,%ecx
   41b61:	8d 04 0a             	lea    (%rdx,%rcx,1),%eax
   41b64:	0f b6 c0             	movzbl %al,%eax
   41b67:	29 c8                	sub    %ecx,%eax
   41b69:	0f b6 c0             	movzbl %al,%eax
   41b6c:	c7 45 f4 40 00 00 00 	movl   $0x40,-0xc(%rbp)
   41b73:	88 45 f3             	mov    %al,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41b76:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41b7a:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41b7d:	ee                   	out    %al,(%dx)
}
   41b7e:	90                   	nop
        outb(IO_TIMER1, TIMER_DIV(rate) / 256);
   41b7f:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41b82:	89 c2                	mov    %eax,%edx
   41b84:	c1 ea 1f             	shr    $0x1f,%edx
   41b87:	01 d0                	add    %edx,%eax
   41b89:	d1 f8                	sar    %eax
   41b8b:	05 de 34 12 00       	add    $0x1234de,%eax
   41b90:	99                   	cltd   
   41b91:	f7 7d dc             	idivl  -0x24(%rbp)
   41b94:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   41b9a:	85 c0                	test   %eax,%eax
   41b9c:	0f 48 c2             	cmovs  %edx,%eax
   41b9f:	c1 f8 08             	sar    $0x8,%eax
   41ba2:	0f b6 c0             	movzbl %al,%eax
   41ba5:	c7 45 fc 40 00 00 00 	movl   $0x40,-0x4(%rbp)
   41bac:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41baf:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41bb3:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41bb6:	ee                   	out    %al,(%dx)
}
   41bb7:	90                   	nop
        interrupts_enabled |= 1 << (INT_TIMER - INT_HARDWARE);
   41bb8:	0f b7 05 21 18 01 00 	movzwl 0x11821(%rip),%eax        # 533e0 <interrupts_enabled>
   41bbf:	83 c8 01             	or     $0x1,%eax
   41bc2:	66 89 05 17 18 01 00 	mov    %ax,0x11817(%rip)        # 533e0 <interrupts_enabled>
   41bc9:	eb 11                	jmp    41bdc <timer_init+0xc5>
    } else {
        interrupts_enabled &= ~(1 << (INT_TIMER - INT_HARDWARE));
   41bcb:	0f b7 05 0e 18 01 00 	movzwl 0x1180e(%rip),%eax        # 533e0 <interrupts_enabled>
   41bd2:	83 e0 fe             	and    $0xfffffffe,%eax
   41bd5:	66 89 05 04 18 01 00 	mov    %ax,0x11804(%rip)        # 533e0 <interrupts_enabled>
    }
    interrupt_mask();
   41bdc:	e8 d8 fd ff ff       	call   419b9 <interrupt_mask>
}
   41be1:	90                   	nop
   41be2:	c9                   	leave  
   41be3:	c3                   	ret    

0000000000041be4 <physical_memory_isreserved>:
//    Returns non-zero iff `pa` is a reserved physical address.

#define IOPHYSMEM       0x000A0000
#define EXTPHYSMEM      0x00100000

int physical_memory_isreserved(uintptr_t pa) {
   41be4:	55                   	push   %rbp
   41be5:	48 89 e5             	mov    %rsp,%rbp
   41be8:	48 83 ec 08          	sub    $0x8,%rsp
   41bec:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    return pa == 0 || (pa >= IOPHYSMEM && pa < EXTPHYSMEM);
   41bf0:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   41bf5:	74 14                	je     41c0b <physical_memory_isreserved+0x27>
   41bf7:	48 81 7d f8 ff ff 09 	cmpq   $0x9ffff,-0x8(%rbp)
   41bfe:	00 
   41bff:	76 11                	jbe    41c12 <physical_memory_isreserved+0x2e>
   41c01:	48 81 7d f8 ff ff 0f 	cmpq   $0xfffff,-0x8(%rbp)
   41c08:	00 
   41c09:	77 07                	ja     41c12 <physical_memory_isreserved+0x2e>
   41c0b:	b8 01 00 00 00       	mov    $0x1,%eax
   41c10:	eb 05                	jmp    41c17 <physical_memory_isreserved+0x33>
   41c12:	b8 00 00 00 00       	mov    $0x0,%eax
}
   41c17:	c9                   	leave  
   41c18:	c3                   	ret    

0000000000041c19 <pci_make_configaddr>:


// pci_make_configaddr(bus, slot, func)
//    Construct a PCI configuration space address from parts.

static int pci_make_configaddr(int bus, int slot, int func) {
   41c19:	55                   	push   %rbp
   41c1a:	48 89 e5             	mov    %rsp,%rbp
   41c1d:	48 83 ec 10          	sub    $0x10,%rsp
   41c21:	89 7d fc             	mov    %edi,-0x4(%rbp)
   41c24:	89 75 f8             	mov    %esi,-0x8(%rbp)
   41c27:	89 55 f4             	mov    %edx,-0xc(%rbp)
    return (bus << 16) | (slot << 11) | (func << 8);
   41c2a:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41c2d:	c1 e0 10             	shl    $0x10,%eax
   41c30:	89 c2                	mov    %eax,%edx
   41c32:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41c35:	c1 e0 0b             	shl    $0xb,%eax
   41c38:	09 c2                	or     %eax,%edx
   41c3a:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41c3d:	c1 e0 08             	shl    $0x8,%eax
   41c40:	09 d0                	or     %edx,%eax
}
   41c42:	c9                   	leave  
   41c43:	c3                   	ret    

0000000000041c44 <pci_config_readl>:
//    Read a 32-bit word in PCI configuration space.

#define PCI_HOST_BRIDGE_CONFIG_ADDR 0xCF8
#define PCI_HOST_BRIDGE_CONFIG_DATA 0xCFC

static uint32_t pci_config_readl(int configaddr, int offset) {
   41c44:	55                   	push   %rbp
   41c45:	48 89 e5             	mov    %rsp,%rbp
   41c48:	48 83 ec 18          	sub    $0x18,%rsp
   41c4c:	89 7d ec             	mov    %edi,-0x14(%rbp)
   41c4f:	89 75 e8             	mov    %esi,-0x18(%rbp)
    outl(PCI_HOST_BRIDGE_CONFIG_ADDR, 0x80000000 | configaddr | offset);
   41c52:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41c55:	8b 45 e8             	mov    -0x18(%rbp),%eax
   41c58:	09 d0                	or     %edx,%eax
   41c5a:	0d 00 00 00 80       	or     $0x80000000,%eax
   41c5f:	c7 45 f4 f8 0c 00 00 	movl   $0xcf8,-0xc(%rbp)
   41c66:	89 45 f0             	mov    %eax,-0x10(%rbp)
    asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
   41c69:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41c6c:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41c6f:	ef                   	out    %eax,(%dx)
}
   41c70:	90                   	nop
   41c71:	c7 45 fc fc 0c 00 00 	movl   $0xcfc,-0x4(%rbp)
    asm volatile("inl %w1,%0" : "=a" (data) : "d" (port));
   41c78:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41c7b:	89 c2                	mov    %eax,%edx
   41c7d:	ed                   	in     (%dx),%eax
   41c7e:	89 45 f8             	mov    %eax,-0x8(%rbp)
    return data;
   41c81:	8b 45 f8             	mov    -0x8(%rbp),%eax
    return inl(PCI_HOST_BRIDGE_CONFIG_DATA);
}
   41c84:	c9                   	leave  
   41c85:	c3                   	ret    

0000000000041c86 <pci_find_device>:

// pci_find_device
//    Search for a PCI device matching `vendor` and `device`. Return
//    the config base address or -1 if no device was found.

static int pci_find_device(int vendor, int device) {
   41c86:	55                   	push   %rbp
   41c87:	48 89 e5             	mov    %rsp,%rbp
   41c8a:	48 83 ec 28          	sub    $0x28,%rsp
   41c8e:	89 7d dc             	mov    %edi,-0x24(%rbp)
   41c91:	89 75 d8             	mov    %esi,-0x28(%rbp)
    for (int bus = 0; bus != 256; ++bus) {
   41c94:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   41c9b:	eb 73                	jmp    41d10 <pci_find_device+0x8a>
        for (int slot = 0; slot != 32; ++slot) {
   41c9d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
   41ca4:	eb 60                	jmp    41d06 <pci_find_device+0x80>
            for (int func = 0; func != 8; ++func) {
   41ca6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   41cad:	eb 4a                	jmp    41cf9 <pci_find_device+0x73>
                int configaddr = pci_make_configaddr(bus, slot, func);
   41caf:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41cb2:	8b 4d f8             	mov    -0x8(%rbp),%ecx
   41cb5:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41cb8:	89 ce                	mov    %ecx,%esi
   41cba:	89 c7                	mov    %eax,%edi
   41cbc:	e8 58 ff ff ff       	call   41c19 <pci_make_configaddr>
   41cc1:	89 45 f0             	mov    %eax,-0x10(%rbp)
                uint32_t vendor_device = pci_config_readl(configaddr, 0);
   41cc4:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41cc7:	be 00 00 00 00       	mov    $0x0,%esi
   41ccc:	89 c7                	mov    %eax,%edi
   41cce:	e8 71 ff ff ff       	call   41c44 <pci_config_readl>
   41cd3:	89 45 ec             	mov    %eax,-0x14(%rbp)
                if (vendor_device == (uint32_t) (vendor | (device << 16))) {
   41cd6:	8b 45 d8             	mov    -0x28(%rbp),%eax
   41cd9:	c1 e0 10             	shl    $0x10,%eax
   41cdc:	0b 45 dc             	or     -0x24(%rbp),%eax
   41cdf:	39 45 ec             	cmp    %eax,-0x14(%rbp)
   41ce2:	75 05                	jne    41ce9 <pci_find_device+0x63>
                    return configaddr;
   41ce4:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41ce7:	eb 35                	jmp    41d1e <pci_find_device+0x98>
                } else if (vendor_device == (uint32_t) -1 && func == 0) {
   41ce9:	83 7d ec ff          	cmpl   $0xffffffff,-0x14(%rbp)
   41ced:	75 06                	jne    41cf5 <pci_find_device+0x6f>
   41cef:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   41cf3:	74 0c                	je     41d01 <pci_find_device+0x7b>
            for (int func = 0; func != 8; ++func) {
   41cf5:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   41cf9:	83 7d f4 08          	cmpl   $0x8,-0xc(%rbp)
   41cfd:	75 b0                	jne    41caf <pci_find_device+0x29>
   41cff:	eb 01                	jmp    41d02 <pci_find_device+0x7c>
                    break;
   41d01:	90                   	nop
        for (int slot = 0; slot != 32; ++slot) {
   41d02:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
   41d06:	83 7d f8 20          	cmpl   $0x20,-0x8(%rbp)
   41d0a:	75 9a                	jne    41ca6 <pci_find_device+0x20>
    for (int bus = 0; bus != 256; ++bus) {
   41d0c:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   41d10:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
   41d17:	75 84                	jne    41c9d <pci_find_device+0x17>
                }
            }
        }
    }
    return -1;
   41d19:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
   41d1e:	c9                   	leave  
   41d1f:	c3                   	ret    

0000000000041d20 <poweroff>:
//    that speaks ACPI; QEMU emulates a PIIX4 Power Management Controller.

#define PCI_VENDOR_ID_INTEL     0x8086
#define PCI_DEVICE_ID_PIIX4     0x7113

void poweroff(void) {
   41d20:	55                   	push   %rbp
   41d21:	48 89 e5             	mov    %rsp,%rbp
   41d24:	48 83 ec 10          	sub    $0x10,%rsp
    int configaddr = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PIIX4);
   41d28:	be 13 71 00 00       	mov    $0x7113,%esi
   41d2d:	bf 86 80 00 00       	mov    $0x8086,%edi
   41d32:	e8 4f ff ff ff       	call   41c86 <pci_find_device>
   41d37:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if (configaddr >= 0) {
   41d3a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
   41d3e:	78 30                	js     41d70 <poweroff+0x50>
        // Read I/O base register from controller's PCI configuration space.
        int pm_io_base = pci_config_readl(configaddr, 0x40) & 0xFFC0;
   41d40:	8b 45 fc             	mov    -0x4(%rbp),%eax
   41d43:	be 40 00 00 00       	mov    $0x40,%esi
   41d48:	89 c7                	mov    %eax,%edi
   41d4a:	e8 f5 fe ff ff       	call   41c44 <pci_config_readl>
   41d4f:	25 c0 ff 00 00       	and    $0xffc0,%eax
   41d54:	89 45 f8             	mov    %eax,-0x8(%rbp)
        // Write `suspend enable` to the power management control register.
        outw(pm_io_base + 4, 0x2000);
   41d57:	8b 45 f8             	mov    -0x8(%rbp),%eax
   41d5a:	83 c0 04             	add    $0x4,%eax
   41d5d:	89 45 f4             	mov    %eax,-0xc(%rbp)
   41d60:	66 c7 45 f2 00 20    	movw   $0x2000,-0xe(%rbp)
    asm volatile("outw %0,%w1" : : "a" (data), "d" (port));
   41d66:	0f b7 45 f2          	movzwl -0xe(%rbp),%eax
   41d6a:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41d6d:	66 ef                	out    %ax,(%dx)
}
   41d6f:	90                   	nop
    }
    // No PIIX4; spin.
    console_printf(CPOS(24, 0), 0xC000, "Cannot power off!\n");
   41d70:	ba a0 49 04 00       	mov    $0x449a0,%edx
   41d75:	be 00 c0 00 00       	mov    $0xc000,%esi
   41d7a:	bf 80 07 00 00       	mov    $0x780,%edi
   41d7f:	b8 00 00 00 00       	mov    $0x0,%eax
   41d84:	e8 1e 1c 00 00       	call   439a7 <console_printf>
 spinloop: goto spinloop;
   41d89:	eb fe                	jmp    41d89 <poweroff+0x69>

0000000000041d8b <reboot>:


// reboot
//    Reboot the virtual machine.

void reboot(void) {
   41d8b:	55                   	push   %rbp
   41d8c:	48 89 e5             	mov    %rsp,%rbp
   41d8f:	48 83 ec 10          	sub    $0x10,%rsp
   41d93:	c7 45 fc 92 00 00 00 	movl   $0x92,-0x4(%rbp)
   41d9a:	c6 45 fb 03          	movb   $0x3,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41d9e:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41da2:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41da5:	ee                   	out    %al,(%dx)
}
   41da6:	90                   	nop
    outb(0x92, 3);
 spinloop: goto spinloop;
   41da7:	eb fe                	jmp    41da7 <reboot+0x1c>

0000000000041da9 <process_init>:


// process_init(p, flags)
//    Initialize special-purpose registers for process `p`.

void process_init(proc* p, int flags) {
   41da9:	55                   	push   %rbp
   41daa:	48 89 e5             	mov    %rsp,%rbp
   41dad:	48 83 ec 10          	sub    $0x10,%rsp
   41db1:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   41db5:	89 75 f4             	mov    %esi,-0xc(%rbp)
    memset(&p->p_registers, 0, sizeof(p->p_registers));
   41db8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41dbc:	48 83 c0 18          	add    $0x18,%rax
   41dc0:	ba c0 00 00 00       	mov    $0xc0,%edx
   41dc5:	be 00 00 00 00       	mov    $0x0,%esi
   41dca:	48 89 c7             	mov    %rax,%rdi
   41dcd:	e8 a0 13 00 00       	call   43172 <memset>
    p->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
   41dd2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41dd6:	66 c7 80 b8 00 00 00 	movw   $0x13,0xb8(%rax)
   41ddd:	13 00 
    p->p_registers.reg_fs = SEGSEL_APP_DATA | 3;
   41ddf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41de3:	48 c7 80 90 00 00 00 	movq   $0x23,0x90(%rax)
   41dea:	23 00 00 00 
    p->p_registers.reg_gs = SEGSEL_APP_DATA | 3;
   41dee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41df2:	48 c7 80 98 00 00 00 	movq   $0x23,0x98(%rax)
   41df9:	23 00 00 00 
    p->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
   41dfd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e01:	66 c7 80 d0 00 00 00 	movw   $0x23,0xd0(%rax)
   41e08:	23 00 
    p->p_registers.reg_rflags = EFLAGS_IF;
   41e0a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e0e:	48 c7 80 c0 00 00 00 	movq   $0x200,0xc0(%rax)
   41e15:	00 02 00 00 

    if (flags & PROCINIT_ALLOW_PROGRAMMED_IO) {
   41e19:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41e1c:	83 e0 01             	and    $0x1,%eax
   41e1f:	85 c0                	test   %eax,%eax
   41e21:	74 1c                	je     41e3f <process_init+0x96>
        p->p_registers.reg_rflags |= EFLAGS_IOPL_3;
   41e23:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e27:	48 8b 80 c0 00 00 00 	mov    0xc0(%rax),%rax
   41e2e:	80 cc 30             	or     $0x30,%ah
   41e31:	48 89 c2             	mov    %rax,%rdx
   41e34:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e38:	48 89 90 c0 00 00 00 	mov    %rdx,0xc0(%rax)
    }
    if (flags & PROCINIT_DISABLE_INTERRUPTS) {
   41e3f:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41e42:	83 e0 02             	and    $0x2,%eax
   41e45:	85 c0                	test   %eax,%eax
   41e47:	74 1c                	je     41e65 <process_init+0xbc>
        p->p_registers.reg_rflags &= ~EFLAGS_IF;
   41e49:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e4d:	48 8b 80 c0 00 00 00 	mov    0xc0(%rax),%rax
   41e54:	80 e4 fd             	and    $0xfd,%ah
   41e57:	48 89 c2             	mov    %rax,%rdx
   41e5a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e5e:	48 89 90 c0 00 00 00 	mov    %rdx,0xc0(%rax)
    }
    p->display_status = 1;
   41e65:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   41e69:	c6 80 e8 00 00 00 01 	movb   $0x1,0xe8(%rax)
}
   41e70:	90                   	nop
   41e71:	c9                   	leave  
   41e72:	c3                   	ret    

0000000000041e73 <console_show_cursor>:

// console_show_cursor(cpos)
//    Move the console cursor to position `cpos`, which should be between 0
//    and 80 * 25.

void console_show_cursor(int cpos) {
   41e73:	55                   	push   %rbp
   41e74:	48 89 e5             	mov    %rsp,%rbp
   41e77:	48 83 ec 28          	sub    $0x28,%rsp
   41e7b:	89 7d dc             	mov    %edi,-0x24(%rbp)
    if (cpos < 0 || cpos > CONSOLE_ROWS * CONSOLE_COLUMNS) {
   41e7e:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
   41e82:	78 09                	js     41e8d <console_show_cursor+0x1a>
   41e84:	81 7d dc d0 07 00 00 	cmpl   $0x7d0,-0x24(%rbp)
   41e8b:	7e 07                	jle    41e94 <console_show_cursor+0x21>
        cpos = 0;
   41e8d:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%rbp)
   41e94:	c7 45 e4 d4 03 00 00 	movl   $0x3d4,-0x1c(%rbp)
   41e9b:	c6 45 e3 0e          	movb   $0xe,-0x1d(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41e9f:	0f b6 45 e3          	movzbl -0x1d(%rbp),%eax
   41ea3:	8b 55 e4             	mov    -0x1c(%rbp),%edx
   41ea6:	ee                   	out    %al,(%dx)
}
   41ea7:	90                   	nop
    }
    outb(0x3D4, 14);
    outb(0x3D5, cpos / 256);
   41ea8:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41eab:	8d 90 ff 00 00 00    	lea    0xff(%rax),%edx
   41eb1:	85 c0                	test   %eax,%eax
   41eb3:	0f 48 c2             	cmovs  %edx,%eax
   41eb6:	c1 f8 08             	sar    $0x8,%eax
   41eb9:	0f b6 c0             	movzbl %al,%eax
   41ebc:	c7 45 ec d5 03 00 00 	movl   $0x3d5,-0x14(%rbp)
   41ec3:	88 45 eb             	mov    %al,-0x15(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41ec6:	0f b6 45 eb          	movzbl -0x15(%rbp),%eax
   41eca:	8b 55 ec             	mov    -0x14(%rbp),%edx
   41ecd:	ee                   	out    %al,(%dx)
}
   41ece:	90                   	nop
   41ecf:	c7 45 f4 d4 03 00 00 	movl   $0x3d4,-0xc(%rbp)
   41ed6:	c6 45 f3 0f          	movb   $0xf,-0xd(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41eda:	0f b6 45 f3          	movzbl -0xd(%rbp),%eax
   41ede:	8b 55 f4             	mov    -0xc(%rbp),%edx
   41ee1:	ee                   	out    %al,(%dx)
}
   41ee2:	90                   	nop
    outb(0x3D4, 15);
    outb(0x3D5, cpos % 256);
   41ee3:	8b 45 dc             	mov    -0x24(%rbp),%eax
   41ee6:	99                   	cltd   
   41ee7:	c1 ea 18             	shr    $0x18,%edx
   41eea:	01 d0                	add    %edx,%eax
   41eec:	0f b6 c0             	movzbl %al,%eax
   41eef:	29 d0                	sub    %edx,%eax
   41ef1:	0f b6 c0             	movzbl %al,%eax
   41ef4:	c7 45 fc d5 03 00 00 	movl   $0x3d5,-0x4(%rbp)
   41efb:	88 45 fb             	mov    %al,-0x5(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   41efe:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41f02:	8b 55 fc             	mov    -0x4(%rbp),%edx
   41f05:	ee                   	out    %al,(%dx)
}
   41f06:	90                   	nop
}
   41f07:	90                   	nop
   41f08:	c9                   	leave  
   41f09:	c3                   	ret    

0000000000041f0a <keyboard_readc>:
    /*CKEY(16)*/ {{'\'', '"', 0, 0}},  /*CKEY(17)*/ {{'`', '~', 0, 0}},
    /*CKEY(18)*/ {{'\\', '|', 034, 0}},  /*CKEY(19)*/ {{',', '<', 0, 0}},
    /*CKEY(20)*/ {{'.', '>', 0, 0}},  /*CKEY(21)*/ {{'/', '?', 0, 0}}
};

int keyboard_readc(void) {
   41f0a:	55                   	push   %rbp
   41f0b:	48 89 e5             	mov    %rsp,%rbp
   41f0e:	48 83 ec 20          	sub    $0x20,%rsp
   41f12:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   41f19:	8b 45 f0             	mov    -0x10(%rbp),%eax
   41f1c:	89 c2                	mov    %eax,%edx
   41f1e:	ec                   	in     (%dx),%al
   41f1f:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   41f22:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
    static uint8_t modifiers;
    static uint8_t last_escape;

    if ((inb(KEYBOARD_STATUSREG) & KEYBOARD_STATUS_READY) == 0) {
   41f26:	0f b6 c0             	movzbl %al,%eax
   41f29:	83 e0 01             	and    $0x1,%eax
   41f2c:	85 c0                	test   %eax,%eax
   41f2e:	75 0a                	jne    41f3a <keyboard_readc+0x30>
        return -1;
   41f30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   41f35:	e9 e7 01 00 00       	jmp    42121 <keyboard_readc+0x217>
   41f3a:	c7 45 e8 60 00 00 00 	movl   $0x60,-0x18(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   41f41:	8b 45 e8             	mov    -0x18(%rbp),%eax
   41f44:	89 c2                	mov    %eax,%edx
   41f46:	ec                   	in     (%dx),%al
   41f47:	88 45 e7             	mov    %al,-0x19(%rbp)
    return data;
   41f4a:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
    }

    uint8_t data = inb(KEYBOARD_DATAREG);
   41f4e:	88 45 fb             	mov    %al,-0x5(%rbp)
    uint8_t escape = last_escape;
   41f51:	0f b6 05 8a 14 01 00 	movzbl 0x1148a(%rip),%eax        # 533e2 <last_escape.2>
   41f58:	88 45 fa             	mov    %al,-0x6(%rbp)
    last_escape = 0;
   41f5b:	c6 05 80 14 01 00 00 	movb   $0x0,0x11480(%rip)        # 533e2 <last_escape.2>

    if (data == 0xE0) {         // mode shift
   41f62:	80 7d fb e0          	cmpb   $0xe0,-0x5(%rbp)
   41f66:	75 11                	jne    41f79 <keyboard_readc+0x6f>
        last_escape = 0x80;
   41f68:	c6 05 73 14 01 00 80 	movb   $0x80,0x11473(%rip)        # 533e2 <last_escape.2>
        return 0;
   41f6f:	b8 00 00 00 00       	mov    $0x0,%eax
   41f74:	e9 a8 01 00 00       	jmp    42121 <keyboard_readc+0x217>
    } else if (data & 0x80) {   // key release: matters only for modifier keys
   41f79:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41f7d:	84 c0                	test   %al,%al
   41f7f:	79 60                	jns    41fe1 <keyboard_readc+0xd7>
        int ch = keymap[(data & 0x7F) | escape];
   41f81:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41f85:	83 e0 7f             	and    $0x7f,%eax
   41f88:	89 c2                	mov    %eax,%edx
   41f8a:	0f b6 45 fa          	movzbl -0x6(%rbp),%eax
   41f8e:	09 d0                	or     %edx,%eax
   41f90:	48 98                	cltq   
   41f92:	0f b6 80 c0 49 04 00 	movzbl 0x449c0(%rax),%eax
   41f99:	0f b6 c0             	movzbl %al,%eax
   41f9c:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if (ch >= KEY_SHIFT && ch < KEY_CAPSLOCK) {
   41f9f:	81 7d f4 f9 00 00 00 	cmpl   $0xf9,-0xc(%rbp)
   41fa6:	7e 2f                	jle    41fd7 <keyboard_readc+0xcd>
   41fa8:	81 7d f4 fc 00 00 00 	cmpl   $0xfc,-0xc(%rbp)
   41faf:	7f 26                	jg     41fd7 <keyboard_readc+0xcd>
            modifiers &= ~(1 << (ch - KEY_SHIFT));
   41fb1:	8b 45 f4             	mov    -0xc(%rbp),%eax
   41fb4:	2d fa 00 00 00       	sub    $0xfa,%eax
   41fb9:	ba 01 00 00 00       	mov    $0x1,%edx
   41fbe:	89 c1                	mov    %eax,%ecx
   41fc0:	d3 e2                	shl    %cl,%edx
   41fc2:	89 d0                	mov    %edx,%eax
   41fc4:	f7 d0                	not    %eax
   41fc6:	89 c2                	mov    %eax,%edx
   41fc8:	0f b6 05 14 14 01 00 	movzbl 0x11414(%rip),%eax        # 533e3 <modifiers.1>
   41fcf:	21 d0                	and    %edx,%eax
   41fd1:	88 05 0c 14 01 00    	mov    %al,0x1140c(%rip)        # 533e3 <modifiers.1>
        }
        return 0;
   41fd7:	b8 00 00 00 00       	mov    $0x0,%eax
   41fdc:	e9 40 01 00 00       	jmp    42121 <keyboard_readc+0x217>
    }

    int ch = (unsigned char) keymap[data | escape];
   41fe1:	0f b6 45 fb          	movzbl -0x5(%rbp),%eax
   41fe5:	0a 45 fa             	or     -0x6(%rbp),%al
   41fe8:	0f b6 c0             	movzbl %al,%eax
   41feb:	48 98                	cltq   
   41fed:	0f b6 80 c0 49 04 00 	movzbl 0x449c0(%rax),%eax
   41ff4:	0f b6 c0             	movzbl %al,%eax
   41ff7:	89 45 fc             	mov    %eax,-0x4(%rbp)

    if (ch >= 'a' && ch <= 'z') {
   41ffa:	83 7d fc 60          	cmpl   $0x60,-0x4(%rbp)
   41ffe:	7e 57                	jle    42057 <keyboard_readc+0x14d>
   42000:	83 7d fc 7a          	cmpl   $0x7a,-0x4(%rbp)
   42004:	7f 51                	jg     42057 <keyboard_readc+0x14d>
        if (modifiers & MOD_CONTROL) {
   42006:	0f b6 05 d6 13 01 00 	movzbl 0x113d6(%rip),%eax        # 533e3 <modifiers.1>
   4200d:	0f b6 c0             	movzbl %al,%eax
   42010:	83 e0 02             	and    $0x2,%eax
   42013:	85 c0                	test   %eax,%eax
   42015:	74 09                	je     42020 <keyboard_readc+0x116>
            ch -= 0x60;
   42017:	83 6d fc 60          	subl   $0x60,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   4201b:	e9 fd 00 00 00       	jmp    4211d <keyboard_readc+0x213>
        } else if (!(modifiers & MOD_SHIFT) != !(modifiers & MOD_CAPSLOCK)) {
   42020:	0f b6 05 bc 13 01 00 	movzbl 0x113bc(%rip),%eax        # 533e3 <modifiers.1>
   42027:	0f b6 c0             	movzbl %al,%eax
   4202a:	83 e0 01             	and    $0x1,%eax
   4202d:	85 c0                	test   %eax,%eax
   4202f:	0f 94 c2             	sete   %dl
   42032:	0f b6 05 aa 13 01 00 	movzbl 0x113aa(%rip),%eax        # 533e3 <modifiers.1>
   42039:	0f b6 c0             	movzbl %al,%eax
   4203c:	83 e0 08             	and    $0x8,%eax
   4203f:	85 c0                	test   %eax,%eax
   42041:	0f 94 c0             	sete   %al
   42044:	31 d0                	xor    %edx,%eax
   42046:	84 c0                	test   %al,%al
   42048:	0f 84 cf 00 00 00    	je     4211d <keyboard_readc+0x213>
            ch -= 0x20;
   4204e:	83 6d fc 20          	subl   $0x20,-0x4(%rbp)
        if (modifiers & MOD_CONTROL) {
   42052:	e9 c6 00 00 00       	jmp    4211d <keyboard_readc+0x213>
        }
    } else if (ch >= KEY_CAPSLOCK) {
   42057:	81 7d fc fc 00 00 00 	cmpl   $0xfc,-0x4(%rbp)
   4205e:	7e 30                	jle    42090 <keyboard_readc+0x186>
        modifiers ^= 1 << (ch - KEY_SHIFT);
   42060:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42063:	2d fa 00 00 00       	sub    $0xfa,%eax
   42068:	ba 01 00 00 00       	mov    $0x1,%edx
   4206d:	89 c1                	mov    %eax,%ecx
   4206f:	d3 e2                	shl    %cl,%edx
   42071:	89 d0                	mov    %edx,%eax
   42073:	89 c2                	mov    %eax,%edx
   42075:	0f b6 05 67 13 01 00 	movzbl 0x11367(%rip),%eax        # 533e3 <modifiers.1>
   4207c:	31 d0                	xor    %edx,%eax
   4207e:	88 05 5f 13 01 00    	mov    %al,0x1135f(%rip)        # 533e3 <modifiers.1>
        ch = 0;
   42084:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4208b:	e9 8e 00 00 00       	jmp    4211e <keyboard_readc+0x214>
    } else if (ch >= KEY_SHIFT) {
   42090:	81 7d fc f9 00 00 00 	cmpl   $0xf9,-0x4(%rbp)
   42097:	7e 2d                	jle    420c6 <keyboard_readc+0x1bc>
        modifiers |= 1 << (ch - KEY_SHIFT);
   42099:	8b 45 fc             	mov    -0x4(%rbp),%eax
   4209c:	2d fa 00 00 00       	sub    $0xfa,%eax
   420a1:	ba 01 00 00 00       	mov    $0x1,%edx
   420a6:	89 c1                	mov    %eax,%ecx
   420a8:	d3 e2                	shl    %cl,%edx
   420aa:	89 d0                	mov    %edx,%eax
   420ac:	89 c2                	mov    %eax,%edx
   420ae:	0f b6 05 2e 13 01 00 	movzbl 0x1132e(%rip),%eax        # 533e3 <modifiers.1>
   420b5:	09 d0                	or     %edx,%eax
   420b7:	88 05 26 13 01 00    	mov    %al,0x11326(%rip)        # 533e3 <modifiers.1>
        ch = 0;
   420bd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   420c4:	eb 58                	jmp    4211e <keyboard_readc+0x214>
    } else if (ch >= CKEY(0) && ch <= CKEY(21)) {
   420c6:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   420ca:	7e 31                	jle    420fd <keyboard_readc+0x1f3>
   420cc:	81 7d fc 95 00 00 00 	cmpl   $0x95,-0x4(%rbp)
   420d3:	7f 28                	jg     420fd <keyboard_readc+0x1f3>
        ch = complex_keymap[ch - CKEY(0)].map[modifiers & 3];
   420d5:	8b 45 fc             	mov    -0x4(%rbp),%eax
   420d8:	8d 50 80             	lea    -0x80(%rax),%edx
   420db:	0f b6 05 01 13 01 00 	movzbl 0x11301(%rip),%eax        # 533e3 <modifiers.1>
   420e2:	0f b6 c0             	movzbl %al,%eax
   420e5:	83 e0 03             	and    $0x3,%eax
   420e8:	48 98                	cltq   
   420ea:	48 63 d2             	movslq %edx,%rdx
   420ed:	0f b6 84 90 c0 4a 04 	movzbl 0x44ac0(%rax,%rdx,4),%eax
   420f4:	00 
   420f5:	0f b6 c0             	movzbl %al,%eax
   420f8:	89 45 fc             	mov    %eax,-0x4(%rbp)
   420fb:	eb 21                	jmp    4211e <keyboard_readc+0x214>
    } else if (ch < 0x80 && (modifiers & MOD_CONTROL)) {
   420fd:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
   42101:	7f 1b                	jg     4211e <keyboard_readc+0x214>
   42103:	0f b6 05 d9 12 01 00 	movzbl 0x112d9(%rip),%eax        # 533e3 <modifiers.1>
   4210a:	0f b6 c0             	movzbl %al,%eax
   4210d:	83 e0 02             	and    $0x2,%eax
   42110:	85 c0                	test   %eax,%eax
   42112:	74 0a                	je     4211e <keyboard_readc+0x214>
        ch = 0;
   42114:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4211b:	eb 01                	jmp    4211e <keyboard_readc+0x214>
        if (modifiers & MOD_CONTROL) {
   4211d:	90                   	nop
    }

    return ch;
   4211e:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
   42121:	c9                   	leave  
   42122:	c3                   	ret    

0000000000042123 <delay>:
#define IO_PARALLEL1_CONTROL    0x37A
# define IO_PARALLEL_CONTROL_SELECT     0x08
# define IO_PARALLEL_CONTROL_INIT       0x04
# define IO_PARALLEL_CONTROL_STROBE     0x01

static void delay(void) {
   42123:	55                   	push   %rbp
   42124:	48 89 e5             	mov    %rsp,%rbp
   42127:	48 83 ec 20          	sub    $0x20,%rsp
   4212b:	c7 45 e4 84 00 00 00 	movl   $0x84,-0x1c(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   42132:	8b 45 e4             	mov    -0x1c(%rbp),%eax
   42135:	89 c2                	mov    %eax,%edx
   42137:	ec                   	in     (%dx),%al
   42138:	88 45 e3             	mov    %al,-0x1d(%rbp)
   4213b:	c7 45 ec 84 00 00 00 	movl   $0x84,-0x14(%rbp)
   42142:	8b 45 ec             	mov    -0x14(%rbp),%eax
   42145:	89 c2                	mov    %eax,%edx
   42147:	ec                   	in     (%dx),%al
   42148:	88 45 eb             	mov    %al,-0x15(%rbp)
   4214b:	c7 45 f4 84 00 00 00 	movl   $0x84,-0xc(%rbp)
   42152:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42155:	89 c2                	mov    %eax,%edx
   42157:	ec                   	in     (%dx),%al
   42158:	88 45 f3             	mov    %al,-0xd(%rbp)
   4215b:	c7 45 fc 84 00 00 00 	movl   $0x84,-0x4(%rbp)
   42162:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42165:	89 c2                	mov    %eax,%edx
   42167:	ec                   	in     (%dx),%al
   42168:	88 45 fb             	mov    %al,-0x5(%rbp)
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
    (void) inb(0x84);
}
   4216b:	90                   	nop
   4216c:	c9                   	leave  
   4216d:	c3                   	ret    

000000000004216e <parallel_port_putc>:

static void parallel_port_putc(printer* p, unsigned char c, int color) {
   4216e:	55                   	push   %rbp
   4216f:	48 89 e5             	mov    %rsp,%rbp
   42172:	48 83 ec 40          	sub    $0x40,%rsp
   42176:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   4217a:	89 f0                	mov    %esi,%eax
   4217c:	89 55 c0             	mov    %edx,-0x40(%rbp)
   4217f:	88 45 c4             	mov    %al,-0x3c(%rbp)
    static int initialized;
    (void) p, (void) color;
    if (!initialized) {
   42182:	8b 05 5c 12 01 00    	mov    0x1125c(%rip),%eax        # 533e4 <initialized.0>
   42188:	85 c0                	test   %eax,%eax
   4218a:	75 1e                	jne    421aa <parallel_port_putc+0x3c>
   4218c:	c7 45 f8 7a 03 00 00 	movl   $0x37a,-0x8(%rbp)
   42193:	c6 45 f7 00          	movb   $0x0,-0x9(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42197:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
   4219b:	8b 55 f8             	mov    -0x8(%rbp),%edx
   4219e:	ee                   	out    %al,(%dx)
}
   4219f:	90                   	nop
        outb(IO_PARALLEL1_CONTROL, 0);
        initialized = 1;
   421a0:	c7 05 3a 12 01 00 01 	movl   $0x1,0x1123a(%rip)        # 533e4 <initialized.0>
   421a7:	00 00 00 
    }

    for (int i = 0;
   421aa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   421b1:	eb 09                	jmp    421bc <parallel_port_putc+0x4e>
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
         ++i) {
        delay();
   421b3:	e8 6b ff ff ff       	call   42123 <delay>
         ++i) {
   421b8:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
         i < 12800 && (inb(IO_PARALLEL1_STATUS) & IO_PARALLEL_STATUS_BUSY) == 0;
   421bc:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%rbp)
   421c3:	7f 18                	jg     421dd <parallel_port_putc+0x6f>
   421c5:	c7 45 f0 79 03 00 00 	movl   $0x379,-0x10(%rbp)
    asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
   421cc:	8b 45 f0             	mov    -0x10(%rbp),%eax
   421cf:	89 c2                	mov    %eax,%edx
   421d1:	ec                   	in     (%dx),%al
   421d2:	88 45 ef             	mov    %al,-0x11(%rbp)
    return data;
   421d5:	0f b6 45 ef          	movzbl -0x11(%rbp),%eax
   421d9:	84 c0                	test   %al,%al
   421db:	79 d6                	jns    421b3 <parallel_port_putc+0x45>
    }
    outb(IO_PARALLEL1_DATA, c);
   421dd:	0f b6 45 c4          	movzbl -0x3c(%rbp),%eax
   421e1:	c7 45 d8 78 03 00 00 	movl   $0x378,-0x28(%rbp)
   421e8:	88 45 d7             	mov    %al,-0x29(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   421eb:	0f b6 45 d7          	movzbl -0x29(%rbp),%eax
   421ef:	8b 55 d8             	mov    -0x28(%rbp),%edx
   421f2:	ee                   	out    %al,(%dx)
}
   421f3:	90                   	nop
   421f4:	c7 45 e0 7a 03 00 00 	movl   $0x37a,-0x20(%rbp)
   421fb:	c6 45 df 0d          	movb   $0xd,-0x21(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   421ff:	0f b6 45 df          	movzbl -0x21(%rbp),%eax
   42203:	8b 55 e0             	mov    -0x20(%rbp),%edx
   42206:	ee                   	out    %al,(%dx)
}
   42207:	90                   	nop
   42208:	c7 45 e8 7a 03 00 00 	movl   $0x37a,-0x18(%rbp)
   4220f:	c6 45 e7 0c          	movb   $0xc,-0x19(%rbp)
    asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
   42213:	0f b6 45 e7          	movzbl -0x19(%rbp),%eax
   42217:	8b 55 e8             	mov    -0x18(%rbp),%edx
   4221a:	ee                   	out    %al,(%dx)
}
   4221b:	90                   	nop
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT | IO_PARALLEL_CONTROL_STROBE);
    outb(IO_PARALLEL1_CONTROL, IO_PARALLEL_CONTROL_SELECT
         | IO_PARALLEL_CONTROL_INIT);
}
   4221c:	90                   	nop
   4221d:	c9                   	leave  
   4221e:	c3                   	ret    

000000000004221f <log_vprintf>:

void log_vprintf(const char* format, va_list val) {
   4221f:	55                   	push   %rbp
   42220:	48 89 e5             	mov    %rsp,%rbp
   42223:	48 83 ec 20          	sub    $0x20,%rsp
   42227:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4222b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    printer p;
    p.putc = parallel_port_putc;
   4222f:	48 c7 45 f8 6e 21 04 	movq   $0x4216e,-0x8(%rbp)
   42236:	00 
    printer_vprintf(&p, 0, format, val);
   42237:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
   4223b:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
   4223f:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
   42243:	be 00 00 00 00       	mov    $0x0,%esi
   42248:	48 89 c7             	mov    %rax,%rdi
   4224b:	e8 33 10 00 00       	call   43283 <printer_vprintf>
}
   42250:	90                   	nop
   42251:	c9                   	leave  
   42252:	c3                   	ret    

0000000000042253 <log_printf>:

void log_printf(const char* format, ...) {
   42253:	55                   	push   %rbp
   42254:	48 89 e5             	mov    %rsp,%rbp
   42257:	48 83 ec 60          	sub    $0x60,%rsp
   4225b:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   4225f:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   42263:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   42267:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   4226b:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   4226f:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   42273:	c7 45 b8 08 00 00 00 	movl   $0x8,-0x48(%rbp)
   4227a:	48 8d 45 10          	lea    0x10(%rbp),%rax
   4227e:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   42282:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   42286:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    log_vprintf(format, val);
   4228a:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
   4228e:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42292:	48 89 d6             	mov    %rdx,%rsi
   42295:	48 89 c7             	mov    %rax,%rdi
   42298:	e8 82 ff ff ff       	call   4221f <log_vprintf>
    va_end(val);
}
   4229d:	90                   	nop
   4229e:	c9                   	leave  
   4229f:	c3                   	ret    

00000000000422a0 <error_vprintf>:

// error_printf, error_vprintf
//    Print debugging messages to the console and to the host's
//    `log.txt` file via `log_printf`.

int error_vprintf(int cpos, int color, const char* format, va_list val) {
   422a0:	55                   	push   %rbp
   422a1:	48 89 e5             	mov    %rsp,%rbp
   422a4:	48 83 ec 40          	sub    $0x40,%rsp
   422a8:	89 7d dc             	mov    %edi,-0x24(%rbp)
   422ab:	89 75 d8             	mov    %esi,-0x28(%rbp)
   422ae:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
   422b2:	48 89 4d c8          	mov    %rcx,-0x38(%rbp)
    va_list val2;
    __builtin_va_copy(val2, val);
   422b6:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
   422ba:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   422be:	48 8b 0a             	mov    (%rdx),%rcx
   422c1:	48 89 08             	mov    %rcx,(%rax)
   422c4:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
   422c8:	48 89 48 08          	mov    %rcx,0x8(%rax)
   422cc:	48 8b 52 10          	mov    0x10(%rdx),%rdx
   422d0:	48 89 50 10          	mov    %rdx,0x10(%rax)
    log_vprintf(format, val2);
   422d4:	48 8d 55 e8          	lea    -0x18(%rbp),%rdx
   422d8:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   422dc:	48 89 d6             	mov    %rdx,%rsi
   422df:	48 89 c7             	mov    %rax,%rdi
   422e2:	e8 38 ff ff ff       	call   4221f <log_vprintf>
    va_end(val2);
    return console_vprintf(cpos, color, format, val);
   422e7:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   422eb:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   422ef:	8b 75 d8             	mov    -0x28(%rbp),%esi
   422f2:	8b 45 dc             	mov    -0x24(%rbp),%eax
   422f5:	89 c7                	mov    %eax,%edi
   422f7:	e8 66 16 00 00       	call   43962 <console_vprintf>
}
   422fc:	c9                   	leave  
   422fd:	c3                   	ret    

00000000000422fe <error_printf>:

int error_printf(int cpos, int color, const char* format, ...) {
   422fe:	55                   	push   %rbp
   422ff:	48 89 e5             	mov    %rsp,%rbp
   42302:	48 83 ec 60          	sub    $0x60,%rsp
   42306:	89 7d ac             	mov    %edi,-0x54(%rbp)
   42309:	89 75 a8             	mov    %esi,-0x58(%rbp)
   4230c:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
   42310:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   42314:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   42318:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   4231c:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   42323:	48 8d 45 10          	lea    0x10(%rbp),%rax
   42327:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   4232b:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4232f:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = error_vprintf(cpos, color, format, val);
   42333:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   42337:	48 8b 55 a0          	mov    -0x60(%rbp),%rdx
   4233b:	8b 75 a8             	mov    -0x58(%rbp),%esi
   4233e:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42341:	89 c7                	mov    %eax,%edi
   42343:	e8 58 ff ff ff       	call   422a0 <error_vprintf>
   42348:	89 45 ac             	mov    %eax,-0x54(%rbp)
    va_end(val);
    return cpos;
   4234b:	8b 45 ac             	mov    -0x54(%rbp),%eax
}
   4234e:	c9                   	leave  
   4234f:	c3                   	ret    

0000000000042350 <check_keyboard>:
//    Check for the user typing a control key. 'a', 'm', and 'c' cause a soft
//    reboot where the kernel runs the allocator programs, "malloc", or
//    "alloctests", respectively. Control-C or 'q' exit the virtual machine.
//    Returns key typed or -1 for no key.

int check_keyboard(void) {
   42350:	55                   	push   %rbp
   42351:	48 89 e5             	mov    %rsp,%rbp
   42354:	53                   	push   %rbx
   42355:	48 83 ec 48          	sub    $0x48,%rsp
    int c = keyboard_readc();
   42359:	e8 ac fb ff ff       	call   41f0a <keyboard_readc>
   4235e:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    if (c == 'a' || c == 'm' || c == 'c' || c == 't'|| c =='2') {
   42361:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   42365:	74 1c                	je     42383 <check_keyboard+0x33>
   42367:	83 7d e4 6d          	cmpl   $0x6d,-0x1c(%rbp)
   4236b:	74 16                	je     42383 <check_keyboard+0x33>
   4236d:	83 7d e4 63          	cmpl   $0x63,-0x1c(%rbp)
   42371:	74 10                	je     42383 <check_keyboard+0x33>
   42373:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   42377:	74 0a                	je     42383 <check_keyboard+0x33>
   42379:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   4237d:	0f 85 e9 00 00 00    	jne    4246c <check_keyboard+0x11c>
        // Install a temporary page table to carry us through the
        // process of reinitializing memory. This replicates work the
        // bootloader does.
        x86_64_pagetable* pt = (x86_64_pagetable*) 0x8000;
   42383:	48 c7 45 d8 00 80 00 	movq   $0x8000,-0x28(%rbp)
   4238a:	00 
        memset(pt, 0, PAGESIZE * 3);
   4238b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4238f:	ba 00 30 00 00       	mov    $0x3000,%edx
   42394:	be 00 00 00 00       	mov    $0x0,%esi
   42399:	48 89 c7             	mov    %rax,%rdi
   4239c:	e8 d1 0d 00 00       	call   43172 <memset>
        pt[0].entry[0] = 0x9000 | PTE_P | PTE_W | PTE_U;
   423a1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   423a5:	48 c7 00 07 90 00 00 	movq   $0x9007,(%rax)
        pt[1].entry[0] = 0xA000 | PTE_P | PTE_W | PTE_U;
   423ac:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   423b0:	48 05 00 10 00 00    	add    $0x1000,%rax
   423b6:	48 c7 00 07 a0 00 00 	movq   $0xa007,(%rax)
        pt[2].entry[0] = PTE_P | PTE_W | PTE_U | PTE_PS;
   423bd:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   423c1:	48 05 00 20 00 00    	add    $0x2000,%rax
   423c7:	48 c7 00 87 00 00 00 	movq   $0x87,(%rax)
        lcr3((uintptr_t) pt);
   423ce:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   423d2:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
}

static inline void lcr3(uintptr_t val) {
    asm volatile("" : : : "memory");
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   423d6:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   423da:	0f 22 d8             	mov    %rax,%cr3
}
   423dd:	90                   	nop
        // The soft reboot process doesn't modify memory, so it's
        // safe to pass `multiboot_info` on the kernel stack, even
        // though it will get overwritten as the kernel runs.
        uint32_t multiboot_info[5];
        multiboot_info[0] = 4;
   423de:	c7 45 b4 04 00 00 00 	movl   $0x4,-0x4c(%rbp)
        const char* argument = "malloc";
   423e5:	48 c7 45 e8 18 4b 04 	movq   $0x44b18,-0x18(%rbp)
   423ec:	00 
        if (c == 'a') {
   423ed:	83 7d e4 61          	cmpl   $0x61,-0x1c(%rbp)
   423f1:	75 0a                	jne    423fd <check_keyboard+0xad>
            argument = "allocator";
   423f3:	48 c7 45 e8 1f 4b 04 	movq   $0x44b1f,-0x18(%rbp)
   423fa:	00 
   423fb:	eb 2e                	jmp    4242b <check_keyboard+0xdb>
        } else if (c == 'c') {
   423fd:	83 7d e4 63          	cmpl   $0x63,-0x1c(%rbp)
   42401:	75 0a                	jne    4240d <check_keyboard+0xbd>
            argument = "alloctests";
   42403:	48 c7 45 e8 29 4b 04 	movq   $0x44b29,-0x18(%rbp)
   4240a:	00 
   4240b:	eb 1e                	jmp    4242b <check_keyboard+0xdb>
        } else if(c == 't'){
   4240d:	83 7d e4 74          	cmpl   $0x74,-0x1c(%rbp)
   42411:	75 0a                	jne    4241d <check_keyboard+0xcd>
            argument = "test";
   42413:	48 c7 45 e8 34 4b 04 	movq   $0x44b34,-0x18(%rbp)
   4241a:	00 
   4241b:	eb 0e                	jmp    4242b <check_keyboard+0xdb>
        }
        else if(c == '2'){
   4241d:	83 7d e4 32          	cmpl   $0x32,-0x1c(%rbp)
   42421:	75 08                	jne    4242b <check_keyboard+0xdb>
            argument = "test2";
   42423:	48 c7 45 e8 39 4b 04 	movq   $0x44b39,-0x18(%rbp)
   4242a:	00 
        }
        uintptr_t argument_ptr = (uintptr_t) argument;
   4242b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4242f:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
        assert(argument_ptr < 0x100000000L);
   42433:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42438:	48 39 45 d0          	cmp    %rax,-0x30(%rbp)
   4243c:	76 14                	jbe    42452 <check_keyboard+0x102>
   4243e:	ba 3f 4b 04 00       	mov    $0x44b3f,%edx
   42443:	be 5c 02 00 00       	mov    $0x25c,%esi
   42448:	bf 5b 4b 04 00       	mov    $0x44b5b,%edi
   4244d:	e8 1f 01 00 00       	call   42571 <assert_fail>
        multiboot_info[4] = (uint32_t) argument_ptr;
   42452:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42456:	89 45 c4             	mov    %eax,-0x3c(%rbp)
        asm volatile("movl $0x2BADB002, %%eax; jmp entry_from_boot"
   42459:	48 8d 45 b4          	lea    -0x4c(%rbp),%rax
   4245d:	48 89 c3             	mov    %rax,%rbx
   42460:	b8 02 b0 ad 2b       	mov    $0x2badb002,%eax
   42465:	e9 96 db ff ff       	jmp    40000 <entry_from_boot>
    if (c == 'a' || c == 'm' || c == 'c' || c == 't'|| c =='2') {
   4246a:	eb 11                	jmp    4247d <check_keyboard+0x12d>
                     : : "b" (multiboot_info) : "memory");
    } else if (c == 0x03 || c == 'q') {
   4246c:	83 7d e4 03          	cmpl   $0x3,-0x1c(%rbp)
   42470:	74 06                	je     42478 <check_keyboard+0x128>
   42472:	83 7d e4 71          	cmpl   $0x71,-0x1c(%rbp)
   42476:	75 05                	jne    4247d <check_keyboard+0x12d>
        poweroff();
   42478:	e8 a3 f8 ff ff       	call   41d20 <poweroff>
    }
    return c;
   4247d:	8b 45 e4             	mov    -0x1c(%rbp),%eax
}
   42480:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   42484:	c9                   	leave  
   42485:	c3                   	ret    

0000000000042486 <fail>:

// fail
//    Loop until user presses Control-C, then poweroff.

static void fail(void) __attribute__((noreturn));
static void fail(void) {
   42486:	55                   	push   %rbp
   42487:	48 89 e5             	mov    %rsp,%rbp
    while (1) {
        check_keyboard();
   4248a:	e8 c1 fe ff ff       	call   42350 <check_keyboard>
   4248f:	eb f9                	jmp    4248a <fail+0x4>

0000000000042491 <kernel_panic>:

// kernel_panic, assert_fail
//    Use console_printf() to print a failure message and then wait for
//    control-C. Also write the failure message to the log.

void kernel_panic(const char* format, ...) {
   42491:	55                   	push   %rbp
   42492:	48 89 e5             	mov    %rsp,%rbp
   42495:	48 83 ec 60          	sub    $0x60,%rsp
   42499:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   4249d:	48 89 75 d8          	mov    %rsi,-0x28(%rbp)
   424a1:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
   424a5:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   424a9:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   424ad:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   424b1:	c7 45 b0 08 00 00 00 	movl   $0x8,-0x50(%rbp)
   424b8:	48 8d 45 10          	lea    0x10(%rbp),%rax
   424bc:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
   424c0:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   424c4:	48 89 45 c0          	mov    %rax,-0x40(%rbp)

    if (format) {
   424c8:	48 83 7d a8 00       	cmpq   $0x0,-0x58(%rbp)
   424cd:	0f 84 80 00 00 00    	je     42553 <kernel_panic+0xc2>
        // Print kernel_panic message to both the screen and the log
        int cpos = error_printf(CPOS(23, 0), 0xC000, "PANIC: ");
   424d3:	ba 68 4b 04 00       	mov    $0x44b68,%edx
   424d8:	be 00 c0 00 00       	mov    $0xc000,%esi
   424dd:	bf 30 07 00 00       	mov    $0x730,%edi
   424e2:	b8 00 00 00 00       	mov    $0x0,%eax
   424e7:	e8 12 fe ff ff       	call   422fe <error_printf>
   424ec:	89 45 cc             	mov    %eax,-0x34(%rbp)
        cpos = error_vprintf(cpos, 0xC000, format, val);
   424ef:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
   424f3:	48 8b 55 a8          	mov    -0x58(%rbp),%rdx
   424f7:	8b 45 cc             	mov    -0x34(%rbp),%eax
   424fa:	be 00 c0 00 00       	mov    $0xc000,%esi
   424ff:	89 c7                	mov    %eax,%edi
   42501:	e8 9a fd ff ff       	call   422a0 <error_vprintf>
   42506:	89 45 cc             	mov    %eax,-0x34(%rbp)
        if (CCOL(cpos)) {
   42509:	8b 4d cc             	mov    -0x34(%rbp),%ecx
   4250c:	48 63 c1             	movslq %ecx,%rax
   4250f:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
   42516:	48 c1 e8 20          	shr    $0x20,%rax
   4251a:	c1 f8 05             	sar    $0x5,%eax
   4251d:	89 ce                	mov    %ecx,%esi
   4251f:	c1 fe 1f             	sar    $0x1f,%esi
   42522:	29 f0                	sub    %esi,%eax
   42524:	89 c2                	mov    %eax,%edx
   42526:	89 d0                	mov    %edx,%eax
   42528:	c1 e0 02             	shl    $0x2,%eax
   4252b:	01 d0                	add    %edx,%eax
   4252d:	c1 e0 04             	shl    $0x4,%eax
   42530:	29 c1                	sub    %eax,%ecx
   42532:	89 ca                	mov    %ecx,%edx
   42534:	85 d2                	test   %edx,%edx
   42536:	74 34                	je     4256c <kernel_panic+0xdb>
            error_printf(cpos, 0xC000, "\n");
   42538:	8b 45 cc             	mov    -0x34(%rbp),%eax
   4253b:	ba 70 4b 04 00       	mov    $0x44b70,%edx
   42540:	be 00 c0 00 00       	mov    $0xc000,%esi
   42545:	89 c7                	mov    %eax,%edi
   42547:	b8 00 00 00 00       	mov    $0x0,%eax
   4254c:	e8 ad fd ff ff       	call   422fe <error_printf>
   42551:	eb 19                	jmp    4256c <kernel_panic+0xdb>
        }
    } else {
        error_printf(CPOS(23, 0), 0xC000, "PANIC");
   42553:	ba 72 4b 04 00       	mov    $0x44b72,%edx
   42558:	be 00 c0 00 00       	mov    $0xc000,%esi
   4255d:	bf 30 07 00 00       	mov    $0x730,%edi
   42562:	b8 00 00 00 00       	mov    $0x0,%eax
   42567:	e8 92 fd ff ff       	call   422fe <error_printf>
    }

    va_end(val);
    fail();
   4256c:	e8 15 ff ff ff       	call   42486 <fail>

0000000000042571 <assert_fail>:
}

void assert_fail(const char* file, int line, const char* msg) {
   42571:	55                   	push   %rbp
   42572:	48 89 e5             	mov    %rsp,%rbp
   42575:	48 83 ec 20          	sub    $0x20,%rsp
   42579:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   4257d:	89 75 f4             	mov    %esi,-0xc(%rbp)
   42580:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    kernel_panic("%s:%d: assertion '%s' failed\n", file, line, msg);
   42584:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
   42588:	8b 55 f4             	mov    -0xc(%rbp),%edx
   4258b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4258f:	48 89 c6             	mov    %rax,%rsi
   42592:	bf 78 4b 04 00       	mov    $0x44b78,%edi
   42597:	b8 00 00 00 00       	mov    $0x0,%eax
   4259c:	e8 f0 fe ff ff       	call   42491 <kernel_panic>

00000000000425a1 <default_exception>:
}

void default_exception(proc* p){
   425a1:	55                   	push   %rbp
   425a2:	48 89 e5             	mov    %rsp,%rbp
   425a5:	48 83 ec 20          	sub    $0x20,%rsp
   425a9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    x86_64_registers * reg = &(p->p_registers);
   425ad:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   425b1:	48 83 c0 18          	add    $0x18,%rax
   425b5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    kernel_panic("Unexpected exception %d!\n", reg->reg_intno);
   425b9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   425bd:	48 8b 80 88 00 00 00 	mov    0x88(%rax),%rax
   425c4:	48 89 c6             	mov    %rax,%rsi
   425c7:	bf 96 4b 04 00       	mov    $0x44b96,%edi
   425cc:	b8 00 00 00 00       	mov    $0x0,%eax
   425d1:	e8 bb fe ff ff       	call   42491 <kernel_panic>

00000000000425d6 <pageindex>:
static inline int pageindex(uintptr_t addr, int level) {
   425d6:	55                   	push   %rbp
   425d7:	48 89 e5             	mov    %rsp,%rbp
   425da:	48 83 ec 10          	sub    $0x10,%rsp
   425de:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
   425e2:	89 75 f4             	mov    %esi,-0xc(%rbp)
    assert(level >= 0 && level <= 3);
   425e5:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
   425e9:	78 06                	js     425f1 <pageindex+0x1b>
   425eb:	83 7d f4 03          	cmpl   $0x3,-0xc(%rbp)
   425ef:	7e 14                	jle    42605 <pageindex+0x2f>
   425f1:	ba b0 4b 04 00       	mov    $0x44bb0,%edx
   425f6:	be 1e 00 00 00       	mov    $0x1e,%esi
   425fb:	bf c9 4b 04 00       	mov    $0x44bc9,%edi
   42600:	e8 6c ff ff ff       	call   42571 <assert_fail>
    return (int) (addr >> (PAGEOFFBITS + (3 - level) * PAGEINDEXBITS)) & 0x1FF;
   42605:	b8 03 00 00 00       	mov    $0x3,%eax
   4260a:	2b 45 f4             	sub    -0xc(%rbp),%eax
   4260d:	89 c2                	mov    %eax,%edx
   4260f:	89 d0                	mov    %edx,%eax
   42611:	c1 e0 03             	shl    $0x3,%eax
   42614:	01 d0                	add    %edx,%eax
   42616:	83 c0 0c             	add    $0xc,%eax
   42619:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4261d:	89 c1                	mov    %eax,%ecx
   4261f:	48 d3 ea             	shr    %cl,%rdx
   42622:	48 89 d0             	mov    %rdx,%rax
   42625:	25 ff 01 00 00       	and    $0x1ff,%eax
}
   4262a:	c9                   	leave  
   4262b:	c3                   	ret    

000000000004262c <virtual_memory_init>:

static x86_64_pagetable kernel_pagetables[5];
x86_64_pagetable* kernel_pagetable;


void virtual_memory_init(void) {
   4262c:	55                   	push   %rbp
   4262d:	48 89 e5             	mov    %rsp,%rbp
   42630:	48 83 ec 20          	sub    $0x20,%rsp
    kernel_pagetable = &kernel_pagetables[0];
   42634:	48 c7 05 c1 19 01 00 	movq   $0x55000,0x119c1(%rip)        # 54000 <kernel_pagetable>
   4263b:	00 50 05 00 
    memset(kernel_pagetables, 0, sizeof(kernel_pagetables));
   4263f:	ba 00 50 00 00       	mov    $0x5000,%edx
   42644:	be 00 00 00 00       	mov    $0x0,%esi
   42649:	bf 00 50 05 00       	mov    $0x55000,%edi
   4264e:	e8 1f 0b 00 00       	call   43172 <memset>

    // connect the pagetable pages
    kernel_pagetables[0].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[1] | PTE_P | PTE_W | PTE_U;
   42653:	b8 00 60 05 00       	mov    $0x56000,%eax
   42658:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[0].entry[0] =
   4265c:	48 89 05 9d 29 01 00 	mov    %rax,0x1299d(%rip)        # 55000 <kernel_pagetables>
    kernel_pagetables[1].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[2] | PTE_P | PTE_W | PTE_U;
   42663:	b8 00 70 05 00       	mov    $0x57000,%eax
   42668:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[1].entry[0] =
   4266c:	48 89 05 8d 39 01 00 	mov    %rax,0x1398d(%rip)        # 56000 <kernel_pagetables+0x1000>
    kernel_pagetables[2].entry[0] =
        (x86_64_pageentry_t) &kernel_pagetables[3] | PTE_P | PTE_W | PTE_U;
   42673:	b8 00 80 05 00       	mov    $0x58000,%eax
   42678:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[0] =
   4267c:	48 89 05 7d 49 01 00 	mov    %rax,0x1497d(%rip)        # 57000 <kernel_pagetables+0x2000>
    kernel_pagetables[2].entry[1] =
        (x86_64_pageentry_t) &kernel_pagetables[4] | PTE_P | PTE_W | PTE_U;
   42683:	b8 00 90 05 00       	mov    $0x59000,%eax
   42688:	48 83 c8 07          	or     $0x7,%rax
    kernel_pagetables[2].entry[1] =
   4268c:	48 89 05 75 49 01 00 	mov    %rax,0x14975(%rip)        # 57008 <kernel_pagetables+0x2008>

    // identity map the page table
    virtual_memory_map(kernel_pagetable, (uintptr_t) 0, (uintptr_t) 0,
   42693:	48 8b 05 66 19 01 00 	mov    0x11966(%rip),%rax        # 54000 <kernel_pagetable>
   4269a:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   426a0:	b9 00 00 20 00       	mov    $0x200000,%ecx
   426a5:	ba 00 00 00 00       	mov    $0x0,%edx
   426aa:	be 00 00 00 00       	mov    $0x0,%esi
   426af:	48 89 c7             	mov    %rax,%rdi
   426b2:	e8 b9 01 00 00       	call   42870 <virtual_memory_map>
                       MEMSIZE_PHYSICAL, PTE_P | PTE_W | PTE_U);

    // check if kernel is identity mapped
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   426b7:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   426be:	00 
   426bf:	eb 62                	jmp    42723 <virtual_memory_init+0xf7>
        vamapping vmap = virtual_memory_lookup(kernel_pagetable, addr);
   426c1:	48 8b 0d 38 19 01 00 	mov    0x11938(%rip),%rcx        # 54000 <kernel_pagetable>
   426c8:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   426cc:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   426d0:	48 89 ce             	mov    %rcx,%rsi
   426d3:	48 89 c7             	mov    %rax,%rdi
   426d6:	e8 58 05 00 00       	call   42c33 <virtual_memory_lookup>
        // this assert will probably fail initially!
        // have you implemented virtual_memory_map and lookup_l4pagetable ?
        assert(vmap.pa == addr);
   426db:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   426df:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
   426e3:	74 14                	je     426f9 <virtual_memory_init+0xcd>
   426e5:	ba d2 4b 04 00       	mov    $0x44bd2,%edx
   426ea:	be 2d 00 00 00       	mov    $0x2d,%esi
   426ef:	bf e2 4b 04 00       	mov    $0x44be2,%edi
   426f4:	e8 78 fe ff ff       	call   42571 <assert_fail>
        assert((vmap.perm & (PTE_P|PTE_W)) == (PTE_P|PTE_W));
   426f9:	8b 45 f0             	mov    -0x10(%rbp),%eax
   426fc:	48 98                	cltq   
   426fe:	83 e0 03             	and    $0x3,%eax
   42701:	48 83 f8 03          	cmp    $0x3,%rax
   42705:	74 14                	je     4271b <virtual_memory_init+0xef>
   42707:	ba e8 4b 04 00       	mov    $0x44be8,%edx
   4270c:	be 2e 00 00 00       	mov    $0x2e,%esi
   42711:	bf e2 4b 04 00       	mov    $0x44be2,%edi
   42716:	e8 56 fe ff ff       	call   42571 <assert_fail>
    for(uintptr_t addr = 0 ; addr < MEMSIZE_PHYSICAL ; addr += PAGESIZE){
   4271b:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   42722:	00 
   42723:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   4272a:	00 
   4272b:	76 94                	jbe    426c1 <virtual_memory_init+0x95>
    }

    // set pointer to this pagetable in the CR3 register
    // set_pagetable also does several checks for a valid pagetable
    set_pagetable(kernel_pagetable);
   4272d:	48 8b 05 cc 18 01 00 	mov    0x118cc(%rip),%rax        # 54000 <kernel_pagetable>
   42734:	48 89 c7             	mov    %rax,%rdi
   42737:	e8 03 00 00 00       	call   4273f <set_pagetable>
}
   4273c:	90                   	nop
   4273d:	c9                   	leave  
   4273e:	c3                   	ret    

000000000004273f <set_pagetable>:
// set_pagetable
//    Change page directory. lcr3() is the hardware instruction;
//    set_pagetable() additionally checks that important kernel procedures are
//    mappable in `pagetable`, and calls kernel_panic() if they aren't.

void set_pagetable(x86_64_pagetable* pagetable) {
   4273f:	55                   	push   %rbp
   42740:	48 89 e5             	mov    %rsp,%rbp
   42743:	48 83 c4 80          	add    $0xffffffffffffff80,%rsp
   42747:	48 89 7d 88          	mov    %rdi,-0x78(%rbp)
    assert(PAGEOFFSET(pagetable) == 0); // must be page aligned
   4274b:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   4274f:	25 ff 0f 00 00       	and    $0xfff,%eax
   42754:	48 85 c0             	test   %rax,%rax
   42757:	74 14                	je     4276d <set_pagetable+0x2e>
   42759:	ba 15 4c 04 00       	mov    $0x44c15,%edx
   4275e:	be 3d 00 00 00       	mov    $0x3d,%esi
   42763:	bf e2 4b 04 00       	mov    $0x44be2,%edi
   42768:	e8 04 fe ff ff       	call   42571 <assert_fail>
    // check for kernel space being mapped in pagetable
    assert(virtual_memory_lookup(pagetable, (uintptr_t) default_int_handler).pa
   4276d:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   42772:	48 8d 45 98          	lea    -0x68(%rbp),%rax
   42776:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   4277a:	48 89 ce             	mov    %rcx,%rsi
   4277d:	48 89 c7             	mov    %rax,%rdi
   42780:	e8 ae 04 00 00       	call   42c33 <virtual_memory_lookup>
   42785:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42789:	ba 9c 00 04 00       	mov    $0x4009c,%edx
   4278e:	48 39 d0             	cmp    %rdx,%rax
   42791:	74 14                	je     427a7 <set_pagetable+0x68>
   42793:	ba 30 4c 04 00       	mov    $0x44c30,%edx
   42798:	be 3f 00 00 00       	mov    $0x3f,%esi
   4279d:	bf e2 4b 04 00       	mov    $0x44be2,%edi
   427a2:	e8 ca fd ff ff       	call   42571 <assert_fail>
           == (uintptr_t) default_int_handler);
    assert(virtual_memory_lookup(kernel_pagetable, (uintptr_t) pagetable).pa
   427a7:	48 8b 55 88          	mov    -0x78(%rbp),%rdx
   427ab:	48 8b 0d 4e 18 01 00 	mov    0x1184e(%rip),%rcx        # 54000 <kernel_pagetable>
   427b2:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   427b6:	48 89 ce             	mov    %rcx,%rsi
   427b9:	48 89 c7             	mov    %rax,%rdi
   427bc:	e8 72 04 00 00       	call   42c33 <virtual_memory_lookup>
   427c1:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   427c5:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   427c9:	48 39 c2             	cmp    %rax,%rdx
   427cc:	74 14                	je     427e2 <set_pagetable+0xa3>
   427ce:	ba 98 4c 04 00       	mov    $0x44c98,%edx
   427d3:	be 41 00 00 00       	mov    $0x41,%esi
   427d8:	bf e2 4b 04 00       	mov    $0x44be2,%edi
   427dd:	e8 8f fd ff ff       	call   42571 <assert_fail>
           == (uintptr_t) pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) kernel_pagetable).pa
   427e2:	48 8b 05 17 18 01 00 	mov    0x11817(%rip),%rax        # 54000 <kernel_pagetable>
   427e9:	48 89 c2             	mov    %rax,%rdx
   427ec:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
   427f0:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   427f4:	48 89 ce             	mov    %rcx,%rsi
   427f7:	48 89 c7             	mov    %rax,%rdi
   427fa:	e8 34 04 00 00       	call   42c33 <virtual_memory_lookup>
   427ff:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42803:	48 8b 15 f6 17 01 00 	mov    0x117f6(%rip),%rdx        # 54000 <kernel_pagetable>
   4280a:	48 39 d0             	cmp    %rdx,%rax
   4280d:	74 14                	je     42823 <set_pagetable+0xe4>
   4280f:	ba f8 4c 04 00       	mov    $0x44cf8,%edx
   42814:	be 43 00 00 00       	mov    $0x43,%esi
   42819:	bf e2 4b 04 00       	mov    $0x44be2,%edi
   4281e:	e8 4e fd ff ff       	call   42571 <assert_fail>
           == (uintptr_t) kernel_pagetable);
    assert(virtual_memory_lookup(pagetable, (uintptr_t) virtual_memory_map).pa
   42823:	ba 70 28 04 00       	mov    $0x42870,%edx
   42828:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
   4282c:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
   42830:	48 89 ce             	mov    %rcx,%rsi
   42833:	48 89 c7             	mov    %rax,%rdi
   42836:	e8 f8 03 00 00       	call   42c33 <virtual_memory_lookup>
   4283b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4283f:	ba 70 28 04 00       	mov    $0x42870,%edx
   42844:	48 39 d0             	cmp    %rdx,%rax
   42847:	74 14                	je     4285d <set_pagetable+0x11e>
   42849:	ba 60 4d 04 00       	mov    $0x44d60,%edx
   4284e:	be 45 00 00 00       	mov    $0x45,%esi
   42853:	bf e2 4b 04 00       	mov    $0x44be2,%edi
   42858:	e8 14 fd ff ff       	call   42571 <assert_fail>
           == (uintptr_t) virtual_memory_map);
    lcr3((uintptr_t) pagetable);
   4285d:	48 8b 45 88          	mov    -0x78(%rbp),%rax
   42861:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    asm volatile("movq %0,%%cr3" : : "r" (val) : "memory");
   42865:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42869:	0f 22 d8             	mov    %rax,%cr3
}
   4286c:	90                   	nop
}
   4286d:	90                   	nop
   4286e:	c9                   	leave  
   4286f:	c3                   	ret    

0000000000042870 <virtual_memory_map>:
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l4pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm);

int virtual_memory_map(x86_64_pagetable* pagetable, uintptr_t va,
                       uintptr_t pa, size_t sz, int perm) {
   42870:	55                   	push   %rbp
   42871:	48 89 e5             	mov    %rsp,%rbp
   42874:	53                   	push   %rbx
   42875:	48 83 ec 58          	sub    $0x58,%rsp
   42879:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   4287d:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   42881:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
   42885:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
   42889:	44 89 45 ac          	mov    %r8d,-0x54(%rbp)

    // sanity checks for virtual address, size, and permisions
    assert(va % PAGESIZE == 0); // virtual address is page-aligned
   4288d:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42891:	25 ff 0f 00 00       	and    $0xfff,%eax
   42896:	48 85 c0             	test   %rax,%rax
   42899:	74 14                	je     428af <virtual_memory_map+0x3f>
   4289b:	ba c6 4d 04 00       	mov    $0x44dc6,%edx
   428a0:	be 66 00 00 00       	mov    $0x66,%esi
   428a5:	bf e2 4b 04 00       	mov    $0x44be2,%edi
   428aa:	e8 c2 fc ff ff       	call   42571 <assert_fail>
    assert(sz % PAGESIZE == 0); // size is a multiple of PAGESIZE
   428af:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   428b3:	25 ff 0f 00 00       	and    $0xfff,%eax
   428b8:	48 85 c0             	test   %rax,%rax
   428bb:	74 14                	je     428d1 <virtual_memory_map+0x61>
   428bd:	ba d9 4d 04 00       	mov    $0x44dd9,%edx
   428c2:	be 67 00 00 00       	mov    $0x67,%esi
   428c7:	bf e2 4b 04 00       	mov    $0x44be2,%edi
   428cc:	e8 a0 fc ff ff       	call   42571 <assert_fail>
    assert(va + sz >= va || va + sz == 0); // va range does not wrap
   428d1:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   428d5:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   428d9:	48 01 d0             	add    %rdx,%rax
   428dc:	48 39 45 c0          	cmp    %rax,-0x40(%rbp)
   428e0:	76 24                	jbe    42906 <virtual_memory_map+0x96>
   428e2:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
   428e6:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   428ea:	48 01 d0             	add    %rdx,%rax
   428ed:	48 85 c0             	test   %rax,%rax
   428f0:	74 14                	je     42906 <virtual_memory_map+0x96>
   428f2:	ba ec 4d 04 00       	mov    $0x44dec,%edx
   428f7:	be 68 00 00 00       	mov    $0x68,%esi
   428fc:	bf e2 4b 04 00       	mov    $0x44be2,%edi
   42901:	e8 6b fc ff ff       	call   42571 <assert_fail>
    if (perm & PTE_P) {
   42906:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42909:	48 98                	cltq   
   4290b:	83 e0 01             	and    $0x1,%eax
   4290e:	48 85 c0             	test   %rax,%rax
   42911:	74 6e                	je     42981 <virtual_memory_map+0x111>
        assert(pa % PAGESIZE == 0); // physical addr is page-aligned
   42913:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42917:	25 ff 0f 00 00       	and    $0xfff,%eax
   4291c:	48 85 c0             	test   %rax,%rax
   4291f:	74 14                	je     42935 <virtual_memory_map+0xc5>
   42921:	ba 0a 4e 04 00       	mov    $0x44e0a,%edx
   42926:	be 6a 00 00 00       	mov    $0x6a,%esi
   4292b:	bf e2 4b 04 00       	mov    $0x44be2,%edi
   42930:	e8 3c fc ff ff       	call   42571 <assert_fail>
        assert(pa + sz >= pa);      // physical address range does not wrap
   42935:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42939:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   4293d:	48 01 d0             	add    %rdx,%rax
   42940:	48 39 45 b8          	cmp    %rax,-0x48(%rbp)
   42944:	76 14                	jbe    4295a <virtual_memory_map+0xea>
   42946:	ba 1d 4e 04 00       	mov    $0x44e1d,%edx
   4294b:	be 6b 00 00 00       	mov    $0x6b,%esi
   42950:	bf e2 4b 04 00       	mov    $0x44be2,%edi
   42955:	e8 17 fc ff ff       	call   42571 <assert_fail>
        assert(pa + sz <= MEMSIZE_PHYSICAL); // physical addresses exist
   4295a:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   4295e:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
   42962:	48 01 d0             	add    %rdx,%rax
   42965:	48 3d 00 00 20 00    	cmp    $0x200000,%rax
   4296b:	76 14                	jbe    42981 <virtual_memory_map+0x111>
   4296d:	ba 2b 4e 04 00       	mov    $0x44e2b,%edx
   42972:	be 6c 00 00 00       	mov    $0x6c,%esi
   42977:	bf e2 4b 04 00       	mov    $0x44be2,%edi
   4297c:	e8 f0 fb ff ff       	call   42571 <assert_fail>
    }
    assert(perm >= 0 && perm < 0x1000); // `perm` makes sense (perm can only be 12 bits)
   42981:	83 7d ac 00          	cmpl   $0x0,-0x54(%rbp)
   42985:	78 09                	js     42990 <virtual_memory_map+0x120>
   42987:	81 7d ac ff 0f 00 00 	cmpl   $0xfff,-0x54(%rbp)
   4298e:	7e 14                	jle    429a4 <virtual_memory_map+0x134>
   42990:	ba 47 4e 04 00       	mov    $0x44e47,%edx
   42995:	be 6e 00 00 00       	mov    $0x6e,%esi
   4299a:	bf e2 4b 04 00       	mov    $0x44be2,%edi
   4299f:	e8 cd fb ff ff       	call   42571 <assert_fail>
    assert((uintptr_t) pagetable % PAGESIZE == 0); // `pagetable` page-aligned
   429a4:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   429a8:	25 ff 0f 00 00       	and    $0xfff,%eax
   429ad:	48 85 c0             	test   %rax,%rax
   429b0:	74 14                	je     429c6 <virtual_memory_map+0x156>
   429b2:	ba 68 4e 04 00       	mov    $0x44e68,%edx
   429b7:	be 6f 00 00 00       	mov    $0x6f,%esi
   429bc:	bf e2 4b 04 00       	mov    $0x44be2,%edi
   429c1:	e8 ab fb ff ff       	call   42571 <assert_fail>

    int last_index123 = -1;
   429c6:	c7 45 ec ff ff ff ff 	movl   $0xffffffff,-0x14(%rbp)
    x86_64_pagetable* l4pagetable = NULL;
   429cd:	48 c7 45 e0 00 00 00 	movq   $0x0,-0x20(%rbp)
   429d4:	00 

    // for each page-aligned address, set the appropriate page entry
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   429d5:	e9 e1 00 00 00       	jmp    42abb <virtual_memory_map+0x24b>
        int cur_index123 = (va >> (PAGEOFFBITS + PAGEINDEXBITS));
   429da:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   429de:	48 c1 e8 15          	shr    $0x15,%rax
   429e2:	89 45 dc             	mov    %eax,-0x24(%rbp)
        if (cur_index123 != last_index123) {
   429e5:	8b 45 dc             	mov    -0x24(%rbp),%eax
   429e8:	3b 45 ec             	cmp    -0x14(%rbp),%eax
   429eb:	74 20                	je     42a0d <virtual_memory_map+0x19d>
            // find pointer to last level pagetable for current va
            l4pagetable = lookup_l4pagetable(pagetable, va, perm);
   429ed:	8b 55 ac             	mov    -0x54(%rbp),%edx
   429f0:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
   429f4:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   429f8:	48 89 ce             	mov    %rcx,%rsi
   429fb:	48 89 c7             	mov    %rax,%rdi
   429fe:	e8 ce 00 00 00       	call   42ad1 <lookup_l4pagetable>
   42a03:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            last_index123 = cur_index123;
   42a07:	8b 45 dc             	mov    -0x24(%rbp),%eax
   42a0a:	89 45 ec             	mov    %eax,-0x14(%rbp)
        }
        if ((perm & PTE_P) && l4pagetable) { // if page is marked present
   42a0d:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42a10:	48 98                	cltq   
   42a12:	83 e0 01             	and    $0x1,%eax
   42a15:	48 85 c0             	test   %rax,%rax
   42a18:	74 34                	je     42a4e <virtual_memory_map+0x1de>
   42a1a:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   42a1f:	74 2d                	je     42a4e <virtual_memory_map+0x1de>
            // set page table entry to pa and perm
            l4pagetable->entry[L4PAGEINDEX(va)] = pa | perm;
   42a21:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42a24:	48 63 d8             	movslq %eax,%rbx
   42a27:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42a2b:	be 03 00 00 00       	mov    $0x3,%esi
   42a30:	48 89 c7             	mov    %rax,%rdi
   42a33:	e8 9e fb ff ff       	call   425d6 <pageindex>
   42a38:	89 c2                	mov    %eax,%edx
   42a3a:	48 0b 5d b8          	or     -0x48(%rbp),%rbx
   42a3e:	48 89 d9             	mov    %rbx,%rcx
   42a41:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42a45:	48 63 d2             	movslq %edx,%rdx
   42a48:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   42a4c:	eb 55                	jmp    42aa3 <virtual_memory_map+0x233>
        } else if (l4pagetable) { // if page is NOT marked present
   42a4e:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   42a53:	74 26                	je     42a7b <virtual_memory_map+0x20b>
            // set page table entry to just perm
            l4pagetable->entry[L4PAGEINDEX(va)] = perm;
   42a55:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42a59:	be 03 00 00 00       	mov    $0x3,%esi
   42a5e:	48 89 c7             	mov    %rax,%rdi
   42a61:	e8 70 fb ff ff       	call   425d6 <pageindex>
   42a66:	89 c2                	mov    %eax,%edx
   42a68:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42a6b:	48 63 c8             	movslq %eax,%rcx
   42a6e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42a72:	48 63 d2             	movslq %edx,%rdx
   42a75:	48 89 0c d0          	mov    %rcx,(%rax,%rdx,8)
   42a79:	eb 28                	jmp    42aa3 <virtual_memory_map+0x233>
        } else if (perm & PTE_P) {
   42a7b:	8b 45 ac             	mov    -0x54(%rbp),%eax
   42a7e:	48 98                	cltq   
   42a80:	83 e0 01             	and    $0x1,%eax
   42a83:	48 85 c0             	test   %rax,%rax
   42a86:	74 1b                	je     42aa3 <virtual_memory_map+0x233>
            // error, no allocated l4 page found for va
            log_printf("[Kern Info] failed to find l4pagetable address at " __FILE__ ": %d\n", __LINE__);
   42a88:	be 84 00 00 00       	mov    $0x84,%esi
   42a8d:	bf 90 4e 04 00       	mov    $0x44e90,%edi
   42a92:	b8 00 00 00 00       	mov    $0x0,%eax
   42a97:	e8 b7 f7 ff ff       	call   42253 <log_printf>
            return -1;
   42a9c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42aa1:	eb 28                	jmp    42acb <virtual_memory_map+0x25b>
    for (; sz != 0; va += PAGESIZE, pa += PAGESIZE, sz -= PAGESIZE) {
   42aa3:	48 81 45 c0 00 10 00 	addq   $0x1000,-0x40(%rbp)
   42aaa:	00 
   42aab:	48 81 45 b8 00 10 00 	addq   $0x1000,-0x48(%rbp)
   42ab2:	00 
   42ab3:	48 81 6d b0 00 10 00 	subq   $0x1000,-0x50(%rbp)
   42aba:	00 
   42abb:	48 83 7d b0 00       	cmpq   $0x0,-0x50(%rbp)
   42ac0:	0f 85 14 ff ff ff    	jne    429da <virtual_memory_map+0x16a>
        }
    }
    return 0;
   42ac6:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42acb:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   42acf:	c9                   	leave  
   42ad0:	c3                   	ret    

0000000000042ad1 <lookup_l4pagetable>:
//
//    Returns an x86_64_pagetable pointer to the last level pagetable
//    if it exists and can be accessed with the given permissions
//    Returns NULL otherwise
static x86_64_pagetable* lookup_l4pagetable(x86_64_pagetable* pagetable,
                 uintptr_t va, int perm) {
   42ad1:	55                   	push   %rbp
   42ad2:	48 89 e5             	mov    %rsp,%rbp
   42ad5:	48 83 ec 40          	sub    $0x40,%rsp
   42ad9:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42add:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
   42ae1:	89 55 cc             	mov    %edx,-0x34(%rbp)
    x86_64_pagetable* pt = pagetable;
   42ae4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42ae8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    // 1. Find index to the next pagetable entry using the `va`
    // 2. Check if this entry has the appropriate requested permissions
    // 3. Repeat the steps till you reach the l4 pagetable (i.e thrice)
    // 4. return the pagetable address

    for (int i = 0; i <= 2; ++i) {
   42aec:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
   42af3:	e9 2b 01 00 00       	jmp    42c23 <lookup_l4pagetable+0x152>
        // find page entry by finding `ith` level index of va to index pagetable entries of `pt`
        // you should read x86-64.h to understand relevant structs and macros to make this part easier
        x86_64_pageentry_t pe = pt->entry[PAGEINDEX(va, i)];
   42af8:	8b 55 f4             	mov    -0xc(%rbp),%edx
   42afb:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   42aff:	89 d6                	mov    %edx,%esi
   42b01:	48 89 c7             	mov    %rax,%rdi
   42b04:	e8 cd fa ff ff       	call   425d6 <pageindex>
   42b09:	89 c2                	mov    %eax,%edx
   42b0b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42b0f:	48 63 d2             	movslq %edx,%rdx
   42b12:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
   42b16:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

        if (!(pe & PTE_P)) { // address of next level should be present AND PTE_P should be set, error otherwise
   42b1a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42b1e:	83 e0 01             	and    $0x1,%eax
   42b21:	48 85 c0             	test   %rax,%rax
   42b24:	75 63                	jne    42b89 <lookup_l4pagetable+0xb8>
            log_printf("[Kern Info] Error looking up l4pagetable: Pagetable address: 0x%x perm: 0x%x."
   42b26:	8b 45 f4             	mov    -0xc(%rbp),%eax
   42b29:	8d 48 02             	lea    0x2(%rax),%ecx
   42b2c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42b30:	25 ff 0f 00 00       	and    $0xfff,%eax
   42b35:	48 89 c2             	mov    %rax,%rdx
   42b38:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42b3c:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42b42:	48 89 c6             	mov    %rax,%rsi
   42b45:	bf d0 4e 04 00       	mov    $0x44ed0,%edi
   42b4a:	b8 00 00 00 00       	mov    $0x0,%eax
   42b4f:	e8 ff f6 ff ff       	call   42253 <log_printf>
                    " Failed to get level (%d)\n",
                    PTE_ADDR(pe), PTE_FLAGS(pe), (i+2));
            if (!(perm & PTE_P)) {
   42b54:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42b57:	48 98                	cltq   
   42b59:	83 e0 01             	and    $0x1,%eax
   42b5c:	48 85 c0             	test   %rax,%rax
   42b5f:	75 0a                	jne    42b6b <lookup_l4pagetable+0x9a>
                return NULL;
   42b61:	b8 00 00 00 00       	mov    $0x0,%eax
   42b66:	e9 c6 00 00 00       	jmp    42c31 <lookup_l4pagetable+0x160>
            }
            log_printf("[Kern Info] failed to find pagetable address at " __FILE__ ": %d\n", __LINE__);
   42b6b:	be a7 00 00 00       	mov    $0xa7,%esi
   42b70:	bf 38 4f 04 00       	mov    $0x44f38,%edi
   42b75:	b8 00 00 00 00       	mov    $0x0,%eax
   42b7a:	e8 d4 f6 ff ff       	call   42253 <log_printf>
            return NULL;
   42b7f:	b8 00 00 00 00       	mov    $0x0,%eax
   42b84:	e9 a8 00 00 00       	jmp    42c31 <lookup_l4pagetable+0x160>
        }

        // sanity-check page entry and permissions
        assert(PTE_ADDR(pe) < MEMSIZE_PHYSICAL); // at sensible address
   42b89:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42b8d:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42b93:	48 3d ff ff 1f 00    	cmp    $0x1fffff,%rax
   42b99:	76 14                	jbe    42baf <lookup_l4pagetable+0xde>
   42b9b:	ba 78 4f 04 00       	mov    $0x44f78,%edx
   42ba0:	be ac 00 00 00       	mov    $0xac,%esi
   42ba5:	bf e2 4b 04 00       	mov    $0x44be2,%edi
   42baa:	e8 c2 f9 ff ff       	call   42571 <assert_fail>
        if (perm & PTE_W) {       // if requester wants PTE_W,
   42baf:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42bb2:	48 98                	cltq   
   42bb4:	83 e0 02             	and    $0x2,%eax
   42bb7:	48 85 c0             	test   %rax,%rax
   42bba:	74 20                	je     42bdc <lookup_l4pagetable+0x10b>
            assert(pe & PTE_W);   //   entry must allow PTE_W
   42bbc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42bc0:	83 e0 02             	and    $0x2,%eax
   42bc3:	48 85 c0             	test   %rax,%rax
   42bc6:	75 14                	jne    42bdc <lookup_l4pagetable+0x10b>
   42bc8:	ba 98 4f 04 00       	mov    $0x44f98,%edx
   42bcd:	be ae 00 00 00       	mov    $0xae,%esi
   42bd2:	bf e2 4b 04 00       	mov    $0x44be2,%edi
   42bd7:	e8 95 f9 ff ff       	call   42571 <assert_fail>
        }
        if (perm & PTE_U) {       // if requester wants PTE_U,
   42bdc:	8b 45 cc             	mov    -0x34(%rbp),%eax
   42bdf:	48 98                	cltq   
   42be1:	83 e0 04             	and    $0x4,%eax
   42be4:	48 85 c0             	test   %rax,%rax
   42be7:	74 20                	je     42c09 <lookup_l4pagetable+0x138>
            assert(pe & PTE_U);   //   entry must allow PTE_U
   42be9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42bed:	83 e0 04             	and    $0x4,%eax
   42bf0:	48 85 c0             	test   %rax,%rax
   42bf3:	75 14                	jne    42c09 <lookup_l4pagetable+0x138>
   42bf5:	ba a3 4f 04 00       	mov    $0x44fa3,%edx
   42bfa:	be b1 00 00 00       	mov    $0xb1,%esi
   42bff:	bf e2 4b 04 00       	mov    $0x44be2,%edi
   42c04:	e8 68 f9 ff ff       	call   42571 <assert_fail>
        }

        // set pt to physical address to next pagetable using `pe`
        pt = 0; // replace this
   42c09:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
   42c10:	00 
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   42c11:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42c15:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42c1b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 2; ++i) {
   42c1f:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
   42c23:	83 7d f4 02          	cmpl   $0x2,-0xc(%rbp)
   42c27:	0f 8e cb fe ff ff    	jle    42af8 <lookup_l4pagetable+0x27>
    }
    return pt;
   42c2d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
   42c31:	c9                   	leave  
   42c32:	c3                   	ret    

0000000000042c33 <virtual_memory_lookup>:

// virtual_memory_lookup(pagetable, va)
//    Returns information about the mapping of the virtual address `va` in
//    `pagetable`. The information is returned as a `vamapping` object.

vamapping virtual_memory_lookup(x86_64_pagetable* pagetable, uintptr_t va) {
   42c33:	55                   	push   %rbp
   42c34:	48 89 e5             	mov    %rsp,%rbp
   42c37:	48 83 ec 50          	sub    $0x50,%rsp
   42c3b:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   42c3f:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
   42c43:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
    x86_64_pagetable* pt = pagetable;
   42c47:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   42c4b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    x86_64_pageentry_t pe = PTE_W | PTE_U | PTE_P;
   42c4f:	48 c7 45 f0 07 00 00 	movq   $0x7,-0x10(%rbp)
   42c56:	00 
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   42c57:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
   42c5e:	eb 41                	jmp    42ca1 <virtual_memory_lookup+0x6e>
        pe = pt->entry[PAGEINDEX(va, i)] & ~(pe & (PTE_W | PTE_U));
   42c60:	8b 55 ec             	mov    -0x14(%rbp),%edx
   42c63:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42c67:	89 d6                	mov    %edx,%esi
   42c69:	48 89 c7             	mov    %rax,%rdi
   42c6c:	e8 65 f9 ff ff       	call   425d6 <pageindex>
   42c71:	89 c2                	mov    %eax,%edx
   42c73:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42c77:	48 63 d2             	movslq %edx,%rdx
   42c7a:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
   42c7e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42c82:	83 e0 06             	and    $0x6,%eax
   42c85:	48 f7 d0             	not    %rax
   42c88:	48 21 d0             	and    %rdx,%rax
   42c8b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
        pt = (x86_64_pagetable*) PTE_ADDR(pe);
   42c8f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42c93:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42c99:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    for (int i = 0; i <= 3 && (pe & PTE_P); ++i) {
   42c9d:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
   42ca1:	83 7d ec 03          	cmpl   $0x3,-0x14(%rbp)
   42ca5:	7f 0c                	jg     42cb3 <virtual_memory_lookup+0x80>
   42ca7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42cab:	83 e0 01             	and    $0x1,%eax
   42cae:	48 85 c0             	test   %rax,%rax
   42cb1:	75 ad                	jne    42c60 <virtual_memory_lookup+0x2d>
    }
    vamapping vam = { -1, (uintptr_t) -1, 0 };
   42cb3:	c7 45 d0 ff ff ff ff 	movl   $0xffffffff,-0x30(%rbp)
   42cba:	48 c7 45 d8 ff ff ff 	movq   $0xffffffffffffffff,-0x28(%rbp)
   42cc1:	ff 
   42cc2:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%rbp)
    if (pe & PTE_P) {
   42cc9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42ccd:	83 e0 01             	and    $0x1,%eax
   42cd0:	48 85 c0             	test   %rax,%rax
   42cd3:	74 34                	je     42d09 <virtual_memory_lookup+0xd6>
        vam.pn = PAGENUMBER(pe);
   42cd5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42cd9:	48 c1 e8 0c          	shr    $0xc,%rax
   42cdd:	89 45 d0             	mov    %eax,-0x30(%rbp)
        vam.pa = PTE_ADDR(pe) + PAGEOFFSET(va);
   42ce0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42ce4:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   42cea:	48 89 c2             	mov    %rax,%rdx
   42ced:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
   42cf1:	25 ff 0f 00 00       	and    $0xfff,%eax
   42cf6:	48 09 d0             	or     %rdx,%rax
   42cf9:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
        vam.perm = PTE_FLAGS(pe);
   42cfd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42d01:	25 ff 0f 00 00       	and    $0xfff,%eax
   42d06:	89 45 e0             	mov    %eax,-0x20(%rbp)
    }
    return vam;
   42d09:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42d0d:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   42d11:	48 89 10             	mov    %rdx,(%rax)
   42d14:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
   42d18:	48 89 50 08          	mov    %rdx,0x8(%rax)
   42d1c:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   42d20:	48 89 50 10          	mov    %rdx,0x10(%rax)
}
   42d24:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   42d28:	c9                   	leave  
   42d29:	c3                   	ret    

0000000000042d2a <program_load>:
//    `assign_physical_page` to as required. Returns 0 on success and
//    -1 on failure (e.g. out-of-memory). `allocator` is passed to
//    `virtual_memory_map`.

int program_load(proc* p, int programnumber,
                 x86_64_pagetable* (*allocator)(void)) {
   42d2a:	55                   	push   %rbp
   42d2b:	48 89 e5             	mov    %rsp,%rbp
   42d2e:	48 83 ec 40          	sub    $0x40,%rsp
   42d32:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
   42d36:	89 75 d4             	mov    %esi,-0x2c(%rbp)
   42d39:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
    // is this a valid program?
    int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);
   42d3d:	c7 45 f8 07 00 00 00 	movl   $0x7,-0x8(%rbp)
    assert(programnumber >= 0 && programnumber < nprograms);
   42d44:	83 7d d4 00          	cmpl   $0x0,-0x2c(%rbp)
   42d48:	78 08                	js     42d52 <program_load+0x28>
   42d4a:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   42d4d:	3b 45 f8             	cmp    -0x8(%rbp),%eax
   42d50:	7c 14                	jl     42d66 <program_load+0x3c>
   42d52:	ba b0 4f 04 00       	mov    $0x44fb0,%edx
   42d57:	be 37 00 00 00       	mov    $0x37,%esi
   42d5c:	bf e0 4f 04 00       	mov    $0x44fe0,%edi
   42d61:	e8 0b f8 ff ff       	call   42571 <assert_fail>
    elf_header* eh = (elf_header*) ramimages[programnumber].begin;
   42d66:	8b 45 d4             	mov    -0x2c(%rbp),%eax
   42d69:	48 98                	cltq   
   42d6b:	48 c1 e0 04          	shl    $0x4,%rax
   42d6f:	48 05 20 60 04 00    	add    $0x46020,%rax
   42d75:	48 8b 00             	mov    (%rax),%rax
   42d78:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    assert(eh->e_magic == ELF_MAGIC);
   42d7c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42d80:	8b 00                	mov    (%rax),%eax
   42d82:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
   42d87:	74 14                	je     42d9d <program_load+0x73>
   42d89:	ba eb 4f 04 00       	mov    $0x44feb,%edx
   42d8e:	be 39 00 00 00       	mov    $0x39,%esi
   42d93:	bf e0 4f 04 00       	mov    $0x44fe0,%edi
   42d98:	e8 d4 f7 ff ff       	call   42571 <assert_fail>

    // load each loadable program segment into memory
    elf_program* ph = (elf_program*) ((const uint8_t*) eh + eh->e_phoff);
   42d9d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42da1:	48 8b 50 20          	mov    0x20(%rax),%rdx
   42da5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42da9:	48 01 d0             	add    %rdx,%rax
   42dac:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    for (int i = 0; i < eh->e_phnum; ++i) {
   42db0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   42db7:	e9 94 00 00 00       	jmp    42e50 <program_load+0x126>
        if (ph[i].p_type == ELF_PTYPE_LOAD) {
   42dbc:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42dbf:	48 63 d0             	movslq %eax,%rdx
   42dc2:	48 89 d0             	mov    %rdx,%rax
   42dc5:	48 c1 e0 03          	shl    $0x3,%rax
   42dc9:	48 29 d0             	sub    %rdx,%rax
   42dcc:	48 c1 e0 03          	shl    $0x3,%rax
   42dd0:	48 89 c2             	mov    %rax,%rdx
   42dd3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42dd7:	48 01 d0             	add    %rdx,%rax
   42dda:	8b 00                	mov    (%rax),%eax
   42ddc:	83 f8 01             	cmp    $0x1,%eax
   42ddf:	75 6b                	jne    42e4c <program_load+0x122>
            const uint8_t* pdata = (const uint8_t*) eh + ph[i].p_offset;
   42de1:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42de4:	48 63 d0             	movslq %eax,%rdx
   42de7:	48 89 d0             	mov    %rdx,%rax
   42dea:	48 c1 e0 03          	shl    $0x3,%rax
   42dee:	48 29 d0             	sub    %rdx,%rax
   42df1:	48 c1 e0 03          	shl    $0x3,%rax
   42df5:	48 89 c2             	mov    %rax,%rdx
   42df8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42dfc:	48 01 d0             	add    %rdx,%rax
   42dff:	48 8b 50 08          	mov    0x8(%rax),%rdx
   42e03:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e07:	48 01 d0             	add    %rdx,%rax
   42e0a:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
            if (program_load_segment(p, &ph[i], pdata, allocator) < 0) {
   42e0e:	8b 45 fc             	mov    -0x4(%rbp),%eax
   42e11:	48 63 d0             	movslq %eax,%rdx
   42e14:	48 89 d0             	mov    %rdx,%rax
   42e17:	48 c1 e0 03          	shl    $0x3,%rax
   42e1b:	48 29 d0             	sub    %rdx,%rax
   42e1e:	48 c1 e0 03          	shl    $0x3,%rax
   42e22:	48 89 c2             	mov    %rax,%rdx
   42e25:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42e29:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
   42e2d:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
   42e31:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
   42e35:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42e39:	48 89 c7             	mov    %rax,%rdi
   42e3c:	e8 3d 00 00 00       	call   42e7e <program_load_segment>
   42e41:	85 c0                	test   %eax,%eax
   42e43:	79 07                	jns    42e4c <program_load+0x122>
                return -1;
   42e45:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42e4a:	eb 30                	jmp    42e7c <program_load+0x152>
    for (int i = 0; i < eh->e_phnum; ++i) {
   42e4c:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   42e50:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e54:	0f b7 40 38          	movzwl 0x38(%rax),%eax
   42e58:	0f b7 c0             	movzwl %ax,%eax
   42e5b:	39 45 fc             	cmp    %eax,-0x4(%rbp)
   42e5e:	0f 8c 58 ff ff ff    	jl     42dbc <program_load+0x92>
            }
        }
    }

    // set the entry point from the ELF header
    p->p_registers.reg_rip = eh->e_entry;
   42e64:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   42e68:	48 8b 50 18          	mov    0x18(%rax),%rdx
   42e6c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42e70:	48 89 90 b0 00 00 00 	mov    %rdx,0xb0(%rax)
    return 0;
   42e77:	b8 00 00 00 00       	mov    $0x0,%eax
}
   42e7c:	c9                   	leave  
   42e7d:	c3                   	ret    

0000000000042e7e <program_load_segment>:
//    Calls `assign_physical_page` to allocate pages and `virtual_memory_map`
//    to map them in `p->p_pagetable`. Returns 0 on success and -1 on failure.

static int program_load_segment(proc* p, const elf_program* ph,
                                const uint8_t* src,
                                x86_64_pagetable* (*allocator)(void)) {
   42e7e:	55                   	push   %rbp
   42e7f:	48 89 e5             	mov    %rsp,%rbp
   42e82:	48 83 ec 70          	sub    $0x70,%rsp
   42e86:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
   42e8a:	48 89 75 a0          	mov    %rsi,-0x60(%rbp)
   42e8e:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
   42e92:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    uintptr_t va = (uintptr_t) ph->p_va;
   42e96:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42e9a:	48 8b 40 10          	mov    0x10(%rax),%rax
   42e9e:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    uintptr_t end_file = va + ph->p_filesz, end_mem = va + ph->p_memsz;
   42ea2:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42ea6:	48 8b 50 20          	mov    0x20(%rax),%rdx
   42eaa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42eae:	48 01 d0             	add    %rdx,%rax
   42eb1:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   42eb5:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42eb9:	48 8b 50 28          	mov    0x28(%rax),%rdx
   42ebd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42ec1:	48 01 d0             	add    %rdx,%rax
   42ec4:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    va &= ~(PAGESIZE - 1);                // round to page boundary
   42ec8:	48 81 65 e8 00 f0 ff 	andq   $0xfffffffffffff000,-0x18(%rbp)
   42ecf:	ff 


    // allocate memory
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   42ed0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42ed4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   42ed8:	eb 7c                	jmp    42f56 <program_load_segment+0xd8>
        uintptr_t pa = (uintptr_t)palloc(p->p_pid);
   42eda:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42ede:	8b 00                	mov    (%rax),%eax
   42ee0:	89 c7                	mov    %eax,%edi
   42ee2:	e8 97 0b 00 00       	call   43a7e <palloc>
   42ee7:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
        if (pa == (uintptr_t)NULL || virtual_memory_map(p->p_pagetable, addr, pa, PAGESIZE,
   42eeb:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
   42ef0:	74 2a                	je     42f1c <program_load_segment+0x9e>
   42ef2:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42ef6:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   42efd:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
   42f01:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   42f05:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   42f0b:	b9 00 10 00 00       	mov    $0x1000,%ecx
   42f10:	48 89 c7             	mov    %rax,%rdi
   42f13:	e8 58 f9 ff ff       	call   42870 <virtual_memory_map>
   42f18:	85 c0                	test   %eax,%eax
   42f1a:	79 32                	jns    42f4e <program_load_segment+0xd0>
                    PTE_W | PTE_P | PTE_U) < 0) {
            console_printf(CPOS(22, 0), 0xC000,
   42f1c:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42f20:	8b 00                	mov    (%rax),%eax
   42f22:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   42f26:	49 89 d0             	mov    %rdx,%r8
   42f29:	89 c1                	mov    %eax,%ecx
   42f2b:	ba 08 50 04 00       	mov    $0x45008,%edx
   42f30:	be 00 c0 00 00       	mov    $0xc000,%esi
   42f35:	bf e0 06 00 00       	mov    $0x6e0,%edi
   42f3a:	b8 00 00 00 00       	mov    $0x0,%eax
   42f3f:	e8 63 0a 00 00       	call   439a7 <console_printf>
                    "program_load_segment(pid %d): can't assign address %p\n", p->p_pid, addr);
            return -1;
   42f44:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   42f49:	e9 1d 01 00 00       	jmp    4306b <program_load_segment+0x1ed>
    for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   42f4e:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   42f55:	00 
   42f56:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   42f5a:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   42f5e:	0f 82 76 ff ff ff    	jb     42eda <program_load_segment+0x5c>
        }
    }

    // ensure new memory mappings are active
    set_pagetable(p->p_pagetable);
   42f64:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42f68:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   42f6f:	48 89 c7             	mov    %rax,%rdi
   42f72:	e8 c8 f7 ff ff       	call   4273f <set_pagetable>

    // copy data from executable image into process memory
    memcpy((uint8_t*) va, src, end_file - va);
   42f77:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42f7b:	48 2b 45 e8          	sub    -0x18(%rbp),%rax
   42f7f:	48 89 c2             	mov    %rax,%rdx
   42f82:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42f86:	48 8b 4d 98          	mov    -0x68(%rbp),%rcx
   42f8a:	48 89 ce             	mov    %rcx,%rsi
   42f8d:	48 89 c7             	mov    %rax,%rdi
   42f90:	e8 74 01 00 00       	call   43109 <memcpy>
    memset((uint8_t*) end_file, 0, end_mem - end_file);
   42f95:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   42f99:	48 2b 45 e0          	sub    -0x20(%rbp),%rax
   42f9d:	48 89 c2             	mov    %rax,%rdx
   42fa0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   42fa4:	be 00 00 00 00       	mov    $0x0,%esi
   42fa9:	48 89 c7             	mov    %rax,%rdi
   42fac:	e8 c1 01 00 00       	call   43172 <memset>

    // restore kernel pagetables
    set_pagetable(kernel_pagetable);
   42fb1:	48 8b 05 48 10 01 00 	mov    0x11048(%rip),%rax        # 54000 <kernel_pagetable>
   42fb8:	48 89 c7             	mov    %rax,%rdi
   42fbb:	e8 7f f7 ff ff       	call   4273f <set_pagetable>


    if ((ph->p_flags & ELF_PFLAG_WRITE) == 0) {
   42fc0:	48 8b 45 a0          	mov    -0x60(%rbp),%rax
   42fc4:	8b 40 04             	mov    0x4(%rax),%eax
   42fc7:	83 e0 02             	and    $0x2,%eax
   42fca:	85 c0                	test   %eax,%eax
   42fcc:	75 60                	jne    4302e <program_load_segment+0x1b0>
        for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   42fce:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   42fd2:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   42fd6:	eb 4c                	jmp    43024 <program_load_segment+0x1a6>
            vamapping mapping = virtual_memory_lookup(p->p_pagetable, addr);
   42fd8:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42fdc:	48 8b 88 e0 00 00 00 	mov    0xe0(%rax),%rcx
   42fe3:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
   42fe7:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
   42feb:	48 89 ce             	mov    %rcx,%rsi
   42fee:	48 89 c7             	mov    %rax,%rdi
   42ff1:	e8 3d fc ff ff       	call   42c33 <virtual_memory_lookup>

            virtual_memory_map(p->p_pagetable, addr, mapping.pa, PAGESIZE,
   42ff6:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
   42ffa:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   42ffe:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   43005:	48 8b 75 f0          	mov    -0x10(%rbp),%rsi
   43009:	41 b8 05 00 00 00    	mov    $0x5,%r8d
   4300f:	b9 00 10 00 00       	mov    $0x1000,%ecx
   43014:	48 89 c7             	mov    %rax,%rdi
   43017:	e8 54 f8 ff ff       	call   42870 <virtual_memory_map>
        for (uintptr_t addr = va; addr < end_mem; addr += PAGESIZE) {
   4301c:	48 81 45 f0 00 10 00 	addq   $0x1000,-0x10(%rbp)
   43023:	00 
   43024:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43028:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
   4302c:	72 aa                	jb     42fd8 <program_load_segment+0x15a>
                    PTE_P | PTE_U);
        }
    }

    // calculate and update the "program" and "original" breakpoint values
    uintptr_t curr_break = va + PAGESIZE;
   4302e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43032:	48 05 00 10 00 00    	add    $0x1000,%rax
   43038:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    if (curr_break > p->program_break) {
   4303c:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43040:	48 8b 40 08          	mov    0x8(%rax),%rax
   43044:	48 39 45 d0          	cmp    %rax,-0x30(%rbp)
   43048:	76 1c                	jbe    43066 <program_load_segment+0x1e8>
        p->program_break = p->original_break = curr_break;
   4304a:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4304e:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
   43052:	48 89 50 10          	mov    %rdx,0x10(%rax)
   43056:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   4305a:	48 8b 50 10          	mov    0x10(%rax),%rdx
   4305e:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
   43062:	48 89 50 08          	mov    %rdx,0x8(%rax)
    }

    return 0;
   43066:	b8 00 00 00 00       	mov    $0x0,%eax
}
   4306b:	c9                   	leave  
   4306c:	c3                   	ret    

000000000004306d <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
   4306d:	48 89 f9             	mov    %rdi,%rcx
   43070:	89 d7                	mov    %edx,%edi
    console_printer* cp = (console_printer*) p;
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
   43072:	48 81 79 08 a0 8f 0b 	cmpq   $0xb8fa0,0x8(%rcx)
   43079:	00 
   4307a:	72 08                	jb     43084 <console_putc+0x17>
        cp->cursor = console;
   4307c:	48 c7 41 08 00 80 0b 	movq   $0xb8000,0x8(%rcx)
   43083:	00 
    }
    if (c == '\n') {
   43084:	40 80 fe 0a          	cmp    $0xa,%sil
   43088:	74 16                	je     430a0 <console_putc+0x33>
        int pos = (cp->cursor - console) % 80;
        for (; pos != 80; pos++) {
            *cp->cursor++ = ' ' | color;
        }
    } else {
        *cp->cursor++ = c | color;
   4308a:	48 8b 41 08          	mov    0x8(%rcx),%rax
   4308e:	48 8d 50 02          	lea    0x2(%rax),%rdx
   43092:	48 89 51 08          	mov    %rdx,0x8(%rcx)
   43096:	40 0f b6 f6          	movzbl %sil,%esi
   4309a:	09 fe                	or     %edi,%esi
   4309c:	66 89 30             	mov    %si,(%rax)
    }
}
   4309f:	c3                   	ret    
        int pos = (cp->cursor - console) % 80;
   430a0:	4c 8b 41 08          	mov    0x8(%rcx),%r8
   430a4:	49 81 e8 00 80 0b 00 	sub    $0xb8000,%r8
   430ab:	4c 89 c6             	mov    %r8,%rsi
   430ae:	48 d1 fe             	sar    %rsi
   430b1:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
   430b8:	66 66 66 
   430bb:	48 89 f0             	mov    %rsi,%rax
   430be:	48 f7 ea             	imul   %rdx
   430c1:	48 c1 fa 05          	sar    $0x5,%rdx
   430c5:	49 c1 f8 3f          	sar    $0x3f,%r8
   430c9:	4c 29 c2             	sub    %r8,%rdx
   430cc:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
   430d0:	48 c1 e2 04          	shl    $0x4,%rdx
   430d4:	89 f0                	mov    %esi,%eax
   430d6:	29 d0                	sub    %edx,%eax
            *cp->cursor++ = ' ' | color;
   430d8:	83 cf 20             	or     $0x20,%edi
   430db:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   430df:	48 8d 72 02          	lea    0x2(%rdx),%rsi
   430e3:	48 89 71 08          	mov    %rsi,0x8(%rcx)
   430e7:	66 89 3a             	mov    %di,(%rdx)
        for (; pos != 80; pos++) {
   430ea:	83 c0 01             	add    $0x1,%eax
   430ed:	83 f8 50             	cmp    $0x50,%eax
   430f0:	75 e9                	jne    430db <console_putc+0x6e>
   430f2:	c3                   	ret    

00000000000430f3 <string_putc>:
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
    string_printer* sp = (string_printer*) p;
    if (sp->s < sp->end) {
   430f3:	48 8b 47 08          	mov    0x8(%rdi),%rax
   430f7:	48 3b 47 10          	cmp    0x10(%rdi),%rax
   430fb:	73 0b                	jae    43108 <string_putc+0x15>
        *sp->s++ = c;
   430fd:	48 8d 50 01          	lea    0x1(%rax),%rdx
   43101:	48 89 57 08          	mov    %rdx,0x8(%rdi)
   43105:	40 88 30             	mov    %sil,(%rax)
    }
    (void) color;
}
   43108:	c3                   	ret    

0000000000043109 <memcpy>:
void* memcpy(void* dst, const void* src, size_t n) {
   43109:	48 89 f8             	mov    %rdi,%rax
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   4310c:	48 85 d2             	test   %rdx,%rdx
   4310f:	74 17                	je     43128 <memcpy+0x1f>
   43111:	b9 00 00 00 00       	mov    $0x0,%ecx
        *d = *s;
   43116:	44 0f b6 04 0e       	movzbl (%rsi,%rcx,1),%r8d
   4311b:	44 88 04 08          	mov    %r8b,(%rax,%rcx,1)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
   4311f:	48 83 c1 01          	add    $0x1,%rcx
   43123:	48 39 d1             	cmp    %rdx,%rcx
   43126:	75 ee                	jne    43116 <memcpy+0xd>
}
   43128:	c3                   	ret    

0000000000043129 <memmove>:
void* memmove(void* dst, const void* src, size_t n) {
   43129:	48 89 f8             	mov    %rdi,%rax
    if (s < d && s + n > d) {
   4312c:	48 39 fe             	cmp    %rdi,%rsi
   4312f:	72 1d                	jb     4314e <memmove+0x25>
        while (n-- > 0) {
   43131:	b9 00 00 00 00       	mov    $0x0,%ecx
   43136:	48 85 d2             	test   %rdx,%rdx
   43139:	74 12                	je     4314d <memmove+0x24>
            *d++ = *s++;
   4313b:	0f b6 3c 0e          	movzbl (%rsi,%rcx,1),%edi
   4313f:	40 88 3c 08          	mov    %dil,(%rax,%rcx,1)
        while (n-- > 0) {
   43143:	48 83 c1 01          	add    $0x1,%rcx
   43147:	48 39 ca             	cmp    %rcx,%rdx
   4314a:	75 ef                	jne    4313b <memmove+0x12>
}
   4314c:	c3                   	ret    
   4314d:	c3                   	ret    
    if (s < d && s + n > d) {
   4314e:	48 8d 0c 16          	lea    (%rsi,%rdx,1),%rcx
   43152:	48 39 cf             	cmp    %rcx,%rdi
   43155:	73 da                	jae    43131 <memmove+0x8>
        while (n-- > 0) {
   43157:	48 8d 4a ff          	lea    -0x1(%rdx),%rcx
   4315b:	48 85 d2             	test   %rdx,%rdx
   4315e:	74 ec                	je     4314c <memmove+0x23>
            *--d = *--s;
   43160:	0f b6 14 0e          	movzbl (%rsi,%rcx,1),%edx
   43164:	88 14 08             	mov    %dl,(%rax,%rcx,1)
        while (n-- > 0) {
   43167:	48 83 e9 01          	sub    $0x1,%rcx
   4316b:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
   4316f:	75 ef                	jne    43160 <memmove+0x37>
   43171:	c3                   	ret    

0000000000043172 <memset>:
void* memset(void* v, int c, size_t n) {
   43172:	48 89 f8             	mov    %rdi,%rax
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43175:	48 85 d2             	test   %rdx,%rdx
   43178:	74 12                	je     4318c <memset+0x1a>
   4317a:	48 01 fa             	add    %rdi,%rdx
   4317d:	48 89 f9             	mov    %rdi,%rcx
        *p = c;
   43180:	40 88 31             	mov    %sil,(%rcx)
    for (char* p = (char*) v; n > 0; ++p, --n) {
   43183:	48 83 c1 01          	add    $0x1,%rcx
   43187:	48 39 ca             	cmp    %rcx,%rdx
   4318a:	75 f4                	jne    43180 <memset+0xe>
}
   4318c:	c3                   	ret    

000000000004318d <strlen>:
    for (n = 0; *s != '\0'; ++s) {
   4318d:	80 3f 00             	cmpb   $0x0,(%rdi)
   43190:	74 10                	je     431a2 <strlen+0x15>
   43192:	b8 00 00 00 00       	mov    $0x0,%eax
        ++n;
   43197:	48 83 c0 01          	add    $0x1,%rax
    for (n = 0; *s != '\0'; ++s) {
   4319b:	80 3c 07 00          	cmpb   $0x0,(%rdi,%rax,1)
   4319f:	75 f6                	jne    43197 <strlen+0xa>
   431a1:	c3                   	ret    
   431a2:	b8 00 00 00 00       	mov    $0x0,%eax
}
   431a7:	c3                   	ret    

00000000000431a8 <strnlen>:
size_t strnlen(const char* s, size_t maxlen) {
   431a8:	48 89 f0             	mov    %rsi,%rax
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   431ab:	ba 00 00 00 00       	mov    $0x0,%edx
   431b0:	48 85 f6             	test   %rsi,%rsi
   431b3:	74 11                	je     431c6 <strnlen+0x1e>
   431b5:	80 3c 17 00          	cmpb   $0x0,(%rdi,%rdx,1)
   431b9:	74 0c                	je     431c7 <strnlen+0x1f>
        ++n;
   431bb:	48 83 c2 01          	add    $0x1,%rdx
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
   431bf:	48 39 d0             	cmp    %rdx,%rax
   431c2:	75 f1                	jne    431b5 <strnlen+0xd>
   431c4:	eb 04                	jmp    431ca <strnlen+0x22>
   431c6:	c3                   	ret    
   431c7:	48 89 d0             	mov    %rdx,%rax
}
   431ca:	c3                   	ret    

00000000000431cb <strcpy>:
char* strcpy(char* dst, const char* src) {
   431cb:	48 89 f8             	mov    %rdi,%rax
   431ce:	ba 00 00 00 00       	mov    $0x0,%edx
        *d++ = *src++;
   431d3:	0f b6 0c 16          	movzbl (%rsi,%rdx,1),%ecx
   431d7:	88 0c 10             	mov    %cl,(%rax,%rdx,1)
    } while (d[-1]);
   431da:	48 83 c2 01          	add    $0x1,%rdx
   431de:	84 c9                	test   %cl,%cl
   431e0:	75 f1                	jne    431d3 <strcpy+0x8>
}
   431e2:	c3                   	ret    

00000000000431e3 <strcmp>:
    while (*a && *b && *a == *b) {
   431e3:	0f b6 07             	movzbl (%rdi),%eax
   431e6:	84 c0                	test   %al,%al
   431e8:	74 1a                	je     43204 <strcmp+0x21>
   431ea:	0f b6 16             	movzbl (%rsi),%edx
   431ed:	38 c2                	cmp    %al,%dl
   431ef:	75 13                	jne    43204 <strcmp+0x21>
   431f1:	84 d2                	test   %dl,%dl
   431f3:	74 0f                	je     43204 <strcmp+0x21>
        ++a, ++b;
   431f5:	48 83 c7 01          	add    $0x1,%rdi
   431f9:	48 83 c6 01          	add    $0x1,%rsi
    while (*a && *b && *a == *b) {
   431fd:	0f b6 07             	movzbl (%rdi),%eax
   43200:	84 c0                	test   %al,%al
   43202:	75 e6                	jne    431ea <strcmp+0x7>
    return ((unsigned char) *a > (unsigned char) *b)
   43204:	3a 06                	cmp    (%rsi),%al
   43206:	0f 97 c0             	seta   %al
   43209:	0f b6 c0             	movzbl %al,%eax
        - ((unsigned char) *a < (unsigned char) *b);
   4320c:	83 d8 00             	sbb    $0x0,%eax
}
   4320f:	c3                   	ret    

0000000000043210 <strchr>:
    while (*s && *s != (char) c) {
   43210:	0f b6 07             	movzbl (%rdi),%eax
   43213:	84 c0                	test   %al,%al
   43215:	74 10                	je     43227 <strchr+0x17>
   43217:	40 38 f0             	cmp    %sil,%al
   4321a:	74 18                	je     43234 <strchr+0x24>
        ++s;
   4321c:	48 83 c7 01          	add    $0x1,%rdi
    while (*s && *s != (char) c) {
   43220:	0f b6 07             	movzbl (%rdi),%eax
   43223:	84 c0                	test   %al,%al
   43225:	75 f0                	jne    43217 <strchr+0x7>
        return NULL;
   43227:	40 84 f6             	test   %sil,%sil
   4322a:	b8 00 00 00 00       	mov    $0x0,%eax
   4322f:	48 0f 44 c7          	cmove  %rdi,%rax
}
   43233:	c3                   	ret    
   43234:	48 89 f8             	mov    %rdi,%rax
   43237:	c3                   	ret    

0000000000043238 <rand>:
    if (!rand_seed_set) {
   43238:	83 3d c5 6d 01 00 00 	cmpl   $0x0,0x16dc5(%rip)        # 5a004 <rand_seed_set>
   4323f:	74 1b                	je     4325c <rand+0x24>
    rand_seed = rand_seed * 1664525U + 1013904223U;
   43241:	69 05 b5 6d 01 00 0d 	imul   $0x19660d,0x16db5(%rip),%eax        # 5a000 <rand_seed>
   43248:	66 19 00 
   4324b:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
   43250:	89 05 aa 6d 01 00    	mov    %eax,0x16daa(%rip)        # 5a000 <rand_seed>
    return rand_seed & RAND_MAX;
   43256:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
   4325b:	c3                   	ret    
    rand_seed = seed;
   4325c:	c7 05 9a 6d 01 00 9e 	movl   $0x30d4879e,0x16d9a(%rip)        # 5a000 <rand_seed>
   43263:	87 d4 30 
    rand_seed_set = 1;
   43266:	c7 05 94 6d 01 00 01 	movl   $0x1,0x16d94(%rip)        # 5a004 <rand_seed_set>
   4326d:	00 00 00 
}
   43270:	eb cf                	jmp    43241 <rand+0x9>

0000000000043272 <srand>:
    rand_seed = seed;
   43272:	89 3d 88 6d 01 00    	mov    %edi,0x16d88(%rip)        # 5a000 <rand_seed>
    rand_seed_set = 1;
   43278:	c7 05 82 6d 01 00 01 	movl   $0x1,0x16d82(%rip)        # 5a004 <rand_seed_set>
   4327f:	00 00 00 
}
   43282:	c3                   	ret    

0000000000043283 <printer_vprintf>:
void printer_vprintf(printer* p, int color, const char* format, va_list val) {
   43283:	55                   	push   %rbp
   43284:	48 89 e5             	mov    %rsp,%rbp
   43287:	41 57                	push   %r15
   43289:	41 56                	push   %r14
   4328b:	41 55                	push   %r13
   4328d:	41 54                	push   %r12
   4328f:	53                   	push   %rbx
   43290:	48 83 ec 58          	sub    $0x58,%rsp
   43294:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    for (; *format; ++format) {
   43298:	0f b6 02             	movzbl (%rdx),%eax
   4329b:	84 c0                	test   %al,%al
   4329d:	0f 84 b0 06 00 00    	je     43953 <printer_vprintf+0x6d0>
   432a3:	49 89 fe             	mov    %rdi,%r14
   432a6:	49 89 d4             	mov    %rdx,%r12
            length = 1;
   432a9:	41 89 f7             	mov    %esi,%r15d
   432ac:	e9 a4 04 00 00       	jmp    43755 <printer_vprintf+0x4d2>
        for (++format; *format; ++format) {
   432b1:	49 8d 5c 24 01       	lea    0x1(%r12),%rbx
   432b6:	45 0f b6 64 24 01    	movzbl 0x1(%r12),%r12d
   432bc:	45 84 e4             	test   %r12b,%r12b
   432bf:	0f 84 82 06 00 00    	je     43947 <printer_vprintf+0x6c4>
        int flags = 0;
   432c5:	41 bd 00 00 00 00    	mov    $0x0,%r13d
            const char* flagc = strchr(flag_chars, *format);
   432cb:	41 0f be f4          	movsbl %r12b,%esi
   432cf:	bf 41 52 04 00       	mov    $0x45241,%edi
   432d4:	e8 37 ff ff ff       	call   43210 <strchr>
   432d9:	48 89 c1             	mov    %rax,%rcx
            if (flagc) {
   432dc:	48 85 c0             	test   %rax,%rax
   432df:	74 55                	je     43336 <printer_vprintf+0xb3>
                flags |= 1 << (flagc - flag_chars);
   432e1:	48 81 e9 41 52 04 00 	sub    $0x45241,%rcx
   432e8:	b8 01 00 00 00       	mov    $0x1,%eax
   432ed:	d3 e0                	shl    %cl,%eax
   432ef:	41 09 c5             	or     %eax,%r13d
        for (++format; *format; ++format) {
   432f2:	48 83 c3 01          	add    $0x1,%rbx
   432f6:	44 0f b6 23          	movzbl (%rbx),%r12d
   432fa:	45 84 e4             	test   %r12b,%r12b
   432fd:	75 cc                	jne    432cb <printer_vprintf+0x48>
   432ff:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
        int width = -1;
   43303:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
        int precision = -1;
   43309:	c7 45 9c ff ff ff ff 	movl   $0xffffffff,-0x64(%rbp)
        if (*format == '.') {
   43310:	80 3b 2e             	cmpb   $0x2e,(%rbx)
   43313:	0f 84 a9 00 00 00    	je     433c2 <printer_vprintf+0x13f>
        int length = 0;
   43319:	b9 00 00 00 00       	mov    $0x0,%ecx
        switch (*format) {
   4331e:	0f b6 13             	movzbl (%rbx),%edx
   43321:	8d 42 bd             	lea    -0x43(%rdx),%eax
   43324:	3c 37                	cmp    $0x37,%al
   43326:	0f 87 c4 04 00 00    	ja     437f0 <printer_vprintf+0x56d>
   4332c:	0f b6 c0             	movzbl %al,%eax
   4332f:	ff 24 c5 50 50 04 00 	jmp    *0x45050(,%rax,8)
        if (*format >= '1' && *format <= '9') {
   43336:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
   4333a:	41 8d 44 24 cf       	lea    -0x31(%r12),%eax
   4333f:	3c 08                	cmp    $0x8,%al
   43341:	77 2f                	ja     43372 <printer_vprintf+0xef>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   43343:	0f b6 03             	movzbl (%rbx),%eax
   43346:	8d 50 d0             	lea    -0x30(%rax),%edx
   43349:	80 fa 09             	cmp    $0x9,%dl
   4334c:	77 5e                	ja     433ac <printer_vprintf+0x129>
   4334e:	41 bd 00 00 00 00    	mov    $0x0,%r13d
                width = 10 * width + *format++ - '0';
   43354:	48 83 c3 01          	add    $0x1,%rbx
   43358:	43 8d 54 ad 00       	lea    0x0(%r13,%r13,4),%edx
   4335d:	0f be c0             	movsbl %al,%eax
   43360:	44 8d 6c 50 d0       	lea    -0x30(%rax,%rdx,2),%r13d
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   43365:	0f b6 03             	movzbl (%rbx),%eax
   43368:	8d 50 d0             	lea    -0x30(%rax),%edx
   4336b:	80 fa 09             	cmp    $0x9,%dl
   4336e:	76 e4                	jbe    43354 <printer_vprintf+0xd1>
   43370:	eb 97                	jmp    43309 <printer_vprintf+0x86>
        } else if (*format == '*') {
   43372:	41 80 fc 2a          	cmp    $0x2a,%r12b
   43376:	75 3f                	jne    433b7 <printer_vprintf+0x134>
            width = va_arg(val, int);
   43378:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   4337c:	8b 07                	mov    (%rdi),%eax
   4337e:	83 f8 2f             	cmp    $0x2f,%eax
   43381:	77 17                	ja     4339a <printer_vprintf+0x117>
   43383:	89 c2                	mov    %eax,%edx
   43385:	48 03 57 10          	add    0x10(%rdi),%rdx
   43389:	83 c0 08             	add    $0x8,%eax
   4338c:	89 07                	mov    %eax,(%rdi)
   4338e:	44 8b 2a             	mov    (%rdx),%r13d
            ++format;
   43391:	48 83 c3 01          	add    $0x1,%rbx
   43395:	e9 6f ff ff ff       	jmp    43309 <printer_vprintf+0x86>
            width = va_arg(val, int);
   4339a:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   4339e:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   433a2:	48 8d 42 08          	lea    0x8(%rdx),%rax
   433a6:	48 89 41 08          	mov    %rax,0x8(%rcx)
   433aa:	eb e2                	jmp    4338e <printer_vprintf+0x10b>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
   433ac:	41 bd 00 00 00 00    	mov    $0x0,%r13d
   433b2:	e9 52 ff ff ff       	jmp    43309 <printer_vprintf+0x86>
        int width = -1;
   433b7:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
   433bd:	e9 47 ff ff ff       	jmp    43309 <printer_vprintf+0x86>
            ++format;
   433c2:	48 8d 53 01          	lea    0x1(%rbx),%rdx
            if (*format >= '0' && *format <= '9') {
   433c6:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
   433ca:	8d 48 d0             	lea    -0x30(%rax),%ecx
   433cd:	80 f9 09             	cmp    $0x9,%cl
   433d0:	76 13                	jbe    433e5 <printer_vprintf+0x162>
            } else if (*format == '*') {
   433d2:	3c 2a                	cmp    $0x2a,%al
   433d4:	74 33                	je     43409 <printer_vprintf+0x186>
            ++format;
   433d6:	48 89 d3             	mov    %rdx,%rbx
                precision = 0;
   433d9:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
   433e0:	e9 34 ff ff ff       	jmp    43319 <printer_vprintf+0x96>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   433e5:	b9 00 00 00 00       	mov    $0x0,%ecx
                    precision = 10 * precision + *format++ - '0';
   433ea:	48 83 c2 01          	add    $0x1,%rdx
   433ee:	8d 0c 89             	lea    (%rcx,%rcx,4),%ecx
   433f1:	0f be c0             	movsbl %al,%eax
   433f4:	8d 4c 48 d0          	lea    -0x30(%rax,%rcx,2),%ecx
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
   433f8:	0f b6 02             	movzbl (%rdx),%eax
   433fb:	8d 70 d0             	lea    -0x30(%rax),%esi
   433fe:	40 80 fe 09          	cmp    $0x9,%sil
   43402:	76 e6                	jbe    433ea <printer_vprintf+0x167>
                    precision = 10 * precision + *format++ - '0';
   43404:	48 89 d3             	mov    %rdx,%rbx
   43407:	eb 1c                	jmp    43425 <printer_vprintf+0x1a2>
                precision = va_arg(val, int);
   43409:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   4340d:	8b 07                	mov    (%rdi),%eax
   4340f:	83 f8 2f             	cmp    $0x2f,%eax
   43412:	77 23                	ja     43437 <printer_vprintf+0x1b4>
   43414:	89 c2                	mov    %eax,%edx
   43416:	48 03 57 10          	add    0x10(%rdi),%rdx
   4341a:	83 c0 08             	add    $0x8,%eax
   4341d:	89 07                	mov    %eax,(%rdi)
   4341f:	8b 0a                	mov    (%rdx),%ecx
                ++format;
   43421:	48 83 c3 02          	add    $0x2,%rbx
            if (precision < 0) {
   43425:	85 c9                	test   %ecx,%ecx
   43427:	b8 00 00 00 00       	mov    $0x0,%eax
   4342c:	0f 49 c1             	cmovns %ecx,%eax
   4342f:	89 45 9c             	mov    %eax,-0x64(%rbp)
   43432:	e9 e2 fe ff ff       	jmp    43319 <printer_vprintf+0x96>
                precision = va_arg(val, int);
   43437:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   4343b:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   4343f:	48 8d 42 08          	lea    0x8(%rdx),%rax
   43443:	48 89 41 08          	mov    %rax,0x8(%rcx)
   43447:	eb d6                	jmp    4341f <printer_vprintf+0x19c>
        switch (*format) {
   43449:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
   4344e:	e9 f3 00 00 00       	jmp    43546 <printer_vprintf+0x2c3>
            ++format;
   43453:	48 83 c3 01          	add    $0x1,%rbx
            length = 1;
   43457:	b9 01 00 00 00       	mov    $0x1,%ecx
            goto again;
   4345c:	e9 bd fe ff ff       	jmp    4331e <printer_vprintf+0x9b>
            long x = length ? va_arg(val, long) : va_arg(val, int);
   43461:	85 c9                	test   %ecx,%ecx
   43463:	74 55                	je     434ba <printer_vprintf+0x237>
   43465:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43469:	8b 07                	mov    (%rdi),%eax
   4346b:	83 f8 2f             	cmp    $0x2f,%eax
   4346e:	77 38                	ja     434a8 <printer_vprintf+0x225>
   43470:	89 c2                	mov    %eax,%edx
   43472:	48 03 57 10          	add    0x10(%rdi),%rdx
   43476:	83 c0 08             	add    $0x8,%eax
   43479:	89 07                	mov    %eax,(%rdi)
   4347b:	48 8b 12             	mov    (%rdx),%rdx
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
   4347e:	48 89 d0             	mov    %rdx,%rax
   43481:	48 c1 f8 38          	sar    $0x38,%rax
            num = negative ? -x : x;
   43485:	49 89 d0             	mov    %rdx,%r8
   43488:	49 f7 d8             	neg    %r8
   4348b:	25 80 00 00 00       	and    $0x80,%eax
   43490:	4c 0f 44 c2          	cmove  %rdx,%r8
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
   43494:	0b 45 a8             	or     -0x58(%rbp),%eax
   43497:	83 c8 60             	or     $0x60,%eax
   4349a:	89 45 a8             	mov    %eax,-0x58(%rbp)
        char* data = "";
   4349d:	41 bc 47 50 04 00    	mov    $0x45047,%r12d
            break;
   434a3:	e9 35 01 00 00       	jmp    435dd <printer_vprintf+0x35a>
            long x = length ? va_arg(val, long) : va_arg(val, int);
   434a8:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   434ac:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   434b0:	48 8d 42 08          	lea    0x8(%rdx),%rax
   434b4:	48 89 41 08          	mov    %rax,0x8(%rcx)
   434b8:	eb c1                	jmp    4347b <printer_vprintf+0x1f8>
   434ba:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   434be:	8b 07                	mov    (%rdi),%eax
   434c0:	83 f8 2f             	cmp    $0x2f,%eax
   434c3:	77 10                	ja     434d5 <printer_vprintf+0x252>
   434c5:	89 c2                	mov    %eax,%edx
   434c7:	48 03 57 10          	add    0x10(%rdi),%rdx
   434cb:	83 c0 08             	add    $0x8,%eax
   434ce:	89 07                	mov    %eax,(%rdi)
   434d0:	48 63 12             	movslq (%rdx),%rdx
   434d3:	eb a9                	jmp    4347e <printer_vprintf+0x1fb>
   434d5:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   434d9:	48 8b 57 08          	mov    0x8(%rdi),%rdx
   434dd:	48 8d 42 08          	lea    0x8(%rdx),%rax
   434e1:	48 89 47 08          	mov    %rax,0x8(%rdi)
   434e5:	eb e9                	jmp    434d0 <printer_vprintf+0x24d>
        int base = 10;
   434e7:	be 0a 00 00 00       	mov    $0xa,%esi
   434ec:	eb 58                	jmp    43546 <printer_vprintf+0x2c3>
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   434ee:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   434f2:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   434f6:	48 8d 42 08          	lea    0x8(%rdx),%rax
   434fa:	48 89 41 08          	mov    %rax,0x8(%rcx)
   434fe:	eb 60                	jmp    43560 <printer_vprintf+0x2dd>
   43500:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43504:	8b 07                	mov    (%rdi),%eax
   43506:	83 f8 2f             	cmp    $0x2f,%eax
   43509:	77 10                	ja     4351b <printer_vprintf+0x298>
   4350b:	89 c2                	mov    %eax,%edx
   4350d:	48 03 57 10          	add    0x10(%rdi),%rdx
   43511:	83 c0 08             	add    $0x8,%eax
   43514:	89 07                	mov    %eax,(%rdi)
   43516:	44 8b 02             	mov    (%rdx),%r8d
   43519:	eb 48                	jmp    43563 <printer_vprintf+0x2e0>
   4351b:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   4351f:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   43523:	48 8d 42 08          	lea    0x8(%rdx),%rax
   43527:	48 89 41 08          	mov    %rax,0x8(%rcx)
   4352b:	eb e9                	jmp    43516 <printer_vprintf+0x293>
   4352d:	41 89 f1             	mov    %esi,%r9d
        if (flags & FLAG_NUMERIC) {
   43530:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
    const char* digits = upper_digits;
   43537:	bf 30 52 04 00       	mov    $0x45230,%edi
   4353c:	e9 e2 02 00 00       	jmp    43823 <printer_vprintf+0x5a0>
            base = 16;
   43541:	be 10 00 00 00       	mov    $0x10,%esi
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
   43546:	85 c9                	test   %ecx,%ecx
   43548:	74 b6                	je     43500 <printer_vprintf+0x27d>
   4354a:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   4354e:	8b 01                	mov    (%rcx),%eax
   43550:	83 f8 2f             	cmp    $0x2f,%eax
   43553:	77 99                	ja     434ee <printer_vprintf+0x26b>
   43555:	89 c2                	mov    %eax,%edx
   43557:	48 03 51 10          	add    0x10(%rcx),%rdx
   4355b:	83 c0 08             	add    $0x8,%eax
   4355e:	89 01                	mov    %eax,(%rcx)
   43560:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_NUMERIC;
   43563:	83 4d a8 20          	orl    $0x20,-0x58(%rbp)
    if (base < 0) {
   43567:	85 f6                	test   %esi,%esi
   43569:	79 c2                	jns    4352d <printer_vprintf+0x2aa>
        base = -base;
   4356b:	41 89 f1             	mov    %esi,%r9d
   4356e:	f7 de                	neg    %esi
   43570:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
        digits = lower_digits;
   43577:	bf 10 52 04 00       	mov    $0x45210,%edi
   4357c:	e9 a2 02 00 00       	jmp    43823 <printer_vprintf+0x5a0>
            num = (uintptr_t) va_arg(val, void*);
   43581:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43585:	8b 07                	mov    (%rdi),%eax
   43587:	83 f8 2f             	cmp    $0x2f,%eax
   4358a:	77 1c                	ja     435a8 <printer_vprintf+0x325>
   4358c:	89 c2                	mov    %eax,%edx
   4358e:	48 03 57 10          	add    0x10(%rdi),%rdx
   43592:	83 c0 08             	add    $0x8,%eax
   43595:	89 07                	mov    %eax,(%rdi)
   43597:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
   4359a:	81 4d a8 21 01 00 00 	orl    $0x121,-0x58(%rbp)
            base = -16;
   435a1:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
   435a6:	eb c3                	jmp    4356b <printer_vprintf+0x2e8>
            num = (uintptr_t) va_arg(val, void*);
   435a8:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   435ac:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   435b0:	48 8d 42 08          	lea    0x8(%rdx),%rax
   435b4:	48 89 41 08          	mov    %rax,0x8(%rcx)
   435b8:	eb dd                	jmp    43597 <printer_vprintf+0x314>
            data = va_arg(val, char*);
   435ba:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   435be:	8b 01                	mov    (%rcx),%eax
   435c0:	83 f8 2f             	cmp    $0x2f,%eax
   435c3:	0f 87 a5 01 00 00    	ja     4376e <printer_vprintf+0x4eb>
   435c9:	89 c2                	mov    %eax,%edx
   435cb:	48 03 51 10          	add    0x10(%rcx),%rdx
   435cf:	83 c0 08             	add    $0x8,%eax
   435d2:	89 01                	mov    %eax,(%rcx)
   435d4:	4c 8b 22             	mov    (%rdx),%r12
        unsigned long num = 0;
   435d7:	41 b8 00 00 00 00    	mov    $0x0,%r8d
        if (flags & FLAG_NUMERIC) {
   435dd:	8b 45 a8             	mov    -0x58(%rbp),%eax
   435e0:	83 e0 20             	and    $0x20,%eax
   435e3:	89 45 8c             	mov    %eax,-0x74(%rbp)
   435e6:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
   435ec:	0f 85 21 02 00 00    	jne    43813 <printer_vprintf+0x590>
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
   435f2:	8b 45 a8             	mov    -0x58(%rbp),%eax
   435f5:	89 45 88             	mov    %eax,-0x78(%rbp)
   435f8:	83 e0 60             	and    $0x60,%eax
   435fb:	83 f8 60             	cmp    $0x60,%eax
   435fe:	0f 84 54 02 00 00    	je     43858 <printer_vprintf+0x5d5>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   43604:	8b 45 a8             	mov    -0x58(%rbp),%eax
   43607:	83 e0 21             	and    $0x21,%eax
        const char* prefix = "";
   4360a:	48 c7 45 a0 47 50 04 	movq   $0x45047,-0x60(%rbp)
   43611:	00 
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
   43612:	83 f8 21             	cmp    $0x21,%eax
   43615:	0f 84 79 02 00 00    	je     43894 <printer_vprintf+0x611>
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
   4361b:	8b 7d 9c             	mov    -0x64(%rbp),%edi
   4361e:	89 f8                	mov    %edi,%eax
   43620:	f7 d0                	not    %eax
   43622:	c1 e8 1f             	shr    $0x1f,%eax
   43625:	89 45 84             	mov    %eax,-0x7c(%rbp)
   43628:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
   4362c:	0f 85 9e 02 00 00    	jne    438d0 <printer_vprintf+0x64d>
   43632:	84 c0                	test   %al,%al
   43634:	0f 84 96 02 00 00    	je     438d0 <printer_vprintf+0x64d>
            len = strnlen(data, precision);
   4363a:	48 63 f7             	movslq %edi,%rsi
   4363d:	4c 89 e7             	mov    %r12,%rdi
   43640:	e8 63 fb ff ff       	call   431a8 <strnlen>
   43645:	89 45 98             	mov    %eax,-0x68(%rbp)
                   && !(flags & FLAG_LEFTJUSTIFY)
   43648:	8b 45 88             	mov    -0x78(%rbp),%eax
   4364b:	83 e0 26             	and    $0x26,%eax
            zeros = 0;
   4364e:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
   43655:	83 f8 22             	cmp    $0x22,%eax
   43658:	0f 84 aa 02 00 00    	je     43908 <printer_vprintf+0x685>
        width -= len + zeros + strlen(prefix);
   4365e:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
   43662:	e8 26 fb ff ff       	call   4318d <strlen>
   43667:	8b 55 9c             	mov    -0x64(%rbp),%edx
   4366a:	03 55 98             	add    -0x68(%rbp),%edx
   4366d:	44 89 e9             	mov    %r13d,%ecx
   43670:	29 d1                	sub    %edx,%ecx
   43672:	29 c1                	sub    %eax,%ecx
   43674:	89 4d 8c             	mov    %ecx,-0x74(%rbp)
   43677:	41 89 cd             	mov    %ecx,%r13d
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   4367a:	f6 45 a8 04          	testb  $0x4,-0x58(%rbp)
   4367e:	75 2d                	jne    436ad <printer_vprintf+0x42a>
   43680:	85 c9                	test   %ecx,%ecx
   43682:	7e 29                	jle    436ad <printer_vprintf+0x42a>
            p->putc(p, ' ', color);
   43684:	44 89 fa             	mov    %r15d,%edx
   43687:	be 20 00 00 00       	mov    $0x20,%esi
   4368c:	4c 89 f7             	mov    %r14,%rdi
   4368f:	41 ff 16             	call   *(%r14)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
   43692:	41 83 ed 01          	sub    $0x1,%r13d
   43696:	45 85 ed             	test   %r13d,%r13d
   43699:	7f e9                	jg     43684 <printer_vprintf+0x401>
   4369b:	8b 7d 8c             	mov    -0x74(%rbp),%edi
   4369e:	85 ff                	test   %edi,%edi
   436a0:	b8 01 00 00 00       	mov    $0x1,%eax
   436a5:	0f 4f c7             	cmovg  %edi,%eax
   436a8:	29 c7                	sub    %eax,%edi
   436aa:	41 89 fd             	mov    %edi,%r13d
        for (; *prefix; ++prefix) {
   436ad:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
   436b1:	0f b6 07             	movzbl (%rdi),%eax
   436b4:	84 c0                	test   %al,%al
   436b6:	74 22                	je     436da <printer_vprintf+0x457>
   436b8:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
   436bc:	48 89 fb             	mov    %rdi,%rbx
            p->putc(p, *prefix, color);
   436bf:	0f b6 f0             	movzbl %al,%esi
   436c2:	44 89 fa             	mov    %r15d,%edx
   436c5:	4c 89 f7             	mov    %r14,%rdi
   436c8:	41 ff 16             	call   *(%r14)
        for (; *prefix; ++prefix) {
   436cb:	48 83 c3 01          	add    $0x1,%rbx
   436cf:	0f b6 03             	movzbl (%rbx),%eax
   436d2:	84 c0                	test   %al,%al
   436d4:	75 e9                	jne    436bf <printer_vprintf+0x43c>
   436d6:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; zeros > 0; --zeros) {
   436da:	8b 45 9c             	mov    -0x64(%rbp),%eax
   436dd:	85 c0                	test   %eax,%eax
   436df:	7e 1d                	jle    436fe <printer_vprintf+0x47b>
   436e1:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
   436e5:	89 c3                	mov    %eax,%ebx
            p->putc(p, '0', color);
   436e7:	44 89 fa             	mov    %r15d,%edx
   436ea:	be 30 00 00 00       	mov    $0x30,%esi
   436ef:	4c 89 f7             	mov    %r14,%rdi
   436f2:	41 ff 16             	call   *(%r14)
        for (; zeros > 0; --zeros) {
   436f5:	83 eb 01             	sub    $0x1,%ebx
   436f8:	75 ed                	jne    436e7 <printer_vprintf+0x464>
   436fa:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; len > 0; ++data, --len) {
   436fe:	8b 45 98             	mov    -0x68(%rbp),%eax
   43701:	85 c0                	test   %eax,%eax
   43703:	7e 27                	jle    4372c <printer_vprintf+0x4a9>
   43705:	89 c0                	mov    %eax,%eax
   43707:	4c 01 e0             	add    %r12,%rax
   4370a:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
   4370e:	48 89 c3             	mov    %rax,%rbx
            p->putc(p, *data, color);
   43711:	41 0f b6 34 24       	movzbl (%r12),%esi
   43716:	44 89 fa             	mov    %r15d,%edx
   43719:	4c 89 f7             	mov    %r14,%rdi
   4371c:	41 ff 16             	call   *(%r14)
        for (; len > 0; ++data, --len) {
   4371f:	49 83 c4 01          	add    $0x1,%r12
   43723:	49 39 dc             	cmp    %rbx,%r12
   43726:	75 e9                	jne    43711 <printer_vprintf+0x48e>
   43728:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; width > 0; --width) {
   4372c:	45 85 ed             	test   %r13d,%r13d
   4372f:	7e 14                	jle    43745 <printer_vprintf+0x4c2>
            p->putc(p, ' ', color);
   43731:	44 89 fa             	mov    %r15d,%edx
   43734:	be 20 00 00 00       	mov    $0x20,%esi
   43739:	4c 89 f7             	mov    %r14,%rdi
   4373c:	41 ff 16             	call   *(%r14)
        for (; width > 0; --width) {
   4373f:	41 83 ed 01          	sub    $0x1,%r13d
   43743:	75 ec                	jne    43731 <printer_vprintf+0x4ae>
    for (; *format; ++format) {
   43745:	4c 8d 63 01          	lea    0x1(%rbx),%r12
   43749:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
   4374d:	84 c0                	test   %al,%al
   4374f:	0f 84 fe 01 00 00    	je     43953 <printer_vprintf+0x6d0>
        if (*format != '%') {
   43755:	3c 25                	cmp    $0x25,%al
   43757:	0f 84 54 fb ff ff    	je     432b1 <printer_vprintf+0x2e>
            p->putc(p, *format, color);
   4375d:	0f b6 f0             	movzbl %al,%esi
   43760:	44 89 fa             	mov    %r15d,%edx
   43763:	4c 89 f7             	mov    %r14,%rdi
   43766:	41 ff 16             	call   *(%r14)
            continue;
   43769:	4c 89 e3             	mov    %r12,%rbx
   4376c:	eb d7                	jmp    43745 <printer_vprintf+0x4c2>
            data = va_arg(val, char*);
   4376e:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43772:	48 8b 57 08          	mov    0x8(%rdi),%rdx
   43776:	48 8d 42 08          	lea    0x8(%rdx),%rax
   4377a:	48 89 47 08          	mov    %rax,0x8(%rdi)
   4377e:	e9 51 fe ff ff       	jmp    435d4 <printer_vprintf+0x351>
            color = va_arg(val, int);
   43783:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   43787:	8b 07                	mov    (%rdi),%eax
   43789:	83 f8 2f             	cmp    $0x2f,%eax
   4378c:	77 10                	ja     4379e <printer_vprintf+0x51b>
   4378e:	89 c2                	mov    %eax,%edx
   43790:	48 03 57 10          	add    0x10(%rdi),%rdx
   43794:	83 c0 08             	add    $0x8,%eax
   43797:	89 07                	mov    %eax,(%rdi)
   43799:	44 8b 3a             	mov    (%rdx),%r15d
            goto done;
   4379c:	eb a7                	jmp    43745 <printer_vprintf+0x4c2>
            color = va_arg(val, int);
   4379e:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   437a2:	48 8b 51 08          	mov    0x8(%rcx),%rdx
   437a6:	48 8d 42 08          	lea    0x8(%rdx),%rax
   437aa:	48 89 41 08          	mov    %rax,0x8(%rcx)
   437ae:	eb e9                	jmp    43799 <printer_vprintf+0x516>
            numbuf[0] = va_arg(val, int);
   437b0:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
   437b4:	8b 01                	mov    (%rcx),%eax
   437b6:	83 f8 2f             	cmp    $0x2f,%eax
   437b9:	77 23                	ja     437de <printer_vprintf+0x55b>
   437bb:	89 c2                	mov    %eax,%edx
   437bd:	48 03 51 10          	add    0x10(%rcx),%rdx
   437c1:	83 c0 08             	add    $0x8,%eax
   437c4:	89 01                	mov    %eax,(%rcx)
   437c6:	8b 02                	mov    (%rdx),%eax
   437c8:	88 45 b8             	mov    %al,-0x48(%rbp)
            numbuf[1] = '\0';
   437cb:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
   437cf:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
   437d3:	41 b8 00 00 00 00    	mov    $0x0,%r8d
            break;
   437d9:	e9 ff fd ff ff       	jmp    435dd <printer_vprintf+0x35a>
            numbuf[0] = va_arg(val, int);
   437de:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
   437e2:	48 8b 57 08          	mov    0x8(%rdi),%rdx
   437e6:	48 8d 42 08          	lea    0x8(%rdx),%rax
   437ea:	48 89 47 08          	mov    %rax,0x8(%rdi)
   437ee:	eb d6                	jmp    437c6 <printer_vprintf+0x543>
            numbuf[0] = (*format ? *format : '%');
   437f0:	84 d2                	test   %dl,%dl
   437f2:	0f 85 39 01 00 00    	jne    43931 <printer_vprintf+0x6ae>
   437f8:	c6 45 b8 25          	movb   $0x25,-0x48(%rbp)
            numbuf[1] = '\0';
   437fc:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
                format--;
   43800:	48 83 eb 01          	sub    $0x1,%rbx
            data = numbuf;
   43804:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
   43808:	41 b8 00 00 00 00    	mov    $0x0,%r8d
   4380e:	e9 ca fd ff ff       	jmp    435dd <printer_vprintf+0x35a>
        if (flags & FLAG_NUMERIC) {
   43813:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
    const char* digits = upper_digits;
   43819:	bf 30 52 04 00       	mov    $0x45230,%edi
        if (flags & FLAG_NUMERIC) {
   4381e:	be 0a 00 00 00       	mov    $0xa,%esi
    *--numbuf_end = '\0';
   43823:	c6 45 cf 00          	movb   $0x0,-0x31(%rbp)
   43827:	4c 89 c1             	mov    %r8,%rcx
   4382a:	4c 8d 65 cf          	lea    -0x31(%rbp),%r12
        *--numbuf_end = digits[val % base];
   4382e:	48 63 f6             	movslq %esi,%rsi
   43831:	49 83 ec 01          	sub    $0x1,%r12
   43835:	48 89 c8             	mov    %rcx,%rax
   43838:	ba 00 00 00 00       	mov    $0x0,%edx
   4383d:	48 f7 f6             	div    %rsi
   43840:	0f b6 14 17          	movzbl (%rdi,%rdx,1),%edx
   43844:	41 88 14 24          	mov    %dl,(%r12)
        val /= base;
   43848:	48 89 ca             	mov    %rcx,%rdx
   4384b:	48 89 c1             	mov    %rax,%rcx
    } while (val != 0);
   4384e:	48 39 d6             	cmp    %rdx,%rsi
   43851:	76 de                	jbe    43831 <printer_vprintf+0x5ae>
   43853:	e9 9a fd ff ff       	jmp    435f2 <printer_vprintf+0x36f>
                prefix = "-";
   43858:	48 c7 45 a0 44 50 04 	movq   $0x45044,-0x60(%rbp)
   4385f:	00 
            if (flags & FLAG_NEGATIVE) {
   43860:	8b 45 a8             	mov    -0x58(%rbp),%eax
   43863:	a8 80                	test   $0x80,%al
   43865:	0f 85 b0 fd ff ff    	jne    4361b <printer_vprintf+0x398>
                prefix = "+";
   4386b:	48 c7 45 a0 3f 50 04 	movq   $0x4503f,-0x60(%rbp)
   43872:	00 
            } else if (flags & FLAG_PLUSPOSITIVE) {
   43873:	a8 10                	test   $0x10,%al
   43875:	0f 85 a0 fd ff ff    	jne    4361b <printer_vprintf+0x398>
                prefix = " ";
   4387b:	a8 08                	test   $0x8,%al
   4387d:	ba 47 50 04 00       	mov    $0x45047,%edx
   43882:	b8 46 50 04 00       	mov    $0x45046,%eax
   43887:	48 0f 44 c2          	cmove  %rdx,%rax
   4388b:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   4388f:	e9 87 fd ff ff       	jmp    4361b <printer_vprintf+0x398>
                   && (base == 16 || base == -16)
   43894:	41 8d 41 10          	lea    0x10(%r9),%eax
   43898:	a9 df ff ff ff       	test   $0xffffffdf,%eax
   4389d:	0f 85 78 fd ff ff    	jne    4361b <printer_vprintf+0x398>
                   && (num || (flags & FLAG_ALT2))) {
   438a3:	4d 85 c0             	test   %r8,%r8
   438a6:	75 0d                	jne    438b5 <printer_vprintf+0x632>
   438a8:	f7 45 a8 00 01 00 00 	testl  $0x100,-0x58(%rbp)
   438af:	0f 84 66 fd ff ff    	je     4361b <printer_vprintf+0x398>
            prefix = (base == -16 ? "0x" : "0X");
   438b5:	41 83 f9 f0          	cmp    $0xfffffff0,%r9d
   438b9:	ba 48 50 04 00       	mov    $0x45048,%edx
   438be:	b8 41 50 04 00       	mov    $0x45041,%eax
   438c3:	48 0f 44 c2          	cmove  %rdx,%rax
   438c7:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
   438cb:	e9 4b fd ff ff       	jmp    4361b <printer_vprintf+0x398>
            len = strlen(data);
   438d0:	4c 89 e7             	mov    %r12,%rdi
   438d3:	e8 b5 f8 ff ff       	call   4318d <strlen>
   438d8:	89 45 98             	mov    %eax,-0x68(%rbp)
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
   438db:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
   438df:	0f 84 63 fd ff ff    	je     43648 <printer_vprintf+0x3c5>
   438e5:	80 7d 84 00          	cmpb   $0x0,-0x7c(%rbp)
   438e9:	0f 84 59 fd ff ff    	je     43648 <printer_vprintf+0x3c5>
            zeros = precision > len ? precision - len : 0;
   438ef:	8b 4d 9c             	mov    -0x64(%rbp),%ecx
   438f2:	89 ca                	mov    %ecx,%edx
   438f4:	29 c2                	sub    %eax,%edx
   438f6:	39 c1                	cmp    %eax,%ecx
   438f8:	b8 00 00 00 00       	mov    $0x0,%eax
   438fd:	0f 4e d0             	cmovle %eax,%edx
   43900:	89 55 9c             	mov    %edx,-0x64(%rbp)
   43903:	e9 56 fd ff ff       	jmp    4365e <printer_vprintf+0x3db>
                   && len + (int) strlen(prefix) < width) {
   43908:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
   4390c:	e8 7c f8 ff ff       	call   4318d <strlen>
   43911:	8b 7d 98             	mov    -0x68(%rbp),%edi
   43914:	8d 14 07             	lea    (%rdi,%rax,1),%edx
            zeros = width - len - strlen(prefix);
   43917:	44 89 e9             	mov    %r13d,%ecx
   4391a:	29 f9                	sub    %edi,%ecx
   4391c:	29 c1                	sub    %eax,%ecx
   4391e:	44 39 ea             	cmp    %r13d,%edx
   43921:	b8 00 00 00 00       	mov    $0x0,%eax
   43926:	0f 4d c8             	cmovge %eax,%ecx
   43929:	89 4d 9c             	mov    %ecx,-0x64(%rbp)
   4392c:	e9 2d fd ff ff       	jmp    4365e <printer_vprintf+0x3db>
            numbuf[0] = (*format ? *format : '%');
   43931:	88 55 b8             	mov    %dl,-0x48(%rbp)
            numbuf[1] = '\0';
   43934:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
   43938:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
   4393c:	41 b8 00 00 00 00    	mov    $0x0,%r8d
   43942:	e9 96 fc ff ff       	jmp    435dd <printer_vprintf+0x35a>
        int flags = 0;
   43947:	c7 45 a8 00 00 00 00 	movl   $0x0,-0x58(%rbp)
   4394e:	e9 b0 f9 ff ff       	jmp    43303 <printer_vprintf+0x80>
}
   43953:	48 83 c4 58          	add    $0x58,%rsp
   43957:	5b                   	pop    %rbx
   43958:	41 5c                	pop    %r12
   4395a:	41 5d                	pop    %r13
   4395c:	41 5e                	pop    %r14
   4395e:	41 5f                	pop    %r15
   43960:	5d                   	pop    %rbp
   43961:	c3                   	ret    

0000000000043962 <console_vprintf>:
int console_vprintf(int cpos, int color, const char* format, va_list val) {
   43962:	55                   	push   %rbp
   43963:	48 89 e5             	mov    %rsp,%rbp
   43966:	48 83 ec 10          	sub    $0x10,%rsp
    cp.p.putc = console_putc;
   4396a:	48 c7 45 f0 6d 30 04 	movq   $0x4306d,-0x10(%rbp)
   43971:	00 
        cpos = 0;
   43972:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
   43978:	b8 00 00 00 00       	mov    $0x0,%eax
   4397d:	0f 43 f8             	cmovae %eax,%edi
    cp.cursor = console + cpos;
   43980:	48 63 ff             	movslq %edi,%rdi
   43983:	48 8d 84 3f 00 80 0b 	lea    0xb8000(%rdi,%rdi,1),%rax
   4398a:	00 
   4398b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
   4398f:	48 8d 7d f0          	lea    -0x10(%rbp),%rdi
   43993:	e8 eb f8 ff ff       	call   43283 <printer_vprintf>
    return cp.cursor - console;
   43998:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4399c:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
   439a2:	48 d1 f8             	sar    %rax
}
   439a5:	c9                   	leave  
   439a6:	c3                   	ret    

00000000000439a7 <console_printf>:
int console_printf(int cpos, int color, const char* format, ...) {
   439a7:	55                   	push   %rbp
   439a8:	48 89 e5             	mov    %rsp,%rbp
   439ab:	48 83 ec 50          	sub    $0x50,%rsp
   439af:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   439b3:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   439b7:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_start(val, format);
   439bb:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   439c2:	48 8d 45 10          	lea    0x10(%rbp),%rax
   439c6:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   439ca:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   439ce:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
   439d2:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   439d6:	e8 87 ff ff ff       	call   43962 <console_vprintf>
}
   439db:	c9                   	leave  
   439dc:	c3                   	ret    

00000000000439dd <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
   439dd:	55                   	push   %rbp
   439de:	48 89 e5             	mov    %rsp,%rbp
   439e1:	53                   	push   %rbx
   439e2:	48 83 ec 28          	sub    $0x28,%rsp
   439e6:	48 89 fb             	mov    %rdi,%rbx
    string_printer sp;
    sp.p.putc = string_putc;
   439e9:	48 c7 45 d8 f3 30 04 	movq   $0x430f3,-0x28(%rbp)
   439f0:	00 
    sp.s = s;
   439f1:	48 89 7d e0          	mov    %rdi,-0x20(%rbp)
    if (size) {
   439f5:	48 85 f6             	test   %rsi,%rsi
   439f8:	75 0b                	jne    43a05 <vsnprintf+0x28>
        sp.end = s + size - 1;
        printer_vprintf(&sp.p, 0, format, val);
        *sp.s = 0;
    }
    return sp.s - s;
   439fa:	8b 45 e0             	mov    -0x20(%rbp),%eax
   439fd:	29 d8                	sub    %ebx,%eax
}
   439ff:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
   43a03:	c9                   	leave  
   43a04:	c3                   	ret    
        sp.end = s + size - 1;
   43a05:	48 8d 44 37 ff       	lea    -0x1(%rdi,%rsi,1),%rax
   43a0a:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
   43a0e:	be 00 00 00 00       	mov    $0x0,%esi
   43a13:	48 8d 7d d8          	lea    -0x28(%rbp),%rdi
   43a17:	e8 67 f8 ff ff       	call   43283 <printer_vprintf>
        *sp.s = 0;
   43a1c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43a20:	c6 00 00             	movb   $0x0,(%rax)
   43a23:	eb d5                	jmp    439fa <vsnprintf+0x1d>

0000000000043a25 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
   43a25:	55                   	push   %rbp
   43a26:	48 89 e5             	mov    %rsp,%rbp
   43a29:	48 83 ec 50          	sub    $0x50,%rsp
   43a2d:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
   43a31:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
   43a35:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
   43a39:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
   43a40:	48 8d 45 10          	lea    0x10(%rbp),%rax
   43a44:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
   43a48:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   43a4c:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    int n = vsnprintf(s, size, format, val);
   43a50:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
   43a54:	e8 84 ff ff ff       	call   439dd <vsnprintf>
    va_end(val);
    return n;
}
   43a59:	c9                   	leave  
   43a5a:	c3                   	ret    

0000000000043a5b <console_clear>:

// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   43a5b:	b8 00 80 0b 00       	mov    $0xb8000,%eax
   43a60:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
        console[i] = ' ' | 0x0700;
   43a65:	66 c7 00 20 07       	movw   $0x720,(%rax)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
   43a6a:	48 83 c0 02          	add    $0x2,%rax
   43a6e:	48 39 d0             	cmp    %rdx,%rax
   43a71:	75 f2                	jne    43a65 <console_clear+0xa>
    }
    cursorpos = 0;
   43a73:	c7 05 7f 55 07 00 00 	movl   $0x0,0x7557f(%rip)        # b8ffc <cursorpos>
   43a7a:	00 00 00 
}
   43a7d:	c3                   	ret    

0000000000043a7e <palloc>:
   43a7e:	55                   	push   %rbp
   43a7f:	48 89 e5             	mov    %rsp,%rbp
   43a82:	48 83 ec 20          	sub    $0x20,%rsp
   43a86:	89 7d ec             	mov    %edi,-0x14(%rbp)
   43a89:	48 c7 45 f8 00 10 00 	movq   $0x1000,-0x8(%rbp)
   43a90:	00 
   43a91:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43a95:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43a99:	e9 95 00 00 00       	jmp    43b33 <palloc+0xb5>
   43a9e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43aa2:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43aa6:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   43aad:	00 
   43aae:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43ab2:	48 c1 e8 0c          	shr    $0xc,%rax
   43ab6:	48 98                	cltq   
   43ab8:	0f b6 84 00 20 1f 05 	movzbl 0x51f20(%rax,%rax,1),%eax
   43abf:	00 
   43ac0:	84 c0                	test   %al,%al
   43ac2:	75 6f                	jne    43b33 <palloc+0xb5>
   43ac4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43ac8:	48 c1 e8 0c          	shr    $0xc,%rax
   43acc:	48 98                	cltq   
   43ace:	0f b6 84 00 21 1f 05 	movzbl 0x51f21(%rax,%rax,1),%eax
   43ad5:	00 
   43ad6:	84 c0                	test   %al,%al
   43ad8:	75 59                	jne    43b33 <palloc+0xb5>
   43ada:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43ade:	48 c1 e8 0c          	shr    $0xc,%rax
   43ae2:	89 c2                	mov    %eax,%edx
   43ae4:	48 63 c2             	movslq %edx,%rax
   43ae7:	0f b6 84 00 21 1f 05 	movzbl 0x51f21(%rax,%rax,1),%eax
   43aee:	00 
   43aef:	83 c0 01             	add    $0x1,%eax
   43af2:	89 c1                	mov    %eax,%ecx
   43af4:	48 63 c2             	movslq %edx,%rax
   43af7:	88 8c 00 21 1f 05 00 	mov    %cl,0x51f21(%rax,%rax,1)
   43afe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43b02:	48 c1 e8 0c          	shr    $0xc,%rax
   43b06:	89 c1                	mov    %eax,%ecx
   43b08:	8b 45 ec             	mov    -0x14(%rbp),%eax
   43b0b:	89 c2                	mov    %eax,%edx
   43b0d:	48 63 c1             	movslq %ecx,%rax
   43b10:	88 94 00 20 1f 05 00 	mov    %dl,0x51f20(%rax,%rax,1)
   43b17:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43b1b:	ba 00 10 00 00       	mov    $0x1000,%edx
   43b20:	be cc 00 00 00       	mov    $0xcc,%esi
   43b25:	48 89 c7             	mov    %rax,%rdi
   43b28:	e8 45 f6 ff ff       	call   43172 <memset>
   43b2d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43b31:	eb 2c                	jmp    43b5f <palloc+0xe1>
   43b33:	48 81 7d f8 ff ff 1f 	cmpq   $0x1fffff,-0x8(%rbp)
   43b3a:	00 
   43b3b:	0f 86 5d ff ff ff    	jbe    43a9e <palloc+0x20>
   43b41:	ba 48 52 04 00       	mov    $0x45248,%edx
   43b46:	be 00 0c 00 00       	mov    $0xc00,%esi
   43b4b:	bf 80 07 00 00       	mov    $0x780,%edi
   43b50:	b8 00 00 00 00       	mov    $0x0,%eax
   43b55:	e8 4d fe ff ff       	call   439a7 <console_printf>
   43b5a:	b8 00 00 00 00       	mov    $0x0,%eax
   43b5f:	c9                   	leave  
   43b60:	c3                   	ret    

0000000000043b61 <palloc_target>:
   43b61:	55                   	push   %rbp
   43b62:	48 89 e5             	mov    %rsp,%rbp
   43b65:	48 8b 05 9c 64 01 00 	mov    0x1649c(%rip),%rax        # 5a008 <palloc_target_proc>
   43b6c:	48 85 c0             	test   %rax,%rax
   43b6f:	75 14                	jne    43b85 <palloc_target+0x24>
   43b71:	ba 61 52 04 00       	mov    $0x45261,%edx
   43b76:	be 27 00 00 00       	mov    $0x27,%esi
   43b7b:	bf 7c 52 04 00       	mov    $0x4527c,%edi
   43b80:	e8 ec e9 ff ff       	call   42571 <assert_fail>
   43b85:	48 8b 05 7c 64 01 00 	mov    0x1647c(%rip),%rax        # 5a008 <palloc_target_proc>
   43b8c:	8b 00                	mov    (%rax),%eax
   43b8e:	89 c7                	mov    %eax,%edi
   43b90:	e8 e9 fe ff ff       	call   43a7e <palloc>
   43b95:	5d                   	pop    %rbp
   43b96:	c3                   	ret    

0000000000043b97 <process_free>:
   43b97:	55                   	push   %rbp
   43b98:	48 89 e5             	mov    %rsp,%rbp
   43b9b:	48 83 ec 60          	sub    $0x60,%rsp
   43b9f:	89 7d ac             	mov    %edi,-0x54(%rbp)
   43ba2:	8b 45 ac             	mov    -0x54(%rbp),%eax
   43ba5:	48 63 d0             	movslq %eax,%rdx
   43ba8:	48 89 d0             	mov    %rdx,%rax
   43bab:	48 c1 e0 04          	shl    $0x4,%rax
   43baf:	48 29 d0             	sub    %rdx,%rax
   43bb2:	48 c1 e0 04          	shl    $0x4,%rax
   43bb6:	48 05 d8 10 05 00    	add    $0x510d8,%rax
   43bbc:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
   43bc2:	48 c7 45 f8 00 00 10 	movq   $0x100000,-0x8(%rbp)
   43bc9:	00 
   43bca:	e9 ad 00 00 00       	jmp    43c7c <process_free+0xe5>
   43bcf:	8b 45 ac             	mov    -0x54(%rbp),%eax
   43bd2:	48 63 d0             	movslq %eax,%rdx
   43bd5:	48 89 d0             	mov    %rdx,%rax
   43bd8:	48 c1 e0 04          	shl    $0x4,%rax
   43bdc:	48 29 d0             	sub    %rdx,%rax
   43bdf:	48 c1 e0 04          	shl    $0x4,%rax
   43be3:	48 05 e0 10 05 00    	add    $0x510e0,%rax
   43be9:	48 8b 08             	mov    (%rax),%rcx
   43bec:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
   43bf0:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   43bf4:	48 89 ce             	mov    %rcx,%rsi
   43bf7:	48 89 c7             	mov    %rax,%rdi
   43bfa:	e8 34 f0 ff ff       	call   42c33 <virtual_memory_lookup>
   43bff:	8b 45 c8             	mov    -0x38(%rbp),%eax
   43c02:	48 98                	cltq   
   43c04:	83 e0 01             	and    $0x1,%eax
   43c07:	48 85 c0             	test   %rax,%rax
   43c0a:	74 68                	je     43c74 <process_free+0xdd>
   43c0c:	8b 45 b8             	mov    -0x48(%rbp),%eax
   43c0f:	48 63 d0             	movslq %eax,%rdx
   43c12:	0f b6 94 12 21 1f 05 	movzbl 0x51f21(%rdx,%rdx,1),%edx
   43c19:	00 
   43c1a:	83 ea 01             	sub    $0x1,%edx
   43c1d:	48 98                	cltq   
   43c1f:	88 94 00 21 1f 05 00 	mov    %dl,0x51f21(%rax,%rax,1)
   43c26:	8b 45 b8             	mov    -0x48(%rbp),%eax
   43c29:	48 98                	cltq   
   43c2b:	0f b6 84 00 21 1f 05 	movzbl 0x51f21(%rax,%rax,1),%eax
   43c32:	00 
   43c33:	84 c0                	test   %al,%al
   43c35:	75 0f                	jne    43c46 <process_free+0xaf>
   43c37:	8b 45 b8             	mov    -0x48(%rbp),%eax
   43c3a:	48 98                	cltq   
   43c3c:	c6 84 00 20 1f 05 00 	movb   $0x0,0x51f20(%rax,%rax,1)
   43c43:	00 
   43c44:	eb 2e                	jmp    43c74 <process_free+0xdd>
   43c46:	8b 45 b8             	mov    -0x48(%rbp),%eax
   43c49:	48 98                	cltq   
   43c4b:	0f b6 84 00 20 1f 05 	movzbl 0x51f20(%rax,%rax,1),%eax
   43c52:	00 
   43c53:	0f be c0             	movsbl %al,%eax
   43c56:	39 45 ac             	cmp    %eax,-0x54(%rbp)
   43c59:	75 19                	jne    43c74 <process_free+0xdd>
   43c5b:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
   43c5f:	8b 55 ac             	mov    -0x54(%rbp),%edx
   43c62:	48 89 c6             	mov    %rax,%rsi
   43c65:	bf 88 52 04 00       	mov    $0x45288,%edi
   43c6a:	b8 00 00 00 00       	mov    $0x0,%eax
   43c6f:	e8 df e5 ff ff       	call   42253 <log_printf>
   43c74:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   43c7b:	00 
   43c7c:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   43c83:	00 
   43c84:	0f 86 45 ff ff ff    	jbe    43bcf <process_free+0x38>
   43c8a:	8b 45 ac             	mov    -0x54(%rbp),%eax
   43c8d:	48 63 d0             	movslq %eax,%rdx
   43c90:	48 89 d0             	mov    %rdx,%rax
   43c93:	48 c1 e0 04          	shl    $0x4,%rax
   43c97:	48 29 d0             	sub    %rdx,%rax
   43c9a:	48 c1 e0 04          	shl    $0x4,%rax
   43c9e:	48 05 e0 10 05 00    	add    $0x510e0,%rax
   43ca4:	48 8b 00             	mov    (%rax),%rax
   43ca7:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43cab:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43caf:	48 8b 00             	mov    (%rax),%rax
   43cb2:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43cb8:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   43cbc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43cc0:	48 8b 00             	mov    (%rax),%rax
   43cc3:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43cc9:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   43ccd:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43cd1:	48 8b 00             	mov    (%rax),%rax
   43cd4:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43cda:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   43cde:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43ce2:	48 8b 40 08          	mov    0x8(%rax),%rax
   43ce6:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
   43cec:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
   43cf0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43cf4:	48 c1 e8 0c          	shr    $0xc,%rax
   43cf8:	48 98                	cltq   
   43cfa:	0f b6 84 00 21 1f 05 	movzbl 0x51f21(%rax,%rax,1),%eax
   43d01:	00 
   43d02:	3c 01                	cmp    $0x1,%al
   43d04:	74 14                	je     43d1a <process_free+0x183>
   43d06:	ba c0 52 04 00       	mov    $0x452c0,%edx
   43d0b:	be 4f 00 00 00       	mov    $0x4f,%esi
   43d10:	bf 7c 52 04 00       	mov    $0x4527c,%edi
   43d15:	e8 57 e8 ff ff       	call   42571 <assert_fail>
   43d1a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43d1e:	48 c1 e8 0c          	shr    $0xc,%rax
   43d22:	48 98                	cltq   
   43d24:	c6 84 00 21 1f 05 00 	movb   $0x0,0x51f21(%rax,%rax,1)
   43d2b:	00 
   43d2c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43d30:	48 c1 e8 0c          	shr    $0xc,%rax
   43d34:	48 98                	cltq   
   43d36:	c6 84 00 20 1f 05 00 	movb   $0x0,0x51f20(%rax,%rax,1)
   43d3d:	00 
   43d3e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43d42:	48 c1 e8 0c          	shr    $0xc,%rax
   43d46:	48 98                	cltq   
   43d48:	0f b6 84 00 21 1f 05 	movzbl 0x51f21(%rax,%rax,1),%eax
   43d4f:	00 
   43d50:	3c 01                	cmp    $0x1,%al
   43d52:	74 14                	je     43d68 <process_free+0x1d1>
   43d54:	ba e8 52 04 00       	mov    $0x452e8,%edx
   43d59:	be 52 00 00 00       	mov    $0x52,%esi
   43d5e:	bf 7c 52 04 00       	mov    $0x4527c,%edi
   43d63:	e8 09 e8 ff ff       	call   42571 <assert_fail>
   43d68:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43d6c:	48 c1 e8 0c          	shr    $0xc,%rax
   43d70:	48 98                	cltq   
   43d72:	c6 84 00 21 1f 05 00 	movb   $0x0,0x51f21(%rax,%rax,1)
   43d79:	00 
   43d7a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43d7e:	48 c1 e8 0c          	shr    $0xc,%rax
   43d82:	48 98                	cltq   
   43d84:	c6 84 00 20 1f 05 00 	movb   $0x0,0x51f20(%rax,%rax,1)
   43d8b:	00 
   43d8c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43d90:	48 c1 e8 0c          	shr    $0xc,%rax
   43d94:	48 98                	cltq   
   43d96:	0f b6 84 00 21 1f 05 	movzbl 0x51f21(%rax,%rax,1),%eax
   43d9d:	00 
   43d9e:	3c 01                	cmp    $0x1,%al
   43da0:	74 14                	je     43db6 <process_free+0x21f>
   43da2:	ba 10 53 04 00       	mov    $0x45310,%edx
   43da7:	be 55 00 00 00       	mov    $0x55,%esi
   43dac:	bf 7c 52 04 00       	mov    $0x4527c,%edi
   43db1:	e8 bb e7 ff ff       	call   42571 <assert_fail>
   43db6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43dba:	48 c1 e8 0c          	shr    $0xc,%rax
   43dbe:	48 98                	cltq   
   43dc0:	c6 84 00 21 1f 05 00 	movb   $0x0,0x51f21(%rax,%rax,1)
   43dc7:	00 
   43dc8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43dcc:	48 c1 e8 0c          	shr    $0xc,%rax
   43dd0:	48 98                	cltq   
   43dd2:	c6 84 00 20 1f 05 00 	movb   $0x0,0x51f20(%rax,%rax,1)
   43dd9:	00 
   43dda:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43dde:	48 c1 e8 0c          	shr    $0xc,%rax
   43de2:	48 98                	cltq   
   43de4:	0f b6 84 00 21 1f 05 	movzbl 0x51f21(%rax,%rax,1),%eax
   43deb:	00 
   43dec:	3c 01                	cmp    $0x1,%al
   43dee:	74 14                	je     43e04 <process_free+0x26d>
   43df0:	ba 38 53 04 00       	mov    $0x45338,%edx
   43df5:	be 58 00 00 00       	mov    $0x58,%esi
   43dfa:	bf 7c 52 04 00       	mov    $0x4527c,%edi
   43dff:	e8 6d e7 ff ff       	call   42571 <assert_fail>
   43e04:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43e08:	48 c1 e8 0c          	shr    $0xc,%rax
   43e0c:	48 98                	cltq   
   43e0e:	c6 84 00 21 1f 05 00 	movb   $0x0,0x51f21(%rax,%rax,1)
   43e15:	00 
   43e16:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43e1a:	48 c1 e8 0c          	shr    $0xc,%rax
   43e1e:	48 98                	cltq   
   43e20:	c6 84 00 20 1f 05 00 	movb   $0x0,0x51f20(%rax,%rax,1)
   43e27:	00 
   43e28:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43e2c:	48 c1 e8 0c          	shr    $0xc,%rax
   43e30:	48 98                	cltq   
   43e32:	0f b6 84 00 21 1f 05 	movzbl 0x51f21(%rax,%rax,1),%eax
   43e39:	00 
   43e3a:	3c 01                	cmp    $0x1,%al
   43e3c:	74 14                	je     43e52 <process_free+0x2bb>
   43e3e:	ba 60 53 04 00       	mov    $0x45360,%edx
   43e43:	be 5b 00 00 00       	mov    $0x5b,%esi
   43e48:	bf 7c 52 04 00       	mov    $0x4527c,%edi
   43e4d:	e8 1f e7 ff ff       	call   42571 <assert_fail>
   43e52:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43e56:	48 c1 e8 0c          	shr    $0xc,%rax
   43e5a:	48 98                	cltq   
   43e5c:	c6 84 00 21 1f 05 00 	movb   $0x0,0x51f21(%rax,%rax,1)
   43e63:	00 
   43e64:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
   43e68:	48 c1 e8 0c          	shr    $0xc,%rax
   43e6c:	48 98                	cltq   
   43e6e:	c6 84 00 20 1f 05 00 	movb   $0x0,0x51f20(%rax,%rax,1)
   43e75:	00 
   43e76:	90                   	nop
   43e77:	c9                   	leave  
   43e78:	c3                   	ret    

0000000000043e79 <process_config_tables>:
   43e79:	55                   	push   %rbp
   43e7a:	48 89 e5             	mov    %rsp,%rbp
   43e7d:	48 83 ec 40          	sub    $0x40,%rsp
   43e81:	89 7d cc             	mov    %edi,-0x34(%rbp)
   43e84:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43e87:	89 c7                	mov    %eax,%edi
   43e89:	e8 f0 fb ff ff       	call   43a7e <palloc>
   43e8e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   43e92:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43e95:	89 c7                	mov    %eax,%edi
   43e97:	e8 e2 fb ff ff       	call   43a7e <palloc>
   43e9c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
   43ea0:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43ea3:	89 c7                	mov    %eax,%edi
   43ea5:	e8 d4 fb ff ff       	call   43a7e <palloc>
   43eaa:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   43eae:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43eb1:	89 c7                	mov    %eax,%edi
   43eb3:	e8 c6 fb ff ff       	call   43a7e <palloc>
   43eb8:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
   43ebc:	8b 45 cc             	mov    -0x34(%rbp),%eax
   43ebf:	89 c7                	mov    %eax,%edi
   43ec1:	e8 b8 fb ff ff       	call   43a7e <palloc>
   43ec6:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
   43eca:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   43ecf:	74 20                	je     43ef1 <process_config_tables+0x78>
   43ed1:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   43ed6:	74 19                	je     43ef1 <process_config_tables+0x78>
   43ed8:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   43edd:	74 12                	je     43ef1 <process_config_tables+0x78>
   43edf:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   43ee4:	74 0b                	je     43ef1 <process_config_tables+0x78>
   43ee6:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43eeb:	0f 85 e1 00 00 00    	jne    43fd2 <process_config_tables+0x159>
   43ef1:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   43ef6:	74 24                	je     43f1c <process_config_tables+0xa3>
   43ef8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43efc:	48 c1 e8 0c          	shr    $0xc,%rax
   43f00:	48 98                	cltq   
   43f02:	c6 84 00 20 1f 05 00 	movb   $0x0,0x51f20(%rax,%rax,1)
   43f09:	00 
   43f0a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43f0e:	48 c1 e8 0c          	shr    $0xc,%rax
   43f12:	48 98                	cltq   
   43f14:	c6 84 00 21 1f 05 00 	movb   $0x0,0x51f21(%rax,%rax,1)
   43f1b:	00 
   43f1c:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
   43f21:	74 24                	je     43f47 <process_config_tables+0xce>
   43f23:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43f27:	48 c1 e8 0c          	shr    $0xc,%rax
   43f2b:	48 98                	cltq   
   43f2d:	c6 84 00 20 1f 05 00 	movb   $0x0,0x51f20(%rax,%rax,1)
   43f34:	00 
   43f35:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43f39:	48 c1 e8 0c          	shr    $0xc,%rax
   43f3d:	48 98                	cltq   
   43f3f:	c6 84 00 21 1f 05 00 	movb   $0x0,0x51f21(%rax,%rax,1)
   43f46:	00 
   43f47:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   43f4c:	74 24                	je     43f72 <process_config_tables+0xf9>
   43f4e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43f52:	48 c1 e8 0c          	shr    $0xc,%rax
   43f56:	48 98                	cltq   
   43f58:	c6 84 00 20 1f 05 00 	movb   $0x0,0x51f20(%rax,%rax,1)
   43f5f:	00 
   43f60:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   43f64:	48 c1 e8 0c          	shr    $0xc,%rax
   43f68:	48 98                	cltq   
   43f6a:	c6 84 00 21 1f 05 00 	movb   $0x0,0x51f21(%rax,%rax,1)
   43f71:	00 
   43f72:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
   43f77:	74 24                	je     43f9d <process_config_tables+0x124>
   43f79:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43f7d:	48 c1 e8 0c          	shr    $0xc,%rax
   43f81:	48 98                	cltq   
   43f83:	c6 84 00 20 1f 05 00 	movb   $0x0,0x51f20(%rax,%rax,1)
   43f8a:	00 
   43f8b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   43f8f:	48 c1 e8 0c          	shr    $0xc,%rax
   43f93:	48 98                	cltq   
   43f95:	c6 84 00 21 1f 05 00 	movb   $0x0,0x51f21(%rax,%rax,1)
   43f9c:	00 
   43f9d:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
   43fa2:	74 24                	je     43fc8 <process_config_tables+0x14f>
   43fa4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43fa8:	48 c1 e8 0c          	shr    $0xc,%rax
   43fac:	48 98                	cltq   
   43fae:	c6 84 00 20 1f 05 00 	movb   $0x0,0x51f20(%rax,%rax,1)
   43fb5:	00 
   43fb6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   43fba:	48 c1 e8 0c          	shr    $0xc,%rax
   43fbe:	48 98                	cltq   
   43fc0:	c6 84 00 21 1f 05 00 	movb   $0x0,0x51f21(%rax,%rax,1)
   43fc7:	00 
   43fc8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   43fcd:	e9 f3 01 00 00       	jmp    441c5 <process_config_tables+0x34c>
   43fd2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   43fd6:	ba 00 10 00 00       	mov    $0x1000,%edx
   43fdb:	be 00 00 00 00       	mov    $0x0,%esi
   43fe0:	48 89 c7             	mov    %rax,%rdi
   43fe3:	e8 8a f1 ff ff       	call   43172 <memset>
   43fe8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   43fec:	ba 00 10 00 00       	mov    $0x1000,%edx
   43ff1:	be 00 00 00 00       	mov    $0x0,%esi
   43ff6:	48 89 c7             	mov    %rax,%rdi
   43ff9:	e8 74 f1 ff ff       	call   43172 <memset>
   43ffe:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44002:	ba 00 10 00 00       	mov    $0x1000,%edx
   44007:	be 00 00 00 00       	mov    $0x0,%esi
   4400c:	48 89 c7             	mov    %rax,%rdi
   4400f:	e8 5e f1 ff ff       	call   43172 <memset>
   44014:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   44018:	ba 00 10 00 00       	mov    $0x1000,%edx
   4401d:	be 00 00 00 00       	mov    $0x0,%esi
   44022:	48 89 c7             	mov    %rax,%rdi
   44025:	e8 48 f1 ff ff       	call   43172 <memset>
   4402a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4402e:	ba 00 10 00 00       	mov    $0x1000,%edx
   44033:	be 00 00 00 00       	mov    $0x0,%esi
   44038:	48 89 c7             	mov    %rax,%rdi
   4403b:	e8 32 f1 ff ff       	call   43172 <memset>
   44040:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44044:	48 83 c8 07          	or     $0x7,%rax
   44048:	48 89 c2             	mov    %rax,%rdx
   4404b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4404f:	48 89 10             	mov    %rdx,(%rax)
   44052:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44056:	48 83 c8 07          	or     $0x7,%rax
   4405a:	48 89 c2             	mov    %rax,%rdx
   4405d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   44061:	48 89 10             	mov    %rdx,(%rax)
   44064:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   44068:	48 83 c8 07          	or     $0x7,%rax
   4406c:	48 89 c2             	mov    %rax,%rdx
   4406f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44073:	48 89 10             	mov    %rdx,(%rax)
   44076:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4407a:	48 83 c8 07          	or     $0x7,%rax
   4407e:	48 89 c2             	mov    %rax,%rdx
   44081:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44085:	48 89 50 08          	mov    %rdx,0x8(%rax)
   44089:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   4408d:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   44093:	41 b8 03 00 00 00    	mov    $0x3,%r8d
   44099:	b9 00 00 10 00       	mov    $0x100000,%ecx
   4409e:	ba 00 00 00 00       	mov    $0x0,%edx
   440a3:	be 00 00 00 00       	mov    $0x0,%esi
   440a8:	48 89 c7             	mov    %rax,%rdi
   440ab:	e8 c0 e7 ff ff       	call   42870 <virtual_memory_map>
   440b0:	85 c0                	test   %eax,%eax
   440b2:	75 2f                	jne    440e3 <process_config_tables+0x26a>
   440b4:	ba 00 80 0b 00       	mov    $0xb8000,%edx
   440b9:	be 00 80 0b 00       	mov    $0xb8000,%esi
   440be:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   440c2:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   440c8:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   440ce:	b9 00 10 00 00       	mov    $0x1000,%ecx
   440d3:	48 89 c7             	mov    %rax,%rdi
   440d6:	e8 95 e7 ff ff       	call   42870 <virtual_memory_map>
   440db:	85 c0                	test   %eax,%eax
   440dd:	0f 84 bb 00 00 00    	je     4419e <process_config_tables+0x325>
   440e3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   440e7:	48 c1 e8 0c          	shr    $0xc,%rax
   440eb:	48 98                	cltq   
   440ed:	c6 84 00 20 1f 05 00 	movb   $0x0,0x51f20(%rax,%rax,1)
   440f4:	00 
   440f5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   440f9:	48 c1 e8 0c          	shr    $0xc,%rax
   440fd:	48 98                	cltq   
   440ff:	c6 84 00 21 1f 05 00 	movb   $0x0,0x51f21(%rax,%rax,1)
   44106:	00 
   44107:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4410b:	48 c1 e8 0c          	shr    $0xc,%rax
   4410f:	48 98                	cltq   
   44111:	c6 84 00 20 1f 05 00 	movb   $0x0,0x51f20(%rax,%rax,1)
   44118:	00 
   44119:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   4411d:	48 c1 e8 0c          	shr    $0xc,%rax
   44121:	48 98                	cltq   
   44123:	c6 84 00 21 1f 05 00 	movb   $0x0,0x51f21(%rax,%rax,1)
   4412a:	00 
   4412b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4412f:	48 c1 e8 0c          	shr    $0xc,%rax
   44133:	48 98                	cltq   
   44135:	c6 84 00 20 1f 05 00 	movb   $0x0,0x51f20(%rax,%rax,1)
   4413c:	00 
   4413d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44141:	48 c1 e8 0c          	shr    $0xc,%rax
   44145:	48 98                	cltq   
   44147:	c6 84 00 21 1f 05 00 	movb   $0x0,0x51f21(%rax,%rax,1)
   4414e:	00 
   4414f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   44153:	48 c1 e8 0c          	shr    $0xc,%rax
   44157:	48 98                	cltq   
   44159:	c6 84 00 20 1f 05 00 	movb   $0x0,0x51f20(%rax,%rax,1)
   44160:	00 
   44161:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
   44165:	48 c1 e8 0c          	shr    $0xc,%rax
   44169:	48 98                	cltq   
   4416b:	c6 84 00 21 1f 05 00 	movb   $0x0,0x51f21(%rax,%rax,1)
   44172:	00 
   44173:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44177:	48 c1 e8 0c          	shr    $0xc,%rax
   4417b:	48 98                	cltq   
   4417d:	c6 84 00 20 1f 05 00 	movb   $0x0,0x51f20(%rax,%rax,1)
   44184:	00 
   44185:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44189:	48 c1 e8 0c          	shr    $0xc,%rax
   4418d:	48 98                	cltq   
   4418f:	c6 84 00 21 1f 05 00 	movb   $0x0,0x51f21(%rax,%rax,1)
   44196:	00 
   44197:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   4419c:	eb 27                	jmp    441c5 <process_config_tables+0x34c>
   4419e:	8b 45 cc             	mov    -0x34(%rbp),%eax
   441a1:	48 63 d0             	movslq %eax,%rdx
   441a4:	48 89 d0             	mov    %rdx,%rax
   441a7:	48 c1 e0 04          	shl    $0x4,%rax
   441ab:	48 29 d0             	sub    %rdx,%rax
   441ae:	48 c1 e0 04          	shl    $0x4,%rax
   441b2:	48 8d 90 e0 10 05 00 	lea    0x510e0(%rax),%rdx
   441b9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
   441bd:	48 89 02             	mov    %rax,(%rdx)
   441c0:	b8 00 00 00 00       	mov    $0x0,%eax
   441c5:	c9                   	leave  
   441c6:	c3                   	ret    

00000000000441c7 <process_load>:
   441c7:	55                   	push   %rbp
   441c8:	48 89 e5             	mov    %rsp,%rbp
   441cb:	48 83 ec 20          	sub    $0x20,%rsp
   441cf:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   441d3:	89 75 e4             	mov    %esi,-0x1c(%rbp)
   441d6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   441da:	48 89 05 27 5e 01 00 	mov    %rax,0x15e27(%rip)        # 5a008 <palloc_target_proc>
   441e1:	8b 4d e4             	mov    -0x1c(%rbp),%ecx
   441e4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   441e8:	ba 61 3b 04 00       	mov    $0x43b61,%edx
   441ed:	89 ce                	mov    %ecx,%esi
   441ef:	48 89 c7             	mov    %rax,%rdi
   441f2:	e8 33 eb ff ff       	call   42d2a <program_load>
   441f7:	89 45 fc             	mov    %eax,-0x4(%rbp)
   441fa:	8b 45 fc             	mov    -0x4(%rbp),%eax
   441fd:	c9                   	leave  
   441fe:	c3                   	ret    

00000000000441ff <process_setup_stack>:
   441ff:	55                   	push   %rbp
   44200:	48 89 e5             	mov    %rsp,%rbp
   44203:	48 83 ec 20          	sub    $0x20,%rsp
   44207:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   4420b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4420f:	8b 00                	mov    (%rax),%eax
   44211:	89 c7                	mov    %eax,%edi
   44213:	e8 66 f8 ff ff       	call   43a7e <palloc>
   44218:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   4421c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44220:	48 c7 80 c8 00 00 00 	movq   $0x300000,0xc8(%rax)
   44227:	00 00 30 00 
   4422b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   4422f:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   44236:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   4423a:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   44240:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   44246:	b9 00 10 00 00       	mov    $0x1000,%ecx
   4424b:	be 00 f0 2f 00       	mov    $0x2ff000,%esi
   44250:	48 89 c7             	mov    %rax,%rdi
   44253:	e8 18 e6 ff ff       	call   42870 <virtual_memory_map>
   44258:	90                   	nop
   44259:	c9                   	leave  
   4425a:	c3                   	ret    

000000000004425b <find_free_pid>:
   4425b:	55                   	push   %rbp
   4425c:	48 89 e5             	mov    %rsp,%rbp
   4425f:	48 83 ec 10          	sub    $0x10,%rsp
   44263:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
   4426a:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
   44271:	eb 24                	jmp    44297 <find_free_pid+0x3c>
   44273:	8b 45 fc             	mov    -0x4(%rbp),%eax
   44276:	48 63 d0             	movslq %eax,%rdx
   44279:	48 89 d0             	mov    %rdx,%rax
   4427c:	48 c1 e0 04          	shl    $0x4,%rax
   44280:	48 29 d0             	sub    %rdx,%rax
   44283:	48 c1 e0 04          	shl    $0x4,%rax
   44287:	48 05 d8 10 05 00    	add    $0x510d8,%rax
   4428d:	8b 00                	mov    (%rax),%eax
   4428f:	85 c0                	test   %eax,%eax
   44291:	74 0c                	je     4429f <find_free_pid+0x44>
   44293:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
   44297:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
   4429b:	7e d6                	jle    44273 <find_free_pid+0x18>
   4429d:	eb 01                	jmp    442a0 <find_free_pid+0x45>
   4429f:	90                   	nop
   442a0:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
   442a4:	74 05                	je     442ab <find_free_pid+0x50>
   442a6:	8b 45 fc             	mov    -0x4(%rbp),%eax
   442a9:	eb 05                	jmp    442b0 <find_free_pid+0x55>
   442ab:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   442b0:	c9                   	leave  
   442b1:	c3                   	ret    

00000000000442b2 <process_fork>:
   442b2:	55                   	push   %rbp
   442b3:	48 89 e5             	mov    %rsp,%rbp
   442b6:	48 83 ec 40          	sub    $0x40,%rsp
   442ba:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
   442be:	b8 00 00 00 00       	mov    $0x0,%eax
   442c3:	e8 93 ff ff ff       	call   4425b <find_free_pid>
   442c8:	89 45 f4             	mov    %eax,-0xc(%rbp)
   442cb:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%rbp)
   442cf:	75 0a                	jne    442db <process_fork+0x29>
   442d1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   442d6:	e9 67 02 00 00       	jmp    44542 <process_fork+0x290>
   442db:	8b 45 f4             	mov    -0xc(%rbp),%eax
   442de:	48 63 d0             	movslq %eax,%rdx
   442e1:	48 89 d0             	mov    %rdx,%rax
   442e4:	48 c1 e0 04          	shl    $0x4,%rax
   442e8:	48 29 d0             	sub    %rdx,%rax
   442eb:	48 c1 e0 04          	shl    $0x4,%rax
   442ef:	48 05 00 10 05 00    	add    $0x51000,%rax
   442f5:	be 00 00 00 00       	mov    $0x0,%esi
   442fa:	48 89 c7             	mov    %rax,%rdi
   442fd:	e8 a7 da ff ff       	call   41da9 <process_init>
   44302:	8b 45 f4             	mov    -0xc(%rbp),%eax
   44305:	89 c7                	mov    %eax,%edi
   44307:	e8 6d fb ff ff       	call   43e79 <process_config_tables>
   4430c:	83 f8 ff             	cmp    $0xffffffff,%eax
   4430f:	75 0a                	jne    4431b <process_fork+0x69>
   44311:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   44316:	e9 27 02 00 00       	jmp    44542 <process_fork+0x290>
   4431b:	48 c7 45 f8 00 00 10 	movq   $0x100000,-0x8(%rbp)
   44322:	00 
   44323:	e9 79 01 00 00       	jmp    444a1 <process_fork+0x1ef>
   44328:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   4432c:	8b 00                	mov    (%rax),%eax
   4432e:	48 63 d0             	movslq %eax,%rdx
   44331:	48 89 d0             	mov    %rdx,%rax
   44334:	48 c1 e0 04          	shl    $0x4,%rax
   44338:	48 29 d0             	sub    %rdx,%rax
   4433b:	48 c1 e0 04          	shl    $0x4,%rax
   4433f:	48 05 e0 10 05 00    	add    $0x510e0,%rax
   44345:	48 8b 08             	mov    (%rax),%rcx
   44348:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
   4434c:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   44350:	48 89 ce             	mov    %rcx,%rsi
   44353:	48 89 c7             	mov    %rax,%rdi
   44356:	e8 d8 e8 ff ff       	call   42c33 <virtual_memory_lookup>
   4435b:	8b 45 e0             	mov    -0x20(%rbp),%eax
   4435e:	48 98                	cltq   
   44360:	83 e0 07             	and    $0x7,%eax
   44363:	48 83 f8 07          	cmp    $0x7,%rax
   44367:	0f 85 a1 00 00 00    	jne    4440e <process_fork+0x15c>
   4436d:	8b 45 f4             	mov    -0xc(%rbp),%eax
   44370:	89 c7                	mov    %eax,%edi
   44372:	e8 07 f7 ff ff       	call   43a7e <palloc>
   44377:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
   4437b:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
   44380:	75 14                	jne    44396 <process_fork+0xe4>
   44382:	8b 45 f4             	mov    -0xc(%rbp),%eax
   44385:	89 c7                	mov    %eax,%edi
   44387:	e8 0b f8 ff ff       	call   43b97 <process_free>
   4438c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   44391:	e9 ac 01 00 00       	jmp    44542 <process_fork+0x290>
   44396:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   4439a:	48 89 c1             	mov    %rax,%rcx
   4439d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   443a1:	ba 00 10 00 00       	mov    $0x1000,%edx
   443a6:	48 89 ce             	mov    %rcx,%rsi
   443a9:	48 89 c7             	mov    %rax,%rdi
   443ac:	e8 58 ed ff ff       	call   43109 <memcpy>
   443b1:	48 8b 7d e8          	mov    -0x18(%rbp),%rdi
   443b5:	8b 45 f4             	mov    -0xc(%rbp),%eax
   443b8:	48 63 d0             	movslq %eax,%rdx
   443bb:	48 89 d0             	mov    %rdx,%rax
   443be:	48 c1 e0 04          	shl    $0x4,%rax
   443c2:	48 29 d0             	sub    %rdx,%rax
   443c5:	48 c1 e0 04          	shl    $0x4,%rax
   443c9:	48 05 e0 10 05 00    	add    $0x510e0,%rax
   443cf:	48 8b 00             	mov    (%rax),%rax
   443d2:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   443d6:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   443dc:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   443e2:	b9 00 10 00 00       	mov    $0x1000,%ecx
   443e7:	48 89 fa             	mov    %rdi,%rdx
   443ea:	48 89 c7             	mov    %rax,%rdi
   443ed:	e8 7e e4 ff ff       	call   42870 <virtual_memory_map>
   443f2:	85 c0                	test   %eax,%eax
   443f4:	0f 84 9f 00 00 00    	je     44499 <process_fork+0x1e7>
   443fa:	8b 45 f4             	mov    -0xc(%rbp),%eax
   443fd:	89 c7                	mov    %eax,%edi
   443ff:	e8 93 f7 ff ff       	call   43b97 <process_free>
   44404:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   44409:	e9 34 01 00 00       	jmp    44542 <process_fork+0x290>
   4440e:	8b 45 e0             	mov    -0x20(%rbp),%eax
   44411:	48 98                	cltq   
   44413:	83 e0 05             	and    $0x5,%eax
   44416:	48 83 f8 05          	cmp    $0x5,%rax
   4441a:	75 7d                	jne    44499 <process_fork+0x1e7>
   4441c:	48 8b 7d d8          	mov    -0x28(%rbp),%rdi
   44420:	8b 45 f4             	mov    -0xc(%rbp),%eax
   44423:	48 63 d0             	movslq %eax,%rdx
   44426:	48 89 d0             	mov    %rdx,%rax
   44429:	48 c1 e0 04          	shl    $0x4,%rax
   4442d:	48 29 d0             	sub    %rdx,%rax
   44430:	48 c1 e0 04          	shl    $0x4,%rax
   44434:	48 05 e0 10 05 00    	add    $0x510e0,%rax
   4443a:	48 8b 00             	mov    (%rax),%rax
   4443d:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
   44441:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   44447:	41 b8 05 00 00 00    	mov    $0x5,%r8d
   4444d:	b9 00 10 00 00       	mov    $0x1000,%ecx
   44452:	48 89 fa             	mov    %rdi,%rdx
   44455:	48 89 c7             	mov    %rax,%rdi
   44458:	e8 13 e4 ff ff       	call   42870 <virtual_memory_map>
   4445d:	85 c0                	test   %eax,%eax
   4445f:	74 14                	je     44475 <process_fork+0x1c3>
   44461:	8b 45 f4             	mov    -0xc(%rbp),%eax
   44464:	89 c7                	mov    %eax,%edi
   44466:	e8 2c f7 ff ff       	call   43b97 <process_free>
   4446b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   44470:	e9 cd 00 00 00       	jmp    44542 <process_fork+0x290>
   44475:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
   44479:	48 c1 e8 0c          	shr    $0xc,%rax
   4447d:	89 c2                	mov    %eax,%edx
   4447f:	48 63 c2             	movslq %edx,%rax
   44482:	0f b6 84 00 21 1f 05 	movzbl 0x51f21(%rax,%rax,1),%eax
   44489:	00 
   4448a:	83 c0 01             	add    $0x1,%eax
   4448d:	89 c1                	mov    %eax,%ecx
   4448f:	48 63 c2             	movslq %edx,%rax
   44492:	88 8c 00 21 1f 05 00 	mov    %cl,0x51f21(%rax,%rax,1)
   44499:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
   444a0:	00 
   444a1:	48 81 7d f8 ff ff 2f 	cmpq   $0x2fffff,-0x8(%rbp)
   444a8:	00 
   444a9:	0f 86 79 fe ff ff    	jbe    44328 <process_fork+0x76>
   444af:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
   444b3:	8b 08                	mov    (%rax),%ecx
   444b5:	8b 45 f4             	mov    -0xc(%rbp),%eax
   444b8:	48 63 d0             	movslq %eax,%rdx
   444bb:	48 89 d0             	mov    %rdx,%rax
   444be:	48 c1 e0 04          	shl    $0x4,%rax
   444c2:	48 29 d0             	sub    %rdx,%rax
   444c5:	48 c1 e0 04          	shl    $0x4,%rax
   444c9:	48 8d b0 10 10 05 00 	lea    0x51010(%rax),%rsi
   444d0:	48 63 d1             	movslq %ecx,%rdx
   444d3:	48 89 d0             	mov    %rdx,%rax
   444d6:	48 c1 e0 04          	shl    $0x4,%rax
   444da:	48 29 d0             	sub    %rdx,%rax
   444dd:	48 c1 e0 04          	shl    $0x4,%rax
   444e1:	48 8d 90 10 10 05 00 	lea    0x51010(%rax),%rdx
   444e8:	48 8d 46 08          	lea    0x8(%rsi),%rax
   444ec:	48 83 c2 08          	add    $0x8,%rdx
   444f0:	b9 18 00 00 00       	mov    $0x18,%ecx
   444f5:	48 89 c7             	mov    %rax,%rdi
   444f8:	48 89 d6             	mov    %rdx,%rsi
   444fb:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
   444fe:	8b 45 f4             	mov    -0xc(%rbp),%eax
   44501:	48 63 d0             	movslq %eax,%rdx
   44504:	48 89 d0             	mov    %rdx,%rax
   44507:	48 c1 e0 04          	shl    $0x4,%rax
   4450b:	48 29 d0             	sub    %rdx,%rax
   4450e:	48 c1 e0 04          	shl    $0x4,%rax
   44512:	48 05 18 10 05 00    	add    $0x51018,%rax
   44518:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
   4451f:	8b 45 f4             	mov    -0xc(%rbp),%eax
   44522:	48 63 d0             	movslq %eax,%rdx
   44525:	48 89 d0             	mov    %rdx,%rax
   44528:	48 c1 e0 04          	shl    $0x4,%rax
   4452c:	48 29 d0             	sub    %rdx,%rax
   4452f:	48 c1 e0 04          	shl    $0x4,%rax
   44533:	48 05 d8 10 05 00    	add    $0x510d8,%rax
   44539:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
   4453f:	8b 45 f4             	mov    -0xc(%rbp),%eax
   44542:	c9                   	leave  
   44543:	c3                   	ret    

0000000000044544 <process_page_alloc>:
   44544:	55                   	push   %rbp
   44545:	48 89 e5             	mov    %rsp,%rbp
   44548:	48 83 ec 20          	sub    $0x20,%rsp
   4454c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
   44550:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
   44554:	48 81 7d e0 ff ff 0f 	cmpq   $0xfffff,-0x20(%rbp)
   4455b:	00 
   4455c:	77 07                	ja     44565 <process_page_alloc+0x21>
   4455e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   44563:	eb 4b                	jmp    445b0 <process_page_alloc+0x6c>
   44565:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44569:	8b 00                	mov    (%rax),%eax
   4456b:	89 c7                	mov    %eax,%edi
   4456d:	e8 0c f5 ff ff       	call   43a7e <palloc>
   44572:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   44576:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
   4457b:	74 2e                	je     445ab <process_page_alloc+0x67>
   4457d:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
   44581:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
   44585:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
   4458c:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
   44590:	41 b9 00 00 00 00    	mov    $0x0,%r9d
   44596:	41 b8 07 00 00 00    	mov    $0x7,%r8d
   4459c:	b9 00 10 00 00       	mov    $0x1000,%ecx
   445a1:	48 89 c7             	mov    %rax,%rdi
   445a4:	e8 c7 e2 ff ff       	call   42870 <virtual_memory_map>
   445a9:	eb 05                	jmp    445b0 <process_page_alloc+0x6c>
   445ab:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
   445b0:	c9                   	leave  
   445b1:	c3                   	ret    
