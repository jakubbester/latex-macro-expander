
obj/p-malloc.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000100000 <process_main>:
extern uint8_t end[];

uint8_t* heap_top;
uint8_t* stack_bottom;

void process_main(void) {
  100000:	55                   	push   %rbp
  100001:	48 89 e5             	mov    %rsp,%rbp
  100004:	53                   	push   %rbx
  100005:	48 83 ec 08          	sub    $0x8,%rsp

// getpid
//    Return current process ID.
static inline pid_t getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  100009:	cd 31                	int    $0x31
  10000b:	89 c3                	mov    %eax,%ebx
    pid_t p = getpid();

    heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  10000d:	b8 47 30 10 00       	mov    $0x103047,%eax
  100012:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  100018:	48 89 05 e9 1f 00 00 	mov    %rax,0x1fe9(%rip)        # 102008 <heap_top>
    return rbp;
}

static inline uintptr_t read_rsp(void) {
    uintptr_t rsp;
    asm volatile("movq %%rsp,%0" : "=r" (rsp));
  10001f:	48 89 e0             	mov    %rsp,%rax

    // The bottom of the stack is the first address on the current
    // stack page (this process never needs more than one stack page).
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);
  100022:	48 83 e8 01          	sub    $0x1,%rax
  100026:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  10002c:	48 89 05 cd 1f 00 00 	mov    %rax,0x1fcd(%rip)        # 102000 <stack_bottom>
  100033:	eb 02                	jmp    100037 <process_main+0x37>

// yield
//    Yield control of the CPU to the kernel. The kernel will pick another
//    process to run, if possible.
static inline void yield(void) {
    asm volatile ("int %0" : /* no result */
  100035:	cd 32                	int    $0x32

    // Allocate heap pages until (1) hit the stack (out of address space)
    // or (2) allocation fails (out of physical memory).
    while (1) {
	if ((rand() % ALLOC_SLOWDOWN) < p) {
  100037:	e8 00 02 00 00       	call   10023c <rand>
  10003c:	48 63 d0             	movslq %eax,%rdx
  10003f:	48 69 d2 1f 85 eb 51 	imul   $0x51eb851f,%rdx,%rdx
  100046:	48 c1 fa 25          	sar    $0x25,%rdx
  10004a:	89 c1                	mov    %eax,%ecx
  10004c:	c1 f9 1f             	sar    $0x1f,%ecx
  10004f:	29 ca                	sub    %ecx,%edx
  100051:	6b d2 64             	imul   $0x64,%edx,%edx
  100054:	29 d0                	sub    %edx,%eax
  100056:	39 d8                	cmp    %ebx,%eax
  100058:	7d db                	jge    100035 <process_main+0x35>
	    void * ret = malloc(PAGESIZE);
  10005a:	bf 00 10 00 00       	mov    $0x1000,%edi
  10005f:	e8 da 0c 00 00       	call   100d3e <malloc>
	    if(ret == NULL)
  100064:	48 85 c0             	test   %rax,%rax
  100067:	74 04                	je     10006d <process_main+0x6d>
		break;
	    *((int*)ret) = p;       // check we have write access
  100069:	89 18                	mov    %ebx,(%rax)
  10006b:	eb c8                	jmp    100035 <process_main+0x35>
  10006d:	cd 32                	int    $0x32
  10006f:	eb fc                	jmp    10006d <process_main+0x6d>

0000000000100071 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  100071:	48 89 f9             	mov    %rdi,%rcx
  100074:	89 d7                	mov    %edx,%edi
    console_printer* cp = (console_printer*) p;
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  100076:	48 81 79 08 a0 8f 0b 	cmpq   $0xb8fa0,0x8(%rcx)
  10007d:	00 
  10007e:	72 08                	jb     100088 <console_putc+0x17>
        cp->cursor = console;
  100080:	48 c7 41 08 00 80 0b 	movq   $0xb8000,0x8(%rcx)
  100087:	00 
    }
    if (c == '\n') {
  100088:	40 80 fe 0a          	cmp    $0xa,%sil
  10008c:	74 16                	je     1000a4 <console_putc+0x33>
        int pos = (cp->cursor - console) % 80;
        for (; pos != 80; pos++) {
            *cp->cursor++ = ' ' | color;
        }
    } else {
        *cp->cursor++ = c | color;
  10008e:	48 8b 41 08          	mov    0x8(%rcx),%rax
  100092:	48 8d 50 02          	lea    0x2(%rax),%rdx
  100096:	48 89 51 08          	mov    %rdx,0x8(%rcx)
  10009a:	40 0f b6 f6          	movzbl %sil,%esi
  10009e:	09 fe                	or     %edi,%esi
  1000a0:	66 89 30             	mov    %si,(%rax)
    }
}
  1000a3:	c3                   	ret    
        int pos = (cp->cursor - console) % 80;
  1000a4:	4c 8b 41 08          	mov    0x8(%rcx),%r8
  1000a8:	49 81 e8 00 80 0b 00 	sub    $0xb8000,%r8
  1000af:	4c 89 c6             	mov    %r8,%rsi
  1000b2:	48 d1 fe             	sar    %rsi
  1000b5:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  1000bc:	66 66 66 
  1000bf:	48 89 f0             	mov    %rsi,%rax
  1000c2:	48 f7 ea             	imul   %rdx
  1000c5:	48 c1 fa 05          	sar    $0x5,%rdx
  1000c9:	49 c1 f8 3f          	sar    $0x3f,%r8
  1000cd:	4c 29 c2             	sub    %r8,%rdx
  1000d0:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
  1000d4:	48 c1 e2 04          	shl    $0x4,%rdx
  1000d8:	89 f0                	mov    %esi,%eax
  1000da:	29 d0                	sub    %edx,%eax
            *cp->cursor++ = ' ' | color;
  1000dc:	83 cf 20             	or     $0x20,%edi
  1000df:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1000e3:	48 8d 72 02          	lea    0x2(%rdx),%rsi
  1000e7:	48 89 71 08          	mov    %rsi,0x8(%rcx)
  1000eb:	66 89 3a             	mov    %di,(%rdx)
        for (; pos != 80; pos++) {
  1000ee:	83 c0 01             	add    $0x1,%eax
  1000f1:	83 f8 50             	cmp    $0x50,%eax
  1000f4:	75 e9                	jne    1000df <console_putc+0x6e>
  1000f6:	c3                   	ret    

00000000001000f7 <string_putc>:
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
    string_printer* sp = (string_printer*) p;
    if (sp->s < sp->end) {
  1000f7:	48 8b 47 08          	mov    0x8(%rdi),%rax
  1000fb:	48 3b 47 10          	cmp    0x10(%rdi),%rax
  1000ff:	73 0b                	jae    10010c <string_putc+0x15>
        *sp->s++ = c;
  100101:	48 8d 50 01          	lea    0x1(%rax),%rdx
  100105:	48 89 57 08          	mov    %rdx,0x8(%rdi)
  100109:	40 88 30             	mov    %sil,(%rax)
    }
    (void) color;
}
  10010c:	c3                   	ret    

000000000010010d <memcpy>:
void* memcpy(void* dst, const void* src, size_t n) {
  10010d:	48 89 f8             	mov    %rdi,%rax
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100110:	48 85 d2             	test   %rdx,%rdx
  100113:	74 17                	je     10012c <memcpy+0x1f>
  100115:	b9 00 00 00 00       	mov    $0x0,%ecx
        *d = *s;
  10011a:	44 0f b6 04 0e       	movzbl (%rsi,%rcx,1),%r8d
  10011f:	44 88 04 08          	mov    %r8b,(%rax,%rcx,1)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100123:	48 83 c1 01          	add    $0x1,%rcx
  100127:	48 39 d1             	cmp    %rdx,%rcx
  10012a:	75 ee                	jne    10011a <memcpy+0xd>
}
  10012c:	c3                   	ret    

000000000010012d <memmove>:
void* memmove(void* dst, const void* src, size_t n) {
  10012d:	48 89 f8             	mov    %rdi,%rax
    if (s < d && s + n > d) {
  100130:	48 39 fe             	cmp    %rdi,%rsi
  100133:	72 1d                	jb     100152 <memmove+0x25>
        while (n-- > 0) {
  100135:	b9 00 00 00 00       	mov    $0x0,%ecx
  10013a:	48 85 d2             	test   %rdx,%rdx
  10013d:	74 12                	je     100151 <memmove+0x24>
            *d++ = *s++;
  10013f:	0f b6 3c 0e          	movzbl (%rsi,%rcx,1),%edi
  100143:	40 88 3c 08          	mov    %dil,(%rax,%rcx,1)
        while (n-- > 0) {
  100147:	48 83 c1 01          	add    $0x1,%rcx
  10014b:	48 39 ca             	cmp    %rcx,%rdx
  10014e:	75 ef                	jne    10013f <memmove+0x12>
}
  100150:	c3                   	ret    
  100151:	c3                   	ret    
    if (s < d && s + n > d) {
  100152:	48 8d 0c 16          	lea    (%rsi,%rdx,1),%rcx
  100156:	48 39 cf             	cmp    %rcx,%rdi
  100159:	73 da                	jae    100135 <memmove+0x8>
        while (n-- > 0) {
  10015b:	48 8d 4a ff          	lea    -0x1(%rdx),%rcx
  10015f:	48 85 d2             	test   %rdx,%rdx
  100162:	74 ec                	je     100150 <memmove+0x23>
            *--d = *--s;
  100164:	0f b6 14 0e          	movzbl (%rsi,%rcx,1),%edx
  100168:	88 14 08             	mov    %dl,(%rax,%rcx,1)
        while (n-- > 0) {
  10016b:	48 83 e9 01          	sub    $0x1,%rcx
  10016f:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
  100173:	75 ef                	jne    100164 <memmove+0x37>
  100175:	c3                   	ret    

0000000000100176 <memset>:
void* memset(void* v, int c, size_t n) {
  100176:	48 89 f8             	mov    %rdi,%rax
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100179:	48 85 d2             	test   %rdx,%rdx
  10017c:	74 12                	je     100190 <memset+0x1a>
  10017e:	48 01 fa             	add    %rdi,%rdx
  100181:	48 89 f9             	mov    %rdi,%rcx
        *p = c;
  100184:	40 88 31             	mov    %sil,(%rcx)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100187:	48 83 c1 01          	add    $0x1,%rcx
  10018b:	48 39 ca             	cmp    %rcx,%rdx
  10018e:	75 f4                	jne    100184 <memset+0xe>
}
  100190:	c3                   	ret    

0000000000100191 <strlen>:
    for (n = 0; *s != '\0'; ++s) {
  100191:	80 3f 00             	cmpb   $0x0,(%rdi)
  100194:	74 10                	je     1001a6 <strlen+0x15>
  100196:	b8 00 00 00 00       	mov    $0x0,%eax
        ++n;
  10019b:	48 83 c0 01          	add    $0x1,%rax
    for (n = 0; *s != '\0'; ++s) {
  10019f:	80 3c 07 00          	cmpb   $0x0,(%rdi,%rax,1)
  1001a3:	75 f6                	jne    10019b <strlen+0xa>
  1001a5:	c3                   	ret    
  1001a6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  1001ab:	c3                   	ret    

00000000001001ac <strnlen>:
size_t strnlen(const char* s, size_t maxlen) {
  1001ac:	48 89 f0             	mov    %rsi,%rax
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1001af:	ba 00 00 00 00       	mov    $0x0,%edx
  1001b4:	48 85 f6             	test   %rsi,%rsi
  1001b7:	74 11                	je     1001ca <strnlen+0x1e>
  1001b9:	80 3c 17 00          	cmpb   $0x0,(%rdi,%rdx,1)
  1001bd:	74 0c                	je     1001cb <strnlen+0x1f>
        ++n;
  1001bf:	48 83 c2 01          	add    $0x1,%rdx
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  1001c3:	48 39 d0             	cmp    %rdx,%rax
  1001c6:	75 f1                	jne    1001b9 <strnlen+0xd>
  1001c8:	eb 04                	jmp    1001ce <strnlen+0x22>
  1001ca:	c3                   	ret    
  1001cb:	48 89 d0             	mov    %rdx,%rax
}
  1001ce:	c3                   	ret    

00000000001001cf <strcpy>:
char* strcpy(char* dst, const char* src) {
  1001cf:	48 89 f8             	mov    %rdi,%rax
  1001d2:	ba 00 00 00 00       	mov    $0x0,%edx
        *d++ = *src++;
  1001d7:	0f b6 0c 16          	movzbl (%rsi,%rdx,1),%ecx
  1001db:	88 0c 10             	mov    %cl,(%rax,%rdx,1)
    } while (d[-1]);
  1001de:	48 83 c2 01          	add    $0x1,%rdx
  1001e2:	84 c9                	test   %cl,%cl
  1001e4:	75 f1                	jne    1001d7 <strcpy+0x8>
}
  1001e6:	c3                   	ret    

00000000001001e7 <strcmp>:
    while (*a && *b && *a == *b) {
  1001e7:	0f b6 07             	movzbl (%rdi),%eax
  1001ea:	84 c0                	test   %al,%al
  1001ec:	74 1a                	je     100208 <strcmp+0x21>
  1001ee:	0f b6 16             	movzbl (%rsi),%edx
  1001f1:	38 c2                	cmp    %al,%dl
  1001f3:	75 13                	jne    100208 <strcmp+0x21>
  1001f5:	84 d2                	test   %dl,%dl
  1001f7:	74 0f                	je     100208 <strcmp+0x21>
        ++a, ++b;
  1001f9:	48 83 c7 01          	add    $0x1,%rdi
  1001fd:	48 83 c6 01          	add    $0x1,%rsi
    while (*a && *b && *a == *b) {
  100201:	0f b6 07             	movzbl (%rdi),%eax
  100204:	84 c0                	test   %al,%al
  100206:	75 e6                	jne    1001ee <strcmp+0x7>
    return ((unsigned char) *a > (unsigned char) *b)
  100208:	3a 06                	cmp    (%rsi),%al
  10020a:	0f 97 c0             	seta   %al
  10020d:	0f b6 c0             	movzbl %al,%eax
        - ((unsigned char) *a < (unsigned char) *b);
  100210:	83 d8 00             	sbb    $0x0,%eax
}
  100213:	c3                   	ret    

0000000000100214 <strchr>:
    while (*s && *s != (char) c) {
  100214:	0f b6 07             	movzbl (%rdi),%eax
  100217:	84 c0                	test   %al,%al
  100219:	74 10                	je     10022b <strchr+0x17>
  10021b:	40 38 f0             	cmp    %sil,%al
  10021e:	74 18                	je     100238 <strchr+0x24>
        ++s;
  100220:	48 83 c7 01          	add    $0x1,%rdi
    while (*s && *s != (char) c) {
  100224:	0f b6 07             	movzbl (%rdi),%eax
  100227:	84 c0                	test   %al,%al
  100229:	75 f0                	jne    10021b <strchr+0x7>
        return NULL;
  10022b:	40 84 f6             	test   %sil,%sil
  10022e:	b8 00 00 00 00       	mov    $0x0,%eax
  100233:	48 0f 44 c7          	cmove  %rdi,%rax
}
  100237:	c3                   	ret    
  100238:	48 89 f8             	mov    %rdi,%rax
  10023b:	c3                   	ret    

000000000010023c <rand>:
    if (!rand_seed_set) {
  10023c:	83 3d d1 1d 00 00 00 	cmpl   $0x0,0x1dd1(%rip)        # 102014 <rand_seed_set>
  100243:	74 1b                	je     100260 <rand+0x24>
    rand_seed = rand_seed * 1664525U + 1013904223U;
  100245:	69 05 c1 1d 00 00 0d 	imul   $0x19660d,0x1dc1(%rip),%eax        # 102010 <rand_seed>
  10024c:	66 19 00 
  10024f:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  100254:	89 05 b6 1d 00 00    	mov    %eax,0x1db6(%rip)        # 102010 <rand_seed>
    return rand_seed & RAND_MAX;
  10025a:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  10025f:	c3                   	ret    
    rand_seed = seed;
  100260:	c7 05 a6 1d 00 00 9e 	movl   $0x30d4879e,0x1da6(%rip)        # 102010 <rand_seed>
  100267:	87 d4 30 
    rand_seed_set = 1;
  10026a:	c7 05 a0 1d 00 00 01 	movl   $0x1,0x1da0(%rip)        # 102014 <rand_seed_set>
  100271:	00 00 00 
}
  100274:	eb cf                	jmp    100245 <rand+0x9>

0000000000100276 <srand>:
    rand_seed = seed;
  100276:	89 3d 94 1d 00 00    	mov    %edi,0x1d94(%rip)        # 102010 <rand_seed>
    rand_seed_set = 1;
  10027c:	c7 05 8e 1d 00 00 01 	movl   $0x1,0x1d8e(%rip)        # 102014 <rand_seed_set>
  100283:	00 00 00 
}
  100286:	c3                   	ret    

0000000000100287 <printer_vprintf>:
void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  100287:	55                   	push   %rbp
  100288:	48 89 e5             	mov    %rsp,%rbp
  10028b:	41 57                	push   %r15
  10028d:	41 56                	push   %r14
  10028f:	41 55                	push   %r13
  100291:	41 54                	push   %r12
  100293:	53                   	push   %rbx
  100294:	48 83 ec 58          	sub    $0x58,%rsp
  100298:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    for (; *format; ++format) {
  10029c:	0f b6 02             	movzbl (%rdx),%eax
  10029f:	84 c0                	test   %al,%al
  1002a1:	0f 84 b0 06 00 00    	je     100957 <printer_vprintf+0x6d0>
  1002a7:	49 89 fe             	mov    %rdi,%r14
  1002aa:	49 89 d4             	mov    %rdx,%r12
            length = 1;
  1002ad:	41 89 f7             	mov    %esi,%r15d
  1002b0:	e9 a4 04 00 00       	jmp    100759 <printer_vprintf+0x4d2>
        for (++format; *format; ++format) {
  1002b5:	49 8d 5c 24 01       	lea    0x1(%r12),%rbx
  1002ba:	45 0f b6 64 24 01    	movzbl 0x1(%r12),%r12d
  1002c0:	45 84 e4             	test   %r12b,%r12b
  1002c3:	0f 84 82 06 00 00    	je     10094b <printer_vprintf+0x6c4>
        int flags = 0;
  1002c9:	41 bd 00 00 00 00    	mov    $0x0,%r13d
            const char* flagc = strchr(flag_chars, *format);
  1002cf:	41 0f be f4          	movsbl %r12b,%esi
  1002d3:	bf a1 12 10 00       	mov    $0x1012a1,%edi
  1002d8:	e8 37 ff ff ff       	call   100214 <strchr>
  1002dd:	48 89 c1             	mov    %rax,%rcx
            if (flagc) {
  1002e0:	48 85 c0             	test   %rax,%rax
  1002e3:	74 55                	je     10033a <printer_vprintf+0xb3>
                flags |= 1 << (flagc - flag_chars);
  1002e5:	48 81 e9 a1 12 10 00 	sub    $0x1012a1,%rcx
  1002ec:	b8 01 00 00 00       	mov    $0x1,%eax
  1002f1:	d3 e0                	shl    %cl,%eax
  1002f3:	41 09 c5             	or     %eax,%r13d
        for (++format; *format; ++format) {
  1002f6:	48 83 c3 01          	add    $0x1,%rbx
  1002fa:	44 0f b6 23          	movzbl (%rbx),%r12d
  1002fe:	45 84 e4             	test   %r12b,%r12b
  100301:	75 cc                	jne    1002cf <printer_vprintf+0x48>
  100303:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
        int width = -1;
  100307:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
        int precision = -1;
  10030d:	c7 45 9c ff ff ff ff 	movl   $0xffffffff,-0x64(%rbp)
        if (*format == '.') {
  100314:	80 3b 2e             	cmpb   $0x2e,(%rbx)
  100317:	0f 84 a9 00 00 00    	je     1003c6 <printer_vprintf+0x13f>
        int length = 0;
  10031d:	b9 00 00 00 00       	mov    $0x0,%ecx
        switch (*format) {
  100322:	0f b6 13             	movzbl (%rbx),%edx
  100325:	8d 42 bd             	lea    -0x43(%rdx),%eax
  100328:	3c 37                	cmp    $0x37,%al
  10032a:	0f 87 c4 04 00 00    	ja     1007f4 <printer_vprintf+0x56d>
  100330:	0f b6 c0             	movzbl %al,%eax
  100333:	ff 24 c5 b0 10 10 00 	jmp    *0x1010b0(,%rax,8)
        if (*format >= '1' && *format <= '9') {
  10033a:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
  10033e:	41 8d 44 24 cf       	lea    -0x31(%r12),%eax
  100343:	3c 08                	cmp    $0x8,%al
  100345:	77 2f                	ja     100376 <printer_vprintf+0xef>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100347:	0f b6 03             	movzbl (%rbx),%eax
  10034a:	8d 50 d0             	lea    -0x30(%rax),%edx
  10034d:	80 fa 09             	cmp    $0x9,%dl
  100350:	77 5e                	ja     1003b0 <printer_vprintf+0x129>
  100352:	41 bd 00 00 00 00    	mov    $0x0,%r13d
                width = 10 * width + *format++ - '0';
  100358:	48 83 c3 01          	add    $0x1,%rbx
  10035c:	43 8d 54 ad 00       	lea    0x0(%r13,%r13,4),%edx
  100361:	0f be c0             	movsbl %al,%eax
  100364:	44 8d 6c 50 d0       	lea    -0x30(%rax,%rdx,2),%r13d
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100369:	0f b6 03             	movzbl (%rbx),%eax
  10036c:	8d 50 d0             	lea    -0x30(%rax),%edx
  10036f:	80 fa 09             	cmp    $0x9,%dl
  100372:	76 e4                	jbe    100358 <printer_vprintf+0xd1>
  100374:	eb 97                	jmp    10030d <printer_vprintf+0x86>
        } else if (*format == '*') {
  100376:	41 80 fc 2a          	cmp    $0x2a,%r12b
  10037a:	75 3f                	jne    1003bb <printer_vprintf+0x134>
            width = va_arg(val, int);
  10037c:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100380:	8b 07                	mov    (%rdi),%eax
  100382:	83 f8 2f             	cmp    $0x2f,%eax
  100385:	77 17                	ja     10039e <printer_vprintf+0x117>
  100387:	89 c2                	mov    %eax,%edx
  100389:	48 03 57 10          	add    0x10(%rdi),%rdx
  10038d:	83 c0 08             	add    $0x8,%eax
  100390:	89 07                	mov    %eax,(%rdi)
  100392:	44 8b 2a             	mov    (%rdx),%r13d
            ++format;
  100395:	48 83 c3 01          	add    $0x1,%rbx
  100399:	e9 6f ff ff ff       	jmp    10030d <printer_vprintf+0x86>
            width = va_arg(val, int);
  10039e:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1003a2:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1003a6:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1003aa:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1003ae:	eb e2                	jmp    100392 <printer_vprintf+0x10b>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  1003b0:	41 bd 00 00 00 00    	mov    $0x0,%r13d
  1003b6:	e9 52 ff ff ff       	jmp    10030d <printer_vprintf+0x86>
        int width = -1;
  1003bb:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
  1003c1:	e9 47 ff ff ff       	jmp    10030d <printer_vprintf+0x86>
            ++format;
  1003c6:	48 8d 53 01          	lea    0x1(%rbx),%rdx
            if (*format >= '0' && *format <= '9') {
  1003ca:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
  1003ce:	8d 48 d0             	lea    -0x30(%rax),%ecx
  1003d1:	80 f9 09             	cmp    $0x9,%cl
  1003d4:	76 13                	jbe    1003e9 <printer_vprintf+0x162>
            } else if (*format == '*') {
  1003d6:	3c 2a                	cmp    $0x2a,%al
  1003d8:	74 33                	je     10040d <printer_vprintf+0x186>
            ++format;
  1003da:	48 89 d3             	mov    %rdx,%rbx
                precision = 0;
  1003dd:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
  1003e4:	e9 34 ff ff ff       	jmp    10031d <printer_vprintf+0x96>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1003e9:	b9 00 00 00 00       	mov    $0x0,%ecx
                    precision = 10 * precision + *format++ - '0';
  1003ee:	48 83 c2 01          	add    $0x1,%rdx
  1003f2:	8d 0c 89             	lea    (%rcx,%rcx,4),%ecx
  1003f5:	0f be c0             	movsbl %al,%eax
  1003f8:	8d 4c 48 d0          	lea    -0x30(%rax,%rcx,2),%ecx
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1003fc:	0f b6 02             	movzbl (%rdx),%eax
  1003ff:	8d 70 d0             	lea    -0x30(%rax),%esi
  100402:	40 80 fe 09          	cmp    $0x9,%sil
  100406:	76 e6                	jbe    1003ee <printer_vprintf+0x167>
                    precision = 10 * precision + *format++ - '0';
  100408:	48 89 d3             	mov    %rdx,%rbx
  10040b:	eb 1c                	jmp    100429 <printer_vprintf+0x1a2>
                precision = va_arg(val, int);
  10040d:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100411:	8b 07                	mov    (%rdi),%eax
  100413:	83 f8 2f             	cmp    $0x2f,%eax
  100416:	77 23                	ja     10043b <printer_vprintf+0x1b4>
  100418:	89 c2                	mov    %eax,%edx
  10041a:	48 03 57 10          	add    0x10(%rdi),%rdx
  10041e:	83 c0 08             	add    $0x8,%eax
  100421:	89 07                	mov    %eax,(%rdi)
  100423:	8b 0a                	mov    (%rdx),%ecx
                ++format;
  100425:	48 83 c3 02          	add    $0x2,%rbx
            if (precision < 0) {
  100429:	85 c9                	test   %ecx,%ecx
  10042b:	b8 00 00 00 00       	mov    $0x0,%eax
  100430:	0f 49 c1             	cmovns %ecx,%eax
  100433:	89 45 9c             	mov    %eax,-0x64(%rbp)
  100436:	e9 e2 fe ff ff       	jmp    10031d <printer_vprintf+0x96>
                precision = va_arg(val, int);
  10043b:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  10043f:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  100443:	48 8d 42 08          	lea    0x8(%rdx),%rax
  100447:	48 89 41 08          	mov    %rax,0x8(%rcx)
  10044b:	eb d6                	jmp    100423 <printer_vprintf+0x19c>
        switch (*format) {
  10044d:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
  100452:	e9 f3 00 00 00       	jmp    10054a <printer_vprintf+0x2c3>
            ++format;
  100457:	48 83 c3 01          	add    $0x1,%rbx
            length = 1;
  10045b:	b9 01 00 00 00       	mov    $0x1,%ecx
            goto again;
  100460:	e9 bd fe ff ff       	jmp    100322 <printer_vprintf+0x9b>
            long x = length ? va_arg(val, long) : va_arg(val, int);
  100465:	85 c9                	test   %ecx,%ecx
  100467:	74 55                	je     1004be <printer_vprintf+0x237>
  100469:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  10046d:	8b 07                	mov    (%rdi),%eax
  10046f:	83 f8 2f             	cmp    $0x2f,%eax
  100472:	77 38                	ja     1004ac <printer_vprintf+0x225>
  100474:	89 c2                	mov    %eax,%edx
  100476:	48 03 57 10          	add    0x10(%rdi),%rdx
  10047a:	83 c0 08             	add    $0x8,%eax
  10047d:	89 07                	mov    %eax,(%rdi)
  10047f:	48 8b 12             	mov    (%rdx),%rdx
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  100482:	48 89 d0             	mov    %rdx,%rax
  100485:	48 c1 f8 38          	sar    $0x38,%rax
            num = negative ? -x : x;
  100489:	49 89 d0             	mov    %rdx,%r8
  10048c:	49 f7 d8             	neg    %r8
  10048f:	25 80 00 00 00       	and    $0x80,%eax
  100494:	4c 0f 44 c2          	cmove  %rdx,%r8
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  100498:	0b 45 a8             	or     -0x58(%rbp),%eax
  10049b:	83 c8 60             	or     $0x60,%eax
  10049e:	89 45 a8             	mov    %eax,-0x58(%rbp)
        char* data = "";
  1004a1:	41 bc a8 10 10 00    	mov    $0x1010a8,%r12d
            break;
  1004a7:	e9 35 01 00 00       	jmp    1005e1 <printer_vprintf+0x35a>
            long x = length ? va_arg(val, long) : va_arg(val, int);
  1004ac:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1004b0:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1004b4:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1004b8:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1004bc:	eb c1                	jmp    10047f <printer_vprintf+0x1f8>
  1004be:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1004c2:	8b 07                	mov    (%rdi),%eax
  1004c4:	83 f8 2f             	cmp    $0x2f,%eax
  1004c7:	77 10                	ja     1004d9 <printer_vprintf+0x252>
  1004c9:	89 c2                	mov    %eax,%edx
  1004cb:	48 03 57 10          	add    0x10(%rdi),%rdx
  1004cf:	83 c0 08             	add    $0x8,%eax
  1004d2:	89 07                	mov    %eax,(%rdi)
  1004d4:	48 63 12             	movslq (%rdx),%rdx
  1004d7:	eb a9                	jmp    100482 <printer_vprintf+0x1fb>
  1004d9:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1004dd:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  1004e1:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1004e5:	48 89 47 08          	mov    %rax,0x8(%rdi)
  1004e9:	eb e9                	jmp    1004d4 <printer_vprintf+0x24d>
        int base = 10;
  1004eb:	be 0a 00 00 00       	mov    $0xa,%esi
  1004f0:	eb 58                	jmp    10054a <printer_vprintf+0x2c3>
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  1004f2:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1004f6:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1004fa:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1004fe:	48 89 41 08          	mov    %rax,0x8(%rcx)
  100502:	eb 60                	jmp    100564 <printer_vprintf+0x2dd>
  100504:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100508:	8b 07                	mov    (%rdi),%eax
  10050a:	83 f8 2f             	cmp    $0x2f,%eax
  10050d:	77 10                	ja     10051f <printer_vprintf+0x298>
  10050f:	89 c2                	mov    %eax,%edx
  100511:	48 03 57 10          	add    0x10(%rdi),%rdx
  100515:	83 c0 08             	add    $0x8,%eax
  100518:	89 07                	mov    %eax,(%rdi)
  10051a:	44 8b 02             	mov    (%rdx),%r8d
  10051d:	eb 48                	jmp    100567 <printer_vprintf+0x2e0>
  10051f:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100523:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  100527:	48 8d 42 08          	lea    0x8(%rdx),%rax
  10052b:	48 89 41 08          	mov    %rax,0x8(%rcx)
  10052f:	eb e9                	jmp    10051a <printer_vprintf+0x293>
  100531:	41 89 f1             	mov    %esi,%r9d
        if (flags & FLAG_NUMERIC) {
  100534:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
    const char* digits = upper_digits;
  10053b:	bf 90 12 10 00       	mov    $0x101290,%edi
  100540:	e9 e2 02 00 00       	jmp    100827 <printer_vprintf+0x5a0>
            base = 16;
  100545:	be 10 00 00 00       	mov    $0x10,%esi
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  10054a:	85 c9                	test   %ecx,%ecx
  10054c:	74 b6                	je     100504 <printer_vprintf+0x27d>
  10054e:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100552:	8b 01                	mov    (%rcx),%eax
  100554:	83 f8 2f             	cmp    $0x2f,%eax
  100557:	77 99                	ja     1004f2 <printer_vprintf+0x26b>
  100559:	89 c2                	mov    %eax,%edx
  10055b:	48 03 51 10          	add    0x10(%rcx),%rdx
  10055f:	83 c0 08             	add    $0x8,%eax
  100562:	89 01                	mov    %eax,(%rcx)
  100564:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_NUMERIC;
  100567:	83 4d a8 20          	orl    $0x20,-0x58(%rbp)
    if (base < 0) {
  10056b:	85 f6                	test   %esi,%esi
  10056d:	79 c2                	jns    100531 <printer_vprintf+0x2aa>
        base = -base;
  10056f:	41 89 f1             	mov    %esi,%r9d
  100572:	f7 de                	neg    %esi
  100574:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
        digits = lower_digits;
  10057b:	bf 70 12 10 00       	mov    $0x101270,%edi
  100580:	e9 a2 02 00 00       	jmp    100827 <printer_vprintf+0x5a0>
            num = (uintptr_t) va_arg(val, void*);
  100585:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100589:	8b 07                	mov    (%rdi),%eax
  10058b:	83 f8 2f             	cmp    $0x2f,%eax
  10058e:	77 1c                	ja     1005ac <printer_vprintf+0x325>
  100590:	89 c2                	mov    %eax,%edx
  100592:	48 03 57 10          	add    0x10(%rdi),%rdx
  100596:	83 c0 08             	add    $0x8,%eax
  100599:	89 07                	mov    %eax,(%rdi)
  10059b:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  10059e:	81 4d a8 21 01 00 00 	orl    $0x121,-0x58(%rbp)
            base = -16;
  1005a5:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
  1005aa:	eb c3                	jmp    10056f <printer_vprintf+0x2e8>
            num = (uintptr_t) va_arg(val, void*);
  1005ac:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1005b0:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1005b4:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1005b8:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1005bc:	eb dd                	jmp    10059b <printer_vprintf+0x314>
            data = va_arg(val, char*);
  1005be:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1005c2:	8b 01                	mov    (%rcx),%eax
  1005c4:	83 f8 2f             	cmp    $0x2f,%eax
  1005c7:	0f 87 a5 01 00 00    	ja     100772 <printer_vprintf+0x4eb>
  1005cd:	89 c2                	mov    %eax,%edx
  1005cf:	48 03 51 10          	add    0x10(%rcx),%rdx
  1005d3:	83 c0 08             	add    $0x8,%eax
  1005d6:	89 01                	mov    %eax,(%rcx)
  1005d8:	4c 8b 22             	mov    (%rdx),%r12
        unsigned long num = 0;
  1005db:	41 b8 00 00 00 00    	mov    $0x0,%r8d
        if (flags & FLAG_NUMERIC) {
  1005e1:	8b 45 a8             	mov    -0x58(%rbp),%eax
  1005e4:	83 e0 20             	and    $0x20,%eax
  1005e7:	89 45 8c             	mov    %eax,-0x74(%rbp)
  1005ea:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
  1005f0:	0f 85 21 02 00 00    	jne    100817 <printer_vprintf+0x590>
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  1005f6:	8b 45 a8             	mov    -0x58(%rbp),%eax
  1005f9:	89 45 88             	mov    %eax,-0x78(%rbp)
  1005fc:	83 e0 60             	and    $0x60,%eax
  1005ff:	83 f8 60             	cmp    $0x60,%eax
  100602:	0f 84 54 02 00 00    	je     10085c <printer_vprintf+0x5d5>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  100608:	8b 45 a8             	mov    -0x58(%rbp),%eax
  10060b:	83 e0 21             	and    $0x21,%eax
        const char* prefix = "";
  10060e:	48 c7 45 a0 a8 10 10 	movq   $0x1010a8,-0x60(%rbp)
  100615:	00 
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  100616:	83 f8 21             	cmp    $0x21,%eax
  100619:	0f 84 79 02 00 00    	je     100898 <printer_vprintf+0x611>
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  10061f:	8b 7d 9c             	mov    -0x64(%rbp),%edi
  100622:	89 f8                	mov    %edi,%eax
  100624:	f7 d0                	not    %eax
  100626:	c1 e8 1f             	shr    $0x1f,%eax
  100629:	89 45 84             	mov    %eax,-0x7c(%rbp)
  10062c:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
  100630:	0f 85 9e 02 00 00    	jne    1008d4 <printer_vprintf+0x64d>
  100636:	84 c0                	test   %al,%al
  100638:	0f 84 96 02 00 00    	je     1008d4 <printer_vprintf+0x64d>
            len = strnlen(data, precision);
  10063e:	48 63 f7             	movslq %edi,%rsi
  100641:	4c 89 e7             	mov    %r12,%rdi
  100644:	e8 63 fb ff ff       	call   1001ac <strnlen>
  100649:	89 45 98             	mov    %eax,-0x68(%rbp)
                   && !(flags & FLAG_LEFTJUSTIFY)
  10064c:	8b 45 88             	mov    -0x78(%rbp),%eax
  10064f:	83 e0 26             	and    $0x26,%eax
            zeros = 0;
  100652:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  100659:	83 f8 22             	cmp    $0x22,%eax
  10065c:	0f 84 aa 02 00 00    	je     10090c <printer_vprintf+0x685>
        width -= len + zeros + strlen(prefix);
  100662:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  100666:	e8 26 fb ff ff       	call   100191 <strlen>
  10066b:	8b 55 9c             	mov    -0x64(%rbp),%edx
  10066e:	03 55 98             	add    -0x68(%rbp),%edx
  100671:	44 89 e9             	mov    %r13d,%ecx
  100674:	29 d1                	sub    %edx,%ecx
  100676:	29 c1                	sub    %eax,%ecx
  100678:	89 4d 8c             	mov    %ecx,-0x74(%rbp)
  10067b:	41 89 cd             	mov    %ecx,%r13d
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  10067e:	f6 45 a8 04          	testb  $0x4,-0x58(%rbp)
  100682:	75 2d                	jne    1006b1 <printer_vprintf+0x42a>
  100684:	85 c9                	test   %ecx,%ecx
  100686:	7e 29                	jle    1006b1 <printer_vprintf+0x42a>
            p->putc(p, ' ', color);
  100688:	44 89 fa             	mov    %r15d,%edx
  10068b:	be 20 00 00 00       	mov    $0x20,%esi
  100690:	4c 89 f7             	mov    %r14,%rdi
  100693:	41 ff 16             	call   *(%r14)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100696:	41 83 ed 01          	sub    $0x1,%r13d
  10069a:	45 85 ed             	test   %r13d,%r13d
  10069d:	7f e9                	jg     100688 <printer_vprintf+0x401>
  10069f:	8b 7d 8c             	mov    -0x74(%rbp),%edi
  1006a2:	85 ff                	test   %edi,%edi
  1006a4:	b8 01 00 00 00       	mov    $0x1,%eax
  1006a9:	0f 4f c7             	cmovg  %edi,%eax
  1006ac:	29 c7                	sub    %eax,%edi
  1006ae:	41 89 fd             	mov    %edi,%r13d
        for (; *prefix; ++prefix) {
  1006b1:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  1006b5:	0f b6 07             	movzbl (%rdi),%eax
  1006b8:	84 c0                	test   %al,%al
  1006ba:	74 22                	je     1006de <printer_vprintf+0x457>
  1006bc:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  1006c0:	48 89 fb             	mov    %rdi,%rbx
            p->putc(p, *prefix, color);
  1006c3:	0f b6 f0             	movzbl %al,%esi
  1006c6:	44 89 fa             	mov    %r15d,%edx
  1006c9:	4c 89 f7             	mov    %r14,%rdi
  1006cc:	41 ff 16             	call   *(%r14)
        for (; *prefix; ++prefix) {
  1006cf:	48 83 c3 01          	add    $0x1,%rbx
  1006d3:	0f b6 03             	movzbl (%rbx),%eax
  1006d6:	84 c0                	test   %al,%al
  1006d8:	75 e9                	jne    1006c3 <printer_vprintf+0x43c>
  1006da:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; zeros > 0; --zeros) {
  1006de:	8b 45 9c             	mov    -0x64(%rbp),%eax
  1006e1:	85 c0                	test   %eax,%eax
  1006e3:	7e 1d                	jle    100702 <printer_vprintf+0x47b>
  1006e5:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  1006e9:	89 c3                	mov    %eax,%ebx
            p->putc(p, '0', color);
  1006eb:	44 89 fa             	mov    %r15d,%edx
  1006ee:	be 30 00 00 00       	mov    $0x30,%esi
  1006f3:	4c 89 f7             	mov    %r14,%rdi
  1006f6:	41 ff 16             	call   *(%r14)
        for (; zeros > 0; --zeros) {
  1006f9:	83 eb 01             	sub    $0x1,%ebx
  1006fc:	75 ed                	jne    1006eb <printer_vprintf+0x464>
  1006fe:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; len > 0; ++data, --len) {
  100702:	8b 45 98             	mov    -0x68(%rbp),%eax
  100705:	85 c0                	test   %eax,%eax
  100707:	7e 27                	jle    100730 <printer_vprintf+0x4a9>
  100709:	89 c0                	mov    %eax,%eax
  10070b:	4c 01 e0             	add    %r12,%rax
  10070e:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  100712:	48 89 c3             	mov    %rax,%rbx
            p->putc(p, *data, color);
  100715:	41 0f b6 34 24       	movzbl (%r12),%esi
  10071a:	44 89 fa             	mov    %r15d,%edx
  10071d:	4c 89 f7             	mov    %r14,%rdi
  100720:	41 ff 16             	call   *(%r14)
        for (; len > 0; ++data, --len) {
  100723:	49 83 c4 01          	add    $0x1,%r12
  100727:	49 39 dc             	cmp    %rbx,%r12
  10072a:	75 e9                	jne    100715 <printer_vprintf+0x48e>
  10072c:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; width > 0; --width) {
  100730:	45 85 ed             	test   %r13d,%r13d
  100733:	7e 14                	jle    100749 <printer_vprintf+0x4c2>
            p->putc(p, ' ', color);
  100735:	44 89 fa             	mov    %r15d,%edx
  100738:	be 20 00 00 00       	mov    $0x20,%esi
  10073d:	4c 89 f7             	mov    %r14,%rdi
  100740:	41 ff 16             	call   *(%r14)
        for (; width > 0; --width) {
  100743:	41 83 ed 01          	sub    $0x1,%r13d
  100747:	75 ec                	jne    100735 <printer_vprintf+0x4ae>
    for (; *format; ++format) {
  100749:	4c 8d 63 01          	lea    0x1(%rbx),%r12
  10074d:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
  100751:	84 c0                	test   %al,%al
  100753:	0f 84 fe 01 00 00    	je     100957 <printer_vprintf+0x6d0>
        if (*format != '%') {
  100759:	3c 25                	cmp    $0x25,%al
  10075b:	0f 84 54 fb ff ff    	je     1002b5 <printer_vprintf+0x2e>
            p->putc(p, *format, color);
  100761:	0f b6 f0             	movzbl %al,%esi
  100764:	44 89 fa             	mov    %r15d,%edx
  100767:	4c 89 f7             	mov    %r14,%rdi
  10076a:	41 ff 16             	call   *(%r14)
            continue;
  10076d:	4c 89 e3             	mov    %r12,%rbx
  100770:	eb d7                	jmp    100749 <printer_vprintf+0x4c2>
            data = va_arg(val, char*);
  100772:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100776:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  10077a:	48 8d 42 08          	lea    0x8(%rdx),%rax
  10077e:	48 89 47 08          	mov    %rax,0x8(%rdi)
  100782:	e9 51 fe ff ff       	jmp    1005d8 <printer_vprintf+0x351>
            color = va_arg(val, int);
  100787:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  10078b:	8b 07                	mov    (%rdi),%eax
  10078d:	83 f8 2f             	cmp    $0x2f,%eax
  100790:	77 10                	ja     1007a2 <printer_vprintf+0x51b>
  100792:	89 c2                	mov    %eax,%edx
  100794:	48 03 57 10          	add    0x10(%rdi),%rdx
  100798:	83 c0 08             	add    $0x8,%eax
  10079b:	89 07                	mov    %eax,(%rdi)
  10079d:	44 8b 3a             	mov    (%rdx),%r15d
            goto done;
  1007a0:	eb a7                	jmp    100749 <printer_vprintf+0x4c2>
            color = va_arg(val, int);
  1007a2:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1007a6:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1007aa:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1007ae:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1007b2:	eb e9                	jmp    10079d <printer_vprintf+0x516>
            numbuf[0] = va_arg(val, int);
  1007b4:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1007b8:	8b 01                	mov    (%rcx),%eax
  1007ba:	83 f8 2f             	cmp    $0x2f,%eax
  1007bd:	77 23                	ja     1007e2 <printer_vprintf+0x55b>
  1007bf:	89 c2                	mov    %eax,%edx
  1007c1:	48 03 51 10          	add    0x10(%rcx),%rdx
  1007c5:	83 c0 08             	add    $0x8,%eax
  1007c8:	89 01                	mov    %eax,(%rcx)
  1007ca:	8b 02                	mov    (%rdx),%eax
  1007cc:	88 45 b8             	mov    %al,-0x48(%rbp)
            numbuf[1] = '\0';
  1007cf:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
  1007d3:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  1007d7:	41 b8 00 00 00 00    	mov    $0x0,%r8d
            break;
  1007dd:	e9 ff fd ff ff       	jmp    1005e1 <printer_vprintf+0x35a>
            numbuf[0] = va_arg(val, int);
  1007e2:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1007e6:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  1007ea:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1007ee:	48 89 47 08          	mov    %rax,0x8(%rdi)
  1007f2:	eb d6                	jmp    1007ca <printer_vprintf+0x543>
            numbuf[0] = (*format ? *format : '%');
  1007f4:	84 d2                	test   %dl,%dl
  1007f6:	0f 85 39 01 00 00    	jne    100935 <printer_vprintf+0x6ae>
  1007fc:	c6 45 b8 25          	movb   $0x25,-0x48(%rbp)
            numbuf[1] = '\0';
  100800:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
                format--;
  100804:	48 83 eb 01          	sub    $0x1,%rbx
            data = numbuf;
  100808:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  10080c:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  100812:	e9 ca fd ff ff       	jmp    1005e1 <printer_vprintf+0x35a>
        if (flags & FLAG_NUMERIC) {
  100817:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
    const char* digits = upper_digits;
  10081d:	bf 90 12 10 00       	mov    $0x101290,%edi
        if (flags & FLAG_NUMERIC) {
  100822:	be 0a 00 00 00       	mov    $0xa,%esi
    *--numbuf_end = '\0';
  100827:	c6 45 cf 00          	movb   $0x0,-0x31(%rbp)
  10082b:	4c 89 c1             	mov    %r8,%rcx
  10082e:	4c 8d 65 cf          	lea    -0x31(%rbp),%r12
        *--numbuf_end = digits[val % base];
  100832:	48 63 f6             	movslq %esi,%rsi
  100835:	49 83 ec 01          	sub    $0x1,%r12
  100839:	48 89 c8             	mov    %rcx,%rax
  10083c:	ba 00 00 00 00       	mov    $0x0,%edx
  100841:	48 f7 f6             	div    %rsi
  100844:	0f b6 14 17          	movzbl (%rdi,%rdx,1),%edx
  100848:	41 88 14 24          	mov    %dl,(%r12)
        val /= base;
  10084c:	48 89 ca             	mov    %rcx,%rdx
  10084f:	48 89 c1             	mov    %rax,%rcx
    } while (val != 0);
  100852:	48 39 d6             	cmp    %rdx,%rsi
  100855:	76 de                	jbe    100835 <printer_vprintf+0x5ae>
  100857:	e9 9a fd ff ff       	jmp    1005f6 <printer_vprintf+0x36f>
                prefix = "-";
  10085c:	48 c7 45 a0 a5 10 10 	movq   $0x1010a5,-0x60(%rbp)
  100863:	00 
            if (flags & FLAG_NEGATIVE) {
  100864:	8b 45 a8             	mov    -0x58(%rbp),%eax
  100867:	a8 80                	test   $0x80,%al
  100869:	0f 85 b0 fd ff ff    	jne    10061f <printer_vprintf+0x398>
                prefix = "+";
  10086f:	48 c7 45 a0 a0 10 10 	movq   $0x1010a0,-0x60(%rbp)
  100876:	00 
            } else if (flags & FLAG_PLUSPOSITIVE) {
  100877:	a8 10                	test   $0x10,%al
  100879:	0f 85 a0 fd ff ff    	jne    10061f <printer_vprintf+0x398>
                prefix = " ";
  10087f:	a8 08                	test   $0x8,%al
  100881:	ba a8 10 10 00       	mov    $0x1010a8,%edx
  100886:	b8 a7 10 10 00       	mov    $0x1010a7,%eax
  10088b:	48 0f 44 c2          	cmove  %rdx,%rax
  10088f:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  100893:	e9 87 fd ff ff       	jmp    10061f <printer_vprintf+0x398>
                   && (base == 16 || base == -16)
  100898:	41 8d 41 10          	lea    0x10(%r9),%eax
  10089c:	a9 df ff ff ff       	test   $0xffffffdf,%eax
  1008a1:	0f 85 78 fd ff ff    	jne    10061f <printer_vprintf+0x398>
                   && (num || (flags & FLAG_ALT2))) {
  1008a7:	4d 85 c0             	test   %r8,%r8
  1008aa:	75 0d                	jne    1008b9 <printer_vprintf+0x632>
  1008ac:	f7 45 a8 00 01 00 00 	testl  $0x100,-0x58(%rbp)
  1008b3:	0f 84 66 fd ff ff    	je     10061f <printer_vprintf+0x398>
            prefix = (base == -16 ? "0x" : "0X");
  1008b9:	41 83 f9 f0          	cmp    $0xfffffff0,%r9d
  1008bd:	ba a9 10 10 00       	mov    $0x1010a9,%edx
  1008c2:	b8 a2 10 10 00       	mov    $0x1010a2,%eax
  1008c7:	48 0f 44 c2          	cmove  %rdx,%rax
  1008cb:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  1008cf:	e9 4b fd ff ff       	jmp    10061f <printer_vprintf+0x398>
            len = strlen(data);
  1008d4:	4c 89 e7             	mov    %r12,%rdi
  1008d7:	e8 b5 f8 ff ff       	call   100191 <strlen>
  1008dc:	89 45 98             	mov    %eax,-0x68(%rbp)
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  1008df:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
  1008e3:	0f 84 63 fd ff ff    	je     10064c <printer_vprintf+0x3c5>
  1008e9:	80 7d 84 00          	cmpb   $0x0,-0x7c(%rbp)
  1008ed:	0f 84 59 fd ff ff    	je     10064c <printer_vprintf+0x3c5>
            zeros = precision > len ? precision - len : 0;
  1008f3:	8b 4d 9c             	mov    -0x64(%rbp),%ecx
  1008f6:	89 ca                	mov    %ecx,%edx
  1008f8:	29 c2                	sub    %eax,%edx
  1008fa:	39 c1                	cmp    %eax,%ecx
  1008fc:	b8 00 00 00 00       	mov    $0x0,%eax
  100901:	0f 4e d0             	cmovle %eax,%edx
  100904:	89 55 9c             	mov    %edx,-0x64(%rbp)
  100907:	e9 56 fd ff ff       	jmp    100662 <printer_vprintf+0x3db>
                   && len + (int) strlen(prefix) < width) {
  10090c:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  100910:	e8 7c f8 ff ff       	call   100191 <strlen>
  100915:	8b 7d 98             	mov    -0x68(%rbp),%edi
  100918:	8d 14 07             	lea    (%rdi,%rax,1),%edx
            zeros = width - len - strlen(prefix);
  10091b:	44 89 e9             	mov    %r13d,%ecx
  10091e:	29 f9                	sub    %edi,%ecx
  100920:	29 c1                	sub    %eax,%ecx
  100922:	44 39 ea             	cmp    %r13d,%edx
  100925:	b8 00 00 00 00       	mov    $0x0,%eax
  10092a:	0f 4d c8             	cmovge %eax,%ecx
  10092d:	89 4d 9c             	mov    %ecx,-0x64(%rbp)
  100930:	e9 2d fd ff ff       	jmp    100662 <printer_vprintf+0x3db>
            numbuf[0] = (*format ? *format : '%');
  100935:	88 55 b8             	mov    %dl,-0x48(%rbp)
            numbuf[1] = '\0';
  100938:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
  10093c:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  100940:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  100946:	e9 96 fc ff ff       	jmp    1005e1 <printer_vprintf+0x35a>
        int flags = 0;
  10094b:	c7 45 a8 00 00 00 00 	movl   $0x0,-0x58(%rbp)
  100952:	e9 b0 f9 ff ff       	jmp    100307 <printer_vprintf+0x80>
}
  100957:	48 83 c4 58          	add    $0x58,%rsp
  10095b:	5b                   	pop    %rbx
  10095c:	41 5c                	pop    %r12
  10095e:	41 5d                	pop    %r13
  100960:	41 5e                	pop    %r14
  100962:	41 5f                	pop    %r15
  100964:	5d                   	pop    %rbp
  100965:	c3                   	ret    

0000000000100966 <console_vprintf>:
int console_vprintf(int cpos, int color, const char* format, va_list val) {
  100966:	55                   	push   %rbp
  100967:	48 89 e5             	mov    %rsp,%rbp
  10096a:	48 83 ec 10          	sub    $0x10,%rsp
    cp.p.putc = console_putc;
  10096e:	48 c7 45 f0 71 00 10 	movq   $0x100071,-0x10(%rbp)
  100975:	00 
        cpos = 0;
  100976:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
  10097c:	b8 00 00 00 00       	mov    $0x0,%eax
  100981:	0f 43 f8             	cmovae %eax,%edi
    cp.cursor = console + cpos;
  100984:	48 63 ff             	movslq %edi,%rdi
  100987:	48 8d 84 3f 00 80 0b 	lea    0xb8000(%rdi,%rdi,1),%rax
  10098e:	00 
  10098f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  100993:	48 8d 7d f0          	lea    -0x10(%rbp),%rdi
  100997:	e8 eb f8 ff ff       	call   100287 <printer_vprintf>
    return cp.cursor - console;
  10099c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  1009a0:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  1009a6:	48 d1 f8             	sar    %rax
}
  1009a9:	c9                   	leave  
  1009aa:	c3                   	ret    

00000000001009ab <console_printf>:
int console_printf(int cpos, int color, const char* format, ...) {
  1009ab:	55                   	push   %rbp
  1009ac:	48 89 e5             	mov    %rsp,%rbp
  1009af:	48 83 ec 50          	sub    $0x50,%rsp
  1009b3:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  1009b7:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  1009bb:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_start(val, format);
  1009bf:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  1009c6:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1009ca:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  1009ce:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1009d2:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  1009d6:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  1009da:	e8 87 ff ff ff       	call   100966 <console_vprintf>
}
  1009df:	c9                   	leave  
  1009e0:	c3                   	ret    

00000000001009e1 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  1009e1:	55                   	push   %rbp
  1009e2:	48 89 e5             	mov    %rsp,%rbp
  1009e5:	53                   	push   %rbx
  1009e6:	48 83 ec 28          	sub    $0x28,%rsp
  1009ea:	48 89 fb             	mov    %rdi,%rbx
    string_printer sp;
    sp.p.putc = string_putc;
  1009ed:	48 c7 45 d8 f7 00 10 	movq   $0x1000f7,-0x28(%rbp)
  1009f4:	00 
    sp.s = s;
  1009f5:	48 89 7d e0          	mov    %rdi,-0x20(%rbp)
    if (size) {
  1009f9:	48 85 f6             	test   %rsi,%rsi
  1009fc:	75 0b                	jne    100a09 <vsnprintf+0x28>
        sp.end = s + size - 1;
        printer_vprintf(&sp.p, 0, format, val);
        *sp.s = 0;
    }
    return sp.s - s;
  1009fe:	8b 45 e0             	mov    -0x20(%rbp),%eax
  100a01:	29 d8                	sub    %ebx,%eax
}
  100a03:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  100a07:	c9                   	leave  
  100a08:	c3                   	ret    
        sp.end = s + size - 1;
  100a09:	48 8d 44 37 ff       	lea    -0x1(%rdi,%rsi,1),%rax
  100a0e:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  100a12:	be 00 00 00 00       	mov    $0x0,%esi
  100a17:	48 8d 7d d8          	lea    -0x28(%rbp),%rdi
  100a1b:	e8 67 f8 ff ff       	call   100287 <printer_vprintf>
        *sp.s = 0;
  100a20:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100a24:	c6 00 00             	movb   $0x0,(%rax)
  100a27:	eb d5                	jmp    1009fe <vsnprintf+0x1d>

0000000000100a29 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  100a29:	55                   	push   %rbp
  100a2a:	48 89 e5             	mov    %rsp,%rbp
  100a2d:	48 83 ec 50          	sub    $0x50,%rsp
  100a31:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  100a35:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  100a39:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  100a3d:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  100a44:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100a48:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100a4c:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  100a50:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    int n = vsnprintf(s, size, format, val);
  100a54:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  100a58:	e8 84 ff ff ff       	call   1009e1 <vsnprintf>
    va_end(val);
    return n;
}
  100a5d:	c9                   	leave  
  100a5e:	c3                   	ret    

0000000000100a5f <console_clear>:

// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  100a5f:	b8 00 80 0b 00       	mov    $0xb8000,%eax
  100a64:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
        console[i] = ' ' | 0x0700;
  100a69:	66 c7 00 20 07       	movw   $0x720,(%rax)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  100a6e:	48 83 c0 02          	add    $0x2,%rax
  100a72:	48 39 d0             	cmp    %rdx,%rax
  100a75:	75 f2                	jne    100a69 <console_clear+0xa>
    }
    cursorpos = 0;
  100a77:	c7 05 7b 85 fb ff 00 	movl   $0x0,-0x47a85(%rip)        # b8ffc <cursorpos>
  100a7e:	00 00 00 
}
  100a81:	c3                   	ret    

0000000000100a82 <comp_structs>:
//    Compare and sort struct array based on the sizes of alloc'd blocks.

int comp_structs(const void *p1, const void *p2) {
    const heap_info_node a = *(heap_info_node *)p1;
    const heap_info_node b = *(heap_info_node *)p2;
    return a.size <= b.size ? TRUE : FALSE;
  100a82:	48 8b 06             	mov    (%rsi),%rax
  100a85:	48 39 07             	cmp    %rax,(%rdi)
  100a88:	0f 9e c0             	setle  %al
  100a8b:	0f b6 c0             	movzbl %al,%eax
}
  100a8e:	c3                   	ret    

0000000000100a8f <alignof_eight>:
    return ALIGNMENT_EIGHT - sz + (sz & ~(ALIGNMENT_EIGHT - 1));
  100a8f:	48 89 f8             	mov    %rdi,%rax
  100a92:	48 83 e0 f8          	and    $0xfffffffffffffff8,%rax
  100a96:	48 29 f8             	sub    %rdi,%rax
  100a99:	48 83 c0 08          	add    $0x8,%rax
}
  100a9d:	c3                   	ret    

0000000000100a9e <merge>:
// merge()
//    Merges two arrays together to be used by the function responsible for
//    the merge sort algorithm.

void merge(heap_info_node *array, size_t left, size_t center, size_t right,
           int (*compare)(const void *, const void *)) {
  100a9e:	55                   	push   %rbp
  100a9f:	48 89 e5             	mov    %rsp,%rbp
  100aa2:	41 57                	push   %r15
  100aa4:	41 56                	push   %r14
  100aa6:	41 55                	push   %r13
  100aa8:	41 54                	push   %r12
  100aaa:	53                   	push   %rbx
  100aab:	48 83 ec 38          	sub    $0x38,%rsp
  100aaf:	49 89 fa             	mov    %rdi,%r10
  100ab2:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  100ab6:	49 89 f1             	mov    %rsi,%r9
  100ab9:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
  100abd:	48 89 d7             	mov    %rdx,%rdi
  100ac0:	4c 89 45 b0          	mov    %r8,-0x50(%rbp)
    // calculate the lengths of the subarrays
    size_t len1 = center - left + 1;
  100ac4:	48 89 d0             	mov    %rdx,%rax
  100ac7:	48 29 f0             	sub    %rsi,%rax
  100aca:	48 8d 58 01          	lea    0x1(%rax),%rbx
  100ace:	48 89 5d c0          	mov    %rbx,-0x40(%rbp)
    size_t len2 = right - center;
  100ad2:	48 29 d1             	sub    %rdx,%rcx
  100ad5:	48 89 ce             	mov    %rcx,%rsi
  100ad8:	48 89 4d b8          	mov    %rcx,-0x48(%rbp)

    // create temporary storage arrays
    // heap_info_node *temp1[len1]
    heap_info_node temp1[len1];
  100adc:	49 89 d8             	mov    %rbx,%r8
  100adf:	49 c1 e0 04          	shl    $0x4,%r8
  100ae3:	b9 10 00 00 00       	mov    $0x10,%ecx
  100ae8:	49 8d 40 0f          	lea    0xf(%r8),%rax
  100aec:	ba 00 00 00 00       	mov    $0x0,%edx
  100af1:	48 f7 f1             	div    %rcx
  100af4:	48 c1 e0 04          	shl    $0x4,%rax
  100af8:	48 29 c4             	sub    %rax,%rsp
  100afb:	49 89 e6             	mov    %rsp,%r14
    heap_info_node temp2[len2];
  100afe:	48 c1 e6 04          	shl    $0x4,%rsi
  100b02:	48 8d 46 0f          	lea    0xf(%rsi),%rax
  100b06:	ba 00 00 00 00       	mov    $0x0,%edx
  100b0b:	48 f7 f1             	div    %rcx
  100b0e:	48 c1 e0 04          	shl    $0x4,%rax
  100b12:	48 29 c4             	sub    %rax,%rsp
  100b15:	49 89 e7             	mov    %rsp,%r15

    // copy all data over into the storage arrays
    for (size_t i = 0; i < len1; i++)
  100b18:	48 85 db             	test   %rbx,%rbx
  100b1b:	74 2a                	je     100b47 <merge+0xa9>
  100b1d:	4c 89 ca             	mov    %r9,%rdx
  100b20:	48 c1 e2 04          	shl    $0x4,%rdx
  100b24:	4c 01 d2             	add    %r10,%rdx
  100b27:	b8 00 00 00 00       	mov    $0x0,%eax
        temp1[i] = array[left + i];
  100b2c:	48 8b 0c 02          	mov    (%rdx,%rax,1),%rcx
  100b30:	48 8b 5c 02 08       	mov    0x8(%rdx,%rax,1),%rbx
  100b35:	49 89 0c 06          	mov    %rcx,(%r14,%rax,1)
  100b39:	49 89 5c 06 08       	mov    %rbx,0x8(%r14,%rax,1)
    for (size_t i = 0; i < len1; i++)
  100b3e:	48 83 c0 10          	add    $0x10,%rax
  100b42:	49 39 c0             	cmp    %rax,%r8
  100b45:	75 e5                	jne    100b2c <merge+0x8e>
    for (size_t i = 0; i < len2; i++)
  100b47:	48 83 7d b8 00       	cmpq   $0x0,-0x48(%rbp)
  100b4c:	0f 84 70 01 00 00    	je     100cc2 <merge+0x224>
  100b52:	48 c1 e7 04          	shl    $0x4,%rdi
  100b56:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100b5a:	48 8d 14 38          	lea    (%rax,%rdi,1),%rdx
  100b5e:	b8 00 00 00 00       	mov    $0x0,%eax
        temp2[i] = array[center + i + 1];
  100b63:	48 8b 4c 02 10       	mov    0x10(%rdx,%rax,1),%rcx
  100b68:	48 8b 5c 02 18       	mov    0x18(%rdx,%rax,1),%rbx
  100b6d:	49 89 0c 07          	mov    %rcx,(%r15,%rax,1)
  100b71:	49 89 5c 07 08       	mov    %rbx,0x8(%r15,%rax,1)
    for (size_t i = 0; i < len2; i++)
  100b76:	48 83 c0 10          	add    $0x10,%rax
  100b7a:	48 39 c6             	cmp    %rax,%rsi
  100b7d:	75 e4                	jne    100b63 <merge+0xc5>
    size_t i = 0;
    size_t j = 0;
    size_t k = left;
    
    // compare and set values in array accordingly
    while (i < len1 && j < len2) {
  100b7f:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
  100b84:	0f 84 32 01 00 00    	je     100cbc <merge+0x21e>
  100b8a:	4c 8b 6d c8          	mov    -0x38(%rbp),%r13
  100b8e:	49 c1 e5 04          	shl    $0x4,%r13
  100b92:	4c 03 6d a8          	add    -0x58(%rbp),%r13
    size_t j = 0;
  100b96:	bb 00 00 00 00       	mov    $0x0,%ebx
    size_t i = 0;
  100b9b:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  100ba1:	eb 31                	jmp    100bd4 <merge+0x136>
        if ((*compare)(&temp1[i], &temp2[j])) {
            array[k] = temp1[i];
            i++;
        } else {
            array[k] = temp2[j];
  100ba3:	48 89 d8             	mov    %rbx,%rax
  100ba6:	48 c1 e0 04          	shl    $0x4,%rax
  100baa:	49 8b 54 07 08       	mov    0x8(%r15,%rax,1),%rdx
  100baf:	49 8b 04 07          	mov    (%r15,%rax,1),%rax
  100bb3:	49 89 45 00          	mov    %rax,0x0(%r13)
  100bb7:	49 89 55 08          	mov    %rdx,0x8(%r13)
            j++;
  100bbb:	48 83 c3 01          	add    $0x1,%rbx
        }
        k++;
  100bbf:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
    while (i < len1 && j < len2) {
  100bc4:	49 83 c5 10          	add    $0x10,%r13
  100bc8:	4c 3b 65 c0          	cmp    -0x40(%rbp),%r12
  100bcc:	73 42                	jae    100c10 <merge+0x172>
  100bce:	48 3b 5d b8          	cmp    -0x48(%rbp),%rbx
  100bd2:	73 3c                	jae    100c10 <merge+0x172>
        if ((*compare)(&temp1[i], &temp2[j])) {
  100bd4:	48 89 de             	mov    %rbx,%rsi
  100bd7:	48 c1 e6 04          	shl    $0x4,%rsi
  100bdb:	4c 01 fe             	add    %r15,%rsi
  100bde:	4c 89 e7             	mov    %r12,%rdi
  100be1:	48 c1 e7 04          	shl    $0x4,%rdi
  100be5:	4c 01 f7             	add    %r14,%rdi
  100be8:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  100bec:	ff d0                	call   *%rax
  100bee:	85 c0                	test   %eax,%eax
  100bf0:	74 b1                	je     100ba3 <merge+0x105>
            array[k] = temp1[i];
  100bf2:	4c 89 e0             	mov    %r12,%rax
  100bf5:	48 c1 e0 04          	shl    $0x4,%rax
  100bf9:	49 8b 54 06 08       	mov    0x8(%r14,%rax,1),%rdx
  100bfe:	49 8b 04 06          	mov    (%r14,%rax,1),%rax
  100c02:	49 89 45 00          	mov    %rax,0x0(%r13)
  100c06:	49 89 55 08          	mov    %rdx,0x8(%r13)
            i++;
  100c0a:	49 83 c4 01          	add    $0x1,%r12
  100c0e:	eb af                	jmp    100bbf <merge+0x121>
    }

    // add on the rest of the items in the first storage array
    while (i < len1) {
  100c10:	4c 3b 65 c0          	cmp    -0x40(%rbp),%r12
  100c14:	73 50                	jae    100c66 <merge+0x1c8>
  100c16:	4c 8b 45 c0          	mov    -0x40(%rbp),%r8
  100c1a:	4d 29 e0             	sub    %r12,%r8
  100c1d:	49 c1 e0 04          	shl    $0x4,%r8
  100c21:	4c 89 e1             	mov    %r12,%rcx
  100c24:	48 c1 e1 04          	shl    $0x4,%rcx
  100c28:	4c 01 f1             	add    %r14,%rcx
  100c2b:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  100c2f:	48 c1 e2 04          	shl    $0x4,%rdx
  100c33:	48 03 55 a8          	add    -0x58(%rbp),%rdx
    size_t i = 0;
  100c37:	b8 00 00 00 00       	mov    $0x0,%eax
        array[k] = temp1[i];
  100c3c:	48 8b 34 01          	mov    (%rcx,%rax,1),%rsi
  100c40:	48 8b 7c 01 08       	mov    0x8(%rcx,%rax,1),%rdi
  100c45:	48 89 34 02          	mov    %rsi,(%rdx,%rax,1)
  100c49:	48 89 7c 02 08       	mov    %rdi,0x8(%rdx,%rax,1)
    while (i < len1) {
  100c4e:	48 83 c0 10          	add    $0x10,%rax
  100c52:	4c 39 c0             	cmp    %r8,%rax
  100c55:	75 e5                	jne    100c3c <merge+0x19e>
  100c57:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100c5b:	48 03 45 c0          	add    -0x40(%rbp),%rax
        i++;
        k++;
  100c5f:	4c 29 e0             	sub    %r12,%rax
  100c62:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    }

    // add on the rest of the items in the second storage array
    while (j < len2) {
  100c66:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
  100c6a:	48 39 c3             	cmp    %rax,%rbx
  100c6d:	73 3e                	jae    100cad <merge+0x20f>
  100c6f:	48 89 c7             	mov    %rax,%rdi
  100c72:	48 29 df             	sub    %rbx,%rdi
  100c75:	48 c1 e7 04          	shl    $0x4,%rdi
  100c79:	48 c1 e3 04          	shl    $0x4,%rbx
  100c7d:	49 8d 34 1f          	lea    (%r15,%rbx,1),%rsi
  100c81:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  100c85:	48 c1 e2 04          	shl    $0x4,%rdx
  100c89:	48 03 55 a8          	add    -0x58(%rbp),%rdx
  100c8d:	b8 00 00 00 00       	mov    $0x0,%eax
        array[k] = temp2[j];
  100c92:	48 8b 0c 06          	mov    (%rsi,%rax,1),%rcx
  100c96:	48 8b 5c 06 08       	mov    0x8(%rsi,%rax,1),%rbx
  100c9b:	48 89 0c 02          	mov    %rcx,(%rdx,%rax,1)
  100c9f:	48 89 5c 02 08       	mov    %rbx,0x8(%rdx,%rax,1)
    while (j < len2) {
  100ca4:	48 83 c0 10          	add    $0x10,%rax
  100ca8:	48 39 c7             	cmp    %rax,%rdi
  100cab:	75 e5                	jne    100c92 <merge+0x1f4>
        j++;
        k++;
    }
}
  100cad:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
  100cb1:	5b                   	pop    %rbx
  100cb2:	41 5c                	pop    %r12
  100cb4:	41 5d                	pop    %r13
  100cb6:	41 5e                	pop    %r14
  100cb8:	41 5f                	pop    %r15
  100cba:	5d                   	pop    %rbp
  100cbb:	c3                   	ret    
    size_t j = 0;
  100cbc:	48 8b 5d c0          	mov    -0x40(%rbp),%rbx
  100cc0:	eb a4                	jmp    100c66 <merge+0x1c8>
  100cc2:	4c 8b 65 b8          	mov    -0x48(%rbp),%r12
  100cc6:	4c 89 e3             	mov    %r12,%rbx
    while (i < len1) {
  100cc9:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
  100cce:	0f 85 42 ff ff ff    	jne    100c16 <merge+0x178>
  100cd4:	eb d7                	jmp    100cad <merge+0x20f>

0000000000100cd6 <merge_sort>:
//    specialized function to compare the specific values of the array.

void merge_sort(heap_info_node *array, size_t left, size_t right,
                int (*compare)(const void *, const void *)) {
    // check indices as base case for the recursion
    if (left < right) {
  100cd6:	48 39 d6             	cmp    %rdx,%rsi
  100cd9:	72 01                	jb     100cdc <merge_sort+0x6>
  100cdb:	c3                   	ret    
                int (*compare)(const void *, const void *)) {
  100cdc:	55                   	push   %rbp
  100cdd:	48 89 e5             	mov    %rsp,%rbp
  100ce0:	41 57                	push   %r15
  100ce2:	41 56                	push   %r14
  100ce4:	41 55                	push   %r13
  100ce6:	41 54                	push   %r12
  100ce8:	53                   	push   %rbx
  100ce9:	48 83 ec 08          	sub    $0x8,%rsp
  100ced:	49 89 fd             	mov    %rdi,%r13
  100cf0:	48 89 f3             	mov    %rsi,%rbx
  100cf3:	49 89 d4             	mov    %rdx,%r12
  100cf6:	49 89 ce             	mov    %rcx,%r14
        // calculate the center of the array    
        size_t center = (left + right - 1) / 2;
  100cf9:	4c 8d 7c 16 ff       	lea    -0x1(%rsi,%rdx,1),%r15
  100cfe:	49 d1 ef             	shr    %r15

        // recursively call the merge_sort() algorithm to sort subsections
        merge_sort(array, left, center, compare);
  100d01:	4c 89 fa             	mov    %r15,%rdx
  100d04:	e8 cd ff ff ff       	call   100cd6 <merge_sort>
        merge_sort(array, center + 1, right, compare);
  100d09:	49 8d 77 01          	lea    0x1(%r15),%rsi
  100d0d:	4c 89 f1             	mov    %r14,%rcx
  100d10:	4c 89 e2             	mov    %r12,%rdx
  100d13:	4c 89 ef             	mov    %r13,%rdi
  100d16:	e8 bb ff ff ff       	call   100cd6 <merge_sort>

        // merge all resulting arrays back into one
        merge(array, left, center, right, compare);
  100d1b:	4d 89 f0             	mov    %r14,%r8
  100d1e:	4c 89 e1             	mov    %r12,%rcx
  100d21:	4c 89 fa             	mov    %r15,%rdx
  100d24:	48 89 de             	mov    %rbx,%rsi
  100d27:	4c 89 ef             	mov    %r13,%rdi
  100d2a:	e8 6f fd ff ff       	call   100a9e <merge>
    }
}
  100d2f:	48 83 c4 08          	add    $0x8,%rsp
  100d33:	5b                   	pop    %rbx
  100d34:	41 5c                	pop    %r12
  100d36:	41 5d                	pop    %r13
  100d38:	41 5e                	pop    %r14
  100d3a:	41 5f                	pop    %r15
  100d3c:	5d                   	pop    %rbp
  100d3d:	c3                   	ret    

0000000000100d3e <malloc>:

// IMPLEMENT REQUIRED FUNCTIONS
void *malloc(uint64_t numbytes) {
    if (numbytes == 0)
  100d3e:	48 85 ff             	test   %rdi,%rdi
  100d41:	0f 84 96 00 00 00    	je     100ddd <malloc+0x9f>
        return NULL;

    size_t size = sizeof(flist_node) + numbytes + 
                    alignof_eight(sizeof(flist_node) + numbytes);
  100d47:	48 8d 77 18          	lea    0x18(%rdi),%rsi
    return ALIGNMENT_EIGHT - sz + (sz & ~(ALIGNMENT_EIGHT - 1));
  100d4b:	48 89 f0             	mov    %rsi,%rax
  100d4e:	48 83 e0 f8          	and    $0xfffffffffffffff8,%rax
  100d52:	4c 8d 44 07 20       	lea    0x20(%rdi,%rax,1),%r8
    size_t size = sizeof(flist_node) + numbytes + 
  100d57:	4c 89 c7             	mov    %r8,%rdi
  100d5a:	48 29 f7             	sub    %rsi,%rdi
    
    flist_node *tmp = head.next;
  100d5d:	48 8b 05 dc 12 00 00 	mov    0x12dc(%rip),%rax        # 102040 <head+0x10>
    flist_node **ptr = &head.next;

    while (tmp != NULL) {
  100d64:	48 85 c0             	test   %rax,%rax
  100d67:	74 53                	je     100dbc <malloc+0x7e>
    flist_node **ptr = &head.next;
  100d69:	ba 40 20 10 00       	mov    $0x102040,%edx
  100d6e:	eb 13                	jmp    100d83 <malloc+0x45>
                nblock->free = 1;
                nblock->next = tmp->next;
                *ptr = nblock;
            } else {
                size += difference;
                *ptr = tmp->next;
  100d70:	48 8b 78 10          	mov    0x10(%rax),%rdi
  100d74:	eb 3e                	jmp    100db4 <malloc+0x76>
            }

            return (void *)((uintptr_t)tmp + sizeof(flist_node));
        }

        ptr = &(tmp->next);
  100d76:	48 8d 50 10          	lea    0x10(%rax),%rdx
        tmp = tmp->next;
  100d7a:	48 8b 40 10          	mov    0x10(%rax),%rax
    while (tmp != NULL) {
  100d7e:	48 85 c0             	test   %rax,%rax
  100d81:	74 39                	je     100dbc <malloc+0x7e>
        if (tmp->free && tmp->size >= size) {
  100d83:	48 83 78 08 00       	cmpq   $0x0,0x8(%rax)
  100d88:	74 ec                	je     100d76 <malloc+0x38>
  100d8a:	48 8b 08             	mov    (%rax),%rcx
  100d8d:	48 39 f9             	cmp    %rdi,%rcx
  100d90:	72 e4                	jb     100d76 <malloc+0x38>
            size_t difference = tmp->size - size;
  100d92:	4c 29 c6             	sub    %r8,%rsi
  100d95:	48 01 ce             	add    %rcx,%rsi
            if (difference > sizeof(flist_node)) {
  100d98:	48 83 fe 18          	cmp    $0x18,%rsi
  100d9c:	76 d2                	jbe    100d70 <malloc+0x32>
                flist_node *nblock = (flist_node *)((uintptr_t)tmp + size);
  100d9e:	48 01 c7             	add    %rax,%rdi
                nblock->size = difference;
  100da1:	48 89 37             	mov    %rsi,(%rdi)
                nblock->free = 1;
  100da4:	48 c7 47 08 01 00 00 	movq   $0x1,0x8(%rdi)
  100dab:	00 
                nblock->next = tmp->next;
  100dac:	48 8b 48 10          	mov    0x10(%rax),%rcx
  100db0:	48 89 4f 10          	mov    %rcx,0x10(%rdi)
                *ptr = nblock;
  100db4:	48 89 3a             	mov    %rdi,(%rdx)
            return (void *)((uintptr_t)tmp + sizeof(flist_node));
  100db7:	48 83 c0 18          	add    $0x18,%rax
  100dbb:	c3                   	ret    
//     On success, sbrk() returns the previous program break
//     (If the break was increased, then this value is a pointer to the start of the newly allocated memory)
//      On error, (void *) -1 is returned
static inline void * sbrk(const intptr_t increment) {
    static void * result;
    asm volatile ("int %1" :  "=a" (result)
  100dbc:	cd 3a                	int    $0x3a
  100dbe:	48 89 05 5b 12 00 00 	mov    %rax,0x125b(%rip)        # 102020 <result.0>
    }

    tmp = (flist_node *)sbrk(size);
    tmp->size = size;
  100dc5:	48 89 38             	mov    %rdi,(%rax)
    tmp->free = 0;
  100dc8:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
  100dcf:	00 
    tmp->next = (flist_node *)NULL;
  100dd0:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
  100dd7:	00 

    return (void *)((uintptr_t)tmp + sizeof(flist_node));
  100dd8:	48 83 c0 18          	add    $0x18,%rax
  100ddc:	c3                   	ret    
        return NULL;
  100ddd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100de2:	c3                   	ret    

0000000000100de3 <free>:

void free(void *firstbyte) {
    // free the location by setting the corresponding bit
    flist_node *tmp = (flist_node *)((uintptr_t)firstbyte - 
                        sizeof(flist_node));
    tmp->free = 1;
  100de3:	48 c7 47 f0 01 00 00 	movq   $0x1,-0x10(%rdi)
  100dea:	00 
}
  100deb:	c3                   	ret    

0000000000100dec <calloc>:

void *calloc(uint64_t num, uint64_t sz) {
  100dec:	55                   	push   %rbp
  100ded:	48 89 e5             	mov    %rsp,%rbp
  100df0:	41 54                	push   %r12
  100df2:	53                   	push   %rbx
    // alloc new space and set all memory to zero
    void *ptr = malloc(num * sz);
  100df3:	48 0f af fe          	imul   %rsi,%rdi
  100df7:	49 89 fc             	mov    %rdi,%r12
  100dfa:	e8 3f ff ff ff       	call   100d3e <malloc>
  100dff:	48 89 c3             	mov    %rax,%rbx
    memset(ptr, 0, num * sz);
  100e02:	4c 89 e2             	mov    %r12,%rdx
  100e05:	be 00 00 00 00       	mov    $0x0,%esi
  100e0a:	48 89 c7             	mov    %rax,%rdi
  100e0d:	e8 64 f3 ff ff       	call   100176 <memset>
    return ptr;
}
  100e12:	48 89 d8             	mov    %rbx,%rax
  100e15:	5b                   	pop    %rbx
  100e16:	41 5c                	pop    %r12
  100e18:	5d                   	pop    %rbp
  100e19:	c3                   	ret    

0000000000100e1a <realloc>:

void *realloc(void *ptr, uint64_t sz) {
  100e1a:	55                   	push   %rbp
  100e1b:	48 89 e5             	mov    %rsp,%rbp
  100e1e:	41 55                	push   %r13
  100e20:	41 54                	push   %r12
  100e22:	53                   	push   %rbx
  100e23:	48 83 ec 08          	sub    $0x8,%rsp
  100e27:	48 89 fb             	mov    %rdi,%rbx
  100e2a:	48 89 f7             	mov    %rsi,%rdi
    // error handling (multiple cases)
    if (ptr == NULL)
  100e2d:	48 85 db             	test   %rbx,%rbx
  100e30:	74 37                	je     100e69 <realloc+0x4f>
        return malloc(sz);

    if (ptr != NULL && sz == 0) {
  100e32:	48 85 f6             	test   %rsi,%rsi
  100e35:	74 3c                	je     100e73 <realloc+0x59>
        free(ptr);
        return NULL;
    }

    // alloc new space for the information
    void *nptr = malloc(sz);
  100e37:	e8 02 ff ff ff       	call   100d3e <malloc>
  100e3c:	49 89 c4             	mov    %rax,%r12

    // find locations of full size (this includes flist_node and the block)
    flist_node *nptr_node = (flist_node *)((uintptr_t)nptr - 
                                sizeof(flist_node));
    flist_node *ptr_node = (flist_node *)((uintptr_t)ptr - 
  100e3f:	4c 8d 6b e8          	lea    -0x18(%rbx),%r13
    flist_node *nptr_node = (flist_node *)((uintptr_t)nptr - 
  100e43:	48 8d 78 e8          	lea    -0x18(%rax),%rdi
                                sizeof(flist_node));

    // copy over all of the information and free the old space
    memcpy(nptr_node, ptr_node, ptr_node->size);
  100e47:	48 8b 53 e8          	mov    -0x18(%rbx),%rdx
  100e4b:	4c 89 ee             	mov    %r13,%rsi
  100e4e:	e8 ba f2 ff ff       	call   10010d <memcpy>
    tmp->free = 1;
  100e53:	48 c7 43 f0 01 00 00 	movq   $0x1,-0x10(%rbx)
  100e5a:	00 
    free(ptr);

    return nptr;
}
  100e5b:	4c 89 e0             	mov    %r12,%rax
  100e5e:	48 83 c4 08          	add    $0x8,%rsp
  100e62:	5b                   	pop    %rbx
  100e63:	41 5c                	pop    %r12
  100e65:	41 5d                	pop    %r13
  100e67:	5d                   	pop    %rbp
  100e68:	c3                   	ret    
        return malloc(sz);
  100e69:	e8 d0 fe ff ff       	call   100d3e <malloc>
  100e6e:	49 89 c4             	mov    %rax,%r12
  100e71:	eb e8                	jmp    100e5b <realloc+0x41>
    tmp->free = 1;
  100e73:	48 c7 43 f0 01 00 00 	movq   $0x1,-0x10(%rbx)
  100e7a:	00 
        return NULL;
  100e7b:	41 bc 00 00 00 00    	mov    $0x0,%r12d
}
  100e81:	eb d8                	jmp    100e5b <realloc+0x41>

0000000000100e83 <defrag>:

void defrag() {
    // loop through list to find all adjacent free blocks and combine them
    flist_node *tmp1 = head.next;
  100e83:	48 8b 15 b6 11 00 00 	mov    0x11b6(%rip),%rdx        # 102040 <head+0x10>
    while (tmp1 != NULL) {
  100e8a:	48 85 d2             	test   %rdx,%rdx
  100e8d:	74 25                	je     100eb4 <defrag+0x31>
        flist_node *tmp2 = tmp1->next;
  100e8f:	48 8b 42 10          	mov    0x10(%rdx),%rax
        while (tmp2->free && tmp2 != NULL) {
  100e93:	48 83 78 08 00       	cmpq   $0x0,0x8(%rax)
  100e98:	74 11                	je     100eab <defrag+0x28>
            tmp1->size += tmp2->size;
  100e9a:	48 8b 08             	mov    (%rax),%rcx
  100e9d:	48 01 0a             	add    %rcx,(%rdx)
            tmp2 = tmp2->next;
  100ea0:	48 8b 40 10          	mov    0x10(%rax),%rax
        while (tmp2->free && tmp2 != NULL) {
  100ea4:	48 83 78 08 00       	cmpq   $0x0,0x8(%rax)
  100ea9:	75 ef                	jne    100e9a <defrag+0x17>
        }
        tmp1->next = tmp2;
  100eab:	48 89 42 10          	mov    %rax,0x10(%rdx)
  100eaf:	48 89 c2             	mov    %rax,%rdx
  100eb2:	eb db                	jmp    100e8f <defrag+0xc>
        tmp1 = tmp1->next;
    }
}
  100eb4:	c3                   	ret    

0000000000100eb5 <heap_info>:

int heap_info(heap_info_struct *info) {
  100eb5:	55                   	push   %rbp
  100eb6:	48 89 e5             	mov    %rsp,%rbp
  100eb9:	41 57                	push   %r15
  100ebb:	41 56                	push   %r14
  100ebd:	41 55                	push   %r13
  100ebf:	41 54                	push   %r12
  100ec1:	53                   	push   %rbx
  100ec2:	48 83 ec 28          	sub    $0x28,%rsp
  100ec6:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    size_t num_allocs = 0;
    size_t free_space = 0;
    size_t largest_free_chunk = 0;

    // iterate through free list and make initial calculations
    flist_node *tmp = head.next;
  100eca:	48 8b 05 6f 11 00 00 	mov    0x116f(%rip),%rax        # 102040 <head+0x10>
    while (tmp != NULL) {
  100ed1:	48 85 c0             	test   %rax,%rax
  100ed4:	74 42                	je     100f18 <heap_info+0x63>
    size_t largest_free_chunk = 0;
  100ed6:	41 bd 00 00 00 00    	mov    $0x0,%r13d
    size_t free_space = 0;
  100edc:	41 be 00 00 00 00    	mov    $0x0,%r14d
    size_t num_allocs = 0;
  100ee2:	41 bf 00 00 00 00    	mov    $0x0,%r15d
    size_t size = 0;
  100ee8:	bb 00 00 00 00       	mov    $0x0,%ebx
  100eed:	eb 11                	jmp    100f00 <heap_info+0x4b>
            free_space += sizeof(flist_node) + tmp->size;
            if (tmp->size > largest_free_chunk) {
                largest_free_chunk = tmp->size;
            }
        } else
            num_allocs++;
  100eef:	49 83 c7 01          	add    $0x1,%r15

        size++;
  100ef3:	48 83 c3 01          	add    $0x1,%rbx
        tmp = tmp->next;
  100ef7:	48 8b 40 10          	mov    0x10(%rax),%rax
    while (tmp != NULL) {
  100efb:	48 85 c0             	test   %rax,%rax
  100efe:	74 2f                	je     100f2f <heap_info+0x7a>
        if (tmp->free) {
  100f00:	48 83 78 08 00       	cmpq   $0x0,0x8(%rax)
  100f05:	74 e8                	je     100eef <heap_info+0x3a>
            free_space += sizeof(flist_node) + tmp->size;
  100f07:	48 8b 10             	mov    (%rax),%rdx
  100f0a:	4e 8d 74 32 18       	lea    0x18(%rdx,%r14,1),%r14
            if (tmp->size > largest_free_chunk) {
  100f0f:	49 39 d5             	cmp    %rdx,%r13
  100f12:	4c 0f 42 ea          	cmovb  %rdx,%r13
  100f16:	eb db                	jmp    100ef3 <heap_info+0x3e>
    size_t largest_free_chunk = 0;
  100f18:	41 bd 00 00 00 00    	mov    $0x0,%r13d
    size_t free_space = 0;
  100f1e:	41 be 00 00 00 00    	mov    $0x0,%r14d
    size_t num_allocs = 0;
  100f24:	41 bf 00 00 00 00    	mov    $0x0,%r15d
    size_t size = 0;
  100f2a:	bb 00 00 00 00       	mov    $0x0,%ebx
    }

    // create temporary array of structs to sort all values
    heap_info_node *struct_array =
        (heap_info_node *)malloc(sizeof(heap_info_node) * size);
  100f2f:	48 89 df             	mov    %rbx,%rdi
  100f32:	48 c1 e7 04          	shl    $0x4,%rdi
  100f36:	e8 03 fe ff ff       	call   100d3e <malloc>
  100f3b:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    if (struct_array == NULL) {
  100f3f:	48 85 c0             	test   %rax,%rax
  100f42:	74 14                	je     100f58 <heap_info+0xa3>
        info->ptr_array = (void **)NULL;
        // return ERROR;
    }

    // populate temporary array as necessary
    tmp = head.next;
  100f44:	48 8b 05 f5 10 00 00 	mov    0x10f5(%rip),%rax        # 102040 <head+0x10>
    size_t i = 0;
    while (tmp != NULL) {
  100f4b:	48 85 c0             	test   %rax,%rax
  100f4e:	74 4d                	je     100f9d <heap_info+0xe8>
    size_t i = 0;
  100f50:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  100f56:	eb 1f                	jmp    100f77 <heap_info+0xc2>
        info->size_array = (long *)NULL;
  100f58:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
  100f5c:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
  100f63:	00 
        info->ptr_array = (void **)NULL;
  100f64:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
  100f6b:	00 
  100f6c:	eb d6                	jmp    100f44 <heap_info+0x8f>
            struct_array[i].size = tmp->size;
            struct_array[i].ptr = (void *)((uintptr_t)tmp + 
                                    sizeof(flist_node));
            i++;
        }
        tmp = tmp->next;
  100f6e:	48 8b 40 10          	mov    0x10(%rax),%rax
    while (tmp != NULL) {
  100f72:	48 85 c0             	test   %rax,%rax
  100f75:	74 2c                	je     100fa3 <heap_info+0xee>
        if (!tmp->free) {
  100f77:	48 83 78 08 00       	cmpq   $0x0,0x8(%rax)
  100f7c:	75 f0                	jne    100f6e <heap_info+0xb9>
            struct_array[i].size = tmp->size;
  100f7e:	4c 89 e2             	mov    %r12,%rdx
  100f81:	48 c1 e2 04          	shl    $0x4,%rdx
  100f85:	48 03 55 c8          	add    -0x38(%rbp),%rdx
  100f89:	48 8b 08             	mov    (%rax),%rcx
  100f8c:	48 89 0a             	mov    %rcx,(%rdx)
            struct_array[i].ptr = (void *)((uintptr_t)tmp + 
  100f8f:	48 8d 48 18          	lea    0x18(%rax),%rcx
  100f93:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
            i++;
  100f97:	49 83 c4 01          	add    $0x1,%r12
  100f9b:	eb d1                	jmp    100f6e <heap_info+0xb9>
    size_t i = 0;
  100f9d:	41 bc 00 00 00 00    	mov    $0x0,%r12d
    }

    // perform merge sort algorithm on the array of structs
    merge_sort(struct_array, 0, size, comp_structs);
  100fa3:	b9 82 0a 10 00       	mov    $0x100a82,%ecx
  100fa8:	48 89 da             	mov    %rbx,%rdx
  100fab:	be 00 00 00 00       	mov    $0x0,%esi
  100fb0:	48 8b 7d c8          	mov    -0x38(%rbp),%rdi
  100fb4:	e8 1d fd ff ff       	call   100cd6 <merge_sort>

    // create return arrays to be passed onto the user
    long *size_array = (long *)malloc(sizeof(long) * size);
  100fb9:	48 8d 04 dd 00 00 00 	lea    0x0(,%rbx,8),%rax
  100fc0:	00 
  100fc1:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
  100fc5:	48 89 c7             	mov    %rax,%rdi
  100fc8:	e8 71 fd ff ff       	call   100d3e <malloc>
  100fcd:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    if (size_array == NULL) {
  100fd1:	48 85 c0             	test   %rax,%rax
  100fd4:	0f 84 90 00 00 00    	je     10106a <heap_info+0x1b5>
        info->size_array = (long *)NULL;
        info->ptr_array = (void **)NULL;
        return ERROR;
    }

    void **ptr_array = (void **)malloc(sizeof(void *) * size);
  100fda:	48 8b 7d b0          	mov    -0x50(%rbp),%rdi
  100fde:	e8 5b fd ff ff       	call   100d3e <malloc>
  100fe3:	48 89 c7             	mov    %rax,%rdi
    if (ptr_array == NULL) {
  100fe6:	48 85 c0             	test   %rax,%rax
  100fe9:	0f 84 96 00 00 00    	je     101085 <heap_info+0x1d0>
        info->ptr_array = (void **)NULL;
        return ERROR;
    }

    // copy sorted information into the return arrays
    for (size_t j = 0; j < size; j++)
  100fef:	48 85 db             	test   %rbx,%rbx
  100ff2:	74 47                	je     10103b <heap_info+0x186>
        size_array[i] = struct_array[i].size;
  100ff4:	4c 89 e0             	mov    %r12,%rax
  100ff7:	48 c1 e0 04          	shl    $0x4,%rax
  100ffb:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  100fff:	48 01 c2             	add    %rax,%rdx
  101002:	49 c1 e4 03          	shl    $0x3,%r12
  101006:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  10100a:	4a 8d 34 20          	lea    (%rax,%r12,1),%rsi
    for (size_t j = 0; j < size; j++)
  10100e:	b8 00 00 00 00       	mov    $0x0,%eax
        size_array[i] = struct_array[i].size;
  101013:	48 8b 0a             	mov    (%rdx),%rcx
  101016:	48 89 0e             	mov    %rcx,(%rsi)
    for (size_t j = 0; j < size; j++)
  101019:	48 83 c0 01          	add    $0x1,%rax
  10101d:	48 39 d8             	cmp    %rbx,%rax
  101020:	75 f1                	jne    101013 <heap_info+0x15e>
    for (size_t j = 0; j < size; j++)
        ptr_array[i] = struct_array[i].ptr;
  101022:	49 01 fc             	add    %rdi,%r12
  101025:	b8 00 00 00 00       	mov    $0x0,%eax
  10102a:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  10102e:	49 89 0c 24          	mov    %rcx,(%r12)
    for (size_t j = 0; j < size; j++)
  101032:	48 83 c0 01          	add    $0x1,%rax
  101036:	48 39 d8             	cmp    %rbx,%rax
  101039:	75 ef                	jne    10102a <heap_info+0x175>

    // set all final values in the heap info struct
    info->num_allocs = num_allocs;
  10103b:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
  10103f:	44 89 38             	mov    %r15d,(%rax)
    info->size_array = size_array;
  101042:	48 8b 75 c0          	mov    -0x40(%rbp),%rsi
  101046:	48 89 70 08          	mov    %rsi,0x8(%rax)
    info->ptr_array = ptr_array;
  10104a:	48 89 78 10          	mov    %rdi,0x10(%rax)
    info->free_space = free_space;
  10104e:	44 89 70 18          	mov    %r14d,0x18(%rax)
    info->largest_free_chunk = largest_free_chunk;
  101052:	44 89 68 1c          	mov    %r13d,0x1c(%rax)

    return SUCCESS;
  101056:	b8 00 00 00 00       	mov    $0x0,%eax
}
  10105b:	48 83 c4 28          	add    $0x28,%rsp
  10105f:	5b                   	pop    %rbx
  101060:	41 5c                	pop    %r12
  101062:	41 5d                	pop    %r13
  101064:	41 5e                	pop    %r14
  101066:	41 5f                	pop    %r15
  101068:	5d                   	pop    %rbp
  101069:	c3                   	ret    
        info->size_array = (long *)NULL;
  10106a:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
  10106e:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
  101075:	00 
        info->ptr_array = (void **)NULL;
  101076:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
  10107d:	00 
        return ERROR;
  10107e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  101083:	eb d6                	jmp    10105b <heap_info+0x1a6>
        info->size_array = (long *)NULL;
  101085:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
  101089:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
  101090:	00 
        info->ptr_array = (void **)NULL;
  101091:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
  101098:	00 
        return ERROR;
  101099:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10109e:	eb bb                	jmp    10105b <heap_info+0x1a6>
