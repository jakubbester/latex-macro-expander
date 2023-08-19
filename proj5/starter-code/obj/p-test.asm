
obj/p-test.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000100000 <process_main>:
extern uint8_t end[];

uint8_t* heap_top;
uint8_t* stack_bottom;

void process_main(void) {
  100000:	55                   	push   %rbp
  100001:	48 89 e5             	mov    %rsp,%rbp
  100004:	48 83 ec 30          	sub    $0x30,%rsp

    uint8_t * code_page = ROUNDDOWN(end - PAGESIZE - 1, PAGESIZE);
  100008:	be 07 00 10 00       	mov    $0x100007,%esi
  10000d:	48 81 e6 00 f0 ff ff 	and    $0xfffffffffffff000,%rsi
// looks up the virtual memory mapping for addr for the current process 
// and stores it inside map. [map, sizeof(vampping)) address should be 
// allocated, writable addresses to the process, otherwise syscall will 
// not write anything to the variable
static inline void sys_mapping(uintptr_t addr, void * map){
    asm volatile ("int %0" : /* no result */
  100014:	48 8d 7d e8          	lea    -0x18(%rbp),%rdi
  100018:	cd 36                	int    $0x36
    asm volatile ("int %1" : "=a" (result)
  10001a:	cd 34                	int    $0x34
    sys_mapping((uintptr_t)code_page, &map);

    // Fork a total of three new copies.

    pid_t p1 = sys_fork();
    assert(p1 >= 0);
  10001c:	85 c0                	test   %eax,%eax
  10001e:	78 54                	js     100074 <process_main+0x74>
  100020:	89 c2                	mov    %eax,%edx
  100022:	cd 34                	int    $0x34
  100024:	89 c1                	mov    %eax,%ecx
    pid_t p2 = sys_fork();
    assert(p2 >= 0);
  100026:	85 c0                	test   %eax,%eax
  100028:	78 5e                	js     100088 <process_main+0x88>
    asm volatile ("int %1" : "=a" (result)
  10002a:	cd 31                	int    $0x31

    // Check fork return values: fork should return 0 to child.
    if (sys_getpid() == 1) {
  10002c:	83 f8 01             	cmp    $0x1,%eax
  10002f:	74 6b                	je     10009c <process_main+0x9c>
        assert(p1 != 0 && p2 != 0 && p1 != p2);
    } else {
        assert(p1 == 0 || p2 == 0);
  100031:	85 d2                	test   %edx,%edx
  100033:	74 08                	je     10003d <process_main+0x3d>
  100035:	85 c9                	test   %ecx,%ecx
  100037:	0f 85 85 00 00 00    	jne    1000c2 <process_main+0xc2>
    asm volatile ("int %0" : /* no result */
  10003d:	48 8d 7d d0          	lea    -0x30(%rbp),%rdi
  100041:	cd 36                	int    $0x36

    // Now, lets check code page mapping
    vamapping child_cmap;
    sys_mapping((uintptr_t) code_page, &child_cmap);

    if(child_cmap.pa != map.pa){
  100043:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  100047:	48 39 45 d8          	cmp    %rax,-0x28(%rbp)
  10004b:	0f 85 85 00 00 00    	jne    1000d6 <process_main+0xd6>
    asm volatile ("int %0" : /* no result */
  100051:	cd 32                	int    $0x32
  100053:	cd 32                	int    $0x32
    }

    sys_yield();
    sys_yield();

    if(child_cmap.pa == (uintptr_t)code_page || map.pa == (uintptr_t)code_page)
  100055:	48 3b 75 d8          	cmp    -0x28(%rbp),%rsi
  100059:	74 0a                	je     100065 <process_main+0x65>
  10005b:	48 3b 75 f0          	cmp    -0x10(%rbp),%rsi
  10005f:	0f 85 80 00 00 00    	jne    1000e5 <process_main+0xe5>
        panic("Error, code pages are not virtually mapped!");
  100065:	bf 20 0d 10 00       	mov    $0x100d20,%edi
  10006a:	b8 00 00 00 00       	mov    $0x0,%eax
  10006f:	e8 23 0b 00 00       	call   100b97 <panic>
    assert(p1 >= 0);
  100074:	ba a0 0c 10 00       	mov    $0x100ca0,%edx
  100079:	be 12 00 00 00       	mov    $0x12,%esi
  10007e:	bf a8 0c 10 00       	mov    $0x100ca8,%edi
  100083:	e8 dc 0b 00 00       	call   100c64 <assert_fail>
    assert(p2 >= 0);
  100088:	ba b1 0c 10 00       	mov    $0x100cb1,%edx
  10008d:	be 14 00 00 00       	mov    $0x14,%esi
  100092:	bf a8 0c 10 00       	mov    $0x100ca8,%edi
  100097:	e8 c8 0b 00 00       	call   100c64 <assert_fail>
        assert(p1 != 0 && p2 != 0 && p1 != p2);
  10009c:	85 c9                	test   %ecx,%ecx
  10009e:	0f 94 c0             	sete   %al
  1000a1:	39 ca                	cmp    %ecx,%edx
  1000a3:	0f 94 c1             	sete   %cl
  1000a6:	08 c8                	or     %cl,%al
  1000a8:	75 04                	jne    1000ae <process_main+0xae>
  1000aa:	85 d2                	test   %edx,%edx
  1000ac:	75 8f                	jne    10003d <process_main+0x3d>
  1000ae:	ba 00 0d 10 00       	mov    $0x100d00,%edx
  1000b3:	be 18 00 00 00       	mov    $0x18,%esi
  1000b8:	bf a8 0c 10 00       	mov    $0x100ca8,%edi
  1000bd:	e8 a2 0b 00 00       	call   100c64 <assert_fail>
        assert(p1 == 0 || p2 == 0);
  1000c2:	ba b9 0c 10 00       	mov    $0x100cb9,%edx
  1000c7:	be 1a 00 00 00       	mov    $0x1a,%esi
  1000cc:	bf a8 0c 10 00       	mov    $0x100ca8,%edi
  1000d1:	e8 8e 0b 00 00       	call   100c64 <assert_fail>
        panic("Error, code pages not shared!");
  1000d6:	bf cc 0c 10 00       	mov    $0x100ccc,%edi
  1000db:	b8 00 00 00 00       	mov    $0x0,%eax
  1000e0:	e8 b2 0a 00 00       	call   100b97 <panic>
  1000e5:	cd 32                	int    $0x32

    sys_yield();
    TEST_PASS();
  1000e7:	bf ea 0c 10 00       	mov    $0x100cea,%edi
  1000ec:	b8 00 00 00 00       	mov    $0x0,%eax
  1000f1:	e8 a1 0a 00 00       	call   100b97 <panic>

00000000001000f6 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  1000f6:	48 89 f9             	mov    %rdi,%rcx
  1000f9:	89 d7                	mov    %edx,%edi
    console_printer* cp = (console_printer*) p;
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  1000fb:	48 81 79 08 a0 8f 0b 	cmpq   $0xb8fa0,0x8(%rcx)
  100102:	00 
  100103:	72 08                	jb     10010d <console_putc+0x17>
        cp->cursor = console;
  100105:	48 c7 41 08 00 80 0b 	movq   $0xb8000,0x8(%rcx)
  10010c:	00 
    }
    if (c == '\n') {
  10010d:	40 80 fe 0a          	cmp    $0xa,%sil
  100111:	74 16                	je     100129 <console_putc+0x33>
        int pos = (cp->cursor - console) % 80;
        for (; pos != 80; pos++) {
            *cp->cursor++ = ' ' | color;
        }
    } else {
        *cp->cursor++ = c | color;
  100113:	48 8b 41 08          	mov    0x8(%rcx),%rax
  100117:	48 8d 50 02          	lea    0x2(%rax),%rdx
  10011b:	48 89 51 08          	mov    %rdx,0x8(%rcx)
  10011f:	40 0f b6 f6          	movzbl %sil,%esi
  100123:	09 fe                	or     %edi,%esi
  100125:	66 89 30             	mov    %si,(%rax)
    }
}
  100128:	c3                   	ret    
        int pos = (cp->cursor - console) % 80;
  100129:	4c 8b 41 08          	mov    0x8(%rcx),%r8
  10012d:	49 81 e8 00 80 0b 00 	sub    $0xb8000,%r8
  100134:	4c 89 c6             	mov    %r8,%rsi
  100137:	48 d1 fe             	sar    %rsi
  10013a:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  100141:	66 66 66 
  100144:	48 89 f0             	mov    %rsi,%rax
  100147:	48 f7 ea             	imul   %rdx
  10014a:	48 c1 fa 05          	sar    $0x5,%rdx
  10014e:	49 c1 f8 3f          	sar    $0x3f,%r8
  100152:	4c 29 c2             	sub    %r8,%rdx
  100155:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
  100159:	48 c1 e2 04          	shl    $0x4,%rdx
  10015d:	89 f0                	mov    %esi,%eax
  10015f:	29 d0                	sub    %edx,%eax
            *cp->cursor++ = ' ' | color;
  100161:	83 cf 20             	or     $0x20,%edi
  100164:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  100168:	48 8d 72 02          	lea    0x2(%rdx),%rsi
  10016c:	48 89 71 08          	mov    %rsi,0x8(%rcx)
  100170:	66 89 3a             	mov    %di,(%rdx)
        for (; pos != 80; pos++) {
  100173:	83 c0 01             	add    $0x1,%eax
  100176:	83 f8 50             	cmp    $0x50,%eax
  100179:	75 e9                	jne    100164 <console_putc+0x6e>
  10017b:	c3                   	ret    

000000000010017c <string_putc>:
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
    string_printer* sp = (string_printer*) p;
    if (sp->s < sp->end) {
  10017c:	48 8b 47 08          	mov    0x8(%rdi),%rax
  100180:	48 3b 47 10          	cmp    0x10(%rdi),%rax
  100184:	73 0b                	jae    100191 <string_putc+0x15>
        *sp->s++ = c;
  100186:	48 8d 50 01          	lea    0x1(%rax),%rdx
  10018a:	48 89 57 08          	mov    %rdx,0x8(%rdi)
  10018e:	40 88 30             	mov    %sil,(%rax)
    }
    (void) color;
}
  100191:	c3                   	ret    

0000000000100192 <memcpy>:
void* memcpy(void* dst, const void* src, size_t n) {
  100192:	48 89 f8             	mov    %rdi,%rax
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  100195:	48 85 d2             	test   %rdx,%rdx
  100198:	74 17                	je     1001b1 <memcpy+0x1f>
  10019a:	b9 00 00 00 00       	mov    $0x0,%ecx
        *d = *s;
  10019f:	44 0f b6 04 0e       	movzbl (%rsi,%rcx,1),%r8d
  1001a4:	44 88 04 08          	mov    %r8b,(%rax,%rcx,1)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1001a8:	48 83 c1 01          	add    $0x1,%rcx
  1001ac:	48 39 d1             	cmp    %rdx,%rcx
  1001af:	75 ee                	jne    10019f <memcpy+0xd>
}
  1001b1:	c3                   	ret    

00000000001001b2 <memmove>:
void* memmove(void* dst, const void* src, size_t n) {
  1001b2:	48 89 f8             	mov    %rdi,%rax
    if (s < d && s + n > d) {
  1001b5:	48 39 fe             	cmp    %rdi,%rsi
  1001b8:	72 1d                	jb     1001d7 <memmove+0x25>
        while (n-- > 0) {
  1001ba:	b9 00 00 00 00       	mov    $0x0,%ecx
  1001bf:	48 85 d2             	test   %rdx,%rdx
  1001c2:	74 12                	je     1001d6 <memmove+0x24>
            *d++ = *s++;
  1001c4:	0f b6 3c 0e          	movzbl (%rsi,%rcx,1),%edi
  1001c8:	40 88 3c 08          	mov    %dil,(%rax,%rcx,1)
        while (n-- > 0) {
  1001cc:	48 83 c1 01          	add    $0x1,%rcx
  1001d0:	48 39 ca             	cmp    %rcx,%rdx
  1001d3:	75 ef                	jne    1001c4 <memmove+0x12>
}
  1001d5:	c3                   	ret    
  1001d6:	c3                   	ret    
    if (s < d && s + n > d) {
  1001d7:	48 8d 0c 16          	lea    (%rsi,%rdx,1),%rcx
  1001db:	48 39 cf             	cmp    %rcx,%rdi
  1001de:	73 da                	jae    1001ba <memmove+0x8>
        while (n-- > 0) {
  1001e0:	48 8d 4a ff          	lea    -0x1(%rdx),%rcx
  1001e4:	48 85 d2             	test   %rdx,%rdx
  1001e7:	74 ec                	je     1001d5 <memmove+0x23>
            *--d = *--s;
  1001e9:	0f b6 14 0e          	movzbl (%rsi,%rcx,1),%edx
  1001ed:	88 14 08             	mov    %dl,(%rax,%rcx,1)
        while (n-- > 0) {
  1001f0:	48 83 e9 01          	sub    $0x1,%rcx
  1001f4:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
  1001f8:	75 ef                	jne    1001e9 <memmove+0x37>
  1001fa:	c3                   	ret    

00000000001001fb <memset>:
void* memset(void* v, int c, size_t n) {
  1001fb:	48 89 f8             	mov    %rdi,%rax
    for (char* p = (char*) v; n > 0; ++p, --n) {
  1001fe:	48 85 d2             	test   %rdx,%rdx
  100201:	74 12                	je     100215 <memset+0x1a>
  100203:	48 01 fa             	add    %rdi,%rdx
  100206:	48 89 f9             	mov    %rdi,%rcx
        *p = c;
  100209:	40 88 31             	mov    %sil,(%rcx)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  10020c:	48 83 c1 01          	add    $0x1,%rcx
  100210:	48 39 ca             	cmp    %rcx,%rdx
  100213:	75 f4                	jne    100209 <memset+0xe>
}
  100215:	c3                   	ret    

0000000000100216 <strlen>:
    for (n = 0; *s != '\0'; ++s) {
  100216:	80 3f 00             	cmpb   $0x0,(%rdi)
  100219:	74 10                	je     10022b <strlen+0x15>
  10021b:	b8 00 00 00 00       	mov    $0x0,%eax
        ++n;
  100220:	48 83 c0 01          	add    $0x1,%rax
    for (n = 0; *s != '\0'; ++s) {
  100224:	80 3c 07 00          	cmpb   $0x0,(%rdi,%rax,1)
  100228:	75 f6                	jne    100220 <strlen+0xa>
  10022a:	c3                   	ret    
  10022b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100230:	c3                   	ret    

0000000000100231 <strnlen>:
size_t strnlen(const char* s, size_t maxlen) {
  100231:	48 89 f0             	mov    %rsi,%rax
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100234:	ba 00 00 00 00       	mov    $0x0,%edx
  100239:	48 85 f6             	test   %rsi,%rsi
  10023c:	74 11                	je     10024f <strnlen+0x1e>
  10023e:	80 3c 17 00          	cmpb   $0x0,(%rdi,%rdx,1)
  100242:	74 0c                	je     100250 <strnlen+0x1f>
        ++n;
  100244:	48 83 c2 01          	add    $0x1,%rdx
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100248:	48 39 d0             	cmp    %rdx,%rax
  10024b:	75 f1                	jne    10023e <strnlen+0xd>
  10024d:	eb 04                	jmp    100253 <strnlen+0x22>
  10024f:	c3                   	ret    
  100250:	48 89 d0             	mov    %rdx,%rax
}
  100253:	c3                   	ret    

0000000000100254 <strcpy>:
char* strcpy(char* dst, const char* src) {
  100254:	48 89 f8             	mov    %rdi,%rax
  100257:	ba 00 00 00 00       	mov    $0x0,%edx
        *d++ = *src++;
  10025c:	0f b6 0c 16          	movzbl (%rsi,%rdx,1),%ecx
  100260:	88 0c 10             	mov    %cl,(%rax,%rdx,1)
    } while (d[-1]);
  100263:	48 83 c2 01          	add    $0x1,%rdx
  100267:	84 c9                	test   %cl,%cl
  100269:	75 f1                	jne    10025c <strcpy+0x8>
}
  10026b:	c3                   	ret    

000000000010026c <strcmp>:
    while (*a && *b && *a == *b) {
  10026c:	0f b6 07             	movzbl (%rdi),%eax
  10026f:	84 c0                	test   %al,%al
  100271:	74 1a                	je     10028d <strcmp+0x21>
  100273:	0f b6 16             	movzbl (%rsi),%edx
  100276:	38 c2                	cmp    %al,%dl
  100278:	75 13                	jne    10028d <strcmp+0x21>
  10027a:	84 d2                	test   %dl,%dl
  10027c:	74 0f                	je     10028d <strcmp+0x21>
        ++a, ++b;
  10027e:	48 83 c7 01          	add    $0x1,%rdi
  100282:	48 83 c6 01          	add    $0x1,%rsi
    while (*a && *b && *a == *b) {
  100286:	0f b6 07             	movzbl (%rdi),%eax
  100289:	84 c0                	test   %al,%al
  10028b:	75 e6                	jne    100273 <strcmp+0x7>
    return ((unsigned char) *a > (unsigned char) *b)
  10028d:	3a 06                	cmp    (%rsi),%al
  10028f:	0f 97 c0             	seta   %al
  100292:	0f b6 c0             	movzbl %al,%eax
        - ((unsigned char) *a < (unsigned char) *b);
  100295:	83 d8 00             	sbb    $0x0,%eax
}
  100298:	c3                   	ret    

0000000000100299 <strchr>:
    while (*s && *s != (char) c) {
  100299:	0f b6 07             	movzbl (%rdi),%eax
  10029c:	84 c0                	test   %al,%al
  10029e:	74 10                	je     1002b0 <strchr+0x17>
  1002a0:	40 38 f0             	cmp    %sil,%al
  1002a3:	74 18                	je     1002bd <strchr+0x24>
        ++s;
  1002a5:	48 83 c7 01          	add    $0x1,%rdi
    while (*s && *s != (char) c) {
  1002a9:	0f b6 07             	movzbl (%rdi),%eax
  1002ac:	84 c0                	test   %al,%al
  1002ae:	75 f0                	jne    1002a0 <strchr+0x7>
        return NULL;
  1002b0:	40 84 f6             	test   %sil,%sil
  1002b3:	b8 00 00 00 00       	mov    $0x0,%eax
  1002b8:	48 0f 44 c7          	cmove  %rdi,%rax
}
  1002bc:	c3                   	ret    
  1002bd:	48 89 f8             	mov    %rdi,%rax
  1002c0:	c3                   	ret    

00000000001002c1 <rand>:
    if (!rand_seed_set) {
  1002c1:	83 3d 3c 0d 00 00 00 	cmpl   $0x0,0xd3c(%rip)        # 101004 <rand_seed_set>
  1002c8:	74 1b                	je     1002e5 <rand+0x24>
    rand_seed = rand_seed * 1664525U + 1013904223U;
  1002ca:	69 05 2c 0d 00 00 0d 	imul   $0x19660d,0xd2c(%rip),%eax        # 101000 <rand_seed>
  1002d1:	66 19 00 
  1002d4:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  1002d9:	89 05 21 0d 00 00    	mov    %eax,0xd21(%rip)        # 101000 <rand_seed>
    return rand_seed & RAND_MAX;
  1002df:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  1002e4:	c3                   	ret    
    rand_seed = seed;
  1002e5:	c7 05 11 0d 00 00 9e 	movl   $0x30d4879e,0xd11(%rip)        # 101000 <rand_seed>
  1002ec:	87 d4 30 
    rand_seed_set = 1;
  1002ef:	c7 05 0b 0d 00 00 01 	movl   $0x1,0xd0b(%rip)        # 101004 <rand_seed_set>
  1002f6:	00 00 00 
}
  1002f9:	eb cf                	jmp    1002ca <rand+0x9>

00000000001002fb <srand>:
    rand_seed = seed;
  1002fb:	89 3d ff 0c 00 00    	mov    %edi,0xcff(%rip)        # 101000 <rand_seed>
    rand_seed_set = 1;
  100301:	c7 05 f9 0c 00 00 01 	movl   $0x1,0xcf9(%rip)        # 101004 <rand_seed_set>
  100308:	00 00 00 
}
  10030b:	c3                   	ret    

000000000010030c <printer_vprintf>:
void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  10030c:	55                   	push   %rbp
  10030d:	48 89 e5             	mov    %rsp,%rbp
  100310:	41 57                	push   %r15
  100312:	41 56                	push   %r14
  100314:	41 55                	push   %r13
  100316:	41 54                	push   %r12
  100318:	53                   	push   %rbx
  100319:	48 83 ec 58          	sub    $0x58,%rsp
  10031d:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    for (; *format; ++format) {
  100321:	0f b6 02             	movzbl (%rdx),%eax
  100324:	84 c0                	test   %al,%al
  100326:	0f 84 b0 06 00 00    	je     1009dc <printer_vprintf+0x6d0>
  10032c:	49 89 fe             	mov    %rdi,%r14
  10032f:	49 89 d4             	mov    %rdx,%r12
            length = 1;
  100332:	41 89 f7             	mov    %esi,%r15d
  100335:	e9 a4 04 00 00       	jmp    1007de <printer_vprintf+0x4d2>
        for (++format; *format; ++format) {
  10033a:	49 8d 5c 24 01       	lea    0x1(%r12),%rbx
  10033f:	45 0f b6 64 24 01    	movzbl 0x1(%r12),%r12d
  100345:	45 84 e4             	test   %r12b,%r12b
  100348:	0f 84 82 06 00 00    	je     1009d0 <printer_vprintf+0x6c4>
        int flags = 0;
  10034e:	41 bd 00 00 00 00    	mov    $0x0,%r13d
            const char* flagc = strchr(flag_chars, *format);
  100354:	41 0f be f4          	movsbl %r12b,%esi
  100358:	bf 51 0f 10 00       	mov    $0x100f51,%edi
  10035d:	e8 37 ff ff ff       	call   100299 <strchr>
  100362:	48 89 c1             	mov    %rax,%rcx
            if (flagc) {
  100365:	48 85 c0             	test   %rax,%rax
  100368:	74 55                	je     1003bf <printer_vprintf+0xb3>
                flags |= 1 << (flagc - flag_chars);
  10036a:	48 81 e9 51 0f 10 00 	sub    $0x100f51,%rcx
  100371:	b8 01 00 00 00       	mov    $0x1,%eax
  100376:	d3 e0                	shl    %cl,%eax
  100378:	41 09 c5             	or     %eax,%r13d
        for (++format; *format; ++format) {
  10037b:	48 83 c3 01          	add    $0x1,%rbx
  10037f:	44 0f b6 23          	movzbl (%rbx),%r12d
  100383:	45 84 e4             	test   %r12b,%r12b
  100386:	75 cc                	jne    100354 <printer_vprintf+0x48>
  100388:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
        int width = -1;
  10038c:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
        int precision = -1;
  100392:	c7 45 9c ff ff ff ff 	movl   $0xffffffff,-0x64(%rbp)
        if (*format == '.') {
  100399:	80 3b 2e             	cmpb   $0x2e,(%rbx)
  10039c:	0f 84 a9 00 00 00    	je     10044b <printer_vprintf+0x13f>
        int length = 0;
  1003a2:	b9 00 00 00 00       	mov    $0x0,%ecx
        switch (*format) {
  1003a7:	0f b6 13             	movzbl (%rbx),%edx
  1003aa:	8d 42 bd             	lea    -0x43(%rdx),%eax
  1003ad:	3c 37                	cmp    $0x37,%al
  1003af:	0f 87 c4 04 00 00    	ja     100879 <printer_vprintf+0x56d>
  1003b5:	0f b6 c0             	movzbl %al,%eax
  1003b8:	ff 24 c5 60 0d 10 00 	jmp    *0x100d60(,%rax,8)
        if (*format >= '1' && *format <= '9') {
  1003bf:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
  1003c3:	41 8d 44 24 cf       	lea    -0x31(%r12),%eax
  1003c8:	3c 08                	cmp    $0x8,%al
  1003ca:	77 2f                	ja     1003fb <printer_vprintf+0xef>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  1003cc:	0f b6 03             	movzbl (%rbx),%eax
  1003cf:	8d 50 d0             	lea    -0x30(%rax),%edx
  1003d2:	80 fa 09             	cmp    $0x9,%dl
  1003d5:	77 5e                	ja     100435 <printer_vprintf+0x129>
  1003d7:	41 bd 00 00 00 00    	mov    $0x0,%r13d
                width = 10 * width + *format++ - '0';
  1003dd:	48 83 c3 01          	add    $0x1,%rbx
  1003e1:	43 8d 54 ad 00       	lea    0x0(%r13,%r13,4),%edx
  1003e6:	0f be c0             	movsbl %al,%eax
  1003e9:	44 8d 6c 50 d0       	lea    -0x30(%rax,%rdx,2),%r13d
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  1003ee:	0f b6 03             	movzbl (%rbx),%eax
  1003f1:	8d 50 d0             	lea    -0x30(%rax),%edx
  1003f4:	80 fa 09             	cmp    $0x9,%dl
  1003f7:	76 e4                	jbe    1003dd <printer_vprintf+0xd1>
  1003f9:	eb 97                	jmp    100392 <printer_vprintf+0x86>
        } else if (*format == '*') {
  1003fb:	41 80 fc 2a          	cmp    $0x2a,%r12b
  1003ff:	75 3f                	jne    100440 <printer_vprintf+0x134>
            width = va_arg(val, int);
  100401:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100405:	8b 07                	mov    (%rdi),%eax
  100407:	83 f8 2f             	cmp    $0x2f,%eax
  10040a:	77 17                	ja     100423 <printer_vprintf+0x117>
  10040c:	89 c2                	mov    %eax,%edx
  10040e:	48 03 57 10          	add    0x10(%rdi),%rdx
  100412:	83 c0 08             	add    $0x8,%eax
  100415:	89 07                	mov    %eax,(%rdi)
  100417:	44 8b 2a             	mov    (%rdx),%r13d
            ++format;
  10041a:	48 83 c3 01          	add    $0x1,%rbx
  10041e:	e9 6f ff ff ff       	jmp    100392 <printer_vprintf+0x86>
            width = va_arg(val, int);
  100423:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100427:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  10042b:	48 8d 42 08          	lea    0x8(%rdx),%rax
  10042f:	48 89 41 08          	mov    %rax,0x8(%rcx)
  100433:	eb e2                	jmp    100417 <printer_vprintf+0x10b>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100435:	41 bd 00 00 00 00    	mov    $0x0,%r13d
  10043b:	e9 52 ff ff ff       	jmp    100392 <printer_vprintf+0x86>
        int width = -1;
  100440:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
  100446:	e9 47 ff ff ff       	jmp    100392 <printer_vprintf+0x86>
            ++format;
  10044b:	48 8d 53 01          	lea    0x1(%rbx),%rdx
            if (*format >= '0' && *format <= '9') {
  10044f:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
  100453:	8d 48 d0             	lea    -0x30(%rax),%ecx
  100456:	80 f9 09             	cmp    $0x9,%cl
  100459:	76 13                	jbe    10046e <printer_vprintf+0x162>
            } else if (*format == '*') {
  10045b:	3c 2a                	cmp    $0x2a,%al
  10045d:	74 33                	je     100492 <printer_vprintf+0x186>
            ++format;
  10045f:	48 89 d3             	mov    %rdx,%rbx
                precision = 0;
  100462:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
  100469:	e9 34 ff ff ff       	jmp    1003a2 <printer_vprintf+0x96>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  10046e:	b9 00 00 00 00       	mov    $0x0,%ecx
                    precision = 10 * precision + *format++ - '0';
  100473:	48 83 c2 01          	add    $0x1,%rdx
  100477:	8d 0c 89             	lea    (%rcx,%rcx,4),%ecx
  10047a:	0f be c0             	movsbl %al,%eax
  10047d:	8d 4c 48 d0          	lea    -0x30(%rax,%rcx,2),%ecx
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  100481:	0f b6 02             	movzbl (%rdx),%eax
  100484:	8d 70 d0             	lea    -0x30(%rax),%esi
  100487:	40 80 fe 09          	cmp    $0x9,%sil
  10048b:	76 e6                	jbe    100473 <printer_vprintf+0x167>
                    precision = 10 * precision + *format++ - '0';
  10048d:	48 89 d3             	mov    %rdx,%rbx
  100490:	eb 1c                	jmp    1004ae <printer_vprintf+0x1a2>
                precision = va_arg(val, int);
  100492:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100496:	8b 07                	mov    (%rdi),%eax
  100498:	83 f8 2f             	cmp    $0x2f,%eax
  10049b:	77 23                	ja     1004c0 <printer_vprintf+0x1b4>
  10049d:	89 c2                	mov    %eax,%edx
  10049f:	48 03 57 10          	add    0x10(%rdi),%rdx
  1004a3:	83 c0 08             	add    $0x8,%eax
  1004a6:	89 07                	mov    %eax,(%rdi)
  1004a8:	8b 0a                	mov    (%rdx),%ecx
                ++format;
  1004aa:	48 83 c3 02          	add    $0x2,%rbx
            if (precision < 0) {
  1004ae:	85 c9                	test   %ecx,%ecx
  1004b0:	b8 00 00 00 00       	mov    $0x0,%eax
  1004b5:	0f 49 c1             	cmovns %ecx,%eax
  1004b8:	89 45 9c             	mov    %eax,-0x64(%rbp)
  1004bb:	e9 e2 fe ff ff       	jmp    1003a2 <printer_vprintf+0x96>
                precision = va_arg(val, int);
  1004c0:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1004c4:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1004c8:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1004cc:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1004d0:	eb d6                	jmp    1004a8 <printer_vprintf+0x19c>
        switch (*format) {
  1004d2:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
  1004d7:	e9 f3 00 00 00       	jmp    1005cf <printer_vprintf+0x2c3>
            ++format;
  1004dc:	48 83 c3 01          	add    $0x1,%rbx
            length = 1;
  1004e0:	b9 01 00 00 00       	mov    $0x1,%ecx
            goto again;
  1004e5:	e9 bd fe ff ff       	jmp    1003a7 <printer_vprintf+0x9b>
            long x = length ? va_arg(val, long) : va_arg(val, int);
  1004ea:	85 c9                	test   %ecx,%ecx
  1004ec:	74 55                	je     100543 <printer_vprintf+0x237>
  1004ee:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1004f2:	8b 07                	mov    (%rdi),%eax
  1004f4:	83 f8 2f             	cmp    $0x2f,%eax
  1004f7:	77 38                	ja     100531 <printer_vprintf+0x225>
  1004f9:	89 c2                	mov    %eax,%edx
  1004fb:	48 03 57 10          	add    0x10(%rdi),%rdx
  1004ff:	83 c0 08             	add    $0x8,%eax
  100502:	89 07                	mov    %eax,(%rdi)
  100504:	48 8b 12             	mov    (%rdx),%rdx
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  100507:	48 89 d0             	mov    %rdx,%rax
  10050a:	48 c1 f8 38          	sar    $0x38,%rax
            num = negative ? -x : x;
  10050e:	49 89 d0             	mov    %rdx,%r8
  100511:	49 f7 d8             	neg    %r8
  100514:	25 80 00 00 00       	and    $0x80,%eax
  100519:	4c 0f 44 c2          	cmove  %rdx,%r8
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  10051d:	0b 45 a8             	or     -0x58(%rbp),%eax
  100520:	83 c8 60             	or     $0x60,%eax
  100523:	89 45 a8             	mov    %eax,-0x58(%rbp)
        char* data = "";
  100526:	41 bc 60 0f 10 00    	mov    $0x100f60,%r12d
            break;
  10052c:	e9 35 01 00 00       	jmp    100666 <printer_vprintf+0x35a>
            long x = length ? va_arg(val, long) : va_arg(val, int);
  100531:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100535:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  100539:	48 8d 42 08          	lea    0x8(%rdx),%rax
  10053d:	48 89 41 08          	mov    %rax,0x8(%rcx)
  100541:	eb c1                	jmp    100504 <printer_vprintf+0x1f8>
  100543:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100547:	8b 07                	mov    (%rdi),%eax
  100549:	83 f8 2f             	cmp    $0x2f,%eax
  10054c:	77 10                	ja     10055e <printer_vprintf+0x252>
  10054e:	89 c2                	mov    %eax,%edx
  100550:	48 03 57 10          	add    0x10(%rdi),%rdx
  100554:	83 c0 08             	add    $0x8,%eax
  100557:	89 07                	mov    %eax,(%rdi)
  100559:	48 63 12             	movslq (%rdx),%rdx
  10055c:	eb a9                	jmp    100507 <printer_vprintf+0x1fb>
  10055e:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100562:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  100566:	48 8d 42 08          	lea    0x8(%rdx),%rax
  10056a:	48 89 47 08          	mov    %rax,0x8(%rdi)
  10056e:	eb e9                	jmp    100559 <printer_vprintf+0x24d>
        int base = 10;
  100570:	be 0a 00 00 00       	mov    $0xa,%esi
  100575:	eb 58                	jmp    1005cf <printer_vprintf+0x2c3>
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  100577:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  10057b:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  10057f:	48 8d 42 08          	lea    0x8(%rdx),%rax
  100583:	48 89 41 08          	mov    %rax,0x8(%rcx)
  100587:	eb 60                	jmp    1005e9 <printer_vprintf+0x2dd>
  100589:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  10058d:	8b 07                	mov    (%rdi),%eax
  10058f:	83 f8 2f             	cmp    $0x2f,%eax
  100592:	77 10                	ja     1005a4 <printer_vprintf+0x298>
  100594:	89 c2                	mov    %eax,%edx
  100596:	48 03 57 10          	add    0x10(%rdi),%rdx
  10059a:	83 c0 08             	add    $0x8,%eax
  10059d:	89 07                	mov    %eax,(%rdi)
  10059f:	44 8b 02             	mov    (%rdx),%r8d
  1005a2:	eb 48                	jmp    1005ec <printer_vprintf+0x2e0>
  1005a4:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1005a8:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1005ac:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1005b0:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1005b4:	eb e9                	jmp    10059f <printer_vprintf+0x293>
  1005b6:	41 89 f1             	mov    %esi,%r9d
        if (flags & FLAG_NUMERIC) {
  1005b9:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
    const char* digits = upper_digits;
  1005c0:	bf 40 0f 10 00       	mov    $0x100f40,%edi
  1005c5:	e9 e2 02 00 00       	jmp    1008ac <printer_vprintf+0x5a0>
            base = 16;
  1005ca:	be 10 00 00 00       	mov    $0x10,%esi
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  1005cf:	85 c9                	test   %ecx,%ecx
  1005d1:	74 b6                	je     100589 <printer_vprintf+0x27d>
  1005d3:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1005d7:	8b 01                	mov    (%rcx),%eax
  1005d9:	83 f8 2f             	cmp    $0x2f,%eax
  1005dc:	77 99                	ja     100577 <printer_vprintf+0x26b>
  1005de:	89 c2                	mov    %eax,%edx
  1005e0:	48 03 51 10          	add    0x10(%rcx),%rdx
  1005e4:	83 c0 08             	add    $0x8,%eax
  1005e7:	89 01                	mov    %eax,(%rcx)
  1005e9:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_NUMERIC;
  1005ec:	83 4d a8 20          	orl    $0x20,-0x58(%rbp)
    if (base < 0) {
  1005f0:	85 f6                	test   %esi,%esi
  1005f2:	79 c2                	jns    1005b6 <printer_vprintf+0x2aa>
        base = -base;
  1005f4:	41 89 f1             	mov    %esi,%r9d
  1005f7:	f7 de                	neg    %esi
  1005f9:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
        digits = lower_digits;
  100600:	bf 20 0f 10 00       	mov    $0x100f20,%edi
  100605:	e9 a2 02 00 00       	jmp    1008ac <printer_vprintf+0x5a0>
            num = (uintptr_t) va_arg(val, void*);
  10060a:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  10060e:	8b 07                	mov    (%rdi),%eax
  100610:	83 f8 2f             	cmp    $0x2f,%eax
  100613:	77 1c                	ja     100631 <printer_vprintf+0x325>
  100615:	89 c2                	mov    %eax,%edx
  100617:	48 03 57 10          	add    0x10(%rdi),%rdx
  10061b:	83 c0 08             	add    $0x8,%eax
  10061e:	89 07                	mov    %eax,(%rdi)
  100620:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  100623:	81 4d a8 21 01 00 00 	orl    $0x121,-0x58(%rbp)
            base = -16;
  10062a:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
  10062f:	eb c3                	jmp    1005f4 <printer_vprintf+0x2e8>
            num = (uintptr_t) va_arg(val, void*);
  100631:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100635:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  100639:	48 8d 42 08          	lea    0x8(%rdx),%rax
  10063d:	48 89 41 08          	mov    %rax,0x8(%rcx)
  100641:	eb dd                	jmp    100620 <printer_vprintf+0x314>
            data = va_arg(val, char*);
  100643:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100647:	8b 01                	mov    (%rcx),%eax
  100649:	83 f8 2f             	cmp    $0x2f,%eax
  10064c:	0f 87 a5 01 00 00    	ja     1007f7 <printer_vprintf+0x4eb>
  100652:	89 c2                	mov    %eax,%edx
  100654:	48 03 51 10          	add    0x10(%rcx),%rdx
  100658:	83 c0 08             	add    $0x8,%eax
  10065b:	89 01                	mov    %eax,(%rcx)
  10065d:	4c 8b 22             	mov    (%rdx),%r12
        unsigned long num = 0;
  100660:	41 b8 00 00 00 00    	mov    $0x0,%r8d
        if (flags & FLAG_NUMERIC) {
  100666:	8b 45 a8             	mov    -0x58(%rbp),%eax
  100669:	83 e0 20             	and    $0x20,%eax
  10066c:	89 45 8c             	mov    %eax,-0x74(%rbp)
  10066f:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
  100675:	0f 85 21 02 00 00    	jne    10089c <printer_vprintf+0x590>
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  10067b:	8b 45 a8             	mov    -0x58(%rbp),%eax
  10067e:	89 45 88             	mov    %eax,-0x78(%rbp)
  100681:	83 e0 60             	and    $0x60,%eax
  100684:	83 f8 60             	cmp    $0x60,%eax
  100687:	0f 84 54 02 00 00    	je     1008e1 <printer_vprintf+0x5d5>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  10068d:	8b 45 a8             	mov    -0x58(%rbp),%eax
  100690:	83 e0 21             	and    $0x21,%eax
        const char* prefix = "";
  100693:	48 c7 45 a0 60 0f 10 	movq   $0x100f60,-0x60(%rbp)
  10069a:	00 
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  10069b:	83 f8 21             	cmp    $0x21,%eax
  10069e:	0f 84 79 02 00 00    	je     10091d <printer_vprintf+0x611>
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  1006a4:	8b 7d 9c             	mov    -0x64(%rbp),%edi
  1006a7:	89 f8                	mov    %edi,%eax
  1006a9:	f7 d0                	not    %eax
  1006ab:	c1 e8 1f             	shr    $0x1f,%eax
  1006ae:	89 45 84             	mov    %eax,-0x7c(%rbp)
  1006b1:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
  1006b5:	0f 85 9e 02 00 00    	jne    100959 <printer_vprintf+0x64d>
  1006bb:	84 c0                	test   %al,%al
  1006bd:	0f 84 96 02 00 00    	je     100959 <printer_vprintf+0x64d>
            len = strnlen(data, precision);
  1006c3:	48 63 f7             	movslq %edi,%rsi
  1006c6:	4c 89 e7             	mov    %r12,%rdi
  1006c9:	e8 63 fb ff ff       	call   100231 <strnlen>
  1006ce:	89 45 98             	mov    %eax,-0x68(%rbp)
                   && !(flags & FLAG_LEFTJUSTIFY)
  1006d1:	8b 45 88             	mov    -0x78(%rbp),%eax
  1006d4:	83 e0 26             	and    $0x26,%eax
            zeros = 0;
  1006d7:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  1006de:	83 f8 22             	cmp    $0x22,%eax
  1006e1:	0f 84 aa 02 00 00    	je     100991 <printer_vprintf+0x685>
        width -= len + zeros + strlen(prefix);
  1006e7:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  1006eb:	e8 26 fb ff ff       	call   100216 <strlen>
  1006f0:	8b 55 9c             	mov    -0x64(%rbp),%edx
  1006f3:	03 55 98             	add    -0x68(%rbp),%edx
  1006f6:	44 89 e9             	mov    %r13d,%ecx
  1006f9:	29 d1                	sub    %edx,%ecx
  1006fb:	29 c1                	sub    %eax,%ecx
  1006fd:	89 4d 8c             	mov    %ecx,-0x74(%rbp)
  100700:	41 89 cd             	mov    %ecx,%r13d
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100703:	f6 45 a8 04          	testb  $0x4,-0x58(%rbp)
  100707:	75 2d                	jne    100736 <printer_vprintf+0x42a>
  100709:	85 c9                	test   %ecx,%ecx
  10070b:	7e 29                	jle    100736 <printer_vprintf+0x42a>
            p->putc(p, ' ', color);
  10070d:	44 89 fa             	mov    %r15d,%edx
  100710:	be 20 00 00 00       	mov    $0x20,%esi
  100715:	4c 89 f7             	mov    %r14,%rdi
  100718:	41 ff 16             	call   *(%r14)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  10071b:	41 83 ed 01          	sub    $0x1,%r13d
  10071f:	45 85 ed             	test   %r13d,%r13d
  100722:	7f e9                	jg     10070d <printer_vprintf+0x401>
  100724:	8b 7d 8c             	mov    -0x74(%rbp),%edi
  100727:	85 ff                	test   %edi,%edi
  100729:	b8 01 00 00 00       	mov    $0x1,%eax
  10072e:	0f 4f c7             	cmovg  %edi,%eax
  100731:	29 c7                	sub    %eax,%edi
  100733:	41 89 fd             	mov    %edi,%r13d
        for (; *prefix; ++prefix) {
  100736:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  10073a:	0f b6 07             	movzbl (%rdi),%eax
  10073d:	84 c0                	test   %al,%al
  10073f:	74 22                	je     100763 <printer_vprintf+0x457>
  100741:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  100745:	48 89 fb             	mov    %rdi,%rbx
            p->putc(p, *prefix, color);
  100748:	0f b6 f0             	movzbl %al,%esi
  10074b:	44 89 fa             	mov    %r15d,%edx
  10074e:	4c 89 f7             	mov    %r14,%rdi
  100751:	41 ff 16             	call   *(%r14)
        for (; *prefix; ++prefix) {
  100754:	48 83 c3 01          	add    $0x1,%rbx
  100758:	0f b6 03             	movzbl (%rbx),%eax
  10075b:	84 c0                	test   %al,%al
  10075d:	75 e9                	jne    100748 <printer_vprintf+0x43c>
  10075f:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; zeros > 0; --zeros) {
  100763:	8b 45 9c             	mov    -0x64(%rbp),%eax
  100766:	85 c0                	test   %eax,%eax
  100768:	7e 1d                	jle    100787 <printer_vprintf+0x47b>
  10076a:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  10076e:	89 c3                	mov    %eax,%ebx
            p->putc(p, '0', color);
  100770:	44 89 fa             	mov    %r15d,%edx
  100773:	be 30 00 00 00       	mov    $0x30,%esi
  100778:	4c 89 f7             	mov    %r14,%rdi
  10077b:	41 ff 16             	call   *(%r14)
        for (; zeros > 0; --zeros) {
  10077e:	83 eb 01             	sub    $0x1,%ebx
  100781:	75 ed                	jne    100770 <printer_vprintf+0x464>
  100783:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; len > 0; ++data, --len) {
  100787:	8b 45 98             	mov    -0x68(%rbp),%eax
  10078a:	85 c0                	test   %eax,%eax
  10078c:	7e 27                	jle    1007b5 <printer_vprintf+0x4a9>
  10078e:	89 c0                	mov    %eax,%eax
  100790:	4c 01 e0             	add    %r12,%rax
  100793:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  100797:	48 89 c3             	mov    %rax,%rbx
            p->putc(p, *data, color);
  10079a:	41 0f b6 34 24       	movzbl (%r12),%esi
  10079f:	44 89 fa             	mov    %r15d,%edx
  1007a2:	4c 89 f7             	mov    %r14,%rdi
  1007a5:	41 ff 16             	call   *(%r14)
        for (; len > 0; ++data, --len) {
  1007a8:	49 83 c4 01          	add    $0x1,%r12
  1007ac:	49 39 dc             	cmp    %rbx,%r12
  1007af:	75 e9                	jne    10079a <printer_vprintf+0x48e>
  1007b1:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; width > 0; --width) {
  1007b5:	45 85 ed             	test   %r13d,%r13d
  1007b8:	7e 14                	jle    1007ce <printer_vprintf+0x4c2>
            p->putc(p, ' ', color);
  1007ba:	44 89 fa             	mov    %r15d,%edx
  1007bd:	be 20 00 00 00       	mov    $0x20,%esi
  1007c2:	4c 89 f7             	mov    %r14,%rdi
  1007c5:	41 ff 16             	call   *(%r14)
        for (; width > 0; --width) {
  1007c8:	41 83 ed 01          	sub    $0x1,%r13d
  1007cc:	75 ec                	jne    1007ba <printer_vprintf+0x4ae>
    for (; *format; ++format) {
  1007ce:	4c 8d 63 01          	lea    0x1(%rbx),%r12
  1007d2:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
  1007d6:	84 c0                	test   %al,%al
  1007d8:	0f 84 fe 01 00 00    	je     1009dc <printer_vprintf+0x6d0>
        if (*format != '%') {
  1007de:	3c 25                	cmp    $0x25,%al
  1007e0:	0f 84 54 fb ff ff    	je     10033a <printer_vprintf+0x2e>
            p->putc(p, *format, color);
  1007e6:	0f b6 f0             	movzbl %al,%esi
  1007e9:	44 89 fa             	mov    %r15d,%edx
  1007ec:	4c 89 f7             	mov    %r14,%rdi
  1007ef:	41 ff 16             	call   *(%r14)
            continue;
  1007f2:	4c 89 e3             	mov    %r12,%rbx
  1007f5:	eb d7                	jmp    1007ce <printer_vprintf+0x4c2>
            data = va_arg(val, char*);
  1007f7:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1007fb:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  1007ff:	48 8d 42 08          	lea    0x8(%rdx),%rax
  100803:	48 89 47 08          	mov    %rax,0x8(%rdi)
  100807:	e9 51 fe ff ff       	jmp    10065d <printer_vprintf+0x351>
            color = va_arg(val, int);
  10080c:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100810:	8b 07                	mov    (%rdi),%eax
  100812:	83 f8 2f             	cmp    $0x2f,%eax
  100815:	77 10                	ja     100827 <printer_vprintf+0x51b>
  100817:	89 c2                	mov    %eax,%edx
  100819:	48 03 57 10          	add    0x10(%rdi),%rdx
  10081d:	83 c0 08             	add    $0x8,%eax
  100820:	89 07                	mov    %eax,(%rdi)
  100822:	44 8b 3a             	mov    (%rdx),%r15d
            goto done;
  100825:	eb a7                	jmp    1007ce <printer_vprintf+0x4c2>
            color = va_arg(val, int);
  100827:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  10082b:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  10082f:	48 8d 42 08          	lea    0x8(%rdx),%rax
  100833:	48 89 41 08          	mov    %rax,0x8(%rcx)
  100837:	eb e9                	jmp    100822 <printer_vprintf+0x516>
            numbuf[0] = va_arg(val, int);
  100839:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  10083d:	8b 01                	mov    (%rcx),%eax
  10083f:	83 f8 2f             	cmp    $0x2f,%eax
  100842:	77 23                	ja     100867 <printer_vprintf+0x55b>
  100844:	89 c2                	mov    %eax,%edx
  100846:	48 03 51 10          	add    0x10(%rcx),%rdx
  10084a:	83 c0 08             	add    $0x8,%eax
  10084d:	89 01                	mov    %eax,(%rcx)
  10084f:	8b 02                	mov    (%rdx),%eax
  100851:	88 45 b8             	mov    %al,-0x48(%rbp)
            numbuf[1] = '\0';
  100854:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
  100858:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  10085c:	41 b8 00 00 00 00    	mov    $0x0,%r8d
            break;
  100862:	e9 ff fd ff ff       	jmp    100666 <printer_vprintf+0x35a>
            numbuf[0] = va_arg(val, int);
  100867:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  10086b:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  10086f:	48 8d 42 08          	lea    0x8(%rdx),%rax
  100873:	48 89 47 08          	mov    %rax,0x8(%rdi)
  100877:	eb d6                	jmp    10084f <printer_vprintf+0x543>
            numbuf[0] = (*format ? *format : '%');
  100879:	84 d2                	test   %dl,%dl
  10087b:	0f 85 39 01 00 00    	jne    1009ba <printer_vprintf+0x6ae>
  100881:	c6 45 b8 25          	movb   $0x25,-0x48(%rbp)
            numbuf[1] = '\0';
  100885:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
                format--;
  100889:	48 83 eb 01          	sub    $0x1,%rbx
            data = numbuf;
  10088d:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  100891:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  100897:	e9 ca fd ff ff       	jmp    100666 <printer_vprintf+0x35a>
        if (flags & FLAG_NUMERIC) {
  10089c:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
    const char* digits = upper_digits;
  1008a2:	bf 40 0f 10 00       	mov    $0x100f40,%edi
        if (flags & FLAG_NUMERIC) {
  1008a7:	be 0a 00 00 00       	mov    $0xa,%esi
    *--numbuf_end = '\0';
  1008ac:	c6 45 cf 00          	movb   $0x0,-0x31(%rbp)
  1008b0:	4c 89 c1             	mov    %r8,%rcx
  1008b3:	4c 8d 65 cf          	lea    -0x31(%rbp),%r12
        *--numbuf_end = digits[val % base];
  1008b7:	48 63 f6             	movslq %esi,%rsi
  1008ba:	49 83 ec 01          	sub    $0x1,%r12
  1008be:	48 89 c8             	mov    %rcx,%rax
  1008c1:	ba 00 00 00 00       	mov    $0x0,%edx
  1008c6:	48 f7 f6             	div    %rsi
  1008c9:	0f b6 14 17          	movzbl (%rdi,%rdx,1),%edx
  1008cd:	41 88 14 24          	mov    %dl,(%r12)
        val /= base;
  1008d1:	48 89 ca             	mov    %rcx,%rdx
  1008d4:	48 89 c1             	mov    %rax,%rcx
    } while (val != 0);
  1008d7:	48 39 d6             	cmp    %rdx,%rsi
  1008da:	76 de                	jbe    1008ba <printer_vprintf+0x5ae>
  1008dc:	e9 9a fd ff ff       	jmp    10067b <printer_vprintf+0x36f>
                prefix = "-";
  1008e1:	48 c7 45 a0 51 0d 10 	movq   $0x100d51,-0x60(%rbp)
  1008e8:	00 
            if (flags & FLAG_NEGATIVE) {
  1008e9:	8b 45 a8             	mov    -0x58(%rbp),%eax
  1008ec:	a8 80                	test   $0x80,%al
  1008ee:	0f 85 b0 fd ff ff    	jne    1006a4 <printer_vprintf+0x398>
                prefix = "+";
  1008f4:	48 c7 45 a0 4c 0d 10 	movq   $0x100d4c,-0x60(%rbp)
  1008fb:	00 
            } else if (flags & FLAG_PLUSPOSITIVE) {
  1008fc:	a8 10                	test   $0x10,%al
  1008fe:	0f 85 a0 fd ff ff    	jne    1006a4 <printer_vprintf+0x398>
                prefix = " ";
  100904:	a8 08                	test   $0x8,%al
  100906:	ba 60 0f 10 00       	mov    $0x100f60,%edx
  10090b:	b8 5d 0f 10 00       	mov    $0x100f5d,%eax
  100910:	48 0f 44 c2          	cmove  %rdx,%rax
  100914:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  100918:	e9 87 fd ff ff       	jmp    1006a4 <printer_vprintf+0x398>
                   && (base == 16 || base == -16)
  10091d:	41 8d 41 10          	lea    0x10(%r9),%eax
  100921:	a9 df ff ff ff       	test   $0xffffffdf,%eax
  100926:	0f 85 78 fd ff ff    	jne    1006a4 <printer_vprintf+0x398>
                   && (num || (flags & FLAG_ALT2))) {
  10092c:	4d 85 c0             	test   %r8,%r8
  10092f:	75 0d                	jne    10093e <printer_vprintf+0x632>
  100931:	f7 45 a8 00 01 00 00 	testl  $0x100,-0x58(%rbp)
  100938:	0f 84 66 fd ff ff    	je     1006a4 <printer_vprintf+0x398>
            prefix = (base == -16 ? "0x" : "0X");
  10093e:	41 83 f9 f0          	cmp    $0xfffffff0,%r9d
  100942:	ba 53 0d 10 00       	mov    $0x100d53,%edx
  100947:	b8 4e 0d 10 00       	mov    $0x100d4e,%eax
  10094c:	48 0f 44 c2          	cmove  %rdx,%rax
  100950:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  100954:	e9 4b fd ff ff       	jmp    1006a4 <printer_vprintf+0x398>
            len = strlen(data);
  100959:	4c 89 e7             	mov    %r12,%rdi
  10095c:	e8 b5 f8 ff ff       	call   100216 <strlen>
  100961:	89 45 98             	mov    %eax,-0x68(%rbp)
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  100964:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
  100968:	0f 84 63 fd ff ff    	je     1006d1 <printer_vprintf+0x3c5>
  10096e:	80 7d 84 00          	cmpb   $0x0,-0x7c(%rbp)
  100972:	0f 84 59 fd ff ff    	je     1006d1 <printer_vprintf+0x3c5>
            zeros = precision > len ? precision - len : 0;
  100978:	8b 4d 9c             	mov    -0x64(%rbp),%ecx
  10097b:	89 ca                	mov    %ecx,%edx
  10097d:	29 c2                	sub    %eax,%edx
  10097f:	39 c1                	cmp    %eax,%ecx
  100981:	b8 00 00 00 00       	mov    $0x0,%eax
  100986:	0f 4e d0             	cmovle %eax,%edx
  100989:	89 55 9c             	mov    %edx,-0x64(%rbp)
  10098c:	e9 56 fd ff ff       	jmp    1006e7 <printer_vprintf+0x3db>
                   && len + (int) strlen(prefix) < width) {
  100991:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  100995:	e8 7c f8 ff ff       	call   100216 <strlen>
  10099a:	8b 7d 98             	mov    -0x68(%rbp),%edi
  10099d:	8d 14 07             	lea    (%rdi,%rax,1),%edx
            zeros = width - len - strlen(prefix);
  1009a0:	44 89 e9             	mov    %r13d,%ecx
  1009a3:	29 f9                	sub    %edi,%ecx
  1009a5:	29 c1                	sub    %eax,%ecx
  1009a7:	44 39 ea             	cmp    %r13d,%edx
  1009aa:	b8 00 00 00 00       	mov    $0x0,%eax
  1009af:	0f 4d c8             	cmovge %eax,%ecx
  1009b2:	89 4d 9c             	mov    %ecx,-0x64(%rbp)
  1009b5:	e9 2d fd ff ff       	jmp    1006e7 <printer_vprintf+0x3db>
            numbuf[0] = (*format ? *format : '%');
  1009ba:	88 55 b8             	mov    %dl,-0x48(%rbp)
            numbuf[1] = '\0';
  1009bd:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
  1009c1:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  1009c5:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  1009cb:	e9 96 fc ff ff       	jmp    100666 <printer_vprintf+0x35a>
        int flags = 0;
  1009d0:	c7 45 a8 00 00 00 00 	movl   $0x0,-0x58(%rbp)
  1009d7:	e9 b0 f9 ff ff       	jmp    10038c <printer_vprintf+0x80>
}
  1009dc:	48 83 c4 58          	add    $0x58,%rsp
  1009e0:	5b                   	pop    %rbx
  1009e1:	41 5c                	pop    %r12
  1009e3:	41 5d                	pop    %r13
  1009e5:	41 5e                	pop    %r14
  1009e7:	41 5f                	pop    %r15
  1009e9:	5d                   	pop    %rbp
  1009ea:	c3                   	ret    

00000000001009eb <console_vprintf>:
int console_vprintf(int cpos, int color, const char* format, va_list val) {
  1009eb:	55                   	push   %rbp
  1009ec:	48 89 e5             	mov    %rsp,%rbp
  1009ef:	48 83 ec 10          	sub    $0x10,%rsp
    cp.p.putc = console_putc;
  1009f3:	48 c7 45 f0 f6 00 10 	movq   $0x1000f6,-0x10(%rbp)
  1009fa:	00 
        cpos = 0;
  1009fb:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
  100a01:	b8 00 00 00 00       	mov    $0x0,%eax
  100a06:	0f 43 f8             	cmovae %eax,%edi
    cp.cursor = console + cpos;
  100a09:	48 63 ff             	movslq %edi,%rdi
  100a0c:	48 8d 84 3f 00 80 0b 	lea    0xb8000(%rdi,%rdi,1),%rax
  100a13:	00 
  100a14:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  100a18:	48 8d 7d f0          	lea    -0x10(%rbp),%rdi
  100a1c:	e8 eb f8 ff ff       	call   10030c <printer_vprintf>
    return cp.cursor - console;
  100a21:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100a25:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  100a2b:	48 d1 f8             	sar    %rax
}
  100a2e:	c9                   	leave  
  100a2f:	c3                   	ret    

0000000000100a30 <console_printf>:
int console_printf(int cpos, int color, const char* format, ...) {
  100a30:	55                   	push   %rbp
  100a31:	48 89 e5             	mov    %rsp,%rbp
  100a34:	48 83 ec 50          	sub    $0x50,%rsp
  100a38:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  100a3c:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  100a40:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_start(val, format);
  100a44:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  100a4b:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100a4f:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100a53:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  100a57:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  100a5b:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  100a5f:	e8 87 ff ff ff       	call   1009eb <console_vprintf>
}
  100a64:	c9                   	leave  
  100a65:	c3                   	ret    

0000000000100a66 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  100a66:	55                   	push   %rbp
  100a67:	48 89 e5             	mov    %rsp,%rbp
  100a6a:	53                   	push   %rbx
  100a6b:	48 83 ec 28          	sub    $0x28,%rsp
  100a6f:	48 89 fb             	mov    %rdi,%rbx
    string_printer sp;
    sp.p.putc = string_putc;
  100a72:	48 c7 45 d8 7c 01 10 	movq   $0x10017c,-0x28(%rbp)
  100a79:	00 
    sp.s = s;
  100a7a:	48 89 7d e0          	mov    %rdi,-0x20(%rbp)
    if (size) {
  100a7e:	48 85 f6             	test   %rsi,%rsi
  100a81:	75 0b                	jne    100a8e <vsnprintf+0x28>
        sp.end = s + size - 1;
        printer_vprintf(&sp.p, 0, format, val);
        *sp.s = 0;
    }
    return sp.s - s;
  100a83:	8b 45 e0             	mov    -0x20(%rbp),%eax
  100a86:	29 d8                	sub    %ebx,%eax
}
  100a88:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  100a8c:	c9                   	leave  
  100a8d:	c3                   	ret    
        sp.end = s + size - 1;
  100a8e:	48 8d 44 37 ff       	lea    -0x1(%rdi,%rsi,1),%rax
  100a93:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  100a97:	be 00 00 00 00       	mov    $0x0,%esi
  100a9c:	48 8d 7d d8          	lea    -0x28(%rbp),%rdi
  100aa0:	e8 67 f8 ff ff       	call   10030c <printer_vprintf>
        *sp.s = 0;
  100aa5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100aa9:	c6 00 00             	movb   $0x0,(%rax)
  100aac:	eb d5                	jmp    100a83 <vsnprintf+0x1d>

0000000000100aae <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  100aae:	55                   	push   %rbp
  100aaf:	48 89 e5             	mov    %rsp,%rbp
  100ab2:	48 83 ec 50          	sub    $0x50,%rsp
  100ab6:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  100aba:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  100abe:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  100ac2:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  100ac9:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100acd:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100ad1:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  100ad5:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    int n = vsnprintf(s, size, format, val);
  100ad9:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  100add:	e8 84 ff ff ff       	call   100a66 <vsnprintf>
    va_end(val);
    return n;
}
  100ae2:	c9                   	leave  
  100ae3:	c3                   	ret    

0000000000100ae4 <console_clear>:

// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  100ae4:	b8 00 80 0b 00       	mov    $0xb8000,%eax
  100ae9:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
        console[i] = ' ' | 0x0700;
  100aee:	66 c7 00 20 07       	movw   $0x720,(%rax)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  100af3:	48 83 c0 02          	add    $0x2,%rax
  100af7:	48 39 d0             	cmp    %rdx,%rax
  100afa:	75 f2                	jne    100aee <console_clear+0xa>
    }
    cursorpos = 0;
  100afc:	c7 05 f6 84 fb ff 00 	movl   $0x0,-0x47b0a(%rip)        # b8ffc <cursorpos>
  100b03:	00 00 00 
}
  100b06:	c3                   	ret    

0000000000100b07 <app_printf>:
#include "process.h"

// app_printf
//     A version of console_printf that picks a sensible color by process ID.

void app_printf(int colorid, const char* format, ...) {
  100b07:	55                   	push   %rbp
  100b08:	48 89 e5             	mov    %rsp,%rbp
  100b0b:	48 83 ec 50          	sub    $0x50,%rsp
  100b0f:	49 89 f2             	mov    %rsi,%r10
  100b12:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  100b16:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  100b1a:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  100b1e:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    int color;
    if (colorid < 0) {
        color = 0x0700;
  100b22:	be 00 07 00 00       	mov    $0x700,%esi
    if (colorid < 0) {
  100b27:	85 ff                	test   %edi,%edi
  100b29:	78 2e                	js     100b59 <app_printf+0x52>
    } else {
        static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
        color = col[colorid % sizeof(col)] << 8;
  100b2b:	48 63 ff             	movslq %edi,%rdi
  100b2e:	48 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rdx
  100b35:	cc cc cc 
  100b38:	48 89 f8             	mov    %rdi,%rax
  100b3b:	48 f7 e2             	mul    %rdx
  100b3e:	48 89 d0             	mov    %rdx,%rax
  100b41:	48 c1 e8 02          	shr    $0x2,%rax
  100b45:	48 83 e2 fc          	and    $0xfffffffffffffffc,%rdx
  100b49:	48 01 c2             	add    %rax,%rdx
  100b4c:	48 29 d7             	sub    %rdx,%rdi
  100b4f:	0f b6 b7 8d 0f 10 00 	movzbl 0x100f8d(%rdi),%esi
  100b56:	c1 e6 08             	shl    $0x8,%esi
    }

    va_list val;
    va_start(val, format);
  100b59:	c7 45 b8 10 00 00 00 	movl   $0x10,-0x48(%rbp)
  100b60:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100b64:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100b68:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  100b6c:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cursorpos = console_vprintf(cursorpos, color, format, val);
  100b70:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  100b74:	4c 89 d2             	mov    %r10,%rdx
  100b77:	8b 3d 7f 84 fb ff    	mov    -0x47b81(%rip),%edi        # b8ffc <cursorpos>
  100b7d:	e8 69 fe ff ff       	call   1009eb <console_vprintf>
    va_end(val);

    if (CROW(cursorpos) >= 23) {
        cursorpos = CPOS(0, 0);
  100b82:	3d 30 07 00 00       	cmp    $0x730,%eax
  100b87:	ba 00 00 00 00       	mov    $0x0,%edx
  100b8c:	0f 4d c2             	cmovge %edx,%eax
  100b8f:	89 05 67 84 fb ff    	mov    %eax,-0x47b99(%rip)        # b8ffc <cursorpos>
    }
}
  100b95:	c9                   	leave  
  100b96:	c3                   	ret    

0000000000100b97 <panic>:


// panic, assert_fail
//     Call the INT_SYS_PANIC system call so the kernel loops until Control-C.

void panic(const char* format, ...) {
  100b97:	55                   	push   %rbp
  100b98:	48 89 e5             	mov    %rsp,%rbp
  100b9b:	53                   	push   %rbx
  100b9c:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  100ba3:	48 89 fb             	mov    %rdi,%rbx
  100ba6:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
  100baa:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  100bae:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
  100bb2:	4c 89 45 e0          	mov    %r8,-0x20(%rbp)
  100bb6:	4c 89 4d e8          	mov    %r9,-0x18(%rbp)
    va_list val;
    va_start(val, format);
  100bba:	c7 45 a8 08 00 00 00 	movl   $0x8,-0x58(%rbp)
  100bc1:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100bc5:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
  100bc9:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  100bcd:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    char buf[160];
    memcpy(buf, "PANIC: ", 7);
  100bd1:	ba 07 00 00 00       	mov    $0x7,%edx
  100bd6:	be 57 0f 10 00       	mov    $0x100f57,%esi
  100bdb:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  100be2:	e8 ab f5 ff ff       	call   100192 <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  100be7:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  100beb:	48 89 da             	mov    %rbx,%rdx
  100bee:	be 99 00 00 00       	mov    $0x99,%esi
  100bf3:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  100bfa:	e8 67 fe ff ff       	call   100a66 <vsnprintf>
  100bff:	8d 50 07             	lea    0x7(%rax),%edx
    va_end(val);
    if (len > 0 && buf[len - 1] != '\n') {
  100c02:	85 d2                	test   %edx,%edx
  100c04:	7e 0f                	jle    100c15 <panic+0x7e>
  100c06:	83 c0 06             	add    $0x6,%eax
  100c09:	48 98                	cltq   
  100c0b:	80 bc 05 08 ff ff ff 	cmpb   $0xa,-0xf8(%rbp,%rax,1)
  100c12:	0a 
  100c13:	75 29                	jne    100c3e <panic+0xa7>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
    }
    (void) console_printf(CPOS(23, 0), 0xC000, "%s", buf);
  100c15:	48 8d 8d 08 ff ff ff 	lea    -0xf8(%rbp),%rcx
  100c1c:	ba 61 0f 10 00       	mov    $0x100f61,%edx
  100c21:	be 00 c0 00 00       	mov    $0xc000,%esi
  100c26:	bf 30 07 00 00       	mov    $0x730,%edi
  100c2b:	b8 00 00 00 00       	mov    $0x0,%eax
  100c30:	e8 fb fd ff ff       	call   100a30 <console_printf>
    asm volatile ("int %0" : /* no result */
  100c35:	bf 00 00 00 00       	mov    $0x0,%edi
  100c3a:	cd 30                	int    $0x30
 loop: goto loop;
  100c3c:	eb fe                	jmp    100c3c <panic+0xa5>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
  100c3e:	48 63 c2             	movslq %edx,%rax
  100c41:	81 fa 9f 00 00 00    	cmp    $0x9f,%edx
  100c47:	0f 94 c2             	sete   %dl
  100c4a:	0f b6 d2             	movzbl %dl,%edx
  100c4d:	48 29 d0             	sub    %rdx,%rax
  100c50:	48 8d bc 05 08 ff ff 	lea    -0xf8(%rbp,%rax,1),%rdi
  100c57:	ff 
  100c58:	be 5f 0f 10 00       	mov    $0x100f5f,%esi
  100c5d:	e8 f2 f5 ff ff       	call   100254 <strcpy>
  100c62:	eb b1                	jmp    100c15 <panic+0x7e>

0000000000100c64 <assert_fail>:
    sys_panic(NULL);
 spinloop: goto spinloop;       // should never get here
}

void assert_fail(const char* file, int line, const char* msg) {
  100c64:	55                   	push   %rbp
  100c65:	48 89 e5             	mov    %rsp,%rbp
  100c68:	48 89 f9             	mov    %rdi,%rcx
  100c6b:	41 89 f0             	mov    %esi,%r8d
  100c6e:	49 89 d1             	mov    %rdx,%r9
    (void) console_printf(CPOS(23, 0), 0xC000,
  100c71:	ba 68 0f 10 00       	mov    $0x100f68,%edx
  100c76:	be 00 c0 00 00       	mov    $0xc000,%esi
  100c7b:	bf 30 07 00 00       	mov    $0x730,%edi
  100c80:	b8 00 00 00 00       	mov    $0x0,%eax
  100c85:	e8 a6 fd ff ff       	call   100a30 <console_printf>
    asm volatile ("int %0" : /* no result */
  100c8a:	bf 00 00 00 00       	mov    $0x0,%edi
  100c8f:	cd 30                	int    $0x30
 loop: goto loop;
  100c91:	eb fe                	jmp    100c91 <assert_fail+0x2d>
