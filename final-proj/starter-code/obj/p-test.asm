
obj/p-test.full:     file format elf64-x86-64


Disassembly of section .text:

0000000000100000 <process_main>:
uint8_t *heap_bottom;
uint8_t *stack_bottom;



void process_main(void) {
  100000:	55                   	push   %rbp
  100001:	48 89 e5             	mov    %rsp,%rbp
  100004:	41 54                	push   %r12
  100006:	53                   	push   %rbx

// getpid
//    Return current process ID.
static inline pid_t getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  100007:	cd 31                	int    $0x31
  100009:	89 c7                	mov    %eax,%edi
    pid_t p = getpid();
    srand(p);
  10000b:	e8 2d 04 00 00       	call   10043d <srand>
    heap_bottom = heap_top = ROUNDUP((uint8_t*) end, PAGESIZE);
  100010:	b8 57 40 10 00       	mov    $0x104057,%eax
  100015:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  10001b:	48 89 05 ee 1f 00 00 	mov    %rax,0x1fee(%rip)        # 102010 <heap_top>
  100022:	48 89 05 df 1f 00 00 	mov    %rax,0x1fdf(%rip)        # 102008 <heap_bottom>
    return rbp;
}

static inline uintptr_t read_rsp(void) {
    uintptr_t rsp;
    asm volatile("movq %%rsp,%0" : "=r" (rsp));
  100029:	48 89 e0             	mov    %rsp,%rax
    stack_bottom = ROUNDDOWN((uint8_t*) read_rsp() - 1, PAGESIZE);
  10002c:	48 83 e8 01          	sub    $0x1,%rax
  100030:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
  100036:	48 89 05 c3 1f 00 00 	mov    %rax,0x1fc3(%rip)        # 102000 <stack_bottom>

    void *ptr;

    /* Single elements on heap of varying sizes */
    for(int i = 0; i < 512; ++i) {
        ptr = malloc(i);
  10003d:	bf 00 00 00 00       	mov    $0x0,%edi
  100042:	e8 be 0e 00 00       	call   100f05 <malloc>
  100047:	48 89 c7             	mov    %rax,%rdi
  10004a:	bb 01 00 00 00       	mov    $0x1,%ebx
        assert(ptr != NULL || i == 0);
        assert((uintptr_t)ptr % 8 == 0);
  10004f:	49 89 fc             	mov    %rdi,%r12
  100052:	41 83 e4 07          	and    $0x7,%r12d
  100056:	75 40                	jne    100098 <process_main+0x98>
        free(ptr);
  100058:	e8 4d 0f 00 00       	call   100faa <free>
    for(int i = 0; i < 512; ++i) {
  10005d:	48 81 fb 00 02 00 00 	cmp    $0x200,%rbx
  100064:	74 46                	je     1000ac <process_main+0xac>
        ptr = malloc(i);
  100066:	48 89 df             	mov    %rbx,%rdi
  100069:	e8 97 0e 00 00       	call   100f05 <malloc>
  10006e:	48 89 c7             	mov    %rax,%rdi
        assert(ptr != NULL || i == 0);
  100071:	48 85 c0             	test   %rax,%rax
  100074:	0f 94 c2             	sete   %dl
  100077:	85 db                	test   %ebx,%ebx
  100079:	0f 95 c0             	setne  %al
  10007c:	48 83 c3 01          	add    $0x1,%rbx
  100080:	84 c2                	test   %al,%dl
  100082:	74 cb                	je     10004f <process_main+0x4f>
  100084:	ba 00 14 10 00       	mov    $0x101400,%edx
  100089:	be 1b 00 00 00       	mov    $0x1b,%esi
  10008e:	bf 16 14 10 00       	mov    $0x101416,%edi
  100093:	e8 2d 13 00 00       	call   1013c5 <assert_fail>
        assert((uintptr_t)ptr % 8 == 0);
  100098:	ba 1f 14 10 00       	mov    $0x10141f,%edx
  10009d:	be 1c 00 00 00       	mov    $0x1c,%esi
  1000a2:	bf 16 14 10 00       	mov    $0x101416,%edi
  1000a7:	e8 19 13 00 00       	call   1013c5 <assert_fail>

    /* Many things allocated at the same time */
    static char *ptrs[512];

    for(size_t i = 0; i < sizeof(ptrs)/sizeof(ptrs[0]); ++i) {
        ptrs[i] = (char *) malloc(i+1);
  1000ac:	49 83 c4 01          	add    $0x1,%r12
  1000b0:	4c 89 e7             	mov    %r12,%rdi
  1000b3:	e8 4d 0e 00 00       	call   100f05 <malloc>
  1000b8:	48 89 c3             	mov    %rax,%rbx
  1000bb:	4a 89 04 e5 18 20 10 	mov    %rax,0x102018(,%r12,8)
  1000c2:	00 
        assert(ptrs[i] != NULL);
  1000c3:	48 85 c0             	test   %rax,%rax
  1000c6:	74 7a                	je     100142 <process_main+0x142>
        assert((uintptr_t)ptrs[i] % 8 == 0);
  1000c8:	83 e3 07             	and    $0x7,%ebx
  1000cb:	0f 85 85 00 00 00    	jne    100156 <process_main+0x156>
    for(size_t i = 0; i < sizeof(ptrs)/sizeof(ptrs[0]); ++i) {
  1000d1:	49 81 fc 00 02 00 00 	cmp    $0x200,%r12
  1000d8:	75 d2                	jne    1000ac <process_main+0xac>
    }

    for(size_t i = 0; i < sizeof(ptrs)/sizeof(ptrs[0]); ++i) {
        free((void *)ptrs[i]);
  1000da:	48 8b 3c dd 20 20 10 	mov    0x102020(,%rbx,8),%rdi
  1000e1:	00 
  1000e2:	e8 c3 0e 00 00       	call   100faa <free>
    for(size_t i = 0; i < sizeof(ptrs)/sizeof(ptrs[0]); ++i) {
  1000e7:	48 83 c3 01          	add    $0x1,%rbx
  1000eb:	48 81 fb 00 02 00 00 	cmp    $0x200,%rbx
  1000f2:	75 e6                	jne    1000da <process_main+0xda>
    }

    /* Single elements on heap of varying sizes,
     * in reverse size order, leading to small splitting of free blocks. */
    for(size_t i = 4096; i > 0; --i) {
  1000f4:	bb 00 10 00 00       	mov    $0x1000,%ebx
        ptr = malloc(i);
  1000f9:	48 89 df             	mov    %rbx,%rdi
  1000fc:	e8 04 0e 00 00       	call   100f05 <malloc>
  100101:	48 89 c7             	mov    %rax,%rdi
        assert(ptr != NULL);
  100104:	48 85 c0             	test   %rax,%rax
  100107:	74 61                	je     10016a <process_main+0x16a>
        assert((uintptr_t)ptr % 8 == 0);
  100109:	a8 07                	test   $0x7,%al
  10010b:	75 71                	jne    10017e <process_main+0x17e>

        /* Check that we can write */
        free(ptr);
  10010d:	e8 98 0e 00 00       	call   100faa <free>
    for(size_t i = 4096; i > 0; --i) {
  100112:	48 83 eb 01          	sub    $0x1,%rbx
  100116:	75 e1                	jne    1000f9 <process_main+0xf9>
    }

    ptr = malloc(25);
  100118:	bf 19 00 00 00       	mov    $0x19,%edi
  10011d:	e8 e3 0d 00 00       	call   100f05 <malloc>
  100122:	48 89 c7             	mov    %rax,%rdi
    assert(ptr != NULL);
  100125:	48 85 c0             	test   %rax,%rax
  100128:	74 68                	je     100192 <process_main+0x192>
    assert((uintptr_t)ptr % 8 == 0);
  10012a:	a8 07                	test   $0x7,%al
  10012c:	74 78                	je     1001a6 <process_main+0x1a6>
  10012e:	ba 1f 14 10 00       	mov    $0x10141f,%edx
  100133:	be 3a 00 00 00       	mov    $0x3a,%esi
  100138:	bf 16 14 10 00       	mov    $0x101416,%edi
  10013d:	e8 83 12 00 00       	call   1013c5 <assert_fail>
        assert(ptrs[i] != NULL);
  100142:	ba 37 14 10 00       	mov    $0x101437,%edx
  100147:	be 25 00 00 00       	mov    $0x25,%esi
  10014c:	bf 16 14 10 00       	mov    $0x101416,%edi
  100151:	e8 6f 12 00 00       	call   1013c5 <assert_fail>
        assert((uintptr_t)ptrs[i] % 8 == 0);
  100156:	ba 47 14 10 00       	mov    $0x101447,%edx
  10015b:	be 26 00 00 00       	mov    $0x26,%esi
  100160:	bf 16 14 10 00       	mov    $0x101416,%edi
  100165:	e8 5b 12 00 00       	call   1013c5 <assert_fail>
        assert(ptr != NULL);
  10016a:	ba 63 14 10 00       	mov    $0x101463,%edx
  10016f:	be 31 00 00 00       	mov    $0x31,%esi
  100174:	bf 16 14 10 00       	mov    $0x101416,%edi
  100179:	e8 47 12 00 00       	call   1013c5 <assert_fail>
        assert((uintptr_t)ptr % 8 == 0);
  10017e:	ba 1f 14 10 00       	mov    $0x10141f,%edx
  100183:	be 32 00 00 00       	mov    $0x32,%esi
  100188:	bf 16 14 10 00       	mov    $0x101416,%edi
  10018d:	e8 33 12 00 00       	call   1013c5 <assert_fail>
    assert(ptr != NULL);
  100192:	ba 63 14 10 00       	mov    $0x101463,%edx
  100197:	be 39 00 00 00       	mov    $0x39,%esi
  10019c:	bf 16 14 10 00       	mov    $0x101416,%edi
  1001a1:	e8 1f 12 00 00       	call   1013c5 <assert_fail>

    ptr = realloc(ptr, 25000);
  1001a6:	be a8 61 00 00       	mov    $0x61a8,%esi
  1001ab:	e8 31 0e 00 00       	call   100fe1 <realloc>
  1001b0:	48 89 c7             	mov    %rax,%rdi
    assert(ptr != NULL);
  1001b3:	48 85 c0             	test   %rax,%rax
  1001b6:	74 18                	je     1001d0 <process_main+0x1d0>
    assert((uintptr_t)ptr % 8 == 0);
  1001b8:	a8 07                	test   $0x7,%al
  1001ba:	74 28                	je     1001e4 <process_main+0x1e4>
  1001bc:	ba 1f 14 10 00       	mov    $0x10141f,%edx
  1001c1:	be 3e 00 00 00       	mov    $0x3e,%esi
  1001c6:	bf 16 14 10 00       	mov    $0x101416,%edi
  1001cb:	e8 f5 11 00 00       	call   1013c5 <assert_fail>
    assert(ptr != NULL);
  1001d0:	ba 63 14 10 00       	mov    $0x101463,%edx
  1001d5:	be 3d 00 00 00       	mov    $0x3d,%esi
  1001da:	bf 16 14 10 00       	mov    $0x101416,%edi
  1001df:	e8 e1 11 00 00       	call   1013c5 <assert_fail>

    free(ptr);
  1001e4:	e8 c1 0d 00 00       	call   100faa <free>

    ptr = calloc(10,10);
  1001e9:	be 0a 00 00 00       	mov    $0xa,%esi
  1001ee:	bf 0a 00 00 00       	mov    $0xa,%edi
  1001f3:	e8 bb 0d 00 00       	call   100fb3 <calloc>
    assert(ptr != NULL);
  1001f8:	48 85 c0             	test   %rax,%rax
  1001fb:	74 18                	je     100215 <process_main+0x215>
    assert((uintptr_t)ptr % 8 == 0);
  1001fd:	a8 07                	test   $0x7,%al
  1001ff:	74 28                	je     100229 <process_main+0x229>
  100201:	ba 1f 14 10 00       	mov    $0x10141f,%edx
  100206:	be 44 00 00 00       	mov    $0x44,%esi
  10020b:	bf 16 14 10 00       	mov    $0x101416,%edi
  100210:	e8 b0 11 00 00       	call   1013c5 <assert_fail>
    assert(ptr != NULL);
  100215:	ba 63 14 10 00       	mov    $0x101463,%edx
  10021a:	be 43 00 00 00       	mov    $0x43,%esi
  10021f:	bf 16 14 10 00       	mov    $0x101416,%edi
  100224:	e8 9c 11 00 00       	call   1013c5 <assert_fail>

    TEST_PASS();
  100229:	bf 6f 14 10 00       	mov    $0x10146f,%edi
  10022e:	b8 00 00 00 00       	mov    $0x0,%eax
  100233:	e8 bf 10 00 00       	call   1012f7 <kernel_panic>

0000000000100238 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  100238:	48 89 f9             	mov    %rdi,%rcx
  10023b:	89 d7                	mov    %edx,%edi
    console_printer* cp = (console_printer*) p;
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  10023d:	48 81 79 08 a0 8f 0b 	cmpq   $0xb8fa0,0x8(%rcx)
  100244:	00 
  100245:	72 08                	jb     10024f <console_putc+0x17>
        cp->cursor = console;
  100247:	48 c7 41 08 00 80 0b 	movq   $0xb8000,0x8(%rcx)
  10024e:	00 
    }
    if (c == '\n') {
  10024f:	40 80 fe 0a          	cmp    $0xa,%sil
  100253:	74 16                	je     10026b <console_putc+0x33>
        int pos = (cp->cursor - console) % 80;
        for (; pos != 80; pos++) {
            *cp->cursor++ = ' ' | color;
        }
    } else {
        *cp->cursor++ = c | color;
  100255:	48 8b 41 08          	mov    0x8(%rcx),%rax
  100259:	48 8d 50 02          	lea    0x2(%rax),%rdx
  10025d:	48 89 51 08          	mov    %rdx,0x8(%rcx)
  100261:	40 0f b6 f6          	movzbl %sil,%esi
  100265:	09 fe                	or     %edi,%esi
  100267:	66 89 30             	mov    %si,(%rax)
    }
}
  10026a:	c3                   	ret    
        int pos = (cp->cursor - console) % 80;
  10026b:	4c 8b 41 08          	mov    0x8(%rcx),%r8
  10026f:	49 81 e8 00 80 0b 00 	sub    $0xb8000,%r8
  100276:	4c 89 c6             	mov    %r8,%rsi
  100279:	48 d1 fe             	sar    %rsi
  10027c:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  100283:	66 66 66 
  100286:	48 89 f0             	mov    %rsi,%rax
  100289:	48 f7 ea             	imul   %rdx
  10028c:	48 c1 fa 05          	sar    $0x5,%rdx
  100290:	49 c1 f8 3f          	sar    $0x3f,%r8
  100294:	4c 29 c2             	sub    %r8,%rdx
  100297:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
  10029b:	48 c1 e2 04          	shl    $0x4,%rdx
  10029f:	89 f0                	mov    %esi,%eax
  1002a1:	29 d0                	sub    %edx,%eax
            *cp->cursor++ = ' ' | color;
  1002a3:	83 cf 20             	or     $0x20,%edi
  1002a6:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1002aa:	48 8d 72 02          	lea    0x2(%rdx),%rsi
  1002ae:	48 89 71 08          	mov    %rsi,0x8(%rcx)
  1002b2:	66 89 3a             	mov    %di,(%rdx)
        for (; pos != 80; pos++) {
  1002b5:	83 c0 01             	add    $0x1,%eax
  1002b8:	83 f8 50             	cmp    $0x50,%eax
  1002bb:	75 e9                	jne    1002a6 <console_putc+0x6e>
  1002bd:	c3                   	ret    

00000000001002be <string_putc>:
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
    string_printer* sp = (string_printer*) p;
    if (sp->s < sp->end) {
  1002be:	48 8b 47 08          	mov    0x8(%rdi),%rax
  1002c2:	48 3b 47 10          	cmp    0x10(%rdi),%rax
  1002c6:	73 0b                	jae    1002d3 <string_putc+0x15>
        *sp->s++ = c;
  1002c8:	48 8d 50 01          	lea    0x1(%rax),%rdx
  1002cc:	48 89 57 08          	mov    %rdx,0x8(%rdi)
  1002d0:	40 88 30             	mov    %sil,(%rax)
    }
    (void) color;
}
  1002d3:	c3                   	ret    

00000000001002d4 <memcpy>:
void* memcpy(void* dst, const void* src, size_t n) {
  1002d4:	48 89 f8             	mov    %rdi,%rax
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1002d7:	48 85 d2             	test   %rdx,%rdx
  1002da:	74 17                	je     1002f3 <memcpy+0x1f>
  1002dc:	b9 00 00 00 00       	mov    $0x0,%ecx
        *d = *s;
  1002e1:	44 0f b6 04 0e       	movzbl (%rsi,%rcx,1),%r8d
  1002e6:	44 88 04 08          	mov    %r8b,(%rax,%rcx,1)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  1002ea:	48 83 c1 01          	add    $0x1,%rcx
  1002ee:	48 39 d1             	cmp    %rdx,%rcx
  1002f1:	75 ee                	jne    1002e1 <memcpy+0xd>
}
  1002f3:	c3                   	ret    

00000000001002f4 <memmove>:
void* memmove(void* dst, const void* src, size_t n) {
  1002f4:	48 89 f8             	mov    %rdi,%rax
    if (s < d && s + n > d) {
  1002f7:	48 39 fe             	cmp    %rdi,%rsi
  1002fa:	72 1d                	jb     100319 <memmove+0x25>
        while (n-- > 0) {
  1002fc:	b9 00 00 00 00       	mov    $0x0,%ecx
  100301:	48 85 d2             	test   %rdx,%rdx
  100304:	74 12                	je     100318 <memmove+0x24>
            *d++ = *s++;
  100306:	0f b6 3c 0e          	movzbl (%rsi,%rcx,1),%edi
  10030a:	40 88 3c 08          	mov    %dil,(%rax,%rcx,1)
        while (n-- > 0) {
  10030e:	48 83 c1 01          	add    $0x1,%rcx
  100312:	48 39 ca             	cmp    %rcx,%rdx
  100315:	75 ef                	jne    100306 <memmove+0x12>
}
  100317:	c3                   	ret    
  100318:	c3                   	ret    
    if (s < d && s + n > d) {
  100319:	48 8d 0c 16          	lea    (%rsi,%rdx,1),%rcx
  10031d:	48 39 cf             	cmp    %rcx,%rdi
  100320:	73 da                	jae    1002fc <memmove+0x8>
        while (n-- > 0) {
  100322:	48 8d 4a ff          	lea    -0x1(%rdx),%rcx
  100326:	48 85 d2             	test   %rdx,%rdx
  100329:	74 ec                	je     100317 <memmove+0x23>
            *--d = *--s;
  10032b:	0f b6 14 0e          	movzbl (%rsi,%rcx,1),%edx
  10032f:	88 14 08             	mov    %dl,(%rax,%rcx,1)
        while (n-- > 0) {
  100332:	48 83 e9 01          	sub    $0x1,%rcx
  100336:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
  10033a:	75 ef                	jne    10032b <memmove+0x37>
  10033c:	c3                   	ret    

000000000010033d <memset>:
void* memset(void* v, int c, size_t n) {
  10033d:	48 89 f8             	mov    %rdi,%rax
    for (char* p = (char*) v; n > 0; ++p, --n) {
  100340:	48 85 d2             	test   %rdx,%rdx
  100343:	74 12                	je     100357 <memset+0x1a>
  100345:	48 01 fa             	add    %rdi,%rdx
  100348:	48 89 f9             	mov    %rdi,%rcx
        *p = c;
  10034b:	40 88 31             	mov    %sil,(%rcx)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  10034e:	48 83 c1 01          	add    $0x1,%rcx
  100352:	48 39 ca             	cmp    %rcx,%rdx
  100355:	75 f4                	jne    10034b <memset+0xe>
}
  100357:	c3                   	ret    

0000000000100358 <strlen>:
    for (n = 0; *s != '\0'; ++s) {
  100358:	80 3f 00             	cmpb   $0x0,(%rdi)
  10035b:	74 10                	je     10036d <strlen+0x15>
  10035d:	b8 00 00 00 00       	mov    $0x0,%eax
        ++n;
  100362:	48 83 c0 01          	add    $0x1,%rax
    for (n = 0; *s != '\0'; ++s) {
  100366:	80 3c 07 00          	cmpb   $0x0,(%rdi,%rax,1)
  10036a:	75 f6                	jne    100362 <strlen+0xa>
  10036c:	c3                   	ret    
  10036d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100372:	c3                   	ret    

0000000000100373 <strnlen>:
size_t strnlen(const char* s, size_t maxlen) {
  100373:	48 89 f0             	mov    %rsi,%rax
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  100376:	ba 00 00 00 00       	mov    $0x0,%edx
  10037b:	48 85 f6             	test   %rsi,%rsi
  10037e:	74 11                	je     100391 <strnlen+0x1e>
  100380:	80 3c 17 00          	cmpb   $0x0,(%rdi,%rdx,1)
  100384:	74 0c                	je     100392 <strnlen+0x1f>
        ++n;
  100386:	48 83 c2 01          	add    $0x1,%rdx
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  10038a:	48 39 d0             	cmp    %rdx,%rax
  10038d:	75 f1                	jne    100380 <strnlen+0xd>
  10038f:	eb 04                	jmp    100395 <strnlen+0x22>
  100391:	c3                   	ret    
  100392:	48 89 d0             	mov    %rdx,%rax
}
  100395:	c3                   	ret    

0000000000100396 <strcpy>:
char* strcpy(char* dst, const char* src) {
  100396:	48 89 f8             	mov    %rdi,%rax
  100399:	ba 00 00 00 00       	mov    $0x0,%edx
        *d++ = *src++;
  10039e:	0f b6 0c 16          	movzbl (%rsi,%rdx,1),%ecx
  1003a2:	88 0c 10             	mov    %cl,(%rax,%rdx,1)
    } while (d[-1]);
  1003a5:	48 83 c2 01          	add    $0x1,%rdx
  1003a9:	84 c9                	test   %cl,%cl
  1003ab:	75 f1                	jne    10039e <strcpy+0x8>
}
  1003ad:	c3                   	ret    

00000000001003ae <strcmp>:
    while (*a && *b && *a == *b) {
  1003ae:	0f b6 07             	movzbl (%rdi),%eax
  1003b1:	84 c0                	test   %al,%al
  1003b3:	74 1a                	je     1003cf <strcmp+0x21>
  1003b5:	0f b6 16             	movzbl (%rsi),%edx
  1003b8:	38 c2                	cmp    %al,%dl
  1003ba:	75 13                	jne    1003cf <strcmp+0x21>
  1003bc:	84 d2                	test   %dl,%dl
  1003be:	74 0f                	je     1003cf <strcmp+0x21>
        ++a, ++b;
  1003c0:	48 83 c7 01          	add    $0x1,%rdi
  1003c4:	48 83 c6 01          	add    $0x1,%rsi
    while (*a && *b && *a == *b) {
  1003c8:	0f b6 07             	movzbl (%rdi),%eax
  1003cb:	84 c0                	test   %al,%al
  1003cd:	75 e6                	jne    1003b5 <strcmp+0x7>
    return ((unsigned char) *a > (unsigned char) *b)
  1003cf:	3a 06                	cmp    (%rsi),%al
  1003d1:	0f 97 c0             	seta   %al
  1003d4:	0f b6 c0             	movzbl %al,%eax
        - ((unsigned char) *a < (unsigned char) *b);
  1003d7:	83 d8 00             	sbb    $0x0,%eax
}
  1003da:	c3                   	ret    

00000000001003db <strchr>:
    while (*s && *s != (char) c) {
  1003db:	0f b6 07             	movzbl (%rdi),%eax
  1003de:	84 c0                	test   %al,%al
  1003e0:	74 10                	je     1003f2 <strchr+0x17>
  1003e2:	40 38 f0             	cmp    %sil,%al
  1003e5:	74 18                	je     1003ff <strchr+0x24>
        ++s;
  1003e7:	48 83 c7 01          	add    $0x1,%rdi
    while (*s && *s != (char) c) {
  1003eb:	0f b6 07             	movzbl (%rdi),%eax
  1003ee:	84 c0                	test   %al,%al
  1003f0:	75 f0                	jne    1003e2 <strchr+0x7>
        return NULL;
  1003f2:	40 84 f6             	test   %sil,%sil
  1003f5:	b8 00 00 00 00       	mov    $0x0,%eax
  1003fa:	48 0f 44 c7          	cmove  %rdi,%rax
}
  1003fe:	c3                   	ret    
  1003ff:	48 89 f8             	mov    %rdi,%rax
  100402:	c3                   	ret    

0000000000100403 <rand>:
    if (!rand_seed_set) {
  100403:	83 3d 1a 2c 00 00 00 	cmpl   $0x0,0x2c1a(%rip)        # 103024 <rand_seed_set>
  10040a:	74 1b                	je     100427 <rand+0x24>
    rand_seed = rand_seed * 1664525U + 1013904223U;
  10040c:	69 05 0a 2c 00 00 0d 	imul   $0x19660d,0x2c0a(%rip),%eax        # 103020 <rand_seed>
  100413:	66 19 00 
  100416:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  10041b:	89 05 ff 2b 00 00    	mov    %eax,0x2bff(%rip)        # 103020 <rand_seed>
    return rand_seed & RAND_MAX;
  100421:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  100426:	c3                   	ret    
    rand_seed = seed;
  100427:	c7 05 ef 2b 00 00 9e 	movl   $0x30d4879e,0x2bef(%rip)        # 103020 <rand_seed>
  10042e:	87 d4 30 
    rand_seed_set = 1;
  100431:	c7 05 e9 2b 00 00 01 	movl   $0x1,0x2be9(%rip)        # 103024 <rand_seed_set>
  100438:	00 00 00 
}
  10043b:	eb cf                	jmp    10040c <rand+0x9>

000000000010043d <srand>:
    rand_seed = seed;
  10043d:	89 3d dd 2b 00 00    	mov    %edi,0x2bdd(%rip)        # 103020 <rand_seed>
    rand_seed_set = 1;
  100443:	c7 05 d7 2b 00 00 01 	movl   $0x1,0x2bd7(%rip)        # 103024 <rand_seed_set>
  10044a:	00 00 00 
}
  10044d:	c3                   	ret    

000000000010044e <printer_vprintf>:
void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  10044e:	55                   	push   %rbp
  10044f:	48 89 e5             	mov    %rsp,%rbp
  100452:	41 57                	push   %r15
  100454:	41 56                	push   %r14
  100456:	41 55                	push   %r13
  100458:	41 54                	push   %r12
  10045a:	53                   	push   %rbx
  10045b:	48 83 ec 58          	sub    $0x58,%rsp
  10045f:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    for (; *format; ++format) {
  100463:	0f b6 02             	movzbl (%rdx),%eax
  100466:	84 c0                	test   %al,%al
  100468:	0f 84 b0 06 00 00    	je     100b1e <printer_vprintf+0x6d0>
  10046e:	49 89 fe             	mov    %rdi,%r14
  100471:	49 89 d4             	mov    %rdx,%r12
            length = 1;
  100474:	41 89 f7             	mov    %esi,%r15d
  100477:	e9 a4 04 00 00       	jmp    100920 <printer_vprintf+0x4d2>
        for (++format; *format; ++format) {
  10047c:	49 8d 5c 24 01       	lea    0x1(%r12),%rbx
  100481:	45 0f b6 64 24 01    	movzbl 0x1(%r12),%r12d
  100487:	45 84 e4             	test   %r12b,%r12b
  10048a:	0f 84 82 06 00 00    	je     100b12 <printer_vprintf+0x6c4>
        int flags = 0;
  100490:	41 bd 00 00 00 00    	mov    $0x0,%r13d
            const char* flagc = strchr(flag_chars, *format);
  100496:	41 0f be f4          	movsbl %r12b,%esi
  10049a:	bf 81 16 10 00       	mov    $0x101681,%edi
  10049f:	e8 37 ff ff ff       	call   1003db <strchr>
  1004a4:	48 89 c1             	mov    %rax,%rcx
            if (flagc) {
  1004a7:	48 85 c0             	test   %rax,%rax
  1004aa:	74 55                	je     100501 <printer_vprintf+0xb3>
                flags |= 1 << (flagc - flag_chars);
  1004ac:	48 81 e9 81 16 10 00 	sub    $0x101681,%rcx
  1004b3:	b8 01 00 00 00       	mov    $0x1,%eax
  1004b8:	d3 e0                	shl    %cl,%eax
  1004ba:	41 09 c5             	or     %eax,%r13d
        for (++format; *format; ++format) {
  1004bd:	48 83 c3 01          	add    $0x1,%rbx
  1004c1:	44 0f b6 23          	movzbl (%rbx),%r12d
  1004c5:	45 84 e4             	test   %r12b,%r12b
  1004c8:	75 cc                	jne    100496 <printer_vprintf+0x48>
  1004ca:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
        int width = -1;
  1004ce:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
        int precision = -1;
  1004d4:	c7 45 9c ff ff ff ff 	movl   $0xffffffff,-0x64(%rbp)
        if (*format == '.') {
  1004db:	80 3b 2e             	cmpb   $0x2e,(%rbx)
  1004de:	0f 84 a9 00 00 00    	je     10058d <printer_vprintf+0x13f>
        int length = 0;
  1004e4:	b9 00 00 00 00       	mov    $0x0,%ecx
        switch (*format) {
  1004e9:	0f b6 13             	movzbl (%rbx),%edx
  1004ec:	8d 42 bd             	lea    -0x43(%rdx),%eax
  1004ef:	3c 37                	cmp    $0x37,%al
  1004f1:	0f 87 c4 04 00 00    	ja     1009bb <printer_vprintf+0x56d>
  1004f7:	0f b6 c0             	movzbl %al,%eax
  1004fa:	ff 24 c5 90 14 10 00 	jmp    *0x101490(,%rax,8)
        if (*format >= '1' && *format <= '9') {
  100501:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
  100505:	41 8d 44 24 cf       	lea    -0x31(%r12),%eax
  10050a:	3c 08                	cmp    $0x8,%al
  10050c:	77 2f                	ja     10053d <printer_vprintf+0xef>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  10050e:	0f b6 03             	movzbl (%rbx),%eax
  100511:	8d 50 d0             	lea    -0x30(%rax),%edx
  100514:	80 fa 09             	cmp    $0x9,%dl
  100517:	77 5e                	ja     100577 <printer_vprintf+0x129>
  100519:	41 bd 00 00 00 00    	mov    $0x0,%r13d
                width = 10 * width + *format++ - '0';
  10051f:	48 83 c3 01          	add    $0x1,%rbx
  100523:	43 8d 54 ad 00       	lea    0x0(%r13,%r13,4),%edx
  100528:	0f be c0             	movsbl %al,%eax
  10052b:	44 8d 6c 50 d0       	lea    -0x30(%rax,%rdx,2),%r13d
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100530:	0f b6 03             	movzbl (%rbx),%eax
  100533:	8d 50 d0             	lea    -0x30(%rax),%edx
  100536:	80 fa 09             	cmp    $0x9,%dl
  100539:	76 e4                	jbe    10051f <printer_vprintf+0xd1>
  10053b:	eb 97                	jmp    1004d4 <printer_vprintf+0x86>
        } else if (*format == '*') {
  10053d:	41 80 fc 2a          	cmp    $0x2a,%r12b
  100541:	75 3f                	jne    100582 <printer_vprintf+0x134>
            width = va_arg(val, int);
  100543:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100547:	8b 07                	mov    (%rdi),%eax
  100549:	83 f8 2f             	cmp    $0x2f,%eax
  10054c:	77 17                	ja     100565 <printer_vprintf+0x117>
  10054e:	89 c2                	mov    %eax,%edx
  100550:	48 03 57 10          	add    0x10(%rdi),%rdx
  100554:	83 c0 08             	add    $0x8,%eax
  100557:	89 07                	mov    %eax,(%rdi)
  100559:	44 8b 2a             	mov    (%rdx),%r13d
            ++format;
  10055c:	48 83 c3 01          	add    $0x1,%rbx
  100560:	e9 6f ff ff ff       	jmp    1004d4 <printer_vprintf+0x86>
            width = va_arg(val, int);
  100565:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100569:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  10056d:	48 8d 42 08          	lea    0x8(%rdx),%rax
  100571:	48 89 41 08          	mov    %rax,0x8(%rcx)
  100575:	eb e2                	jmp    100559 <printer_vprintf+0x10b>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  100577:	41 bd 00 00 00 00    	mov    $0x0,%r13d
  10057d:	e9 52 ff ff ff       	jmp    1004d4 <printer_vprintf+0x86>
        int width = -1;
  100582:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
  100588:	e9 47 ff ff ff       	jmp    1004d4 <printer_vprintf+0x86>
            ++format;
  10058d:	48 8d 53 01          	lea    0x1(%rbx),%rdx
            if (*format >= '0' && *format <= '9') {
  100591:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
  100595:	8d 48 d0             	lea    -0x30(%rax),%ecx
  100598:	80 f9 09             	cmp    $0x9,%cl
  10059b:	76 13                	jbe    1005b0 <printer_vprintf+0x162>
            } else if (*format == '*') {
  10059d:	3c 2a                	cmp    $0x2a,%al
  10059f:	74 33                	je     1005d4 <printer_vprintf+0x186>
            ++format;
  1005a1:	48 89 d3             	mov    %rdx,%rbx
                precision = 0;
  1005a4:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
  1005ab:	e9 34 ff ff ff       	jmp    1004e4 <printer_vprintf+0x96>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1005b0:	b9 00 00 00 00       	mov    $0x0,%ecx
                    precision = 10 * precision + *format++ - '0';
  1005b5:	48 83 c2 01          	add    $0x1,%rdx
  1005b9:	8d 0c 89             	lea    (%rcx,%rcx,4),%ecx
  1005bc:	0f be c0             	movsbl %al,%eax
  1005bf:	8d 4c 48 d0          	lea    -0x30(%rax,%rcx,2),%ecx
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  1005c3:	0f b6 02             	movzbl (%rdx),%eax
  1005c6:	8d 70 d0             	lea    -0x30(%rax),%esi
  1005c9:	40 80 fe 09          	cmp    $0x9,%sil
  1005cd:	76 e6                	jbe    1005b5 <printer_vprintf+0x167>
                    precision = 10 * precision + *format++ - '0';
  1005cf:	48 89 d3             	mov    %rdx,%rbx
  1005d2:	eb 1c                	jmp    1005f0 <printer_vprintf+0x1a2>
                precision = va_arg(val, int);
  1005d4:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1005d8:	8b 07                	mov    (%rdi),%eax
  1005da:	83 f8 2f             	cmp    $0x2f,%eax
  1005dd:	77 23                	ja     100602 <printer_vprintf+0x1b4>
  1005df:	89 c2                	mov    %eax,%edx
  1005e1:	48 03 57 10          	add    0x10(%rdi),%rdx
  1005e5:	83 c0 08             	add    $0x8,%eax
  1005e8:	89 07                	mov    %eax,(%rdi)
  1005ea:	8b 0a                	mov    (%rdx),%ecx
                ++format;
  1005ec:	48 83 c3 02          	add    $0x2,%rbx
            if (precision < 0) {
  1005f0:	85 c9                	test   %ecx,%ecx
  1005f2:	b8 00 00 00 00       	mov    $0x0,%eax
  1005f7:	0f 49 c1             	cmovns %ecx,%eax
  1005fa:	89 45 9c             	mov    %eax,-0x64(%rbp)
  1005fd:	e9 e2 fe ff ff       	jmp    1004e4 <printer_vprintf+0x96>
                precision = va_arg(val, int);
  100602:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100606:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  10060a:	48 8d 42 08          	lea    0x8(%rdx),%rax
  10060e:	48 89 41 08          	mov    %rax,0x8(%rcx)
  100612:	eb d6                	jmp    1005ea <printer_vprintf+0x19c>
        switch (*format) {
  100614:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
  100619:	e9 f3 00 00 00       	jmp    100711 <printer_vprintf+0x2c3>
            ++format;
  10061e:	48 83 c3 01          	add    $0x1,%rbx
            length = 1;
  100622:	b9 01 00 00 00       	mov    $0x1,%ecx
            goto again;
  100627:	e9 bd fe ff ff       	jmp    1004e9 <printer_vprintf+0x9b>
            long x = length ? va_arg(val, long) : va_arg(val, int);
  10062c:	85 c9                	test   %ecx,%ecx
  10062e:	74 55                	je     100685 <printer_vprintf+0x237>
  100630:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100634:	8b 07                	mov    (%rdi),%eax
  100636:	83 f8 2f             	cmp    $0x2f,%eax
  100639:	77 38                	ja     100673 <printer_vprintf+0x225>
  10063b:	89 c2                	mov    %eax,%edx
  10063d:	48 03 57 10          	add    0x10(%rdi),%rdx
  100641:	83 c0 08             	add    $0x8,%eax
  100644:	89 07                	mov    %eax,(%rdi)
  100646:	48 8b 12             	mov    (%rdx),%rdx
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  100649:	48 89 d0             	mov    %rdx,%rax
  10064c:	48 c1 f8 38          	sar    $0x38,%rax
            num = negative ? -x : x;
  100650:	49 89 d0             	mov    %rdx,%r8
  100653:	49 f7 d8             	neg    %r8
  100656:	25 80 00 00 00       	and    $0x80,%eax
  10065b:	4c 0f 44 c2          	cmove  %rdx,%r8
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  10065f:	0b 45 a8             	or     -0x58(%rbp),%eax
  100662:	83 c8 60             	or     $0x60,%eax
  100665:	89 45 a8             	mov    %eax,-0x58(%rbp)
        char* data = "";
  100668:	41 bc 90 16 10 00    	mov    $0x101690,%r12d
            break;
  10066e:	e9 35 01 00 00       	jmp    1007a8 <printer_vprintf+0x35a>
            long x = length ? va_arg(val, long) : va_arg(val, int);
  100673:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100677:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  10067b:	48 8d 42 08          	lea    0x8(%rdx),%rax
  10067f:	48 89 41 08          	mov    %rax,0x8(%rcx)
  100683:	eb c1                	jmp    100646 <printer_vprintf+0x1f8>
  100685:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100689:	8b 07                	mov    (%rdi),%eax
  10068b:	83 f8 2f             	cmp    $0x2f,%eax
  10068e:	77 10                	ja     1006a0 <printer_vprintf+0x252>
  100690:	89 c2                	mov    %eax,%edx
  100692:	48 03 57 10          	add    0x10(%rdi),%rdx
  100696:	83 c0 08             	add    $0x8,%eax
  100699:	89 07                	mov    %eax,(%rdi)
  10069b:	48 63 12             	movslq (%rdx),%rdx
  10069e:	eb a9                	jmp    100649 <printer_vprintf+0x1fb>
  1006a0:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1006a4:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  1006a8:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1006ac:	48 89 47 08          	mov    %rax,0x8(%rdi)
  1006b0:	eb e9                	jmp    10069b <printer_vprintf+0x24d>
        int base = 10;
  1006b2:	be 0a 00 00 00       	mov    $0xa,%esi
  1006b7:	eb 58                	jmp    100711 <printer_vprintf+0x2c3>
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  1006b9:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1006bd:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1006c1:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1006c5:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1006c9:	eb 60                	jmp    10072b <printer_vprintf+0x2dd>
  1006cb:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1006cf:	8b 07                	mov    (%rdi),%eax
  1006d1:	83 f8 2f             	cmp    $0x2f,%eax
  1006d4:	77 10                	ja     1006e6 <printer_vprintf+0x298>
  1006d6:	89 c2                	mov    %eax,%edx
  1006d8:	48 03 57 10          	add    0x10(%rdi),%rdx
  1006dc:	83 c0 08             	add    $0x8,%eax
  1006df:	89 07                	mov    %eax,(%rdi)
  1006e1:	44 8b 02             	mov    (%rdx),%r8d
  1006e4:	eb 48                	jmp    10072e <printer_vprintf+0x2e0>
  1006e6:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  1006ea:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  1006ee:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1006f2:	48 89 41 08          	mov    %rax,0x8(%rcx)
  1006f6:	eb e9                	jmp    1006e1 <printer_vprintf+0x293>
  1006f8:	41 89 f1             	mov    %esi,%r9d
        if (flags & FLAG_NUMERIC) {
  1006fb:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
    const char* digits = upper_digits;
  100702:	bf 70 16 10 00       	mov    $0x101670,%edi
  100707:	e9 e2 02 00 00       	jmp    1009ee <printer_vprintf+0x5a0>
            base = 16;
  10070c:	be 10 00 00 00       	mov    $0x10,%esi
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  100711:	85 c9                	test   %ecx,%ecx
  100713:	74 b6                	je     1006cb <printer_vprintf+0x27d>
  100715:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100719:	8b 01                	mov    (%rcx),%eax
  10071b:	83 f8 2f             	cmp    $0x2f,%eax
  10071e:	77 99                	ja     1006b9 <printer_vprintf+0x26b>
  100720:	89 c2                	mov    %eax,%edx
  100722:	48 03 51 10          	add    0x10(%rcx),%rdx
  100726:	83 c0 08             	add    $0x8,%eax
  100729:	89 01                	mov    %eax,(%rcx)
  10072b:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_NUMERIC;
  10072e:	83 4d a8 20          	orl    $0x20,-0x58(%rbp)
    if (base < 0) {
  100732:	85 f6                	test   %esi,%esi
  100734:	79 c2                	jns    1006f8 <printer_vprintf+0x2aa>
        base = -base;
  100736:	41 89 f1             	mov    %esi,%r9d
  100739:	f7 de                	neg    %esi
  10073b:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
        digits = lower_digits;
  100742:	bf 50 16 10 00       	mov    $0x101650,%edi
  100747:	e9 a2 02 00 00       	jmp    1009ee <printer_vprintf+0x5a0>
            num = (uintptr_t) va_arg(val, void*);
  10074c:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100750:	8b 07                	mov    (%rdi),%eax
  100752:	83 f8 2f             	cmp    $0x2f,%eax
  100755:	77 1c                	ja     100773 <printer_vprintf+0x325>
  100757:	89 c2                	mov    %eax,%edx
  100759:	48 03 57 10          	add    0x10(%rdi),%rdx
  10075d:	83 c0 08             	add    $0x8,%eax
  100760:	89 07                	mov    %eax,(%rdi)
  100762:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  100765:	81 4d a8 21 01 00 00 	orl    $0x121,-0x58(%rbp)
            base = -16;
  10076c:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
  100771:	eb c3                	jmp    100736 <printer_vprintf+0x2e8>
            num = (uintptr_t) va_arg(val, void*);
  100773:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100777:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  10077b:	48 8d 42 08          	lea    0x8(%rdx),%rax
  10077f:	48 89 41 08          	mov    %rax,0x8(%rcx)
  100783:	eb dd                	jmp    100762 <printer_vprintf+0x314>
            data = va_arg(val, char*);
  100785:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  100789:	8b 01                	mov    (%rcx),%eax
  10078b:	83 f8 2f             	cmp    $0x2f,%eax
  10078e:	0f 87 a5 01 00 00    	ja     100939 <printer_vprintf+0x4eb>
  100794:	89 c2                	mov    %eax,%edx
  100796:	48 03 51 10          	add    0x10(%rcx),%rdx
  10079a:	83 c0 08             	add    $0x8,%eax
  10079d:	89 01                	mov    %eax,(%rcx)
  10079f:	4c 8b 22             	mov    (%rdx),%r12
        unsigned long num = 0;
  1007a2:	41 b8 00 00 00 00    	mov    $0x0,%r8d
        if (flags & FLAG_NUMERIC) {
  1007a8:	8b 45 a8             	mov    -0x58(%rbp),%eax
  1007ab:	83 e0 20             	and    $0x20,%eax
  1007ae:	89 45 8c             	mov    %eax,-0x74(%rbp)
  1007b1:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
  1007b7:	0f 85 21 02 00 00    	jne    1009de <printer_vprintf+0x590>
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  1007bd:	8b 45 a8             	mov    -0x58(%rbp),%eax
  1007c0:	89 45 88             	mov    %eax,-0x78(%rbp)
  1007c3:	83 e0 60             	and    $0x60,%eax
  1007c6:	83 f8 60             	cmp    $0x60,%eax
  1007c9:	0f 84 54 02 00 00    	je     100a23 <printer_vprintf+0x5d5>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  1007cf:	8b 45 a8             	mov    -0x58(%rbp),%eax
  1007d2:	83 e0 21             	and    $0x21,%eax
        const char* prefix = "";
  1007d5:	48 c7 45 a0 90 16 10 	movq   $0x101690,-0x60(%rbp)
  1007dc:	00 
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  1007dd:	83 f8 21             	cmp    $0x21,%eax
  1007e0:	0f 84 79 02 00 00    	je     100a5f <printer_vprintf+0x611>
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  1007e6:	8b 7d 9c             	mov    -0x64(%rbp),%edi
  1007e9:	89 f8                	mov    %edi,%eax
  1007eb:	f7 d0                	not    %eax
  1007ed:	c1 e8 1f             	shr    $0x1f,%eax
  1007f0:	89 45 84             	mov    %eax,-0x7c(%rbp)
  1007f3:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
  1007f7:	0f 85 9e 02 00 00    	jne    100a9b <printer_vprintf+0x64d>
  1007fd:	84 c0                	test   %al,%al
  1007ff:	0f 84 96 02 00 00    	je     100a9b <printer_vprintf+0x64d>
            len = strnlen(data, precision);
  100805:	48 63 f7             	movslq %edi,%rsi
  100808:	4c 89 e7             	mov    %r12,%rdi
  10080b:	e8 63 fb ff ff       	call   100373 <strnlen>
  100810:	89 45 98             	mov    %eax,-0x68(%rbp)
                   && !(flags & FLAG_LEFTJUSTIFY)
  100813:	8b 45 88             	mov    -0x78(%rbp),%eax
  100816:	83 e0 26             	and    $0x26,%eax
            zeros = 0;
  100819:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  100820:	83 f8 22             	cmp    $0x22,%eax
  100823:	0f 84 aa 02 00 00    	je     100ad3 <printer_vprintf+0x685>
        width -= len + zeros + strlen(prefix);
  100829:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  10082d:	e8 26 fb ff ff       	call   100358 <strlen>
  100832:	8b 55 9c             	mov    -0x64(%rbp),%edx
  100835:	03 55 98             	add    -0x68(%rbp),%edx
  100838:	44 89 e9             	mov    %r13d,%ecx
  10083b:	29 d1                	sub    %edx,%ecx
  10083d:	29 c1                	sub    %eax,%ecx
  10083f:	89 4d 8c             	mov    %ecx,-0x74(%rbp)
  100842:	41 89 cd             	mov    %ecx,%r13d
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  100845:	f6 45 a8 04          	testb  $0x4,-0x58(%rbp)
  100849:	75 2d                	jne    100878 <printer_vprintf+0x42a>
  10084b:	85 c9                	test   %ecx,%ecx
  10084d:	7e 29                	jle    100878 <printer_vprintf+0x42a>
            p->putc(p, ' ', color);
  10084f:	44 89 fa             	mov    %r15d,%edx
  100852:	be 20 00 00 00       	mov    $0x20,%esi
  100857:	4c 89 f7             	mov    %r14,%rdi
  10085a:	41 ff 16             	call   *(%r14)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  10085d:	41 83 ed 01          	sub    $0x1,%r13d
  100861:	45 85 ed             	test   %r13d,%r13d
  100864:	7f e9                	jg     10084f <printer_vprintf+0x401>
  100866:	8b 7d 8c             	mov    -0x74(%rbp),%edi
  100869:	85 ff                	test   %edi,%edi
  10086b:	b8 01 00 00 00       	mov    $0x1,%eax
  100870:	0f 4f c7             	cmovg  %edi,%eax
  100873:	29 c7                	sub    %eax,%edi
  100875:	41 89 fd             	mov    %edi,%r13d
        for (; *prefix; ++prefix) {
  100878:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  10087c:	0f b6 07             	movzbl (%rdi),%eax
  10087f:	84 c0                	test   %al,%al
  100881:	74 22                	je     1008a5 <printer_vprintf+0x457>
  100883:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  100887:	48 89 fb             	mov    %rdi,%rbx
            p->putc(p, *prefix, color);
  10088a:	0f b6 f0             	movzbl %al,%esi
  10088d:	44 89 fa             	mov    %r15d,%edx
  100890:	4c 89 f7             	mov    %r14,%rdi
  100893:	41 ff 16             	call   *(%r14)
        for (; *prefix; ++prefix) {
  100896:	48 83 c3 01          	add    $0x1,%rbx
  10089a:	0f b6 03             	movzbl (%rbx),%eax
  10089d:	84 c0                	test   %al,%al
  10089f:	75 e9                	jne    10088a <printer_vprintf+0x43c>
  1008a1:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; zeros > 0; --zeros) {
  1008a5:	8b 45 9c             	mov    -0x64(%rbp),%eax
  1008a8:	85 c0                	test   %eax,%eax
  1008aa:	7e 1d                	jle    1008c9 <printer_vprintf+0x47b>
  1008ac:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  1008b0:	89 c3                	mov    %eax,%ebx
            p->putc(p, '0', color);
  1008b2:	44 89 fa             	mov    %r15d,%edx
  1008b5:	be 30 00 00 00       	mov    $0x30,%esi
  1008ba:	4c 89 f7             	mov    %r14,%rdi
  1008bd:	41 ff 16             	call   *(%r14)
        for (; zeros > 0; --zeros) {
  1008c0:	83 eb 01             	sub    $0x1,%ebx
  1008c3:	75 ed                	jne    1008b2 <printer_vprintf+0x464>
  1008c5:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; len > 0; ++data, --len) {
  1008c9:	8b 45 98             	mov    -0x68(%rbp),%eax
  1008cc:	85 c0                	test   %eax,%eax
  1008ce:	7e 27                	jle    1008f7 <printer_vprintf+0x4a9>
  1008d0:	89 c0                	mov    %eax,%eax
  1008d2:	4c 01 e0             	add    %r12,%rax
  1008d5:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  1008d9:	48 89 c3             	mov    %rax,%rbx
            p->putc(p, *data, color);
  1008dc:	41 0f b6 34 24       	movzbl (%r12),%esi
  1008e1:	44 89 fa             	mov    %r15d,%edx
  1008e4:	4c 89 f7             	mov    %r14,%rdi
  1008e7:	41 ff 16             	call   *(%r14)
        for (; len > 0; ++data, --len) {
  1008ea:	49 83 c4 01          	add    $0x1,%r12
  1008ee:	49 39 dc             	cmp    %rbx,%r12
  1008f1:	75 e9                	jne    1008dc <printer_vprintf+0x48e>
  1008f3:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; width > 0; --width) {
  1008f7:	45 85 ed             	test   %r13d,%r13d
  1008fa:	7e 14                	jle    100910 <printer_vprintf+0x4c2>
            p->putc(p, ' ', color);
  1008fc:	44 89 fa             	mov    %r15d,%edx
  1008ff:	be 20 00 00 00       	mov    $0x20,%esi
  100904:	4c 89 f7             	mov    %r14,%rdi
  100907:	41 ff 16             	call   *(%r14)
        for (; width > 0; --width) {
  10090a:	41 83 ed 01          	sub    $0x1,%r13d
  10090e:	75 ec                	jne    1008fc <printer_vprintf+0x4ae>
    for (; *format; ++format) {
  100910:	4c 8d 63 01          	lea    0x1(%rbx),%r12
  100914:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
  100918:	84 c0                	test   %al,%al
  10091a:	0f 84 fe 01 00 00    	je     100b1e <printer_vprintf+0x6d0>
        if (*format != '%') {
  100920:	3c 25                	cmp    $0x25,%al
  100922:	0f 84 54 fb ff ff    	je     10047c <printer_vprintf+0x2e>
            p->putc(p, *format, color);
  100928:	0f b6 f0             	movzbl %al,%esi
  10092b:	44 89 fa             	mov    %r15d,%edx
  10092e:	4c 89 f7             	mov    %r14,%rdi
  100931:	41 ff 16             	call   *(%r14)
            continue;
  100934:	4c 89 e3             	mov    %r12,%rbx
  100937:	eb d7                	jmp    100910 <printer_vprintf+0x4c2>
            data = va_arg(val, char*);
  100939:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  10093d:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  100941:	48 8d 42 08          	lea    0x8(%rdx),%rax
  100945:	48 89 47 08          	mov    %rax,0x8(%rdi)
  100949:	e9 51 fe ff ff       	jmp    10079f <printer_vprintf+0x351>
            color = va_arg(val, int);
  10094e:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  100952:	8b 07                	mov    (%rdi),%eax
  100954:	83 f8 2f             	cmp    $0x2f,%eax
  100957:	77 10                	ja     100969 <printer_vprintf+0x51b>
  100959:	89 c2                	mov    %eax,%edx
  10095b:	48 03 57 10          	add    0x10(%rdi),%rdx
  10095f:	83 c0 08             	add    $0x8,%eax
  100962:	89 07                	mov    %eax,(%rdi)
  100964:	44 8b 3a             	mov    (%rdx),%r15d
            goto done;
  100967:	eb a7                	jmp    100910 <printer_vprintf+0x4c2>
            color = va_arg(val, int);
  100969:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  10096d:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  100971:	48 8d 42 08          	lea    0x8(%rdx),%rax
  100975:	48 89 41 08          	mov    %rax,0x8(%rcx)
  100979:	eb e9                	jmp    100964 <printer_vprintf+0x516>
            numbuf[0] = va_arg(val, int);
  10097b:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  10097f:	8b 01                	mov    (%rcx),%eax
  100981:	83 f8 2f             	cmp    $0x2f,%eax
  100984:	77 23                	ja     1009a9 <printer_vprintf+0x55b>
  100986:	89 c2                	mov    %eax,%edx
  100988:	48 03 51 10          	add    0x10(%rcx),%rdx
  10098c:	83 c0 08             	add    $0x8,%eax
  10098f:	89 01                	mov    %eax,(%rcx)
  100991:	8b 02                	mov    (%rdx),%eax
  100993:	88 45 b8             	mov    %al,-0x48(%rbp)
            numbuf[1] = '\0';
  100996:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
  10099a:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  10099e:	41 b8 00 00 00 00    	mov    $0x0,%r8d
            break;
  1009a4:	e9 ff fd ff ff       	jmp    1007a8 <printer_vprintf+0x35a>
            numbuf[0] = va_arg(val, int);
  1009a9:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  1009ad:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  1009b1:	48 8d 42 08          	lea    0x8(%rdx),%rax
  1009b5:	48 89 47 08          	mov    %rax,0x8(%rdi)
  1009b9:	eb d6                	jmp    100991 <printer_vprintf+0x543>
            numbuf[0] = (*format ? *format : '%');
  1009bb:	84 d2                	test   %dl,%dl
  1009bd:	0f 85 39 01 00 00    	jne    100afc <printer_vprintf+0x6ae>
  1009c3:	c6 45 b8 25          	movb   $0x25,-0x48(%rbp)
            numbuf[1] = '\0';
  1009c7:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
                format--;
  1009cb:	48 83 eb 01          	sub    $0x1,%rbx
            data = numbuf;
  1009cf:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  1009d3:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  1009d9:	e9 ca fd ff ff       	jmp    1007a8 <printer_vprintf+0x35a>
        if (flags & FLAG_NUMERIC) {
  1009de:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
    const char* digits = upper_digits;
  1009e4:	bf 70 16 10 00       	mov    $0x101670,%edi
        if (flags & FLAG_NUMERIC) {
  1009e9:	be 0a 00 00 00       	mov    $0xa,%esi
    *--numbuf_end = '\0';
  1009ee:	c6 45 cf 00          	movb   $0x0,-0x31(%rbp)
  1009f2:	4c 89 c1             	mov    %r8,%rcx
  1009f5:	4c 8d 65 cf          	lea    -0x31(%rbp),%r12
        *--numbuf_end = digits[val % base];
  1009f9:	48 63 f6             	movslq %esi,%rsi
  1009fc:	49 83 ec 01          	sub    $0x1,%r12
  100a00:	48 89 c8             	mov    %rcx,%rax
  100a03:	ba 00 00 00 00       	mov    $0x0,%edx
  100a08:	48 f7 f6             	div    %rsi
  100a0b:	0f b6 14 17          	movzbl (%rdi,%rdx,1),%edx
  100a0f:	41 88 14 24          	mov    %dl,(%r12)
        val /= base;
  100a13:	48 89 ca             	mov    %rcx,%rdx
  100a16:	48 89 c1             	mov    %rax,%rcx
    } while (val != 0);
  100a19:	48 39 d6             	cmp    %rdx,%rsi
  100a1c:	76 de                	jbe    1009fc <printer_vprintf+0x5ae>
  100a1e:	e9 9a fd ff ff       	jmp    1007bd <printer_vprintf+0x36f>
                prefix = "-";
  100a23:	48 c7 45 a0 88 14 10 	movq   $0x101488,-0x60(%rbp)
  100a2a:	00 
            if (flags & FLAG_NEGATIVE) {
  100a2b:	8b 45 a8             	mov    -0x58(%rbp),%eax
  100a2e:	a8 80                	test   $0x80,%al
  100a30:	0f 85 b0 fd ff ff    	jne    1007e6 <printer_vprintf+0x398>
                prefix = "+";
  100a36:	48 c7 45 a0 83 14 10 	movq   $0x101483,-0x60(%rbp)
  100a3d:	00 
            } else if (flags & FLAG_PLUSPOSITIVE) {
  100a3e:	a8 10                	test   $0x10,%al
  100a40:	0f 85 a0 fd ff ff    	jne    1007e6 <printer_vprintf+0x398>
                prefix = " ";
  100a46:	a8 08                	test   $0x8,%al
  100a48:	ba 90 16 10 00       	mov    $0x101690,%edx
  100a4d:	b8 8d 16 10 00       	mov    $0x10168d,%eax
  100a52:	48 0f 44 c2          	cmove  %rdx,%rax
  100a56:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  100a5a:	e9 87 fd ff ff       	jmp    1007e6 <printer_vprintf+0x398>
                   && (base == 16 || base == -16)
  100a5f:	41 8d 41 10          	lea    0x10(%r9),%eax
  100a63:	a9 df ff ff ff       	test   $0xffffffdf,%eax
  100a68:	0f 85 78 fd ff ff    	jne    1007e6 <printer_vprintf+0x398>
                   && (num || (flags & FLAG_ALT2))) {
  100a6e:	4d 85 c0             	test   %r8,%r8
  100a71:	75 0d                	jne    100a80 <printer_vprintf+0x632>
  100a73:	f7 45 a8 00 01 00 00 	testl  $0x100,-0x58(%rbp)
  100a7a:	0f 84 66 fd ff ff    	je     1007e6 <printer_vprintf+0x398>
            prefix = (base == -16 ? "0x" : "0X");
  100a80:	41 83 f9 f0          	cmp    $0xfffffff0,%r9d
  100a84:	ba 8a 14 10 00       	mov    $0x10148a,%edx
  100a89:	b8 85 14 10 00       	mov    $0x101485,%eax
  100a8e:	48 0f 44 c2          	cmove  %rdx,%rax
  100a92:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  100a96:	e9 4b fd ff ff       	jmp    1007e6 <printer_vprintf+0x398>
            len = strlen(data);
  100a9b:	4c 89 e7             	mov    %r12,%rdi
  100a9e:	e8 b5 f8 ff ff       	call   100358 <strlen>
  100aa3:	89 45 98             	mov    %eax,-0x68(%rbp)
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  100aa6:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
  100aaa:	0f 84 63 fd ff ff    	je     100813 <printer_vprintf+0x3c5>
  100ab0:	80 7d 84 00          	cmpb   $0x0,-0x7c(%rbp)
  100ab4:	0f 84 59 fd ff ff    	je     100813 <printer_vprintf+0x3c5>
            zeros = precision > len ? precision - len : 0;
  100aba:	8b 4d 9c             	mov    -0x64(%rbp),%ecx
  100abd:	89 ca                	mov    %ecx,%edx
  100abf:	29 c2                	sub    %eax,%edx
  100ac1:	39 c1                	cmp    %eax,%ecx
  100ac3:	b8 00 00 00 00       	mov    $0x0,%eax
  100ac8:	0f 4e d0             	cmovle %eax,%edx
  100acb:	89 55 9c             	mov    %edx,-0x64(%rbp)
  100ace:	e9 56 fd ff ff       	jmp    100829 <printer_vprintf+0x3db>
                   && len + (int) strlen(prefix) < width) {
  100ad3:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  100ad7:	e8 7c f8 ff ff       	call   100358 <strlen>
  100adc:	8b 7d 98             	mov    -0x68(%rbp),%edi
  100adf:	8d 14 07             	lea    (%rdi,%rax,1),%edx
            zeros = width - len - strlen(prefix);
  100ae2:	44 89 e9             	mov    %r13d,%ecx
  100ae5:	29 f9                	sub    %edi,%ecx
  100ae7:	29 c1                	sub    %eax,%ecx
  100ae9:	44 39 ea             	cmp    %r13d,%edx
  100aec:	b8 00 00 00 00       	mov    $0x0,%eax
  100af1:	0f 4d c8             	cmovge %eax,%ecx
  100af4:	89 4d 9c             	mov    %ecx,-0x64(%rbp)
  100af7:	e9 2d fd ff ff       	jmp    100829 <printer_vprintf+0x3db>
            numbuf[0] = (*format ? *format : '%');
  100afc:	88 55 b8             	mov    %dl,-0x48(%rbp)
            numbuf[1] = '\0';
  100aff:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
  100b03:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  100b07:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  100b0d:	e9 96 fc ff ff       	jmp    1007a8 <printer_vprintf+0x35a>
        int flags = 0;
  100b12:	c7 45 a8 00 00 00 00 	movl   $0x0,-0x58(%rbp)
  100b19:	e9 b0 f9 ff ff       	jmp    1004ce <printer_vprintf+0x80>
}
  100b1e:	48 83 c4 58          	add    $0x58,%rsp
  100b22:	5b                   	pop    %rbx
  100b23:	41 5c                	pop    %r12
  100b25:	41 5d                	pop    %r13
  100b27:	41 5e                	pop    %r14
  100b29:	41 5f                	pop    %r15
  100b2b:	5d                   	pop    %rbp
  100b2c:	c3                   	ret    

0000000000100b2d <console_vprintf>:
int console_vprintf(int cpos, int color, const char* format, va_list val) {
  100b2d:	55                   	push   %rbp
  100b2e:	48 89 e5             	mov    %rsp,%rbp
  100b31:	48 83 ec 10          	sub    $0x10,%rsp
    cp.p.putc = console_putc;
  100b35:	48 c7 45 f0 38 02 10 	movq   $0x100238,-0x10(%rbp)
  100b3c:	00 
        cpos = 0;
  100b3d:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
  100b43:	b8 00 00 00 00       	mov    $0x0,%eax
  100b48:	0f 43 f8             	cmovae %eax,%edi
    cp.cursor = console + cpos;
  100b4b:	48 63 ff             	movslq %edi,%rdi
  100b4e:	48 8d 84 3f 00 80 0b 	lea    0xb8000(%rdi,%rdi,1),%rax
  100b55:	00 
  100b56:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  100b5a:	48 8d 7d f0          	lea    -0x10(%rbp),%rdi
  100b5e:	e8 eb f8 ff ff       	call   10044e <printer_vprintf>
    return cp.cursor - console;
  100b63:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  100b67:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  100b6d:	48 d1 f8             	sar    %rax
}
  100b70:	c9                   	leave  
  100b71:	c3                   	ret    

0000000000100b72 <console_printf>:
int console_printf(int cpos, int color, const char* format, ...) {
  100b72:	55                   	push   %rbp
  100b73:	48 89 e5             	mov    %rsp,%rbp
  100b76:	48 83 ec 50          	sub    $0x50,%rsp
  100b7a:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  100b7e:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  100b82:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_start(val, format);
  100b86:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  100b8d:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100b91:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100b95:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  100b99:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  100b9d:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  100ba1:	e8 87 ff ff ff       	call   100b2d <console_vprintf>
}
  100ba6:	c9                   	leave  
  100ba7:	c3                   	ret    

0000000000100ba8 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  100ba8:	55                   	push   %rbp
  100ba9:	48 89 e5             	mov    %rsp,%rbp
  100bac:	53                   	push   %rbx
  100bad:	48 83 ec 28          	sub    $0x28,%rsp
  100bb1:	48 89 fb             	mov    %rdi,%rbx
    string_printer sp;
    sp.p.putc = string_putc;
  100bb4:	48 c7 45 d8 be 02 10 	movq   $0x1002be,-0x28(%rbp)
  100bbb:	00 
    sp.s = s;
  100bbc:	48 89 7d e0          	mov    %rdi,-0x20(%rbp)
    if (size) {
  100bc0:	48 85 f6             	test   %rsi,%rsi
  100bc3:	75 0b                	jne    100bd0 <vsnprintf+0x28>
        sp.end = s + size - 1;
        printer_vprintf(&sp.p, 0, format, val);
        *sp.s = 0;
    }
    return sp.s - s;
  100bc5:	8b 45 e0             	mov    -0x20(%rbp),%eax
  100bc8:	29 d8                	sub    %ebx,%eax
}
  100bca:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  100bce:	c9                   	leave  
  100bcf:	c3                   	ret    
        sp.end = s + size - 1;
  100bd0:	48 8d 44 37 ff       	lea    -0x1(%rdi,%rsi,1),%rax
  100bd5:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  100bd9:	be 00 00 00 00       	mov    $0x0,%esi
  100bde:	48 8d 7d d8          	lea    -0x28(%rbp),%rdi
  100be2:	e8 67 f8 ff ff       	call   10044e <printer_vprintf>
        *sp.s = 0;
  100be7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  100beb:	c6 00 00             	movb   $0x0,(%rax)
  100bee:	eb d5                	jmp    100bc5 <vsnprintf+0x1d>

0000000000100bf0 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  100bf0:	55                   	push   %rbp
  100bf1:	48 89 e5             	mov    %rsp,%rbp
  100bf4:	48 83 ec 50          	sub    $0x50,%rsp
  100bf8:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  100bfc:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  100c00:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  100c04:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  100c0b:	48 8d 45 10          	lea    0x10(%rbp),%rax
  100c0f:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  100c13:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  100c17:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    int n = vsnprintf(s, size, format, val);
  100c1b:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  100c1f:	e8 84 ff ff ff       	call   100ba8 <vsnprintf>
    va_end(val);
    return n;
}
  100c24:	c9                   	leave  
  100c25:	c3                   	ret    

0000000000100c26 <console_clear>:

// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  100c26:	b8 00 80 0b 00       	mov    $0xb8000,%eax
  100c2b:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
        console[i] = ' ' | 0x0700;
  100c30:	66 c7 00 20 07       	movw   $0x720,(%rax)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  100c35:	48 83 c0 02          	add    $0x2,%rax
  100c39:	48 39 d0             	cmp    %rdx,%rax
  100c3c:	75 f2                	jne    100c30 <console_clear+0xa>
    }
    cursorpos = 0;
  100c3e:	c7 05 b4 83 fb ff 00 	movl   $0x0,-0x47c4c(%rip)        # b8ffc <cursorpos>
  100c45:	00 00 00 
}
  100c48:	c3                   	ret    

0000000000100c49 <comp_structs>:
//    Compare and sort struct array based on the sizes of alloc'd blocks.

int comp_structs(const void *p1, const void *p2) {
    const heap_info_node a = *(heap_info_node *)p1;
    const heap_info_node b = *(heap_info_node *)p2;
    return a.size <= b.size ? TRUE : FALSE;
  100c49:	48 8b 06             	mov    (%rsi),%rax
  100c4c:	48 39 07             	cmp    %rax,(%rdi)
  100c4f:	0f 9e c0             	setle  %al
  100c52:	0f b6 c0             	movzbl %al,%eax
}
  100c55:	c3                   	ret    

0000000000100c56 <alignof_eight>:
    return ALIGNMENT_EIGHT - sz + (sz & ~(ALIGNMENT_EIGHT - 1));
  100c56:	48 89 f8             	mov    %rdi,%rax
  100c59:	48 83 e0 f8          	and    $0xfffffffffffffff8,%rax
  100c5d:	48 29 f8             	sub    %rdi,%rax
  100c60:	48 83 c0 08          	add    $0x8,%rax
}
  100c64:	c3                   	ret    

0000000000100c65 <merge>:
// merge()
//    Merges two arrays together to be used by the function responsible for
//    the merge sort algorithm.

void merge(heap_info_node *array, size_t left, size_t center, size_t right,
           int (*compare)(const void *, const void *)) {
  100c65:	55                   	push   %rbp
  100c66:	48 89 e5             	mov    %rsp,%rbp
  100c69:	41 57                	push   %r15
  100c6b:	41 56                	push   %r14
  100c6d:	41 55                	push   %r13
  100c6f:	41 54                	push   %r12
  100c71:	53                   	push   %rbx
  100c72:	48 83 ec 38          	sub    $0x38,%rsp
  100c76:	49 89 fa             	mov    %rdi,%r10
  100c79:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  100c7d:	49 89 f1             	mov    %rsi,%r9
  100c80:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
  100c84:	48 89 d7             	mov    %rdx,%rdi
  100c87:	4c 89 45 b0          	mov    %r8,-0x50(%rbp)
    // calculate the lengths of the subarrays
    size_t len1 = center - left + 1;
  100c8b:	48 89 d0             	mov    %rdx,%rax
  100c8e:	48 29 f0             	sub    %rsi,%rax
  100c91:	48 8d 58 01          	lea    0x1(%rax),%rbx
  100c95:	48 89 5d c0          	mov    %rbx,-0x40(%rbp)
    size_t len2 = right - center;
  100c99:	48 29 d1             	sub    %rdx,%rcx
  100c9c:	48 89 ce             	mov    %rcx,%rsi
  100c9f:	48 89 4d b8          	mov    %rcx,-0x48(%rbp)

    // create temporary storage arrays
    // heap_info_node *temp1[len1]
    heap_info_node temp1[len1];
  100ca3:	49 89 d8             	mov    %rbx,%r8
  100ca6:	49 c1 e0 04          	shl    $0x4,%r8
  100caa:	b9 10 00 00 00       	mov    $0x10,%ecx
  100caf:	49 8d 40 0f          	lea    0xf(%r8),%rax
  100cb3:	ba 00 00 00 00       	mov    $0x0,%edx
  100cb8:	48 f7 f1             	div    %rcx
  100cbb:	48 c1 e0 04          	shl    $0x4,%rax
  100cbf:	48 29 c4             	sub    %rax,%rsp
  100cc2:	49 89 e6             	mov    %rsp,%r14
    heap_info_node temp2[len2];
  100cc5:	48 c1 e6 04          	shl    $0x4,%rsi
  100cc9:	48 8d 46 0f          	lea    0xf(%rsi),%rax
  100ccd:	ba 00 00 00 00       	mov    $0x0,%edx
  100cd2:	48 f7 f1             	div    %rcx
  100cd5:	48 c1 e0 04          	shl    $0x4,%rax
  100cd9:	48 29 c4             	sub    %rax,%rsp
  100cdc:	49 89 e7             	mov    %rsp,%r15

    // copy all data over into the storage arrays
    for (size_t i = 0; i < len1; i++)
  100cdf:	48 85 db             	test   %rbx,%rbx
  100ce2:	74 2a                	je     100d0e <merge+0xa9>
  100ce4:	4c 89 ca             	mov    %r9,%rdx
  100ce7:	48 c1 e2 04          	shl    $0x4,%rdx
  100ceb:	4c 01 d2             	add    %r10,%rdx
  100cee:	b8 00 00 00 00       	mov    $0x0,%eax
        temp1[i] = array[left + i];
  100cf3:	48 8b 0c 02          	mov    (%rdx,%rax,1),%rcx
  100cf7:	48 8b 5c 02 08       	mov    0x8(%rdx,%rax,1),%rbx
  100cfc:	49 89 0c 06          	mov    %rcx,(%r14,%rax,1)
  100d00:	49 89 5c 06 08       	mov    %rbx,0x8(%r14,%rax,1)
    for (size_t i = 0; i < len1; i++)
  100d05:	48 83 c0 10          	add    $0x10,%rax
  100d09:	49 39 c0             	cmp    %rax,%r8
  100d0c:	75 e5                	jne    100cf3 <merge+0x8e>
    for (size_t i = 0; i < len2; i++)
  100d0e:	48 83 7d b8 00       	cmpq   $0x0,-0x48(%rbp)
  100d13:	0f 84 70 01 00 00    	je     100e89 <merge+0x224>
  100d19:	48 c1 e7 04          	shl    $0x4,%rdi
  100d1d:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  100d21:	48 8d 14 38          	lea    (%rax,%rdi,1),%rdx
  100d25:	b8 00 00 00 00       	mov    $0x0,%eax
        temp2[i] = array[center + i + 1];
  100d2a:	48 8b 4c 02 10       	mov    0x10(%rdx,%rax,1),%rcx
  100d2f:	48 8b 5c 02 18       	mov    0x18(%rdx,%rax,1),%rbx
  100d34:	49 89 0c 07          	mov    %rcx,(%r15,%rax,1)
  100d38:	49 89 5c 07 08       	mov    %rbx,0x8(%r15,%rax,1)
    for (size_t i = 0; i < len2; i++)
  100d3d:	48 83 c0 10          	add    $0x10,%rax
  100d41:	48 39 c6             	cmp    %rax,%rsi
  100d44:	75 e4                	jne    100d2a <merge+0xc5>
    size_t i = 0;
    size_t j = 0;
    size_t k = left;
    
    // compare and set values in array accordingly
    while (i < len1 && j < len2) {
  100d46:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
  100d4b:	0f 84 32 01 00 00    	je     100e83 <merge+0x21e>
  100d51:	4c 8b 6d c8          	mov    -0x38(%rbp),%r13
  100d55:	49 c1 e5 04          	shl    $0x4,%r13
  100d59:	4c 03 6d a8          	add    -0x58(%rbp),%r13
    size_t j = 0;
  100d5d:	bb 00 00 00 00       	mov    $0x0,%ebx
    size_t i = 0;
  100d62:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  100d68:	eb 31                	jmp    100d9b <merge+0x136>
        if ((*compare)(&temp1[i], &temp2[j])) {
            array[k] = temp1[i];
            i++;
        } else {
            array[k] = temp2[j];
  100d6a:	48 89 d8             	mov    %rbx,%rax
  100d6d:	48 c1 e0 04          	shl    $0x4,%rax
  100d71:	49 8b 54 07 08       	mov    0x8(%r15,%rax,1),%rdx
  100d76:	49 8b 04 07          	mov    (%r15,%rax,1),%rax
  100d7a:	49 89 45 00          	mov    %rax,0x0(%r13)
  100d7e:	49 89 55 08          	mov    %rdx,0x8(%r13)
            j++;
  100d82:	48 83 c3 01          	add    $0x1,%rbx
        }
        k++;
  100d86:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
    while (i < len1 && j < len2) {
  100d8b:	49 83 c5 10          	add    $0x10,%r13
  100d8f:	4c 3b 65 c0          	cmp    -0x40(%rbp),%r12
  100d93:	73 42                	jae    100dd7 <merge+0x172>
  100d95:	48 3b 5d b8          	cmp    -0x48(%rbp),%rbx
  100d99:	73 3c                	jae    100dd7 <merge+0x172>
        if ((*compare)(&temp1[i], &temp2[j])) {
  100d9b:	48 89 de             	mov    %rbx,%rsi
  100d9e:	48 c1 e6 04          	shl    $0x4,%rsi
  100da2:	4c 01 fe             	add    %r15,%rsi
  100da5:	4c 89 e7             	mov    %r12,%rdi
  100da8:	48 c1 e7 04          	shl    $0x4,%rdi
  100dac:	4c 01 f7             	add    %r14,%rdi
  100daf:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  100db3:	ff d0                	call   *%rax
  100db5:	85 c0                	test   %eax,%eax
  100db7:	74 b1                	je     100d6a <merge+0x105>
            array[k] = temp1[i];
  100db9:	4c 89 e0             	mov    %r12,%rax
  100dbc:	48 c1 e0 04          	shl    $0x4,%rax
  100dc0:	49 8b 54 06 08       	mov    0x8(%r14,%rax,1),%rdx
  100dc5:	49 8b 04 06          	mov    (%r14,%rax,1),%rax
  100dc9:	49 89 45 00          	mov    %rax,0x0(%r13)
  100dcd:	49 89 55 08          	mov    %rdx,0x8(%r13)
            i++;
  100dd1:	49 83 c4 01          	add    $0x1,%r12
  100dd5:	eb af                	jmp    100d86 <merge+0x121>
    }

    // add on the rest of the items in the first storage array
    while (i < len1) {
  100dd7:	4c 3b 65 c0          	cmp    -0x40(%rbp),%r12
  100ddb:	73 50                	jae    100e2d <merge+0x1c8>
  100ddd:	4c 8b 45 c0          	mov    -0x40(%rbp),%r8
  100de1:	4d 29 e0             	sub    %r12,%r8
  100de4:	49 c1 e0 04          	shl    $0x4,%r8
  100de8:	4c 89 e1             	mov    %r12,%rcx
  100deb:	48 c1 e1 04          	shl    $0x4,%rcx
  100def:	4c 01 f1             	add    %r14,%rcx
  100df2:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  100df6:	48 c1 e2 04          	shl    $0x4,%rdx
  100dfa:	48 03 55 a8          	add    -0x58(%rbp),%rdx
    size_t i = 0;
  100dfe:	b8 00 00 00 00       	mov    $0x0,%eax
        array[k] = temp1[i];
  100e03:	48 8b 34 01          	mov    (%rcx,%rax,1),%rsi
  100e07:	48 8b 7c 01 08       	mov    0x8(%rcx,%rax,1),%rdi
  100e0c:	48 89 34 02          	mov    %rsi,(%rdx,%rax,1)
  100e10:	48 89 7c 02 08       	mov    %rdi,0x8(%rdx,%rax,1)
    while (i < len1) {
  100e15:	48 83 c0 10          	add    $0x10,%rax
  100e19:	4c 39 c0             	cmp    %r8,%rax
  100e1c:	75 e5                	jne    100e03 <merge+0x19e>
  100e1e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  100e22:	48 03 45 c0          	add    -0x40(%rbp),%rax
        i++;
        k++;
  100e26:	4c 29 e0             	sub    %r12,%rax
  100e29:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    }

    // add on the rest of the items in the second storage array
    while (j < len2) {
  100e2d:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
  100e31:	48 39 c3             	cmp    %rax,%rbx
  100e34:	73 3e                	jae    100e74 <merge+0x20f>
  100e36:	48 89 c7             	mov    %rax,%rdi
  100e39:	48 29 df             	sub    %rbx,%rdi
  100e3c:	48 c1 e7 04          	shl    $0x4,%rdi
  100e40:	48 c1 e3 04          	shl    $0x4,%rbx
  100e44:	49 8d 34 1f          	lea    (%r15,%rbx,1),%rsi
  100e48:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  100e4c:	48 c1 e2 04          	shl    $0x4,%rdx
  100e50:	48 03 55 a8          	add    -0x58(%rbp),%rdx
  100e54:	b8 00 00 00 00       	mov    $0x0,%eax
        array[k] = temp2[j];
  100e59:	48 8b 0c 06          	mov    (%rsi,%rax,1),%rcx
  100e5d:	48 8b 5c 06 08       	mov    0x8(%rsi,%rax,1),%rbx
  100e62:	48 89 0c 02          	mov    %rcx,(%rdx,%rax,1)
  100e66:	48 89 5c 02 08       	mov    %rbx,0x8(%rdx,%rax,1)
    while (j < len2) {
  100e6b:	48 83 c0 10          	add    $0x10,%rax
  100e6f:	48 39 c7             	cmp    %rax,%rdi
  100e72:	75 e5                	jne    100e59 <merge+0x1f4>
        j++;
        k++;
    }
}
  100e74:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
  100e78:	5b                   	pop    %rbx
  100e79:	41 5c                	pop    %r12
  100e7b:	41 5d                	pop    %r13
  100e7d:	41 5e                	pop    %r14
  100e7f:	41 5f                	pop    %r15
  100e81:	5d                   	pop    %rbp
  100e82:	c3                   	ret    
    size_t j = 0;
  100e83:	48 8b 5d c0          	mov    -0x40(%rbp),%rbx
  100e87:	eb a4                	jmp    100e2d <merge+0x1c8>
  100e89:	4c 8b 65 b8          	mov    -0x48(%rbp),%r12
  100e8d:	4c 89 e3             	mov    %r12,%rbx
    while (i < len1) {
  100e90:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
  100e95:	0f 85 42 ff ff ff    	jne    100ddd <merge+0x178>
  100e9b:	eb d7                	jmp    100e74 <merge+0x20f>

0000000000100e9d <merge_sort>:
//    specialized function to compare the specific values of the array.

void merge_sort(heap_info_node *array, size_t left, size_t right,
                int (*compare)(const void *, const void *)) {
    // check indices as base case for the recursion
    if (left < right) {
  100e9d:	48 39 d6             	cmp    %rdx,%rsi
  100ea0:	72 01                	jb     100ea3 <merge_sort+0x6>
  100ea2:	c3                   	ret    
                int (*compare)(const void *, const void *)) {
  100ea3:	55                   	push   %rbp
  100ea4:	48 89 e5             	mov    %rsp,%rbp
  100ea7:	41 57                	push   %r15
  100ea9:	41 56                	push   %r14
  100eab:	41 55                	push   %r13
  100ead:	41 54                	push   %r12
  100eaf:	53                   	push   %rbx
  100eb0:	48 83 ec 08          	sub    $0x8,%rsp
  100eb4:	49 89 fd             	mov    %rdi,%r13
  100eb7:	48 89 f3             	mov    %rsi,%rbx
  100eba:	49 89 d4             	mov    %rdx,%r12
  100ebd:	49 89 ce             	mov    %rcx,%r14
        // calculate the center of the array    
        size_t center = (left + right - 1) / 2;
  100ec0:	4c 8d 7c 16 ff       	lea    -0x1(%rsi,%rdx,1),%r15
  100ec5:	49 d1 ef             	shr    %r15

        // recursively call the merge_sort() algorithm to sort subsections
        merge_sort(array, left, center, compare);
  100ec8:	4c 89 fa             	mov    %r15,%rdx
  100ecb:	e8 cd ff ff ff       	call   100e9d <merge_sort>
        merge_sort(array, center + 1, right, compare);
  100ed0:	49 8d 77 01          	lea    0x1(%r15),%rsi
  100ed4:	4c 89 f1             	mov    %r14,%rcx
  100ed7:	4c 89 e2             	mov    %r12,%rdx
  100eda:	4c 89 ef             	mov    %r13,%rdi
  100edd:	e8 bb ff ff ff       	call   100e9d <merge_sort>

        // merge all resulting arrays back into one
        merge(array, left, center, right, compare);
  100ee2:	4d 89 f0             	mov    %r14,%r8
  100ee5:	4c 89 e1             	mov    %r12,%rcx
  100ee8:	4c 89 fa             	mov    %r15,%rdx
  100eeb:	48 89 de             	mov    %rbx,%rsi
  100eee:	4c 89 ef             	mov    %r13,%rdi
  100ef1:	e8 6f fd ff ff       	call   100c65 <merge>
    }
}
  100ef6:	48 83 c4 08          	add    $0x8,%rsp
  100efa:	5b                   	pop    %rbx
  100efb:	41 5c                	pop    %r12
  100efd:	41 5d                	pop    %r13
  100eff:	41 5e                	pop    %r14
  100f01:	41 5f                	pop    %r15
  100f03:	5d                   	pop    %rbp
  100f04:	c3                   	ret    

0000000000100f05 <malloc>:

// IMPLEMENT REQUIRED FUNCTIONS
void *malloc(uint64_t numbytes) {
    if (numbytes == 0)
  100f05:	48 85 ff             	test   %rdi,%rdi
  100f08:	0f 84 96 00 00 00    	je     100fa4 <malloc+0x9f>
        return NULL;

    size_t size = sizeof(flist_node) + numbytes + 
                    alignof_eight(sizeof(flist_node) + numbytes);
  100f0e:	48 8d 77 18          	lea    0x18(%rdi),%rsi
    return ALIGNMENT_EIGHT - sz + (sz & ~(ALIGNMENT_EIGHT - 1));
  100f12:	48 89 f0             	mov    %rsi,%rax
  100f15:	48 83 e0 f8          	and    $0xfffffffffffffff8,%rax
  100f19:	4c 8d 44 07 20       	lea    0x20(%rdi,%rax,1),%r8
    size_t size = sizeof(flist_node) + numbytes + 
  100f1e:	4c 89 c7             	mov    %r8,%rdi
  100f21:	48 29 f7             	sub    %rsi,%rdi
    
    flist_node *tmp = head.next;
  100f24:	48 8b 05 25 21 00 00 	mov    0x2125(%rip),%rax        # 103050 <head+0x10>
    flist_node **ptr = &head.next;

    while (tmp != NULL) {
  100f2b:	48 85 c0             	test   %rax,%rax
  100f2e:	74 53                	je     100f83 <malloc+0x7e>
    flist_node **ptr = &head.next;
  100f30:	ba 50 30 10 00       	mov    $0x103050,%edx
  100f35:	eb 13                	jmp    100f4a <malloc+0x45>
                nblock->free = 1;
                nblock->next = tmp->next;
                *ptr = nblock;
            } else {
                size += difference;
                *ptr = tmp->next;
  100f37:	48 8b 78 10          	mov    0x10(%rax),%rdi
  100f3b:	eb 3e                	jmp    100f7b <malloc+0x76>
            }

            return (void *)((uintptr_t)tmp + sizeof(flist_node));
        }

        ptr = &(tmp->next);
  100f3d:	48 8d 50 10          	lea    0x10(%rax),%rdx
        tmp = tmp->next;
  100f41:	48 8b 40 10          	mov    0x10(%rax),%rax
    while (tmp != NULL) {
  100f45:	48 85 c0             	test   %rax,%rax
  100f48:	74 39                	je     100f83 <malloc+0x7e>
        if (tmp->free && tmp->size >= size) {
  100f4a:	48 83 78 08 00       	cmpq   $0x0,0x8(%rax)
  100f4f:	74 ec                	je     100f3d <malloc+0x38>
  100f51:	48 8b 08             	mov    (%rax),%rcx
  100f54:	48 39 f9             	cmp    %rdi,%rcx
  100f57:	72 e4                	jb     100f3d <malloc+0x38>
            size_t difference = tmp->size - size;
  100f59:	4c 29 c6             	sub    %r8,%rsi
  100f5c:	48 01 ce             	add    %rcx,%rsi
            if (difference > sizeof(flist_node)) {
  100f5f:	48 83 fe 18          	cmp    $0x18,%rsi
  100f63:	76 d2                	jbe    100f37 <malloc+0x32>
                flist_node *nblock = (flist_node *)((uintptr_t)tmp + size);
  100f65:	48 01 c7             	add    %rax,%rdi
                nblock->size = difference;
  100f68:	48 89 37             	mov    %rsi,(%rdi)
                nblock->free = 1;
  100f6b:	48 c7 47 08 01 00 00 	movq   $0x1,0x8(%rdi)
  100f72:	00 
                nblock->next = tmp->next;
  100f73:	48 8b 48 10          	mov    0x10(%rax),%rcx
  100f77:	48 89 4f 10          	mov    %rcx,0x10(%rdi)
                *ptr = nblock;
  100f7b:	48 89 3a             	mov    %rdi,(%rdx)
            return (void *)((uintptr_t)tmp + sizeof(flist_node));
  100f7e:	48 83 c0 18          	add    $0x18,%rax
  100f82:	c3                   	ret    
//     On success, sbrk() returns the previous program break
//     (If the break was increased, then this value is a pointer to the start of the newly allocated memory)
//      On error, (void *) -1 is returned
static inline void * sbrk(const intptr_t increment) {
    static void * result;
    asm volatile ("int %1" :  "=a" (result)
  100f83:	cd 3a                	int    $0x3a
  100f85:	48 89 05 a4 20 00 00 	mov    %rax,0x20a4(%rip)        # 103030 <result.0>
    }

    tmp = (flist_node *)sbrk(size);
    tmp->size = size;
  100f8c:	48 89 38             	mov    %rdi,(%rax)
    tmp->free = 0;
  100f8f:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
  100f96:	00 
    tmp->next = (flist_node *)NULL;
  100f97:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
  100f9e:	00 

    return (void *)((uintptr_t)tmp + sizeof(flist_node));
  100f9f:	48 83 c0 18          	add    $0x18,%rax
  100fa3:	c3                   	ret    
        return NULL;
  100fa4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100fa9:	c3                   	ret    

0000000000100faa <free>:

void free(void *firstbyte) {
    // free the location by setting the corresponding bit
    flist_node *tmp = (flist_node *)((uintptr_t)firstbyte - 
                        sizeof(flist_node));
    tmp->free = 1;
  100faa:	48 c7 47 f0 01 00 00 	movq   $0x1,-0x10(%rdi)
  100fb1:	00 
}
  100fb2:	c3                   	ret    

0000000000100fb3 <calloc>:

void *calloc(uint64_t num, uint64_t sz) {
  100fb3:	55                   	push   %rbp
  100fb4:	48 89 e5             	mov    %rsp,%rbp
  100fb7:	41 54                	push   %r12
  100fb9:	53                   	push   %rbx
    // alloc new space and set all memory to zero
    void *ptr = malloc(num * sz);
  100fba:	48 0f af fe          	imul   %rsi,%rdi
  100fbe:	49 89 fc             	mov    %rdi,%r12
  100fc1:	e8 3f ff ff ff       	call   100f05 <malloc>
  100fc6:	48 89 c3             	mov    %rax,%rbx
    memset(ptr, 0, num * sz);
  100fc9:	4c 89 e2             	mov    %r12,%rdx
  100fcc:	be 00 00 00 00       	mov    $0x0,%esi
  100fd1:	48 89 c7             	mov    %rax,%rdi
  100fd4:	e8 64 f3 ff ff       	call   10033d <memset>
    return ptr;
}
  100fd9:	48 89 d8             	mov    %rbx,%rax
  100fdc:	5b                   	pop    %rbx
  100fdd:	41 5c                	pop    %r12
  100fdf:	5d                   	pop    %rbp
  100fe0:	c3                   	ret    

0000000000100fe1 <realloc>:

void *realloc(void *ptr, uint64_t sz) {
  100fe1:	55                   	push   %rbp
  100fe2:	48 89 e5             	mov    %rsp,%rbp
  100fe5:	41 55                	push   %r13
  100fe7:	41 54                	push   %r12
  100fe9:	53                   	push   %rbx
  100fea:	48 83 ec 08          	sub    $0x8,%rsp
  100fee:	48 89 fb             	mov    %rdi,%rbx
  100ff1:	48 89 f7             	mov    %rsi,%rdi
    // error handling (multiple cases)
    if (ptr == NULL)
  100ff4:	48 85 db             	test   %rbx,%rbx
  100ff7:	74 37                	je     101030 <realloc+0x4f>
        return malloc(sz);

    if (ptr != NULL && sz == 0) {
  100ff9:	48 85 f6             	test   %rsi,%rsi
  100ffc:	74 3c                	je     10103a <realloc+0x59>
        free(ptr);
        return NULL;
    }

    // alloc new space for the information
    void *nptr = malloc(sz);
  100ffe:	e8 02 ff ff ff       	call   100f05 <malloc>
  101003:	49 89 c4             	mov    %rax,%r12

    // find locations of full size (this includes flist_node and the block)
    flist_node *nptr_node = (flist_node *)((uintptr_t)nptr - 
                                sizeof(flist_node));
    flist_node *ptr_node = (flist_node *)((uintptr_t)ptr - 
  101006:	4c 8d 6b e8          	lea    -0x18(%rbx),%r13
    flist_node *nptr_node = (flist_node *)((uintptr_t)nptr - 
  10100a:	48 8d 78 e8          	lea    -0x18(%rax),%rdi
                                sizeof(flist_node));

    // copy over all of the information and free the old space
    memcpy(nptr_node, ptr_node, ptr_node->size);
  10100e:	48 8b 53 e8          	mov    -0x18(%rbx),%rdx
  101012:	4c 89 ee             	mov    %r13,%rsi
  101015:	e8 ba f2 ff ff       	call   1002d4 <memcpy>
    tmp->free = 1;
  10101a:	48 c7 43 f0 01 00 00 	movq   $0x1,-0x10(%rbx)
  101021:	00 
    free(ptr);

    return nptr;
}
  101022:	4c 89 e0             	mov    %r12,%rax
  101025:	48 83 c4 08          	add    $0x8,%rsp
  101029:	5b                   	pop    %rbx
  10102a:	41 5c                	pop    %r12
  10102c:	41 5d                	pop    %r13
  10102e:	5d                   	pop    %rbp
  10102f:	c3                   	ret    
        return malloc(sz);
  101030:	e8 d0 fe ff ff       	call   100f05 <malloc>
  101035:	49 89 c4             	mov    %rax,%r12
  101038:	eb e8                	jmp    101022 <realloc+0x41>
    tmp->free = 1;
  10103a:	48 c7 43 f0 01 00 00 	movq   $0x1,-0x10(%rbx)
  101041:	00 
        return NULL;
  101042:	41 bc 00 00 00 00    	mov    $0x0,%r12d
}
  101048:	eb d8                	jmp    101022 <realloc+0x41>

000000000010104a <defrag>:

void defrag() {
    // loop through list to find all adjacent free blocks and combine them
    flist_node *tmp1 = head.next;
  10104a:	48 8b 15 ff 1f 00 00 	mov    0x1fff(%rip),%rdx        # 103050 <head+0x10>
    while (tmp1 != NULL) {
  101051:	48 85 d2             	test   %rdx,%rdx
  101054:	74 25                	je     10107b <defrag+0x31>
        flist_node *tmp2 = tmp1->next;
  101056:	48 8b 42 10          	mov    0x10(%rdx),%rax
        while (tmp2->free && tmp2 != NULL) {
  10105a:	48 83 78 08 00       	cmpq   $0x0,0x8(%rax)
  10105f:	74 11                	je     101072 <defrag+0x28>
            tmp1->size += tmp2->size;
  101061:	48 8b 08             	mov    (%rax),%rcx
  101064:	48 01 0a             	add    %rcx,(%rdx)
            tmp2 = tmp2->next;
  101067:	48 8b 40 10          	mov    0x10(%rax),%rax
        while (tmp2->free && tmp2 != NULL) {
  10106b:	48 83 78 08 00       	cmpq   $0x0,0x8(%rax)
  101070:	75 ef                	jne    101061 <defrag+0x17>
        }
        tmp1->next = tmp2;
  101072:	48 89 42 10          	mov    %rax,0x10(%rdx)
  101076:	48 89 c2             	mov    %rax,%rdx
  101079:	eb db                	jmp    101056 <defrag+0xc>
        tmp1 = tmp1->next;
    }
}
  10107b:	c3                   	ret    

000000000010107c <heap_info>:

int heap_info(heap_info_struct *info) {
  10107c:	55                   	push   %rbp
  10107d:	48 89 e5             	mov    %rsp,%rbp
  101080:	41 57                	push   %r15
  101082:	41 56                	push   %r14
  101084:	41 55                	push   %r13
  101086:	41 54                	push   %r12
  101088:	53                   	push   %rbx
  101089:	48 83 ec 28          	sub    $0x28,%rsp
  10108d:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    size_t num_allocs = 0;
    size_t free_space = 0;
    size_t largest_free_chunk = 0;

    // iterate through free list and make initial calculations
    flist_node *tmp = head.next;
  101091:	48 8b 05 b8 1f 00 00 	mov    0x1fb8(%rip),%rax        # 103050 <head+0x10>
    while (tmp != NULL) {
  101098:	48 85 c0             	test   %rax,%rax
  10109b:	74 42                	je     1010df <heap_info+0x63>
    size_t largest_free_chunk = 0;
  10109d:	41 bd 00 00 00 00    	mov    $0x0,%r13d
    size_t free_space = 0;
  1010a3:	41 be 00 00 00 00    	mov    $0x0,%r14d
    size_t num_allocs = 0;
  1010a9:	41 bf 00 00 00 00    	mov    $0x0,%r15d
    size_t size = 0;
  1010af:	bb 00 00 00 00       	mov    $0x0,%ebx
  1010b4:	eb 11                	jmp    1010c7 <heap_info+0x4b>
            free_space += sizeof(flist_node) + tmp->size;
            if (tmp->size > largest_free_chunk) {
                largest_free_chunk = tmp->size;
            }
        } else
            num_allocs++;
  1010b6:	49 83 c7 01          	add    $0x1,%r15

        size++;
  1010ba:	48 83 c3 01          	add    $0x1,%rbx
        tmp = tmp->next;
  1010be:	48 8b 40 10          	mov    0x10(%rax),%rax
    while (tmp != NULL) {
  1010c2:	48 85 c0             	test   %rax,%rax
  1010c5:	74 2f                	je     1010f6 <heap_info+0x7a>
        if (tmp->free) {
  1010c7:	48 83 78 08 00       	cmpq   $0x0,0x8(%rax)
  1010cc:	74 e8                	je     1010b6 <heap_info+0x3a>
            free_space += sizeof(flist_node) + tmp->size;
  1010ce:	48 8b 10             	mov    (%rax),%rdx
  1010d1:	4e 8d 74 32 18       	lea    0x18(%rdx,%r14,1),%r14
            if (tmp->size > largest_free_chunk) {
  1010d6:	49 39 d5             	cmp    %rdx,%r13
  1010d9:	4c 0f 42 ea          	cmovb  %rdx,%r13
  1010dd:	eb db                	jmp    1010ba <heap_info+0x3e>
    size_t largest_free_chunk = 0;
  1010df:	41 bd 00 00 00 00    	mov    $0x0,%r13d
    size_t free_space = 0;
  1010e5:	41 be 00 00 00 00    	mov    $0x0,%r14d
    size_t num_allocs = 0;
  1010eb:	41 bf 00 00 00 00    	mov    $0x0,%r15d
    size_t size = 0;
  1010f1:	bb 00 00 00 00       	mov    $0x0,%ebx
    }

    // create temporary array of structs to sort all values
    heap_info_node *struct_array =
        (heap_info_node *)malloc(sizeof(heap_info_node) * size);
  1010f6:	48 89 df             	mov    %rbx,%rdi
  1010f9:	48 c1 e7 04          	shl    $0x4,%rdi
  1010fd:	e8 03 fe ff ff       	call   100f05 <malloc>
  101102:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    if (struct_array == NULL) {
  101106:	48 85 c0             	test   %rax,%rax
  101109:	74 14                	je     10111f <heap_info+0xa3>
        info->ptr_array = (void **)NULL;
        // return ERROR;
    }

    // populate temporary array as necessary
    tmp = head.next;
  10110b:	48 8b 05 3e 1f 00 00 	mov    0x1f3e(%rip),%rax        # 103050 <head+0x10>
    size_t i = 0;
    while (tmp != NULL) {
  101112:	48 85 c0             	test   %rax,%rax
  101115:	74 4d                	je     101164 <heap_info+0xe8>
    size_t i = 0;
  101117:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  10111d:	eb 1f                	jmp    10113e <heap_info+0xc2>
        info->size_array = (long *)NULL;
  10111f:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
  101123:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
  10112a:	00 
        info->ptr_array = (void **)NULL;
  10112b:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
  101132:	00 
  101133:	eb d6                	jmp    10110b <heap_info+0x8f>
            struct_array[i].size = tmp->size;
            struct_array[i].ptr = (void *)((uintptr_t)tmp + 
                                    sizeof(flist_node));
            i++;
        }
        tmp = tmp->next;
  101135:	48 8b 40 10          	mov    0x10(%rax),%rax
    while (tmp != NULL) {
  101139:	48 85 c0             	test   %rax,%rax
  10113c:	74 2c                	je     10116a <heap_info+0xee>
        if (!tmp->free) {
  10113e:	48 83 78 08 00       	cmpq   $0x0,0x8(%rax)
  101143:	75 f0                	jne    101135 <heap_info+0xb9>
            struct_array[i].size = tmp->size;
  101145:	4c 89 e2             	mov    %r12,%rdx
  101148:	48 c1 e2 04          	shl    $0x4,%rdx
  10114c:	48 03 55 c8          	add    -0x38(%rbp),%rdx
  101150:	48 8b 08             	mov    (%rax),%rcx
  101153:	48 89 0a             	mov    %rcx,(%rdx)
            struct_array[i].ptr = (void *)((uintptr_t)tmp + 
  101156:	48 8d 48 18          	lea    0x18(%rax),%rcx
  10115a:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
            i++;
  10115e:	49 83 c4 01          	add    $0x1,%r12
  101162:	eb d1                	jmp    101135 <heap_info+0xb9>
    size_t i = 0;
  101164:	41 bc 00 00 00 00    	mov    $0x0,%r12d
    }

    // perform merge sort algorithm on the array of structs
    merge_sort(struct_array, 0, size, comp_structs);
  10116a:	b9 49 0c 10 00       	mov    $0x100c49,%ecx
  10116f:	48 89 da             	mov    %rbx,%rdx
  101172:	be 00 00 00 00       	mov    $0x0,%esi
  101177:	48 8b 7d c8          	mov    -0x38(%rbp),%rdi
  10117b:	e8 1d fd ff ff       	call   100e9d <merge_sort>

    // create return arrays to be passed onto the user
    long *size_array = (long *)malloc(sizeof(long) * size);
  101180:	48 8d 04 dd 00 00 00 	lea    0x0(,%rbx,8),%rax
  101187:	00 
  101188:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
  10118c:	48 89 c7             	mov    %rax,%rdi
  10118f:	e8 71 fd ff ff       	call   100f05 <malloc>
  101194:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    if (size_array == NULL) {
  101198:	48 85 c0             	test   %rax,%rax
  10119b:	0f 84 90 00 00 00    	je     101231 <heap_info+0x1b5>
        info->size_array = (long *)NULL;
        info->ptr_array = (void **)NULL;
        return ERROR;
    }

    void **ptr_array = (void **)malloc(sizeof(void *) * size);
  1011a1:	48 8b 7d b0          	mov    -0x50(%rbp),%rdi
  1011a5:	e8 5b fd ff ff       	call   100f05 <malloc>
  1011aa:	48 89 c7             	mov    %rax,%rdi
    if (ptr_array == NULL) {
  1011ad:	48 85 c0             	test   %rax,%rax
  1011b0:	0f 84 96 00 00 00    	je     10124c <heap_info+0x1d0>
        info->ptr_array = (void **)NULL;
        return ERROR;
    }

    // copy sorted information into the return arrays
    for (size_t j = 0; j < size; j++)
  1011b6:	48 85 db             	test   %rbx,%rbx
  1011b9:	74 47                	je     101202 <heap_info+0x186>
        size_array[i] = struct_array[i].size;
  1011bb:	4c 89 e0             	mov    %r12,%rax
  1011be:	48 c1 e0 04          	shl    $0x4,%rax
  1011c2:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  1011c6:	48 01 c2             	add    %rax,%rdx
  1011c9:	49 c1 e4 03          	shl    $0x3,%r12
  1011cd:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  1011d1:	4a 8d 34 20          	lea    (%rax,%r12,1),%rsi
    for (size_t j = 0; j < size; j++)
  1011d5:	b8 00 00 00 00       	mov    $0x0,%eax
        size_array[i] = struct_array[i].size;
  1011da:	48 8b 0a             	mov    (%rdx),%rcx
  1011dd:	48 89 0e             	mov    %rcx,(%rsi)
    for (size_t j = 0; j < size; j++)
  1011e0:	48 83 c0 01          	add    $0x1,%rax
  1011e4:	48 39 d8             	cmp    %rbx,%rax
  1011e7:	75 f1                	jne    1011da <heap_info+0x15e>
    for (size_t j = 0; j < size; j++)
        ptr_array[i] = struct_array[i].ptr;
  1011e9:	49 01 fc             	add    %rdi,%r12
  1011ec:	b8 00 00 00 00       	mov    $0x0,%eax
  1011f1:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  1011f5:	49 89 0c 24          	mov    %rcx,(%r12)
    for (size_t j = 0; j < size; j++)
  1011f9:	48 83 c0 01          	add    $0x1,%rax
  1011fd:	48 39 d8             	cmp    %rbx,%rax
  101200:	75 ef                	jne    1011f1 <heap_info+0x175>

    // set all final values in the heap info struct
    info->num_allocs = num_allocs;
  101202:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
  101206:	44 89 38             	mov    %r15d,(%rax)
    info->size_array = size_array;
  101209:	48 8b 75 c0          	mov    -0x40(%rbp),%rsi
  10120d:	48 89 70 08          	mov    %rsi,0x8(%rax)
    info->ptr_array = ptr_array;
  101211:	48 89 78 10          	mov    %rdi,0x10(%rax)
    info->free_space = free_space;
  101215:	44 89 70 18          	mov    %r14d,0x18(%rax)
    info->largest_free_chunk = largest_free_chunk;
  101219:	44 89 68 1c          	mov    %r13d,0x1c(%rax)

    return SUCCESS;
  10121d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  101222:	48 83 c4 28          	add    $0x28,%rsp
  101226:	5b                   	pop    %rbx
  101227:	41 5c                	pop    %r12
  101229:	41 5d                	pop    %r13
  10122b:	41 5e                	pop    %r14
  10122d:	41 5f                	pop    %r15
  10122f:	5d                   	pop    %rbp
  101230:	c3                   	ret    
        info->size_array = (long *)NULL;
  101231:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
  101235:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
  10123c:	00 
        info->ptr_array = (void **)NULL;
  10123d:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
  101244:	00 
        return ERROR;
  101245:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10124a:	eb d6                	jmp    101222 <heap_info+0x1a6>
        info->size_array = (long *)NULL;
  10124c:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
  101250:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
  101257:	00 
        info->ptr_array = (void **)NULL;
  101258:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
  10125f:	00 
        return ERROR;
  101260:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  101265:	eb bb                	jmp    101222 <heap_info+0x1a6>

0000000000101267 <app_printf>:
#include "process.h"

// app_printf
//     A version of console_printf that picks a sensible color by process ID.

void app_printf(int colorid, const char* format, ...) {
  101267:	55                   	push   %rbp
  101268:	48 89 e5             	mov    %rsp,%rbp
  10126b:	48 83 ec 50          	sub    $0x50,%rsp
  10126f:	49 89 f2             	mov    %rsi,%r10
  101272:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  101276:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  10127a:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  10127e:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    int color;
    if (colorid < 0) {
        color = 0x0700;
  101282:	be 00 07 00 00       	mov    $0x700,%esi
    if (colorid < 0) {
  101287:	85 ff                	test   %edi,%edi
  101289:	78 2e                	js     1012b9 <app_printf+0x52>
    } else {
        static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
        color = col[colorid % sizeof(col)] << 8;
  10128b:	48 63 ff             	movslq %edi,%rdi
  10128e:	48 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rdx
  101295:	cc cc cc 
  101298:	48 89 f8             	mov    %rdi,%rax
  10129b:	48 f7 e2             	mul    %rdx
  10129e:	48 89 d0             	mov    %rdx,%rax
  1012a1:	48 c1 e8 02          	shr    $0x2,%rax
  1012a5:	48 83 e2 fc          	and    $0xfffffffffffffffc,%rdx
  1012a9:	48 01 c2             	add    %rax,%rdx
  1012ac:	48 29 d7             	sub    %rdx,%rdi
  1012af:	0f b6 b7 bd 16 10 00 	movzbl 0x1016bd(%rdi),%esi
  1012b6:	c1 e6 08             	shl    $0x8,%esi
    }

    va_list val;
    va_start(val, format);
  1012b9:	c7 45 b8 10 00 00 00 	movl   $0x10,-0x48(%rbp)
  1012c0:	48 8d 45 10          	lea    0x10(%rbp),%rax
  1012c4:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  1012c8:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  1012cc:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cursorpos = console_vprintf(cursorpos, color, format, val);
  1012d0:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  1012d4:	4c 89 d2             	mov    %r10,%rdx
  1012d7:	8b 3d 1f 7d fb ff    	mov    -0x482e1(%rip),%edi        # b8ffc <cursorpos>
  1012dd:	e8 4b f8 ff ff       	call   100b2d <console_vprintf>
    va_end(val);

    if (CROW(cursorpos) >= 23) {
        cursorpos = CPOS(0, 0);
  1012e2:	3d 30 07 00 00       	cmp    $0x730,%eax
  1012e7:	ba 00 00 00 00       	mov    $0x0,%edx
  1012ec:	0f 4d c2             	cmovge %edx,%eax
  1012ef:	89 05 07 7d fb ff    	mov    %eax,-0x482f9(%rip)        # b8ffc <cursorpos>
    }
}
  1012f5:	c9                   	leave  
  1012f6:	c3                   	ret    

00000000001012f7 <kernel_panic>:


// kernel_panic, assert_fail
//     Call the INT_SYS_PANIC system call so the kernel loops until Control-C.

void kernel_panic(const char* format, ...) {
  1012f7:	55                   	push   %rbp
  1012f8:	48 89 e5             	mov    %rsp,%rbp
  1012fb:	53                   	push   %rbx
  1012fc:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  101303:	48 89 fb             	mov    %rdi,%rbx
  101306:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
  10130a:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  10130e:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
  101312:	4c 89 45 e0          	mov    %r8,-0x20(%rbp)
  101316:	4c 89 4d e8          	mov    %r9,-0x18(%rbp)
    va_list val;
    va_start(val, format);
  10131a:	c7 45 a8 08 00 00 00 	movl   $0x8,-0x58(%rbp)
  101321:	48 8d 45 10          	lea    0x10(%rbp),%rax
  101325:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
  101329:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  10132d:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    char buf[160];
    memcpy(buf, "PANIC: ", 7);
  101331:	ba 07 00 00 00       	mov    $0x7,%edx
  101336:	be 87 16 10 00       	mov    $0x101687,%esi
  10133b:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  101342:	e8 8d ef ff ff       	call   1002d4 <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  101347:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  10134b:	48 89 da             	mov    %rbx,%rdx
  10134e:	be 99 00 00 00       	mov    $0x99,%esi
  101353:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  10135a:	e8 49 f8 ff ff       	call   100ba8 <vsnprintf>
  10135f:	8d 50 07             	lea    0x7(%rax),%edx
    va_end(val);
    if (len > 0 && buf[len - 1] != '\n') {
  101362:	85 d2                	test   %edx,%edx
  101364:	7e 0f                	jle    101375 <kernel_panic+0x7e>
  101366:	83 c0 06             	add    $0x6,%eax
  101369:	48 98                	cltq   
  10136b:	80 bc 05 08 ff ff ff 	cmpb   $0xa,-0xf8(%rbp,%rax,1)
  101372:	0a 
  101373:	75 2a                	jne    10139f <kernel_panic+0xa8>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
    }
    (void) console_printf(CPOS(23, 0), 0xC000, "%s", buf);
  101375:	48 8d 9d 08 ff ff ff 	lea    -0xf8(%rbp),%rbx
  10137c:	48 89 d9             	mov    %rbx,%rcx
  10137f:	ba 91 16 10 00       	mov    $0x101691,%edx
  101384:	be 00 c0 00 00       	mov    $0xc000,%esi
  101389:	bf 30 07 00 00       	mov    $0x730,%edi
  10138e:	b8 00 00 00 00       	mov    $0x0,%eax
  101393:	e8 da f7 ff ff       	call   100b72 <console_printf>
    asm volatile ("int %0" : /* no result */
  101398:	48 89 df             	mov    %rbx,%rdi
  10139b:	cd 30                	int    $0x30
 loop: goto loop;
  10139d:	eb fe                	jmp    10139d <kernel_panic+0xa6>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
  10139f:	48 63 c2             	movslq %edx,%rax
  1013a2:	81 fa 9f 00 00 00    	cmp    $0x9f,%edx
  1013a8:	0f 94 c2             	sete   %dl
  1013ab:	0f b6 d2             	movzbl %dl,%edx
  1013ae:	48 29 d0             	sub    %rdx,%rax
  1013b1:	48 8d bc 05 08 ff ff 	lea    -0xf8(%rbp,%rax,1),%rdi
  1013b8:	ff 
  1013b9:	be 8f 16 10 00       	mov    $0x10168f,%esi
  1013be:	e8 d3 ef ff ff       	call   100396 <strcpy>
  1013c3:	eb b0                	jmp    101375 <kernel_panic+0x7e>

00000000001013c5 <assert_fail>:
    panic(buf);
 spinloop: goto spinloop;       // should never get here
}

void assert_fail(const char* file, int line, const char* msg) {
  1013c5:	55                   	push   %rbp
  1013c6:	48 89 e5             	mov    %rsp,%rbp
  1013c9:	48 89 f9             	mov    %rdi,%rcx
  1013cc:	41 89 f0             	mov    %esi,%r8d
  1013cf:	49 89 d1             	mov    %rdx,%r9
    (void) console_printf(CPOS(23, 0), 0xC000,
  1013d2:	ba 98 16 10 00       	mov    $0x101698,%edx
  1013d7:	be 00 c0 00 00       	mov    $0xc000,%esi
  1013dc:	bf 30 07 00 00       	mov    $0x730,%edi
  1013e1:	b8 00 00 00 00       	mov    $0x0,%eax
  1013e6:	e8 87 f7 ff ff       	call   100b72 <console_printf>
    asm volatile ("int %0" : /* no result */
  1013eb:	bf 00 00 00 00       	mov    $0x0,%edi
  1013f0:	cd 30                	int    $0x30
 loop: goto loop;
  1013f2:	eb fe                	jmp    1013f2 <assert_fail+0x2d>
