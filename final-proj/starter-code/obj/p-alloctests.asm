
obj/p-alloctests.full:     file format elf64-x86-64


Disassembly of section .text:

00000000002c0000 <process_main>:
#include "time.h"
#include "malloc.h"

extern uint8_t end[];

void process_main(void) {
  2c0000:	55                   	push   %rbp
  2c0001:	48 89 e5             	mov    %rsp,%rbp
  2c0004:	41 56                	push   %r14
  2c0006:	41 55                	push   %r13
  2c0008:	41 54                	push   %r12
  2c000a:	53                   	push   %rbx
  2c000b:	48 83 ec 20          	sub    $0x20,%rsp

// getpid
//    Return current process ID.
static inline pid_t getpid(void) {
    pid_t result;
    asm volatile ("int %1" : "=a" (result)
  2c000f:	cd 31                	int    $0x31
  2c0011:	41 89 c4             	mov    %eax,%r12d
    
    pid_t p = getpid();
    srand(p);
  2c0014:	89 c7                	mov    %eax,%edi
  2c0016:	e8 6a 03 00 00       	call   2c0385 <srand>

    // alloc int array of 10 elements
    int* array = (int *)malloc(sizeof(int) * 10);
  2c001b:	bf 28 00 00 00       	mov    $0x28,%edi
  2c0020:	e8 28 0e 00 00       	call   2c0e4d <malloc>
  2c0025:	48 89 c7             	mov    %rax,%rdi
  2c0028:	ba 00 00 00 00       	mov    $0x0,%edx
    
    // set array elements
    for(int  i = 0 ; i < 10; i++){
	array[i] = i;
  2c002d:	89 14 97             	mov    %edx,(%rdi,%rdx,4)
    for(int  i = 0 ; i < 10; i++){
  2c0030:	48 83 c2 01          	add    $0x1,%rdx
  2c0034:	48 83 fa 0a          	cmp    $0xa,%rdx
  2c0038:	75 f3                	jne    2c002d <process_main+0x2d>
    }

    // realloc array to size 20
    array = (int*)realloc(array, sizeof(int) * 20);
  2c003a:	be 50 00 00 00       	mov    $0x50,%esi
  2c003f:	e8 e5 0e 00 00       	call   2c0f29 <realloc>
  2c0044:	49 89 c5             	mov    %rax,%r13
  2c0047:	b8 00 00 00 00       	mov    $0x0,%eax

    // check if contents are same
    for(int i = 0 ; i < 10 ; i++){
	assert(array[i] == i);
  2c004c:	41 39 44 85 00       	cmp    %eax,0x0(%r13,%rax,4)
  2c0051:	75 64                	jne    2c00b7 <process_main+0xb7>
    for(int i = 0 ; i < 10 ; i++){
  2c0053:	48 83 c0 01          	add    $0x1,%rax
  2c0057:	48 83 f8 0a          	cmp    $0xa,%rax
  2c005b:	75 ef                	jne    2c004c <process_main+0x4c>
    }

    // alloc int array of size 30 using calloc
    int * array2 = (int *)calloc(30, sizeof(int));
  2c005d:	be 04 00 00 00       	mov    $0x4,%esi
  2c0062:	bf 1e 00 00 00       	mov    $0x1e,%edi
  2c0067:	e8 8f 0e 00 00       	call   2c0efb <calloc>
  2c006c:	49 89 c6             	mov    %rax,%r14

    // assert array[i] == 0
    for(int i = 0 ; i < 30; i++){
  2c006f:	48 8d 50 78          	lea    0x78(%rax),%rdx
	assert(array2[i] == 0);
  2c0073:	8b 18                	mov    (%rax),%ebx
  2c0075:	85 db                	test   %ebx,%ebx
  2c0077:	75 52                	jne    2c00cb <process_main+0xcb>
    for(int i = 0 ; i < 30; i++){
  2c0079:	48 83 c0 04          	add    $0x4,%rax
  2c007d:	48 39 d0             	cmp    %rdx,%rax
  2c0080:	75 f1                	jne    2c0073 <process_main+0x73>
    }
    
    heap_info_struct info;
    if(heap_info(&info) == 0){
  2c0082:	48 8d 7d c0          	lea    -0x40(%rbp),%rdi
  2c0086:	e8 39 0f 00 00       	call   2c0fc4 <heap_info>
  2c008b:	85 c0                	test   %eax,%eax
  2c008d:	75 64                	jne    2c00f3 <process_main+0xf3>
	// check if allocations are in sorted order
	for(int  i = 1 ; i < info.num_allocs; i++){
  2c008f:	8b 55 c0             	mov    -0x40(%rbp),%edx
  2c0092:	83 fa 01             	cmp    $0x1,%edx
  2c0095:	7e 70                	jle    2c0107 <process_main+0x107>
  2c0097:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c009b:	8d 52 fe             	lea    -0x2(%rdx),%edx
  2c009e:	48 8d 54 d0 08       	lea    0x8(%rax,%rdx,8),%rdx
	    assert(info.size_array[i] < info.size_array[i-1]);
  2c00a3:	48 8b 30             	mov    (%rax),%rsi
  2c00a6:	48 39 70 08          	cmp    %rsi,0x8(%rax)
  2c00aa:	7d 33                	jge    2c00df <process_main+0xdf>
	for(int  i = 1 ; i < info.num_allocs; i++){
  2c00ac:	48 83 c0 08          	add    $0x8,%rax
  2c00b0:	48 39 d0             	cmp    %rdx,%rax
  2c00b3:	75 ee                	jne    2c00a3 <process_main+0xa3>
  2c00b5:	eb 50                	jmp    2c0107 <process_main+0x107>
	assert(array[i] == i);
  2c00b7:	ba 40 13 2c 00       	mov    $0x2c1340,%edx
  2c00bc:	be 1a 00 00 00       	mov    $0x1a,%esi
  2c00c1:	bf 4e 13 2c 00       	mov    $0x2c134e,%edi
  2c00c6:	e8 42 12 00 00       	call   2c130d <assert_fail>
	assert(array2[i] == 0);
  2c00cb:	ba 5d 13 2c 00       	mov    $0x2c135d,%edx
  2c00d0:	be 22 00 00 00       	mov    $0x22,%esi
  2c00d5:	bf 4e 13 2c 00       	mov    $0x2c134e,%edi
  2c00da:	e8 2e 12 00 00       	call   2c130d <assert_fail>
	    assert(info.size_array[i] < info.size_array[i-1]);
  2c00df:	ba 80 13 2c 00       	mov    $0x2c1380,%edx
  2c00e4:	be 29 00 00 00       	mov    $0x29,%esi
  2c00e9:	bf 4e 13 2c 00       	mov    $0x2c134e,%edi
  2c00ee:	e8 1a 12 00 00       	call   2c130d <assert_fail>
	}
    }
    else{
	app_printf(0, "heap_info failed\n");
  2c00f3:	be 6c 13 2c 00       	mov    $0x2c136c,%esi
  2c00f8:	bf 00 00 00 00       	mov    $0x0,%edi
  2c00fd:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0102:	e8 a8 10 00 00       	call   2c11af <app_printf>
    }
    
    // free array, array2
    free(array);
  2c0107:	4c 89 ef             	mov    %r13,%rdi
  2c010a:	e8 e3 0d 00 00       	call   2c0ef2 <free>
    free(array2);
  2c010f:	4c 89 f7             	mov    %r14,%rdi
  2c0112:	e8 db 0d 00 00       	call   2c0ef2 <free>

    uint64_t total_time = 0;
  2c0117:	41 bd 00 00 00 00    	mov    $0x0,%r13d
/* rdtscp */
static uint64_t rdtsc(void) {
	uint64_t var;
	uint32_t hi, lo;

	__asm volatile
  2c011d:	0f 31                	rdtsc  
	    ("rdtsc" : "=a" (lo), "=d" (hi));

	var = ((uint64_t)hi << 32) | lo;
  2c011f:	48 c1 e2 20          	shl    $0x20,%rdx
  2c0123:	89 c0                	mov    %eax,%eax
  2c0125:	48 09 c2             	or     %rax,%rdx
  2c0128:	49 89 d6             	mov    %rdx,%r14
    int total_pages = 0;
    
    // allocate pages till no more memory
    while (1) {
	uint64_t time = rdtsc();
	void * ptr = malloc(PAGESIZE);
  2c012b:	bf 00 10 00 00       	mov    $0x1000,%edi
  2c0130:	e8 18 0d 00 00       	call   2c0e4d <malloc>
  2c0135:	48 89 c1             	mov    %rax,%rcx
	__asm volatile
  2c0138:	0f 31                	rdtsc  
	var = ((uint64_t)hi << 32) | lo;
  2c013a:	48 c1 e2 20          	shl    $0x20,%rdx
  2c013e:	89 c0                	mov    %eax,%eax
  2c0140:	48 09 c2             	or     %rax,%rdx
	total_time += (rdtsc() - time);
  2c0143:	4c 29 f2             	sub    %r14,%rdx
  2c0146:	49 01 d5             	add    %rdx,%r13
	if(ptr == NULL)
  2c0149:	48 85 c9             	test   %rcx,%rcx
  2c014c:	74 08                	je     2c0156 <process_main+0x156>
	    break;
	total_pages++;
  2c014e:	83 c3 01             	add    $0x1,%ebx
	*((int *)ptr) = p; // check write access
  2c0151:	44 89 21             	mov    %r12d,(%rcx)
    while (1) {
  2c0154:	eb c7                	jmp    2c011d <process_main+0x11d>
    }

    app_printf(p, "Total_time taken to alloc: %d Average time: %d\n", total_time, total_time/total_pages);
  2c0156:	48 63 db             	movslq %ebx,%rbx
  2c0159:	4c 89 e8             	mov    %r13,%rax
  2c015c:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0161:	48 f7 f3             	div    %rbx
  2c0164:	48 89 c1             	mov    %rax,%rcx
  2c0167:	4c 89 ea             	mov    %r13,%rdx
  2c016a:	be b0 13 2c 00       	mov    $0x2c13b0,%esi
  2c016f:	44 89 e7             	mov    %r12d,%edi
  2c0172:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0177:	e8 33 10 00 00       	call   2c11af <app_printf>

// yield
//    Yield control of the CPU to the kernel. The kernel will pick another
//    process to run, if possible.
static inline void yield(void) {
    asm volatile ("int %0" : /* no result */
  2c017c:	cd 32                	int    $0x32
  2c017e:	eb fc                	jmp    2c017c <process_main+0x17c>

00000000002c0180 <console_putc>:
typedef struct console_printer {
    printer p;
    uint16_t* cursor;
} console_printer;

static void console_putc(printer* p, unsigned char c, int color) {
  2c0180:	48 89 f9             	mov    %rdi,%rcx
  2c0183:	89 d7                	mov    %edx,%edi
    console_printer* cp = (console_printer*) p;
    if (cp->cursor >= console + CONSOLE_ROWS * CONSOLE_COLUMNS) {
  2c0185:	48 81 79 08 a0 8f 0b 	cmpq   $0xb8fa0,0x8(%rcx)
  2c018c:	00 
  2c018d:	72 08                	jb     2c0197 <console_putc+0x17>
        cp->cursor = console;
  2c018f:	48 c7 41 08 00 80 0b 	movq   $0xb8000,0x8(%rcx)
  2c0196:	00 
    }
    if (c == '\n') {
  2c0197:	40 80 fe 0a          	cmp    $0xa,%sil
  2c019b:	74 16                	je     2c01b3 <console_putc+0x33>
        int pos = (cp->cursor - console) % 80;
        for (; pos != 80; pos++) {
            *cp->cursor++ = ' ' | color;
        }
    } else {
        *cp->cursor++ = c | color;
  2c019d:	48 8b 41 08          	mov    0x8(%rcx),%rax
  2c01a1:	48 8d 50 02          	lea    0x2(%rax),%rdx
  2c01a5:	48 89 51 08          	mov    %rdx,0x8(%rcx)
  2c01a9:	40 0f b6 f6          	movzbl %sil,%esi
  2c01ad:	09 fe                	or     %edi,%esi
  2c01af:	66 89 30             	mov    %si,(%rax)
    }
}
  2c01b2:	c3                   	ret    
        int pos = (cp->cursor - console) % 80;
  2c01b3:	4c 8b 41 08          	mov    0x8(%rcx),%r8
  2c01b7:	49 81 e8 00 80 0b 00 	sub    $0xb8000,%r8
  2c01be:	4c 89 c6             	mov    %r8,%rsi
  2c01c1:	48 d1 fe             	sar    %rsi
  2c01c4:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
  2c01cb:	66 66 66 
  2c01ce:	48 89 f0             	mov    %rsi,%rax
  2c01d1:	48 f7 ea             	imul   %rdx
  2c01d4:	48 c1 fa 05          	sar    $0x5,%rdx
  2c01d8:	49 c1 f8 3f          	sar    $0x3f,%r8
  2c01dc:	4c 29 c2             	sub    %r8,%rdx
  2c01df:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
  2c01e3:	48 c1 e2 04          	shl    $0x4,%rdx
  2c01e7:	89 f0                	mov    %esi,%eax
  2c01e9:	29 d0                	sub    %edx,%eax
            *cp->cursor++ = ' ' | color;
  2c01eb:	83 cf 20             	or     $0x20,%edi
  2c01ee:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  2c01f2:	48 8d 72 02          	lea    0x2(%rdx),%rsi
  2c01f6:	48 89 71 08          	mov    %rsi,0x8(%rcx)
  2c01fa:	66 89 3a             	mov    %di,(%rdx)
        for (; pos != 80; pos++) {
  2c01fd:	83 c0 01             	add    $0x1,%eax
  2c0200:	83 f8 50             	cmp    $0x50,%eax
  2c0203:	75 e9                	jne    2c01ee <console_putc+0x6e>
  2c0205:	c3                   	ret    

00000000002c0206 <string_putc>:
    char* end;
} string_printer;

static void string_putc(printer* p, unsigned char c, int color) {
    string_printer* sp = (string_printer*) p;
    if (sp->s < sp->end) {
  2c0206:	48 8b 47 08          	mov    0x8(%rdi),%rax
  2c020a:	48 3b 47 10          	cmp    0x10(%rdi),%rax
  2c020e:	73 0b                	jae    2c021b <string_putc+0x15>
        *sp->s++ = c;
  2c0210:	48 8d 50 01          	lea    0x1(%rax),%rdx
  2c0214:	48 89 57 08          	mov    %rdx,0x8(%rdi)
  2c0218:	40 88 30             	mov    %sil,(%rax)
    }
    (void) color;
}
  2c021b:	c3                   	ret    

00000000002c021c <memcpy>:
void* memcpy(void* dst, const void* src, size_t n) {
  2c021c:	48 89 f8             	mov    %rdi,%rax
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  2c021f:	48 85 d2             	test   %rdx,%rdx
  2c0222:	74 17                	je     2c023b <memcpy+0x1f>
  2c0224:	b9 00 00 00 00       	mov    $0x0,%ecx
        *d = *s;
  2c0229:	44 0f b6 04 0e       	movzbl (%rsi,%rcx,1),%r8d
  2c022e:	44 88 04 08          	mov    %r8b,(%rax,%rcx,1)
    for (char* d = (char*) dst; n > 0; --n, ++s, ++d) {
  2c0232:	48 83 c1 01          	add    $0x1,%rcx
  2c0236:	48 39 d1             	cmp    %rdx,%rcx
  2c0239:	75 ee                	jne    2c0229 <memcpy+0xd>
}
  2c023b:	c3                   	ret    

00000000002c023c <memmove>:
void* memmove(void* dst, const void* src, size_t n) {
  2c023c:	48 89 f8             	mov    %rdi,%rax
    if (s < d && s + n > d) {
  2c023f:	48 39 fe             	cmp    %rdi,%rsi
  2c0242:	72 1d                	jb     2c0261 <memmove+0x25>
        while (n-- > 0) {
  2c0244:	b9 00 00 00 00       	mov    $0x0,%ecx
  2c0249:	48 85 d2             	test   %rdx,%rdx
  2c024c:	74 12                	je     2c0260 <memmove+0x24>
            *d++ = *s++;
  2c024e:	0f b6 3c 0e          	movzbl (%rsi,%rcx,1),%edi
  2c0252:	40 88 3c 08          	mov    %dil,(%rax,%rcx,1)
        while (n-- > 0) {
  2c0256:	48 83 c1 01          	add    $0x1,%rcx
  2c025a:	48 39 ca             	cmp    %rcx,%rdx
  2c025d:	75 ef                	jne    2c024e <memmove+0x12>
}
  2c025f:	c3                   	ret    
  2c0260:	c3                   	ret    
    if (s < d && s + n > d) {
  2c0261:	48 8d 0c 16          	lea    (%rsi,%rdx,1),%rcx
  2c0265:	48 39 cf             	cmp    %rcx,%rdi
  2c0268:	73 da                	jae    2c0244 <memmove+0x8>
        while (n-- > 0) {
  2c026a:	48 8d 4a ff          	lea    -0x1(%rdx),%rcx
  2c026e:	48 85 d2             	test   %rdx,%rdx
  2c0271:	74 ec                	je     2c025f <memmove+0x23>
            *--d = *--s;
  2c0273:	0f b6 14 0e          	movzbl (%rsi,%rcx,1),%edx
  2c0277:	88 14 08             	mov    %dl,(%rax,%rcx,1)
        while (n-- > 0) {
  2c027a:	48 83 e9 01          	sub    $0x1,%rcx
  2c027e:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
  2c0282:	75 ef                	jne    2c0273 <memmove+0x37>
  2c0284:	c3                   	ret    

00000000002c0285 <memset>:
void* memset(void* v, int c, size_t n) {
  2c0285:	48 89 f8             	mov    %rdi,%rax
    for (char* p = (char*) v; n > 0; ++p, --n) {
  2c0288:	48 85 d2             	test   %rdx,%rdx
  2c028b:	74 12                	je     2c029f <memset+0x1a>
  2c028d:	48 01 fa             	add    %rdi,%rdx
  2c0290:	48 89 f9             	mov    %rdi,%rcx
        *p = c;
  2c0293:	40 88 31             	mov    %sil,(%rcx)
    for (char* p = (char*) v; n > 0; ++p, --n) {
  2c0296:	48 83 c1 01          	add    $0x1,%rcx
  2c029a:	48 39 ca             	cmp    %rcx,%rdx
  2c029d:	75 f4                	jne    2c0293 <memset+0xe>
}
  2c029f:	c3                   	ret    

00000000002c02a0 <strlen>:
    for (n = 0; *s != '\0'; ++s) {
  2c02a0:	80 3f 00             	cmpb   $0x0,(%rdi)
  2c02a3:	74 10                	je     2c02b5 <strlen+0x15>
  2c02a5:	b8 00 00 00 00       	mov    $0x0,%eax
        ++n;
  2c02aa:	48 83 c0 01          	add    $0x1,%rax
    for (n = 0; *s != '\0'; ++s) {
  2c02ae:	80 3c 07 00          	cmpb   $0x0,(%rdi,%rax,1)
  2c02b2:	75 f6                	jne    2c02aa <strlen+0xa>
  2c02b4:	c3                   	ret    
  2c02b5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  2c02ba:	c3                   	ret    

00000000002c02bb <strnlen>:
size_t strnlen(const char* s, size_t maxlen) {
  2c02bb:	48 89 f0             	mov    %rsi,%rax
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  2c02be:	ba 00 00 00 00       	mov    $0x0,%edx
  2c02c3:	48 85 f6             	test   %rsi,%rsi
  2c02c6:	74 11                	je     2c02d9 <strnlen+0x1e>
  2c02c8:	80 3c 17 00          	cmpb   $0x0,(%rdi,%rdx,1)
  2c02cc:	74 0c                	je     2c02da <strnlen+0x1f>
        ++n;
  2c02ce:	48 83 c2 01          	add    $0x1,%rdx
    for (n = 0; n != maxlen && *s != '\0'; ++s) {
  2c02d2:	48 39 d0             	cmp    %rdx,%rax
  2c02d5:	75 f1                	jne    2c02c8 <strnlen+0xd>
  2c02d7:	eb 04                	jmp    2c02dd <strnlen+0x22>
  2c02d9:	c3                   	ret    
  2c02da:	48 89 d0             	mov    %rdx,%rax
}
  2c02dd:	c3                   	ret    

00000000002c02de <strcpy>:
char* strcpy(char* dst, const char* src) {
  2c02de:	48 89 f8             	mov    %rdi,%rax
  2c02e1:	ba 00 00 00 00       	mov    $0x0,%edx
        *d++ = *src++;
  2c02e6:	0f b6 0c 16          	movzbl (%rsi,%rdx,1),%ecx
  2c02ea:	88 0c 10             	mov    %cl,(%rax,%rdx,1)
    } while (d[-1]);
  2c02ed:	48 83 c2 01          	add    $0x1,%rdx
  2c02f1:	84 c9                	test   %cl,%cl
  2c02f3:	75 f1                	jne    2c02e6 <strcpy+0x8>
}
  2c02f5:	c3                   	ret    

00000000002c02f6 <strcmp>:
    while (*a && *b && *a == *b) {
  2c02f6:	0f b6 07             	movzbl (%rdi),%eax
  2c02f9:	84 c0                	test   %al,%al
  2c02fb:	74 1a                	je     2c0317 <strcmp+0x21>
  2c02fd:	0f b6 16             	movzbl (%rsi),%edx
  2c0300:	38 c2                	cmp    %al,%dl
  2c0302:	75 13                	jne    2c0317 <strcmp+0x21>
  2c0304:	84 d2                	test   %dl,%dl
  2c0306:	74 0f                	je     2c0317 <strcmp+0x21>
        ++a, ++b;
  2c0308:	48 83 c7 01          	add    $0x1,%rdi
  2c030c:	48 83 c6 01          	add    $0x1,%rsi
    while (*a && *b && *a == *b) {
  2c0310:	0f b6 07             	movzbl (%rdi),%eax
  2c0313:	84 c0                	test   %al,%al
  2c0315:	75 e6                	jne    2c02fd <strcmp+0x7>
    return ((unsigned char) *a > (unsigned char) *b)
  2c0317:	3a 06                	cmp    (%rsi),%al
  2c0319:	0f 97 c0             	seta   %al
  2c031c:	0f b6 c0             	movzbl %al,%eax
        - ((unsigned char) *a < (unsigned char) *b);
  2c031f:	83 d8 00             	sbb    $0x0,%eax
}
  2c0322:	c3                   	ret    

00000000002c0323 <strchr>:
    while (*s && *s != (char) c) {
  2c0323:	0f b6 07             	movzbl (%rdi),%eax
  2c0326:	84 c0                	test   %al,%al
  2c0328:	74 10                	je     2c033a <strchr+0x17>
  2c032a:	40 38 f0             	cmp    %sil,%al
  2c032d:	74 18                	je     2c0347 <strchr+0x24>
        ++s;
  2c032f:	48 83 c7 01          	add    $0x1,%rdi
    while (*s && *s != (char) c) {
  2c0333:	0f b6 07             	movzbl (%rdi),%eax
  2c0336:	84 c0                	test   %al,%al
  2c0338:	75 f0                	jne    2c032a <strchr+0x7>
        return NULL;
  2c033a:	40 84 f6             	test   %sil,%sil
  2c033d:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0342:	48 0f 44 c7          	cmove  %rdi,%rax
}
  2c0346:	c3                   	ret    
  2c0347:	48 89 f8             	mov    %rdi,%rax
  2c034a:	c3                   	ret    

00000000002c034b <rand>:
    if (!rand_seed_set) {
  2c034b:	83 3d b2 1c 00 00 00 	cmpl   $0x0,0x1cb2(%rip)        # 2c2004 <rand_seed_set>
  2c0352:	74 1b                	je     2c036f <rand+0x24>
    rand_seed = rand_seed * 1664525U + 1013904223U;
  2c0354:	69 05 a2 1c 00 00 0d 	imul   $0x19660d,0x1ca2(%rip),%eax        # 2c2000 <rand_seed>
  2c035b:	66 19 00 
  2c035e:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
  2c0363:	89 05 97 1c 00 00    	mov    %eax,0x1c97(%rip)        # 2c2000 <rand_seed>
    return rand_seed & RAND_MAX;
  2c0369:	25 ff ff ff 7f       	and    $0x7fffffff,%eax
}
  2c036e:	c3                   	ret    
    rand_seed = seed;
  2c036f:	c7 05 87 1c 00 00 9e 	movl   $0x30d4879e,0x1c87(%rip)        # 2c2000 <rand_seed>
  2c0376:	87 d4 30 
    rand_seed_set = 1;
  2c0379:	c7 05 81 1c 00 00 01 	movl   $0x1,0x1c81(%rip)        # 2c2004 <rand_seed_set>
  2c0380:	00 00 00 
}
  2c0383:	eb cf                	jmp    2c0354 <rand+0x9>

00000000002c0385 <srand>:
    rand_seed = seed;
  2c0385:	89 3d 75 1c 00 00    	mov    %edi,0x1c75(%rip)        # 2c2000 <rand_seed>
    rand_seed_set = 1;
  2c038b:	c7 05 6f 1c 00 00 01 	movl   $0x1,0x1c6f(%rip)        # 2c2004 <rand_seed_set>
  2c0392:	00 00 00 
}
  2c0395:	c3                   	ret    

00000000002c0396 <printer_vprintf>:
void printer_vprintf(printer* p, int color, const char* format, va_list val) {
  2c0396:	55                   	push   %rbp
  2c0397:	48 89 e5             	mov    %rsp,%rbp
  2c039a:	41 57                	push   %r15
  2c039c:	41 56                	push   %r14
  2c039e:	41 55                	push   %r13
  2c03a0:	41 54                	push   %r12
  2c03a2:	53                   	push   %rbx
  2c03a3:	48 83 ec 58          	sub    $0x58,%rsp
  2c03a7:	48 89 4d 90          	mov    %rcx,-0x70(%rbp)
    for (; *format; ++format) {
  2c03ab:	0f b6 02             	movzbl (%rdx),%eax
  2c03ae:	84 c0                	test   %al,%al
  2c03b0:	0f 84 b0 06 00 00    	je     2c0a66 <printer_vprintf+0x6d0>
  2c03b6:	49 89 fe             	mov    %rdi,%r14
  2c03b9:	49 89 d4             	mov    %rdx,%r12
            length = 1;
  2c03bc:	41 89 f7             	mov    %esi,%r15d
  2c03bf:	e9 a4 04 00 00       	jmp    2c0868 <printer_vprintf+0x4d2>
        for (++format; *format; ++format) {
  2c03c4:	49 8d 5c 24 01       	lea    0x1(%r12),%rbx
  2c03c9:	45 0f b6 64 24 01    	movzbl 0x1(%r12),%r12d
  2c03cf:	45 84 e4             	test   %r12b,%r12b
  2c03d2:	0f 84 82 06 00 00    	je     2c0a5a <printer_vprintf+0x6c4>
        int flags = 0;
  2c03d8:	41 bd 00 00 00 00    	mov    $0x0,%r13d
            const char* flagc = strchr(flag_chars, *format);
  2c03de:	41 0f be f4          	movsbl %r12b,%esi
  2c03e2:	bf e1 15 2c 00       	mov    $0x2c15e1,%edi
  2c03e7:	e8 37 ff ff ff       	call   2c0323 <strchr>
  2c03ec:	48 89 c1             	mov    %rax,%rcx
            if (flagc) {
  2c03ef:	48 85 c0             	test   %rax,%rax
  2c03f2:	74 55                	je     2c0449 <printer_vprintf+0xb3>
                flags |= 1 << (flagc - flag_chars);
  2c03f4:	48 81 e9 e1 15 2c 00 	sub    $0x2c15e1,%rcx
  2c03fb:	b8 01 00 00 00       	mov    $0x1,%eax
  2c0400:	d3 e0                	shl    %cl,%eax
  2c0402:	41 09 c5             	or     %eax,%r13d
        for (++format; *format; ++format) {
  2c0405:	48 83 c3 01          	add    $0x1,%rbx
  2c0409:	44 0f b6 23          	movzbl (%rbx),%r12d
  2c040d:	45 84 e4             	test   %r12b,%r12b
  2c0410:	75 cc                	jne    2c03de <printer_vprintf+0x48>
  2c0412:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
        int width = -1;
  2c0416:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
        int precision = -1;
  2c041c:	c7 45 9c ff ff ff ff 	movl   $0xffffffff,-0x64(%rbp)
        if (*format == '.') {
  2c0423:	80 3b 2e             	cmpb   $0x2e,(%rbx)
  2c0426:	0f 84 a9 00 00 00    	je     2c04d5 <printer_vprintf+0x13f>
        int length = 0;
  2c042c:	b9 00 00 00 00       	mov    $0x0,%ecx
        switch (*format) {
  2c0431:	0f b6 13             	movzbl (%rbx),%edx
  2c0434:	8d 42 bd             	lea    -0x43(%rdx),%eax
  2c0437:	3c 37                	cmp    $0x37,%al
  2c0439:	0f 87 c4 04 00 00    	ja     2c0903 <printer_vprintf+0x56d>
  2c043f:	0f b6 c0             	movzbl %al,%eax
  2c0442:	ff 24 c5 f0 13 2c 00 	jmp    *0x2c13f0(,%rax,8)
        if (*format >= '1' && *format <= '9') {
  2c0449:	44 89 6d a8          	mov    %r13d,-0x58(%rbp)
  2c044d:	41 8d 44 24 cf       	lea    -0x31(%r12),%eax
  2c0452:	3c 08                	cmp    $0x8,%al
  2c0454:	77 2f                	ja     2c0485 <printer_vprintf+0xef>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  2c0456:	0f b6 03             	movzbl (%rbx),%eax
  2c0459:	8d 50 d0             	lea    -0x30(%rax),%edx
  2c045c:	80 fa 09             	cmp    $0x9,%dl
  2c045f:	77 5e                	ja     2c04bf <printer_vprintf+0x129>
  2c0461:	41 bd 00 00 00 00    	mov    $0x0,%r13d
                width = 10 * width + *format++ - '0';
  2c0467:	48 83 c3 01          	add    $0x1,%rbx
  2c046b:	43 8d 54 ad 00       	lea    0x0(%r13,%r13,4),%edx
  2c0470:	0f be c0             	movsbl %al,%eax
  2c0473:	44 8d 6c 50 d0       	lea    -0x30(%rax,%rdx,2),%r13d
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  2c0478:	0f b6 03             	movzbl (%rbx),%eax
  2c047b:	8d 50 d0             	lea    -0x30(%rax),%edx
  2c047e:	80 fa 09             	cmp    $0x9,%dl
  2c0481:	76 e4                	jbe    2c0467 <printer_vprintf+0xd1>
  2c0483:	eb 97                	jmp    2c041c <printer_vprintf+0x86>
        } else if (*format == '*') {
  2c0485:	41 80 fc 2a          	cmp    $0x2a,%r12b
  2c0489:	75 3f                	jne    2c04ca <printer_vprintf+0x134>
            width = va_arg(val, int);
  2c048b:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  2c048f:	8b 07                	mov    (%rdi),%eax
  2c0491:	83 f8 2f             	cmp    $0x2f,%eax
  2c0494:	77 17                	ja     2c04ad <printer_vprintf+0x117>
  2c0496:	89 c2                	mov    %eax,%edx
  2c0498:	48 03 57 10          	add    0x10(%rdi),%rdx
  2c049c:	83 c0 08             	add    $0x8,%eax
  2c049f:	89 07                	mov    %eax,(%rdi)
  2c04a1:	44 8b 2a             	mov    (%rdx),%r13d
            ++format;
  2c04a4:	48 83 c3 01          	add    $0x1,%rbx
  2c04a8:	e9 6f ff ff ff       	jmp    2c041c <printer_vprintf+0x86>
            width = va_arg(val, int);
  2c04ad:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  2c04b1:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  2c04b5:	48 8d 42 08          	lea    0x8(%rdx),%rax
  2c04b9:	48 89 41 08          	mov    %rax,0x8(%rcx)
  2c04bd:	eb e2                	jmp    2c04a1 <printer_vprintf+0x10b>
            for (width = 0; *format >= '0' && *format <= '9'; ) {
  2c04bf:	41 bd 00 00 00 00    	mov    $0x0,%r13d
  2c04c5:	e9 52 ff ff ff       	jmp    2c041c <printer_vprintf+0x86>
        int width = -1;
  2c04ca:	41 bd ff ff ff ff    	mov    $0xffffffff,%r13d
  2c04d0:	e9 47 ff ff ff       	jmp    2c041c <printer_vprintf+0x86>
            ++format;
  2c04d5:	48 8d 53 01          	lea    0x1(%rbx),%rdx
            if (*format >= '0' && *format <= '9') {
  2c04d9:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
  2c04dd:	8d 48 d0             	lea    -0x30(%rax),%ecx
  2c04e0:	80 f9 09             	cmp    $0x9,%cl
  2c04e3:	76 13                	jbe    2c04f8 <printer_vprintf+0x162>
            } else if (*format == '*') {
  2c04e5:	3c 2a                	cmp    $0x2a,%al
  2c04e7:	74 33                	je     2c051c <printer_vprintf+0x186>
            ++format;
  2c04e9:	48 89 d3             	mov    %rdx,%rbx
                precision = 0;
  2c04ec:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
  2c04f3:	e9 34 ff ff ff       	jmp    2c042c <printer_vprintf+0x96>
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  2c04f8:	b9 00 00 00 00       	mov    $0x0,%ecx
                    precision = 10 * precision + *format++ - '0';
  2c04fd:	48 83 c2 01          	add    $0x1,%rdx
  2c0501:	8d 0c 89             	lea    (%rcx,%rcx,4),%ecx
  2c0504:	0f be c0             	movsbl %al,%eax
  2c0507:	8d 4c 48 d0          	lea    -0x30(%rax,%rcx,2),%ecx
                for (precision = 0; *format >= '0' && *format <= '9'; ) {
  2c050b:	0f b6 02             	movzbl (%rdx),%eax
  2c050e:	8d 70 d0             	lea    -0x30(%rax),%esi
  2c0511:	40 80 fe 09          	cmp    $0x9,%sil
  2c0515:	76 e6                	jbe    2c04fd <printer_vprintf+0x167>
                    precision = 10 * precision + *format++ - '0';
  2c0517:	48 89 d3             	mov    %rdx,%rbx
  2c051a:	eb 1c                	jmp    2c0538 <printer_vprintf+0x1a2>
                precision = va_arg(val, int);
  2c051c:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  2c0520:	8b 07                	mov    (%rdi),%eax
  2c0522:	83 f8 2f             	cmp    $0x2f,%eax
  2c0525:	77 23                	ja     2c054a <printer_vprintf+0x1b4>
  2c0527:	89 c2                	mov    %eax,%edx
  2c0529:	48 03 57 10          	add    0x10(%rdi),%rdx
  2c052d:	83 c0 08             	add    $0x8,%eax
  2c0530:	89 07                	mov    %eax,(%rdi)
  2c0532:	8b 0a                	mov    (%rdx),%ecx
                ++format;
  2c0534:	48 83 c3 02          	add    $0x2,%rbx
            if (precision < 0) {
  2c0538:	85 c9                	test   %ecx,%ecx
  2c053a:	b8 00 00 00 00       	mov    $0x0,%eax
  2c053f:	0f 49 c1             	cmovns %ecx,%eax
  2c0542:	89 45 9c             	mov    %eax,-0x64(%rbp)
  2c0545:	e9 e2 fe ff ff       	jmp    2c042c <printer_vprintf+0x96>
                precision = va_arg(val, int);
  2c054a:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  2c054e:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  2c0552:	48 8d 42 08          	lea    0x8(%rdx),%rax
  2c0556:	48 89 41 08          	mov    %rax,0x8(%rcx)
  2c055a:	eb d6                	jmp    2c0532 <printer_vprintf+0x19c>
        switch (*format) {
  2c055c:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
  2c0561:	e9 f3 00 00 00       	jmp    2c0659 <printer_vprintf+0x2c3>
            ++format;
  2c0566:	48 83 c3 01          	add    $0x1,%rbx
            length = 1;
  2c056a:	b9 01 00 00 00       	mov    $0x1,%ecx
            goto again;
  2c056f:	e9 bd fe ff ff       	jmp    2c0431 <printer_vprintf+0x9b>
            long x = length ? va_arg(val, long) : va_arg(val, int);
  2c0574:	85 c9                	test   %ecx,%ecx
  2c0576:	74 55                	je     2c05cd <printer_vprintf+0x237>
  2c0578:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  2c057c:	8b 07                	mov    (%rdi),%eax
  2c057e:	83 f8 2f             	cmp    $0x2f,%eax
  2c0581:	77 38                	ja     2c05bb <printer_vprintf+0x225>
  2c0583:	89 c2                	mov    %eax,%edx
  2c0585:	48 03 57 10          	add    0x10(%rdi),%rdx
  2c0589:	83 c0 08             	add    $0x8,%eax
  2c058c:	89 07                	mov    %eax,(%rdi)
  2c058e:	48 8b 12             	mov    (%rdx),%rdx
            int negative = x < 0 ? FLAG_NEGATIVE : 0;
  2c0591:	48 89 d0             	mov    %rdx,%rax
  2c0594:	48 c1 f8 38          	sar    $0x38,%rax
            num = negative ? -x : x;
  2c0598:	49 89 d0             	mov    %rdx,%r8
  2c059b:	49 f7 d8             	neg    %r8
  2c059e:	25 80 00 00 00       	and    $0x80,%eax
  2c05a3:	4c 0f 44 c2          	cmove  %rdx,%r8
            flags |= FLAG_NUMERIC | FLAG_SIGNED | negative;
  2c05a7:	0b 45 a8             	or     -0x58(%rbp),%eax
  2c05aa:	83 c8 60             	or     $0x60,%eax
  2c05ad:	89 45 a8             	mov    %eax,-0x58(%rbp)
        char* data = "";
  2c05b0:	41 bc 7d 13 2c 00    	mov    $0x2c137d,%r12d
            break;
  2c05b6:	e9 35 01 00 00       	jmp    2c06f0 <printer_vprintf+0x35a>
            long x = length ? va_arg(val, long) : va_arg(val, int);
  2c05bb:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  2c05bf:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  2c05c3:	48 8d 42 08          	lea    0x8(%rdx),%rax
  2c05c7:	48 89 41 08          	mov    %rax,0x8(%rcx)
  2c05cb:	eb c1                	jmp    2c058e <printer_vprintf+0x1f8>
  2c05cd:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  2c05d1:	8b 07                	mov    (%rdi),%eax
  2c05d3:	83 f8 2f             	cmp    $0x2f,%eax
  2c05d6:	77 10                	ja     2c05e8 <printer_vprintf+0x252>
  2c05d8:	89 c2                	mov    %eax,%edx
  2c05da:	48 03 57 10          	add    0x10(%rdi),%rdx
  2c05de:	83 c0 08             	add    $0x8,%eax
  2c05e1:	89 07                	mov    %eax,(%rdi)
  2c05e3:	48 63 12             	movslq (%rdx),%rdx
  2c05e6:	eb a9                	jmp    2c0591 <printer_vprintf+0x1fb>
  2c05e8:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  2c05ec:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  2c05f0:	48 8d 42 08          	lea    0x8(%rdx),%rax
  2c05f4:	48 89 47 08          	mov    %rax,0x8(%rdi)
  2c05f8:	eb e9                	jmp    2c05e3 <printer_vprintf+0x24d>
        int base = 10;
  2c05fa:	be 0a 00 00 00       	mov    $0xa,%esi
  2c05ff:	eb 58                	jmp    2c0659 <printer_vprintf+0x2c3>
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  2c0601:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  2c0605:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  2c0609:	48 8d 42 08          	lea    0x8(%rdx),%rax
  2c060d:	48 89 41 08          	mov    %rax,0x8(%rcx)
  2c0611:	eb 60                	jmp    2c0673 <printer_vprintf+0x2dd>
  2c0613:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  2c0617:	8b 07                	mov    (%rdi),%eax
  2c0619:	83 f8 2f             	cmp    $0x2f,%eax
  2c061c:	77 10                	ja     2c062e <printer_vprintf+0x298>
  2c061e:	89 c2                	mov    %eax,%edx
  2c0620:	48 03 57 10          	add    0x10(%rdi),%rdx
  2c0624:	83 c0 08             	add    $0x8,%eax
  2c0627:	89 07                	mov    %eax,(%rdi)
  2c0629:	44 8b 02             	mov    (%rdx),%r8d
  2c062c:	eb 48                	jmp    2c0676 <printer_vprintf+0x2e0>
  2c062e:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  2c0632:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  2c0636:	48 8d 42 08          	lea    0x8(%rdx),%rax
  2c063a:	48 89 41 08          	mov    %rax,0x8(%rcx)
  2c063e:	eb e9                	jmp    2c0629 <printer_vprintf+0x293>
  2c0640:	41 89 f1             	mov    %esi,%r9d
        if (flags & FLAG_NUMERIC) {
  2c0643:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
    const char* digits = upper_digits;
  2c064a:	bf d0 15 2c 00       	mov    $0x2c15d0,%edi
  2c064f:	e9 e2 02 00 00       	jmp    2c0936 <printer_vprintf+0x5a0>
            base = 16;
  2c0654:	be 10 00 00 00       	mov    $0x10,%esi
            num = length ? va_arg(val, unsigned long) : va_arg(val, unsigned);
  2c0659:	85 c9                	test   %ecx,%ecx
  2c065b:	74 b6                	je     2c0613 <printer_vprintf+0x27d>
  2c065d:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  2c0661:	8b 01                	mov    (%rcx),%eax
  2c0663:	83 f8 2f             	cmp    $0x2f,%eax
  2c0666:	77 99                	ja     2c0601 <printer_vprintf+0x26b>
  2c0668:	89 c2                	mov    %eax,%edx
  2c066a:	48 03 51 10          	add    0x10(%rcx),%rdx
  2c066e:	83 c0 08             	add    $0x8,%eax
  2c0671:	89 01                	mov    %eax,(%rcx)
  2c0673:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_NUMERIC;
  2c0676:	83 4d a8 20          	orl    $0x20,-0x58(%rbp)
    if (base < 0) {
  2c067a:	85 f6                	test   %esi,%esi
  2c067c:	79 c2                	jns    2c0640 <printer_vprintf+0x2aa>
        base = -base;
  2c067e:	41 89 f1             	mov    %esi,%r9d
  2c0681:	f7 de                	neg    %esi
  2c0683:	c7 45 8c 20 00 00 00 	movl   $0x20,-0x74(%rbp)
        digits = lower_digits;
  2c068a:	bf b0 15 2c 00       	mov    $0x2c15b0,%edi
  2c068f:	e9 a2 02 00 00       	jmp    2c0936 <printer_vprintf+0x5a0>
            num = (uintptr_t) va_arg(val, void*);
  2c0694:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  2c0698:	8b 07                	mov    (%rdi),%eax
  2c069a:	83 f8 2f             	cmp    $0x2f,%eax
  2c069d:	77 1c                	ja     2c06bb <printer_vprintf+0x325>
  2c069f:	89 c2                	mov    %eax,%edx
  2c06a1:	48 03 57 10          	add    0x10(%rdi),%rdx
  2c06a5:	83 c0 08             	add    $0x8,%eax
  2c06a8:	89 07                	mov    %eax,(%rdi)
  2c06aa:	4c 8b 02             	mov    (%rdx),%r8
            flags |= FLAG_ALT | FLAG_ALT2 | FLAG_NUMERIC;
  2c06ad:	81 4d a8 21 01 00 00 	orl    $0x121,-0x58(%rbp)
            base = -16;
  2c06b4:	be f0 ff ff ff       	mov    $0xfffffff0,%esi
  2c06b9:	eb c3                	jmp    2c067e <printer_vprintf+0x2e8>
            num = (uintptr_t) va_arg(val, void*);
  2c06bb:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  2c06bf:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  2c06c3:	48 8d 42 08          	lea    0x8(%rdx),%rax
  2c06c7:	48 89 41 08          	mov    %rax,0x8(%rcx)
  2c06cb:	eb dd                	jmp    2c06aa <printer_vprintf+0x314>
            data = va_arg(val, char*);
  2c06cd:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  2c06d1:	8b 01                	mov    (%rcx),%eax
  2c06d3:	83 f8 2f             	cmp    $0x2f,%eax
  2c06d6:	0f 87 a5 01 00 00    	ja     2c0881 <printer_vprintf+0x4eb>
  2c06dc:	89 c2                	mov    %eax,%edx
  2c06de:	48 03 51 10          	add    0x10(%rcx),%rdx
  2c06e2:	83 c0 08             	add    $0x8,%eax
  2c06e5:	89 01                	mov    %eax,(%rcx)
  2c06e7:	4c 8b 22             	mov    (%rdx),%r12
        unsigned long num = 0;
  2c06ea:	41 b8 00 00 00 00    	mov    $0x0,%r8d
        if (flags & FLAG_NUMERIC) {
  2c06f0:	8b 45 a8             	mov    -0x58(%rbp),%eax
  2c06f3:	83 e0 20             	and    $0x20,%eax
  2c06f6:	89 45 8c             	mov    %eax,-0x74(%rbp)
  2c06f9:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
  2c06ff:	0f 85 21 02 00 00    	jne    2c0926 <printer_vprintf+0x590>
        if ((flags & FLAG_NUMERIC) && (flags & FLAG_SIGNED)) {
  2c0705:	8b 45 a8             	mov    -0x58(%rbp),%eax
  2c0708:	89 45 88             	mov    %eax,-0x78(%rbp)
  2c070b:	83 e0 60             	and    $0x60,%eax
  2c070e:	83 f8 60             	cmp    $0x60,%eax
  2c0711:	0f 84 54 02 00 00    	je     2c096b <printer_vprintf+0x5d5>
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  2c0717:	8b 45 a8             	mov    -0x58(%rbp),%eax
  2c071a:	83 e0 21             	and    $0x21,%eax
        const char* prefix = "";
  2c071d:	48 c7 45 a0 7d 13 2c 	movq   $0x2c137d,-0x60(%rbp)
  2c0724:	00 
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ALT)
  2c0725:	83 f8 21             	cmp    $0x21,%eax
  2c0728:	0f 84 79 02 00 00    	je     2c09a7 <printer_vprintf+0x611>
        if (precision >= 0 && !(flags & FLAG_NUMERIC)) {
  2c072e:	8b 7d 9c             	mov    -0x64(%rbp),%edi
  2c0731:	89 f8                	mov    %edi,%eax
  2c0733:	f7 d0                	not    %eax
  2c0735:	c1 e8 1f             	shr    $0x1f,%eax
  2c0738:	89 45 84             	mov    %eax,-0x7c(%rbp)
  2c073b:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
  2c073f:	0f 85 9e 02 00 00    	jne    2c09e3 <printer_vprintf+0x64d>
  2c0745:	84 c0                	test   %al,%al
  2c0747:	0f 84 96 02 00 00    	je     2c09e3 <printer_vprintf+0x64d>
            len = strnlen(data, precision);
  2c074d:	48 63 f7             	movslq %edi,%rsi
  2c0750:	4c 89 e7             	mov    %r12,%rdi
  2c0753:	e8 63 fb ff ff       	call   2c02bb <strnlen>
  2c0758:	89 45 98             	mov    %eax,-0x68(%rbp)
                   && !(flags & FLAG_LEFTJUSTIFY)
  2c075b:	8b 45 88             	mov    -0x78(%rbp),%eax
  2c075e:	83 e0 26             	and    $0x26,%eax
            zeros = 0;
  2c0761:	c7 45 9c 00 00 00 00 	movl   $0x0,-0x64(%rbp)
        } else if ((flags & FLAG_NUMERIC) && (flags & FLAG_ZERO)
  2c0768:	83 f8 22             	cmp    $0x22,%eax
  2c076b:	0f 84 aa 02 00 00    	je     2c0a1b <printer_vprintf+0x685>
        width -= len + zeros + strlen(prefix);
  2c0771:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  2c0775:	e8 26 fb ff ff       	call   2c02a0 <strlen>
  2c077a:	8b 55 9c             	mov    -0x64(%rbp),%edx
  2c077d:	03 55 98             	add    -0x68(%rbp),%edx
  2c0780:	44 89 e9             	mov    %r13d,%ecx
  2c0783:	29 d1                	sub    %edx,%ecx
  2c0785:	29 c1                	sub    %eax,%ecx
  2c0787:	89 4d 8c             	mov    %ecx,-0x74(%rbp)
  2c078a:	41 89 cd             	mov    %ecx,%r13d
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  2c078d:	f6 45 a8 04          	testb  $0x4,-0x58(%rbp)
  2c0791:	75 2d                	jne    2c07c0 <printer_vprintf+0x42a>
  2c0793:	85 c9                	test   %ecx,%ecx
  2c0795:	7e 29                	jle    2c07c0 <printer_vprintf+0x42a>
            p->putc(p, ' ', color);
  2c0797:	44 89 fa             	mov    %r15d,%edx
  2c079a:	be 20 00 00 00       	mov    $0x20,%esi
  2c079f:	4c 89 f7             	mov    %r14,%rdi
  2c07a2:	41 ff 16             	call   *(%r14)
        for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width) {
  2c07a5:	41 83 ed 01          	sub    $0x1,%r13d
  2c07a9:	45 85 ed             	test   %r13d,%r13d
  2c07ac:	7f e9                	jg     2c0797 <printer_vprintf+0x401>
  2c07ae:	8b 7d 8c             	mov    -0x74(%rbp),%edi
  2c07b1:	85 ff                	test   %edi,%edi
  2c07b3:	b8 01 00 00 00       	mov    $0x1,%eax
  2c07b8:	0f 4f c7             	cmovg  %edi,%eax
  2c07bb:	29 c7                	sub    %eax,%edi
  2c07bd:	41 89 fd             	mov    %edi,%r13d
        for (; *prefix; ++prefix) {
  2c07c0:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  2c07c4:	0f b6 07             	movzbl (%rdi),%eax
  2c07c7:	84 c0                	test   %al,%al
  2c07c9:	74 22                	je     2c07ed <printer_vprintf+0x457>
  2c07cb:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  2c07cf:	48 89 fb             	mov    %rdi,%rbx
            p->putc(p, *prefix, color);
  2c07d2:	0f b6 f0             	movzbl %al,%esi
  2c07d5:	44 89 fa             	mov    %r15d,%edx
  2c07d8:	4c 89 f7             	mov    %r14,%rdi
  2c07db:	41 ff 16             	call   *(%r14)
        for (; *prefix; ++prefix) {
  2c07de:	48 83 c3 01          	add    $0x1,%rbx
  2c07e2:	0f b6 03             	movzbl (%rbx),%eax
  2c07e5:	84 c0                	test   %al,%al
  2c07e7:	75 e9                	jne    2c07d2 <printer_vprintf+0x43c>
  2c07e9:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; zeros > 0; --zeros) {
  2c07ed:	8b 45 9c             	mov    -0x64(%rbp),%eax
  2c07f0:	85 c0                	test   %eax,%eax
  2c07f2:	7e 1d                	jle    2c0811 <printer_vprintf+0x47b>
  2c07f4:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  2c07f8:	89 c3                	mov    %eax,%ebx
            p->putc(p, '0', color);
  2c07fa:	44 89 fa             	mov    %r15d,%edx
  2c07fd:	be 30 00 00 00       	mov    $0x30,%esi
  2c0802:	4c 89 f7             	mov    %r14,%rdi
  2c0805:	41 ff 16             	call   *(%r14)
        for (; zeros > 0; --zeros) {
  2c0808:	83 eb 01             	sub    $0x1,%ebx
  2c080b:	75 ed                	jne    2c07fa <printer_vprintf+0x464>
  2c080d:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; len > 0; ++data, --len) {
  2c0811:	8b 45 98             	mov    -0x68(%rbp),%eax
  2c0814:	85 c0                	test   %eax,%eax
  2c0816:	7e 27                	jle    2c083f <printer_vprintf+0x4a9>
  2c0818:	89 c0                	mov    %eax,%eax
  2c081a:	4c 01 e0             	add    %r12,%rax
  2c081d:	48 89 5d a8          	mov    %rbx,-0x58(%rbp)
  2c0821:	48 89 c3             	mov    %rax,%rbx
            p->putc(p, *data, color);
  2c0824:	41 0f b6 34 24       	movzbl (%r12),%esi
  2c0829:	44 89 fa             	mov    %r15d,%edx
  2c082c:	4c 89 f7             	mov    %r14,%rdi
  2c082f:	41 ff 16             	call   *(%r14)
        for (; len > 0; ++data, --len) {
  2c0832:	49 83 c4 01          	add    $0x1,%r12
  2c0836:	49 39 dc             	cmp    %rbx,%r12
  2c0839:	75 e9                	jne    2c0824 <printer_vprintf+0x48e>
  2c083b:	48 8b 5d a8          	mov    -0x58(%rbp),%rbx
        for (; width > 0; --width) {
  2c083f:	45 85 ed             	test   %r13d,%r13d
  2c0842:	7e 14                	jle    2c0858 <printer_vprintf+0x4c2>
            p->putc(p, ' ', color);
  2c0844:	44 89 fa             	mov    %r15d,%edx
  2c0847:	be 20 00 00 00       	mov    $0x20,%esi
  2c084c:	4c 89 f7             	mov    %r14,%rdi
  2c084f:	41 ff 16             	call   *(%r14)
        for (; width > 0; --width) {
  2c0852:	41 83 ed 01          	sub    $0x1,%r13d
  2c0856:	75 ec                	jne    2c0844 <printer_vprintf+0x4ae>
    for (; *format; ++format) {
  2c0858:	4c 8d 63 01          	lea    0x1(%rbx),%r12
  2c085c:	0f b6 43 01          	movzbl 0x1(%rbx),%eax
  2c0860:	84 c0                	test   %al,%al
  2c0862:	0f 84 fe 01 00 00    	je     2c0a66 <printer_vprintf+0x6d0>
        if (*format != '%') {
  2c0868:	3c 25                	cmp    $0x25,%al
  2c086a:	0f 84 54 fb ff ff    	je     2c03c4 <printer_vprintf+0x2e>
            p->putc(p, *format, color);
  2c0870:	0f b6 f0             	movzbl %al,%esi
  2c0873:	44 89 fa             	mov    %r15d,%edx
  2c0876:	4c 89 f7             	mov    %r14,%rdi
  2c0879:	41 ff 16             	call   *(%r14)
            continue;
  2c087c:	4c 89 e3             	mov    %r12,%rbx
  2c087f:	eb d7                	jmp    2c0858 <printer_vprintf+0x4c2>
            data = va_arg(val, char*);
  2c0881:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  2c0885:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  2c0889:	48 8d 42 08          	lea    0x8(%rdx),%rax
  2c088d:	48 89 47 08          	mov    %rax,0x8(%rdi)
  2c0891:	e9 51 fe ff ff       	jmp    2c06e7 <printer_vprintf+0x351>
            color = va_arg(val, int);
  2c0896:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  2c089a:	8b 07                	mov    (%rdi),%eax
  2c089c:	83 f8 2f             	cmp    $0x2f,%eax
  2c089f:	77 10                	ja     2c08b1 <printer_vprintf+0x51b>
  2c08a1:	89 c2                	mov    %eax,%edx
  2c08a3:	48 03 57 10          	add    0x10(%rdi),%rdx
  2c08a7:	83 c0 08             	add    $0x8,%eax
  2c08aa:	89 07                	mov    %eax,(%rdi)
  2c08ac:	44 8b 3a             	mov    (%rdx),%r15d
            goto done;
  2c08af:	eb a7                	jmp    2c0858 <printer_vprintf+0x4c2>
            color = va_arg(val, int);
  2c08b1:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  2c08b5:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  2c08b9:	48 8d 42 08          	lea    0x8(%rdx),%rax
  2c08bd:	48 89 41 08          	mov    %rax,0x8(%rcx)
  2c08c1:	eb e9                	jmp    2c08ac <printer_vprintf+0x516>
            numbuf[0] = va_arg(val, int);
  2c08c3:	48 8b 4d 90          	mov    -0x70(%rbp),%rcx
  2c08c7:	8b 01                	mov    (%rcx),%eax
  2c08c9:	83 f8 2f             	cmp    $0x2f,%eax
  2c08cc:	77 23                	ja     2c08f1 <printer_vprintf+0x55b>
  2c08ce:	89 c2                	mov    %eax,%edx
  2c08d0:	48 03 51 10          	add    0x10(%rcx),%rdx
  2c08d4:	83 c0 08             	add    $0x8,%eax
  2c08d7:	89 01                	mov    %eax,(%rcx)
  2c08d9:	8b 02                	mov    (%rdx),%eax
  2c08db:	88 45 b8             	mov    %al,-0x48(%rbp)
            numbuf[1] = '\0';
  2c08de:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
  2c08e2:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  2c08e6:	41 b8 00 00 00 00    	mov    $0x0,%r8d
            break;
  2c08ec:	e9 ff fd ff ff       	jmp    2c06f0 <printer_vprintf+0x35a>
            numbuf[0] = va_arg(val, int);
  2c08f1:	48 8b 7d 90          	mov    -0x70(%rbp),%rdi
  2c08f5:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  2c08f9:	48 8d 42 08          	lea    0x8(%rdx),%rax
  2c08fd:	48 89 47 08          	mov    %rax,0x8(%rdi)
  2c0901:	eb d6                	jmp    2c08d9 <printer_vprintf+0x543>
            numbuf[0] = (*format ? *format : '%');
  2c0903:	84 d2                	test   %dl,%dl
  2c0905:	0f 85 39 01 00 00    	jne    2c0a44 <printer_vprintf+0x6ae>
  2c090b:	c6 45 b8 25          	movb   $0x25,-0x48(%rbp)
            numbuf[1] = '\0';
  2c090f:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
                format--;
  2c0913:	48 83 eb 01          	sub    $0x1,%rbx
            data = numbuf;
  2c0917:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  2c091b:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  2c0921:	e9 ca fd ff ff       	jmp    2c06f0 <printer_vprintf+0x35a>
        if (flags & FLAG_NUMERIC) {
  2c0926:	41 b9 0a 00 00 00    	mov    $0xa,%r9d
    const char* digits = upper_digits;
  2c092c:	bf d0 15 2c 00       	mov    $0x2c15d0,%edi
        if (flags & FLAG_NUMERIC) {
  2c0931:	be 0a 00 00 00       	mov    $0xa,%esi
    *--numbuf_end = '\0';
  2c0936:	c6 45 cf 00          	movb   $0x0,-0x31(%rbp)
  2c093a:	4c 89 c1             	mov    %r8,%rcx
  2c093d:	4c 8d 65 cf          	lea    -0x31(%rbp),%r12
        *--numbuf_end = digits[val % base];
  2c0941:	48 63 f6             	movslq %esi,%rsi
  2c0944:	49 83 ec 01          	sub    $0x1,%r12
  2c0948:	48 89 c8             	mov    %rcx,%rax
  2c094b:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0950:	48 f7 f6             	div    %rsi
  2c0953:	0f b6 14 17          	movzbl (%rdi,%rdx,1),%edx
  2c0957:	41 88 14 24          	mov    %dl,(%r12)
        val /= base;
  2c095b:	48 89 ca             	mov    %rcx,%rdx
  2c095e:	48 89 c1             	mov    %rax,%rcx
    } while (val != 0);
  2c0961:	48 39 d6             	cmp    %rdx,%rsi
  2c0964:	76 de                	jbe    2c0944 <printer_vprintf+0x5ae>
  2c0966:	e9 9a fd ff ff       	jmp    2c0705 <printer_vprintf+0x36f>
                prefix = "-";
  2c096b:	48 c7 45 a0 e5 13 2c 	movq   $0x2c13e5,-0x60(%rbp)
  2c0972:	00 
            if (flags & FLAG_NEGATIVE) {
  2c0973:	8b 45 a8             	mov    -0x58(%rbp),%eax
  2c0976:	a8 80                	test   $0x80,%al
  2c0978:	0f 85 b0 fd ff ff    	jne    2c072e <printer_vprintf+0x398>
                prefix = "+";
  2c097e:	48 c7 45 a0 e0 13 2c 	movq   $0x2c13e0,-0x60(%rbp)
  2c0985:	00 
            } else if (flags & FLAG_PLUSPOSITIVE) {
  2c0986:	a8 10                	test   $0x10,%al
  2c0988:	0f 85 a0 fd ff ff    	jne    2c072e <printer_vprintf+0x398>
                prefix = " ";
  2c098e:	a8 08                	test   $0x8,%al
  2c0990:	ba 7d 13 2c 00       	mov    $0x2c137d,%edx
  2c0995:	b8 ed 15 2c 00       	mov    $0x2c15ed,%eax
  2c099a:	48 0f 44 c2          	cmove  %rdx,%rax
  2c099e:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  2c09a2:	e9 87 fd ff ff       	jmp    2c072e <printer_vprintf+0x398>
                   && (base == 16 || base == -16)
  2c09a7:	41 8d 41 10          	lea    0x10(%r9),%eax
  2c09ab:	a9 df ff ff ff       	test   $0xffffffdf,%eax
  2c09b0:	0f 85 78 fd ff ff    	jne    2c072e <printer_vprintf+0x398>
                   && (num || (flags & FLAG_ALT2))) {
  2c09b6:	4d 85 c0             	test   %r8,%r8
  2c09b9:	75 0d                	jne    2c09c8 <printer_vprintf+0x632>
  2c09bb:	f7 45 a8 00 01 00 00 	testl  $0x100,-0x58(%rbp)
  2c09c2:	0f 84 66 fd ff ff    	je     2c072e <printer_vprintf+0x398>
            prefix = (base == -16 ? "0x" : "0X");
  2c09c8:	41 83 f9 f0          	cmp    $0xfffffff0,%r9d
  2c09cc:	ba e7 13 2c 00       	mov    $0x2c13e7,%edx
  2c09d1:	b8 e2 13 2c 00       	mov    $0x2c13e2,%eax
  2c09d6:	48 0f 44 c2          	cmove  %rdx,%rax
  2c09da:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
  2c09de:	e9 4b fd ff ff       	jmp    2c072e <printer_vprintf+0x398>
            len = strlen(data);
  2c09e3:	4c 89 e7             	mov    %r12,%rdi
  2c09e6:	e8 b5 f8 ff ff       	call   2c02a0 <strlen>
  2c09eb:	89 45 98             	mov    %eax,-0x68(%rbp)
        if ((flags & FLAG_NUMERIC) && precision >= 0) {
  2c09ee:	83 7d 8c 00          	cmpl   $0x0,-0x74(%rbp)
  2c09f2:	0f 84 63 fd ff ff    	je     2c075b <printer_vprintf+0x3c5>
  2c09f8:	80 7d 84 00          	cmpb   $0x0,-0x7c(%rbp)
  2c09fc:	0f 84 59 fd ff ff    	je     2c075b <printer_vprintf+0x3c5>
            zeros = precision > len ? precision - len : 0;
  2c0a02:	8b 4d 9c             	mov    -0x64(%rbp),%ecx
  2c0a05:	89 ca                	mov    %ecx,%edx
  2c0a07:	29 c2                	sub    %eax,%edx
  2c0a09:	39 c1                	cmp    %eax,%ecx
  2c0a0b:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0a10:	0f 4e d0             	cmovle %eax,%edx
  2c0a13:	89 55 9c             	mov    %edx,-0x64(%rbp)
  2c0a16:	e9 56 fd ff ff       	jmp    2c0771 <printer_vprintf+0x3db>
                   && len + (int) strlen(prefix) < width) {
  2c0a1b:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
  2c0a1f:	e8 7c f8 ff ff       	call   2c02a0 <strlen>
  2c0a24:	8b 7d 98             	mov    -0x68(%rbp),%edi
  2c0a27:	8d 14 07             	lea    (%rdi,%rax,1),%edx
            zeros = width - len - strlen(prefix);
  2c0a2a:	44 89 e9             	mov    %r13d,%ecx
  2c0a2d:	29 f9                	sub    %edi,%ecx
  2c0a2f:	29 c1                	sub    %eax,%ecx
  2c0a31:	44 39 ea             	cmp    %r13d,%edx
  2c0a34:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0a39:	0f 4d c8             	cmovge %eax,%ecx
  2c0a3c:	89 4d 9c             	mov    %ecx,-0x64(%rbp)
  2c0a3f:	e9 2d fd ff ff       	jmp    2c0771 <printer_vprintf+0x3db>
            numbuf[0] = (*format ? *format : '%');
  2c0a44:	88 55 b8             	mov    %dl,-0x48(%rbp)
            numbuf[1] = '\0';
  2c0a47:	c6 45 b9 00          	movb   $0x0,-0x47(%rbp)
            data = numbuf;
  2c0a4b:	4c 8d 65 b8          	lea    -0x48(%rbp),%r12
        unsigned long num = 0;
  2c0a4f:	41 b8 00 00 00 00    	mov    $0x0,%r8d
  2c0a55:	e9 96 fc ff ff       	jmp    2c06f0 <printer_vprintf+0x35a>
        int flags = 0;
  2c0a5a:	c7 45 a8 00 00 00 00 	movl   $0x0,-0x58(%rbp)
  2c0a61:	e9 b0 f9 ff ff       	jmp    2c0416 <printer_vprintf+0x80>
}
  2c0a66:	48 83 c4 58          	add    $0x58,%rsp
  2c0a6a:	5b                   	pop    %rbx
  2c0a6b:	41 5c                	pop    %r12
  2c0a6d:	41 5d                	pop    %r13
  2c0a6f:	41 5e                	pop    %r14
  2c0a71:	41 5f                	pop    %r15
  2c0a73:	5d                   	pop    %rbp
  2c0a74:	c3                   	ret    

00000000002c0a75 <console_vprintf>:
int console_vprintf(int cpos, int color, const char* format, va_list val) {
  2c0a75:	55                   	push   %rbp
  2c0a76:	48 89 e5             	mov    %rsp,%rbp
  2c0a79:	48 83 ec 10          	sub    $0x10,%rsp
    cp.p.putc = console_putc;
  2c0a7d:	48 c7 45 f0 80 01 2c 	movq   $0x2c0180,-0x10(%rbp)
  2c0a84:	00 
        cpos = 0;
  2c0a85:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
  2c0a8b:	b8 00 00 00 00       	mov    $0x0,%eax
  2c0a90:	0f 43 f8             	cmovae %eax,%edi
    cp.cursor = console + cpos;
  2c0a93:	48 63 ff             	movslq %edi,%rdi
  2c0a96:	48 8d 84 3f 00 80 0b 	lea    0xb8000(%rdi,%rdi,1),%rax
  2c0a9d:	00 
  2c0a9e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    printer_vprintf(&cp.p, color, format, val);
  2c0aa2:	48 8d 7d f0          	lea    -0x10(%rbp),%rdi
  2c0aa6:	e8 eb f8 ff ff       	call   2c0396 <printer_vprintf>
    return cp.cursor - console;
  2c0aab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2c0aaf:	48 2d 00 80 0b 00    	sub    $0xb8000,%rax
  2c0ab5:	48 d1 f8             	sar    %rax
}
  2c0ab8:	c9                   	leave  
  2c0ab9:	c3                   	ret    

00000000002c0aba <console_printf>:
int console_printf(int cpos, int color, const char* format, ...) {
  2c0aba:	55                   	push   %rbp
  2c0abb:	48 89 e5             	mov    %rsp,%rbp
  2c0abe:	48 83 ec 50          	sub    $0x50,%rsp
  2c0ac2:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c0ac6:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c0aca:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_start(val, format);
  2c0ace:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  2c0ad5:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c0ad9:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c0add:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c0ae1:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cpos = console_vprintf(cpos, color, format, val);
  2c0ae5:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  2c0ae9:	e8 87 ff ff ff       	call   2c0a75 <console_vprintf>
}
  2c0aee:	c9                   	leave  
  2c0aef:	c3                   	ret    

00000000002c0af0 <vsnprintf>:

int vsnprintf(char* s, size_t size, const char* format, va_list val) {
  2c0af0:	55                   	push   %rbp
  2c0af1:	48 89 e5             	mov    %rsp,%rbp
  2c0af4:	53                   	push   %rbx
  2c0af5:	48 83 ec 28          	sub    $0x28,%rsp
  2c0af9:	48 89 fb             	mov    %rdi,%rbx
    string_printer sp;
    sp.p.putc = string_putc;
  2c0afc:	48 c7 45 d8 06 02 2c 	movq   $0x2c0206,-0x28(%rbp)
  2c0b03:	00 
    sp.s = s;
  2c0b04:	48 89 7d e0          	mov    %rdi,-0x20(%rbp)
    if (size) {
  2c0b08:	48 85 f6             	test   %rsi,%rsi
  2c0b0b:	75 0b                	jne    2c0b18 <vsnprintf+0x28>
        sp.end = s + size - 1;
        printer_vprintf(&sp.p, 0, format, val);
        *sp.s = 0;
    }
    return sp.s - s;
  2c0b0d:	8b 45 e0             	mov    -0x20(%rbp),%eax
  2c0b10:	29 d8                	sub    %ebx,%eax
}
  2c0b12:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
  2c0b16:	c9                   	leave  
  2c0b17:	c3                   	ret    
        sp.end = s + size - 1;
  2c0b18:	48 8d 44 37 ff       	lea    -0x1(%rdi,%rsi,1),%rax
  2c0b1d:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
        printer_vprintf(&sp.p, 0, format, val);
  2c0b21:	be 00 00 00 00       	mov    $0x0,%esi
  2c0b26:	48 8d 7d d8          	lea    -0x28(%rbp),%rdi
  2c0b2a:	e8 67 f8 ff ff       	call   2c0396 <printer_vprintf>
        *sp.s = 0;
  2c0b2f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  2c0b33:	c6 00 00             	movb   $0x0,(%rax)
  2c0b36:	eb d5                	jmp    2c0b0d <vsnprintf+0x1d>

00000000002c0b38 <snprintf>:

int snprintf(char* s, size_t size, const char* format, ...) {
  2c0b38:	55                   	push   %rbp
  2c0b39:	48 89 e5             	mov    %rsp,%rbp
  2c0b3c:	48 83 ec 50          	sub    $0x50,%rsp
  2c0b40:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c0b44:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c0b48:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    va_list val;
    va_start(val, format);
  2c0b4c:	c7 45 b8 18 00 00 00 	movl   $0x18,-0x48(%rbp)
  2c0b53:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c0b57:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c0b5b:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c0b5f:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    int n = vsnprintf(s, size, format, val);
  2c0b63:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  2c0b67:	e8 84 ff ff ff       	call   2c0af0 <vsnprintf>
    va_end(val);
    return n;
}
  2c0b6c:	c9                   	leave  
  2c0b6d:	c3                   	ret    

00000000002c0b6e <console_clear>:

// console_clear
//    Erases the console and moves the cursor to the upper left (CPOS(0, 0)).

void console_clear(void) {
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  2c0b6e:	b8 00 80 0b 00       	mov    $0xb8000,%eax
  2c0b73:	ba a0 8f 0b 00       	mov    $0xb8fa0,%edx
        console[i] = ' ' | 0x0700;
  2c0b78:	66 c7 00 20 07       	movw   $0x720,(%rax)
    for (int i = 0; i < CONSOLE_ROWS * CONSOLE_COLUMNS; ++i) {
  2c0b7d:	48 83 c0 02          	add    $0x2,%rax
  2c0b81:	48 39 d0             	cmp    %rdx,%rax
  2c0b84:	75 f2                	jne    2c0b78 <console_clear+0xa>
    }
    cursorpos = 0;
  2c0b86:	c7 05 6c 84 df ff 00 	movl   $0x0,-0x207b94(%rip)        # b8ffc <cursorpos>
  2c0b8d:	00 00 00 
}
  2c0b90:	c3                   	ret    

00000000002c0b91 <comp_structs>:
//    Compare and sort struct array based on the sizes of alloc'd blocks.

int comp_structs(const void *p1, const void *p2) {
    const heap_info_node a = *(heap_info_node *)p1;
    const heap_info_node b = *(heap_info_node *)p2;
    return a.size <= b.size ? TRUE : FALSE;
  2c0b91:	48 8b 06             	mov    (%rsi),%rax
  2c0b94:	48 39 07             	cmp    %rax,(%rdi)
  2c0b97:	0f 9e c0             	setle  %al
  2c0b9a:	0f b6 c0             	movzbl %al,%eax
}
  2c0b9d:	c3                   	ret    

00000000002c0b9e <alignof_eight>:
    return ALIGNMENT_EIGHT - sz + (sz & ~(ALIGNMENT_EIGHT - 1));
  2c0b9e:	48 89 f8             	mov    %rdi,%rax
  2c0ba1:	48 83 e0 f8          	and    $0xfffffffffffffff8,%rax
  2c0ba5:	48 29 f8             	sub    %rdi,%rax
  2c0ba8:	48 83 c0 08          	add    $0x8,%rax
}
  2c0bac:	c3                   	ret    

00000000002c0bad <merge>:
// merge()
//    Merges two arrays together to be used by the function responsible for
//    the merge sort algorithm.

void merge(heap_info_node *array, size_t left, size_t center, size_t right,
           int (*compare)(const void *, const void *)) {
  2c0bad:	55                   	push   %rbp
  2c0bae:	48 89 e5             	mov    %rsp,%rbp
  2c0bb1:	41 57                	push   %r15
  2c0bb3:	41 56                	push   %r14
  2c0bb5:	41 55                	push   %r13
  2c0bb7:	41 54                	push   %r12
  2c0bb9:	53                   	push   %rbx
  2c0bba:	48 83 ec 38          	sub    $0x38,%rsp
  2c0bbe:	49 89 fa             	mov    %rdi,%r10
  2c0bc1:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
  2c0bc5:	49 89 f1             	mov    %rsi,%r9
  2c0bc8:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
  2c0bcc:	48 89 d7             	mov    %rdx,%rdi
  2c0bcf:	4c 89 45 b0          	mov    %r8,-0x50(%rbp)
    // calculate the lengths of the subarrays
    size_t len1 = center - left + 1;
  2c0bd3:	48 89 d0             	mov    %rdx,%rax
  2c0bd6:	48 29 f0             	sub    %rsi,%rax
  2c0bd9:	48 8d 58 01          	lea    0x1(%rax),%rbx
  2c0bdd:	48 89 5d c0          	mov    %rbx,-0x40(%rbp)
    size_t len2 = right - center;
  2c0be1:	48 29 d1             	sub    %rdx,%rcx
  2c0be4:	48 89 ce             	mov    %rcx,%rsi
  2c0be7:	48 89 4d b8          	mov    %rcx,-0x48(%rbp)

    // create temporary storage arrays
    // heap_info_node *temp1[len1]
    heap_info_node temp1[len1];
  2c0beb:	49 89 d8             	mov    %rbx,%r8
  2c0bee:	49 c1 e0 04          	shl    $0x4,%r8
  2c0bf2:	b9 10 00 00 00       	mov    $0x10,%ecx
  2c0bf7:	49 8d 40 0f          	lea    0xf(%r8),%rax
  2c0bfb:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0c00:	48 f7 f1             	div    %rcx
  2c0c03:	48 c1 e0 04          	shl    $0x4,%rax
  2c0c07:	48 29 c4             	sub    %rax,%rsp
  2c0c0a:	49 89 e6             	mov    %rsp,%r14
    heap_info_node temp2[len2];
  2c0c0d:	48 c1 e6 04          	shl    $0x4,%rsi
  2c0c11:	48 8d 46 0f          	lea    0xf(%rsi),%rax
  2c0c15:	ba 00 00 00 00       	mov    $0x0,%edx
  2c0c1a:	48 f7 f1             	div    %rcx
  2c0c1d:	48 c1 e0 04          	shl    $0x4,%rax
  2c0c21:	48 29 c4             	sub    %rax,%rsp
  2c0c24:	49 89 e7             	mov    %rsp,%r15

    // copy all data over into the storage arrays
    for (size_t i = 0; i < len1; i++)
  2c0c27:	48 85 db             	test   %rbx,%rbx
  2c0c2a:	74 2a                	je     2c0c56 <merge+0xa9>
  2c0c2c:	4c 89 ca             	mov    %r9,%rdx
  2c0c2f:	48 c1 e2 04          	shl    $0x4,%rdx
  2c0c33:	4c 01 d2             	add    %r10,%rdx
  2c0c36:	b8 00 00 00 00       	mov    $0x0,%eax
        temp1[i] = array[left + i];
  2c0c3b:	48 8b 0c 02          	mov    (%rdx,%rax,1),%rcx
  2c0c3f:	48 8b 5c 02 08       	mov    0x8(%rdx,%rax,1),%rbx
  2c0c44:	49 89 0c 06          	mov    %rcx,(%r14,%rax,1)
  2c0c48:	49 89 5c 06 08       	mov    %rbx,0x8(%r14,%rax,1)
    for (size_t i = 0; i < len1; i++)
  2c0c4d:	48 83 c0 10          	add    $0x10,%rax
  2c0c51:	49 39 c0             	cmp    %rax,%r8
  2c0c54:	75 e5                	jne    2c0c3b <merge+0x8e>
    for (size_t i = 0; i < len2; i++)
  2c0c56:	48 83 7d b8 00       	cmpq   $0x0,-0x48(%rbp)
  2c0c5b:	0f 84 70 01 00 00    	je     2c0dd1 <merge+0x224>
  2c0c61:	48 c1 e7 04          	shl    $0x4,%rdi
  2c0c65:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
  2c0c69:	48 8d 14 38          	lea    (%rax,%rdi,1),%rdx
  2c0c6d:	b8 00 00 00 00       	mov    $0x0,%eax
        temp2[i] = array[center + i + 1];
  2c0c72:	48 8b 4c 02 10       	mov    0x10(%rdx,%rax,1),%rcx
  2c0c77:	48 8b 5c 02 18       	mov    0x18(%rdx,%rax,1),%rbx
  2c0c7c:	49 89 0c 07          	mov    %rcx,(%r15,%rax,1)
  2c0c80:	49 89 5c 07 08       	mov    %rbx,0x8(%r15,%rax,1)
    for (size_t i = 0; i < len2; i++)
  2c0c85:	48 83 c0 10          	add    $0x10,%rax
  2c0c89:	48 39 c6             	cmp    %rax,%rsi
  2c0c8c:	75 e4                	jne    2c0c72 <merge+0xc5>
    size_t i = 0;
    size_t j = 0;
    size_t k = left;
    
    // compare and set values in array accordingly
    while (i < len1 && j < len2) {
  2c0c8e:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
  2c0c93:	0f 84 32 01 00 00    	je     2c0dcb <merge+0x21e>
  2c0c99:	4c 8b 6d c8          	mov    -0x38(%rbp),%r13
  2c0c9d:	49 c1 e5 04          	shl    $0x4,%r13
  2c0ca1:	4c 03 6d a8          	add    -0x58(%rbp),%r13
    size_t j = 0;
  2c0ca5:	bb 00 00 00 00       	mov    $0x0,%ebx
    size_t i = 0;
  2c0caa:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  2c0cb0:	eb 31                	jmp    2c0ce3 <merge+0x136>
        if ((*compare)(&temp1[i], &temp2[j])) {
            array[k] = temp1[i];
            i++;
        } else {
            array[k] = temp2[j];
  2c0cb2:	48 89 d8             	mov    %rbx,%rax
  2c0cb5:	48 c1 e0 04          	shl    $0x4,%rax
  2c0cb9:	49 8b 54 07 08       	mov    0x8(%r15,%rax,1),%rdx
  2c0cbe:	49 8b 04 07          	mov    (%r15,%rax,1),%rax
  2c0cc2:	49 89 45 00          	mov    %rax,0x0(%r13)
  2c0cc6:	49 89 55 08          	mov    %rdx,0x8(%r13)
            j++;
  2c0cca:	48 83 c3 01          	add    $0x1,%rbx
        }
        k++;
  2c0cce:	48 83 45 c8 01       	addq   $0x1,-0x38(%rbp)
    while (i < len1 && j < len2) {
  2c0cd3:	49 83 c5 10          	add    $0x10,%r13
  2c0cd7:	4c 3b 65 c0          	cmp    -0x40(%rbp),%r12
  2c0cdb:	73 42                	jae    2c0d1f <merge+0x172>
  2c0cdd:	48 3b 5d b8          	cmp    -0x48(%rbp),%rbx
  2c0ce1:	73 3c                	jae    2c0d1f <merge+0x172>
        if ((*compare)(&temp1[i], &temp2[j])) {
  2c0ce3:	48 89 de             	mov    %rbx,%rsi
  2c0ce6:	48 c1 e6 04          	shl    $0x4,%rsi
  2c0cea:	4c 01 fe             	add    %r15,%rsi
  2c0ced:	4c 89 e7             	mov    %r12,%rdi
  2c0cf0:	48 c1 e7 04          	shl    $0x4,%rdi
  2c0cf4:	4c 01 f7             	add    %r14,%rdi
  2c0cf7:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
  2c0cfb:	ff d0                	call   *%rax
  2c0cfd:	85 c0                	test   %eax,%eax
  2c0cff:	74 b1                	je     2c0cb2 <merge+0x105>
            array[k] = temp1[i];
  2c0d01:	4c 89 e0             	mov    %r12,%rax
  2c0d04:	48 c1 e0 04          	shl    $0x4,%rax
  2c0d08:	49 8b 54 06 08       	mov    0x8(%r14,%rax,1),%rdx
  2c0d0d:	49 8b 04 06          	mov    (%r14,%rax,1),%rax
  2c0d11:	49 89 45 00          	mov    %rax,0x0(%r13)
  2c0d15:	49 89 55 08          	mov    %rdx,0x8(%r13)
            i++;
  2c0d19:	49 83 c4 01          	add    $0x1,%r12
  2c0d1d:	eb af                	jmp    2c0cce <merge+0x121>
    }

    // add on the rest of the items in the first storage array
    while (i < len1) {
  2c0d1f:	4c 3b 65 c0          	cmp    -0x40(%rbp),%r12
  2c0d23:	73 50                	jae    2c0d75 <merge+0x1c8>
  2c0d25:	4c 8b 45 c0          	mov    -0x40(%rbp),%r8
  2c0d29:	4d 29 e0             	sub    %r12,%r8
  2c0d2c:	49 c1 e0 04          	shl    $0x4,%r8
  2c0d30:	4c 89 e1             	mov    %r12,%rcx
  2c0d33:	48 c1 e1 04          	shl    $0x4,%rcx
  2c0d37:	4c 01 f1             	add    %r14,%rcx
  2c0d3a:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  2c0d3e:	48 c1 e2 04          	shl    $0x4,%rdx
  2c0d42:	48 03 55 a8          	add    -0x58(%rbp),%rdx
    size_t i = 0;
  2c0d46:	b8 00 00 00 00       	mov    $0x0,%eax
        array[k] = temp1[i];
  2c0d4b:	48 8b 34 01          	mov    (%rcx,%rax,1),%rsi
  2c0d4f:	48 8b 7c 01 08       	mov    0x8(%rcx,%rax,1),%rdi
  2c0d54:	48 89 34 02          	mov    %rsi,(%rdx,%rax,1)
  2c0d58:	48 89 7c 02 08       	mov    %rdi,0x8(%rdx,%rax,1)
    while (i < len1) {
  2c0d5d:	48 83 c0 10          	add    $0x10,%rax
  2c0d61:	4c 39 c0             	cmp    %r8,%rax
  2c0d64:	75 e5                	jne    2c0d4b <merge+0x19e>
  2c0d66:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
  2c0d6a:	48 03 45 c0          	add    -0x40(%rbp),%rax
        i++;
        k++;
  2c0d6e:	4c 29 e0             	sub    %r12,%rax
  2c0d71:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    }

    // add on the rest of the items in the second storage array
    while (j < len2) {
  2c0d75:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
  2c0d79:	48 39 c3             	cmp    %rax,%rbx
  2c0d7c:	73 3e                	jae    2c0dbc <merge+0x20f>
  2c0d7e:	48 89 c7             	mov    %rax,%rdi
  2c0d81:	48 29 df             	sub    %rbx,%rdi
  2c0d84:	48 c1 e7 04          	shl    $0x4,%rdi
  2c0d88:	48 c1 e3 04          	shl    $0x4,%rbx
  2c0d8c:	49 8d 34 1f          	lea    (%r15,%rbx,1),%rsi
  2c0d90:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  2c0d94:	48 c1 e2 04          	shl    $0x4,%rdx
  2c0d98:	48 03 55 a8          	add    -0x58(%rbp),%rdx
  2c0d9c:	b8 00 00 00 00       	mov    $0x0,%eax
        array[k] = temp2[j];
  2c0da1:	48 8b 0c 06          	mov    (%rsi,%rax,1),%rcx
  2c0da5:	48 8b 5c 06 08       	mov    0x8(%rsi,%rax,1),%rbx
  2c0daa:	48 89 0c 02          	mov    %rcx,(%rdx,%rax,1)
  2c0dae:	48 89 5c 02 08       	mov    %rbx,0x8(%rdx,%rax,1)
    while (j < len2) {
  2c0db3:	48 83 c0 10          	add    $0x10,%rax
  2c0db7:	48 39 c7             	cmp    %rax,%rdi
  2c0dba:	75 e5                	jne    2c0da1 <merge+0x1f4>
        j++;
        k++;
    }
}
  2c0dbc:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
  2c0dc0:	5b                   	pop    %rbx
  2c0dc1:	41 5c                	pop    %r12
  2c0dc3:	41 5d                	pop    %r13
  2c0dc5:	41 5e                	pop    %r14
  2c0dc7:	41 5f                	pop    %r15
  2c0dc9:	5d                   	pop    %rbp
  2c0dca:	c3                   	ret    
    size_t j = 0;
  2c0dcb:	48 8b 5d c0          	mov    -0x40(%rbp),%rbx
  2c0dcf:	eb a4                	jmp    2c0d75 <merge+0x1c8>
  2c0dd1:	4c 8b 65 b8          	mov    -0x48(%rbp),%r12
  2c0dd5:	4c 89 e3             	mov    %r12,%rbx
    while (i < len1) {
  2c0dd8:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
  2c0ddd:	0f 85 42 ff ff ff    	jne    2c0d25 <merge+0x178>
  2c0de3:	eb d7                	jmp    2c0dbc <merge+0x20f>

00000000002c0de5 <merge_sort>:
//    specialized function to compare the specific values of the array.

void merge_sort(heap_info_node *array, size_t left, size_t right,
                int (*compare)(const void *, const void *)) {
    // check indices as base case for the recursion
    if (left < right) {
  2c0de5:	48 39 d6             	cmp    %rdx,%rsi
  2c0de8:	72 01                	jb     2c0deb <merge_sort+0x6>
  2c0dea:	c3                   	ret    
                int (*compare)(const void *, const void *)) {
  2c0deb:	55                   	push   %rbp
  2c0dec:	48 89 e5             	mov    %rsp,%rbp
  2c0def:	41 57                	push   %r15
  2c0df1:	41 56                	push   %r14
  2c0df3:	41 55                	push   %r13
  2c0df5:	41 54                	push   %r12
  2c0df7:	53                   	push   %rbx
  2c0df8:	48 83 ec 08          	sub    $0x8,%rsp
  2c0dfc:	49 89 fd             	mov    %rdi,%r13
  2c0dff:	48 89 f3             	mov    %rsi,%rbx
  2c0e02:	49 89 d4             	mov    %rdx,%r12
  2c0e05:	49 89 ce             	mov    %rcx,%r14
        // calculate the center of the array    
        size_t center = (left + right - 1) / 2;
  2c0e08:	4c 8d 7c 16 ff       	lea    -0x1(%rsi,%rdx,1),%r15
  2c0e0d:	49 d1 ef             	shr    %r15

        // recursively call the merge_sort() algorithm to sort subsections
        merge_sort(array, left, center, compare);
  2c0e10:	4c 89 fa             	mov    %r15,%rdx
  2c0e13:	e8 cd ff ff ff       	call   2c0de5 <merge_sort>
        merge_sort(array, center + 1, right, compare);
  2c0e18:	49 8d 77 01          	lea    0x1(%r15),%rsi
  2c0e1c:	4c 89 f1             	mov    %r14,%rcx
  2c0e1f:	4c 89 e2             	mov    %r12,%rdx
  2c0e22:	4c 89 ef             	mov    %r13,%rdi
  2c0e25:	e8 bb ff ff ff       	call   2c0de5 <merge_sort>

        // merge all resulting arrays back into one
        merge(array, left, center, right, compare);
  2c0e2a:	4d 89 f0             	mov    %r14,%r8
  2c0e2d:	4c 89 e1             	mov    %r12,%rcx
  2c0e30:	4c 89 fa             	mov    %r15,%rdx
  2c0e33:	48 89 de             	mov    %rbx,%rsi
  2c0e36:	4c 89 ef             	mov    %r13,%rdi
  2c0e39:	e8 6f fd ff ff       	call   2c0bad <merge>
    }
}
  2c0e3e:	48 83 c4 08          	add    $0x8,%rsp
  2c0e42:	5b                   	pop    %rbx
  2c0e43:	41 5c                	pop    %r12
  2c0e45:	41 5d                	pop    %r13
  2c0e47:	41 5e                	pop    %r14
  2c0e49:	41 5f                	pop    %r15
  2c0e4b:	5d                   	pop    %rbp
  2c0e4c:	c3                   	ret    

00000000002c0e4d <malloc>:

// IMPLEMENT REQUIRED FUNCTIONS
void *malloc(uint64_t numbytes) {
    if (numbytes == 0)
  2c0e4d:	48 85 ff             	test   %rdi,%rdi
  2c0e50:	0f 84 96 00 00 00    	je     2c0eec <malloc+0x9f>
        return NULL;

    size_t size = sizeof(flist_node) + numbytes + 
                    alignof_eight(sizeof(flist_node) + numbytes);
  2c0e56:	48 8d 77 18          	lea    0x18(%rdi),%rsi
    return ALIGNMENT_EIGHT - sz + (sz & ~(ALIGNMENT_EIGHT - 1));
  2c0e5a:	48 89 f0             	mov    %rsi,%rax
  2c0e5d:	48 83 e0 f8          	and    $0xfffffffffffffff8,%rax
  2c0e61:	4c 8d 44 07 20       	lea    0x20(%rdi,%rax,1),%r8
    size_t size = sizeof(flist_node) + numbytes + 
  2c0e66:	4c 89 c7             	mov    %r8,%rdi
  2c0e69:	48 29 f7             	sub    %rsi,%rdi
    
    flist_node *tmp = head.next;
  2c0e6c:	48 8b 05 bd 11 00 00 	mov    0x11bd(%rip),%rax        # 2c2030 <head+0x10>
    flist_node **ptr = &head.next;

    while (tmp != NULL) {
  2c0e73:	48 85 c0             	test   %rax,%rax
  2c0e76:	74 53                	je     2c0ecb <malloc+0x7e>
    flist_node **ptr = &head.next;
  2c0e78:	ba 30 20 2c 00       	mov    $0x2c2030,%edx
  2c0e7d:	eb 13                	jmp    2c0e92 <malloc+0x45>
                nblock->free = 1;
                nblock->next = tmp->next;
                *ptr = nblock;
            } else {
                size += difference;
                *ptr = tmp->next;
  2c0e7f:	48 8b 78 10          	mov    0x10(%rax),%rdi
  2c0e83:	eb 3e                	jmp    2c0ec3 <malloc+0x76>
            }

            return (void *)((uintptr_t)tmp + sizeof(flist_node));
        }

        ptr = &(tmp->next);
  2c0e85:	48 8d 50 10          	lea    0x10(%rax),%rdx
        tmp = tmp->next;
  2c0e89:	48 8b 40 10          	mov    0x10(%rax),%rax
    while (tmp != NULL) {
  2c0e8d:	48 85 c0             	test   %rax,%rax
  2c0e90:	74 39                	je     2c0ecb <malloc+0x7e>
        if (tmp->free && tmp->size >= size) {
  2c0e92:	48 83 78 08 00       	cmpq   $0x0,0x8(%rax)
  2c0e97:	74 ec                	je     2c0e85 <malloc+0x38>
  2c0e99:	48 8b 08             	mov    (%rax),%rcx
  2c0e9c:	48 39 f9             	cmp    %rdi,%rcx
  2c0e9f:	72 e4                	jb     2c0e85 <malloc+0x38>
            size_t difference = tmp->size - size;
  2c0ea1:	4c 29 c6             	sub    %r8,%rsi
  2c0ea4:	48 01 ce             	add    %rcx,%rsi
            if (difference > sizeof(flist_node)) {
  2c0ea7:	48 83 fe 18          	cmp    $0x18,%rsi
  2c0eab:	76 d2                	jbe    2c0e7f <malloc+0x32>
                flist_node *nblock = (flist_node *)((uintptr_t)tmp + size);
  2c0ead:	48 01 c7             	add    %rax,%rdi
                nblock->size = difference;
  2c0eb0:	48 89 37             	mov    %rsi,(%rdi)
                nblock->free = 1;
  2c0eb3:	48 c7 47 08 01 00 00 	movq   $0x1,0x8(%rdi)
  2c0eba:	00 
                nblock->next = tmp->next;
  2c0ebb:	48 8b 48 10          	mov    0x10(%rax),%rcx
  2c0ebf:	48 89 4f 10          	mov    %rcx,0x10(%rdi)
                *ptr = nblock;
  2c0ec3:	48 89 3a             	mov    %rdi,(%rdx)
            return (void *)((uintptr_t)tmp + sizeof(flist_node));
  2c0ec6:	48 83 c0 18          	add    $0x18,%rax
  2c0eca:	c3                   	ret    
//     On success, sbrk() returns the previous program break
//     (If the break was increased, then this value is a pointer to the start of the newly allocated memory)
//      On error, (void *) -1 is returned
static inline void * sbrk(const intptr_t increment) {
    static void * result;
    asm volatile ("int %1" :  "=a" (result)
  2c0ecb:	cd 3a                	int    $0x3a
  2c0ecd:	48 89 05 3c 11 00 00 	mov    %rax,0x113c(%rip)        # 2c2010 <result.0>
    }

    tmp = (flist_node *)sbrk(size);
    tmp->size = size;
  2c0ed4:	48 89 38             	mov    %rdi,(%rax)
    tmp->free = 0;
  2c0ed7:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
  2c0ede:	00 
    tmp->next = (flist_node *)NULL;
  2c0edf:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
  2c0ee6:	00 

    return (void *)((uintptr_t)tmp + sizeof(flist_node));
  2c0ee7:	48 83 c0 18          	add    $0x18,%rax
  2c0eeb:	c3                   	ret    
        return NULL;
  2c0eec:	b8 00 00 00 00       	mov    $0x0,%eax
}
  2c0ef1:	c3                   	ret    

00000000002c0ef2 <free>:

void free(void *firstbyte) {
    // free the location by setting the corresponding bit
    flist_node *tmp = (flist_node *)((uintptr_t)firstbyte - 
                        sizeof(flist_node));
    tmp->free = 1;
  2c0ef2:	48 c7 47 f0 01 00 00 	movq   $0x1,-0x10(%rdi)
  2c0ef9:	00 
}
  2c0efa:	c3                   	ret    

00000000002c0efb <calloc>:

void *calloc(uint64_t num, uint64_t sz) {
  2c0efb:	55                   	push   %rbp
  2c0efc:	48 89 e5             	mov    %rsp,%rbp
  2c0eff:	41 54                	push   %r12
  2c0f01:	53                   	push   %rbx
    // alloc new space and set all memory to zero
    void *ptr = malloc(num * sz);
  2c0f02:	48 0f af fe          	imul   %rsi,%rdi
  2c0f06:	49 89 fc             	mov    %rdi,%r12
  2c0f09:	e8 3f ff ff ff       	call   2c0e4d <malloc>
  2c0f0e:	48 89 c3             	mov    %rax,%rbx
    memset(ptr, 0, num * sz);
  2c0f11:	4c 89 e2             	mov    %r12,%rdx
  2c0f14:	be 00 00 00 00       	mov    $0x0,%esi
  2c0f19:	48 89 c7             	mov    %rax,%rdi
  2c0f1c:	e8 64 f3 ff ff       	call   2c0285 <memset>
    return ptr;
}
  2c0f21:	48 89 d8             	mov    %rbx,%rax
  2c0f24:	5b                   	pop    %rbx
  2c0f25:	41 5c                	pop    %r12
  2c0f27:	5d                   	pop    %rbp
  2c0f28:	c3                   	ret    

00000000002c0f29 <realloc>:

void *realloc(void *ptr, uint64_t sz) {
  2c0f29:	55                   	push   %rbp
  2c0f2a:	48 89 e5             	mov    %rsp,%rbp
  2c0f2d:	41 55                	push   %r13
  2c0f2f:	41 54                	push   %r12
  2c0f31:	53                   	push   %rbx
  2c0f32:	48 83 ec 08          	sub    $0x8,%rsp
  2c0f36:	48 89 fb             	mov    %rdi,%rbx
  2c0f39:	48 89 f7             	mov    %rsi,%rdi
    // error handling (multiple cases)
    if (ptr == NULL)
  2c0f3c:	48 85 db             	test   %rbx,%rbx
  2c0f3f:	74 37                	je     2c0f78 <realloc+0x4f>
        return malloc(sz);

    if (ptr != NULL && sz == 0) {
  2c0f41:	48 85 f6             	test   %rsi,%rsi
  2c0f44:	74 3c                	je     2c0f82 <realloc+0x59>
        free(ptr);
        return NULL;
    }

    // alloc new space for the information
    void *nptr = malloc(sz);
  2c0f46:	e8 02 ff ff ff       	call   2c0e4d <malloc>
  2c0f4b:	49 89 c4             	mov    %rax,%r12

    // find locations of full size (this includes flist_node and the block)
    flist_node *nptr_node = (flist_node *)((uintptr_t)nptr - 
                                sizeof(flist_node));
    flist_node *ptr_node = (flist_node *)((uintptr_t)ptr - 
  2c0f4e:	4c 8d 6b e8          	lea    -0x18(%rbx),%r13
    flist_node *nptr_node = (flist_node *)((uintptr_t)nptr - 
  2c0f52:	48 8d 78 e8          	lea    -0x18(%rax),%rdi
                                sizeof(flist_node));

    // copy over all of the information and free the old space
    memcpy(nptr_node, ptr_node, ptr_node->size);
  2c0f56:	48 8b 53 e8          	mov    -0x18(%rbx),%rdx
  2c0f5a:	4c 89 ee             	mov    %r13,%rsi
  2c0f5d:	e8 ba f2 ff ff       	call   2c021c <memcpy>
    tmp->free = 1;
  2c0f62:	48 c7 43 f0 01 00 00 	movq   $0x1,-0x10(%rbx)
  2c0f69:	00 
    free(ptr);

    return nptr;
}
  2c0f6a:	4c 89 e0             	mov    %r12,%rax
  2c0f6d:	48 83 c4 08          	add    $0x8,%rsp
  2c0f71:	5b                   	pop    %rbx
  2c0f72:	41 5c                	pop    %r12
  2c0f74:	41 5d                	pop    %r13
  2c0f76:	5d                   	pop    %rbp
  2c0f77:	c3                   	ret    
        return malloc(sz);
  2c0f78:	e8 d0 fe ff ff       	call   2c0e4d <malloc>
  2c0f7d:	49 89 c4             	mov    %rax,%r12
  2c0f80:	eb e8                	jmp    2c0f6a <realloc+0x41>
    tmp->free = 1;
  2c0f82:	48 c7 43 f0 01 00 00 	movq   $0x1,-0x10(%rbx)
  2c0f89:	00 
        return NULL;
  2c0f8a:	41 bc 00 00 00 00    	mov    $0x0,%r12d
}
  2c0f90:	eb d8                	jmp    2c0f6a <realloc+0x41>

00000000002c0f92 <defrag>:

void defrag() {
    // loop through list to find all adjacent free blocks and combine them
    flist_node *tmp1 = head.next;
  2c0f92:	48 8b 15 97 10 00 00 	mov    0x1097(%rip),%rdx        # 2c2030 <head+0x10>
    while (tmp1 != NULL) {
  2c0f99:	48 85 d2             	test   %rdx,%rdx
  2c0f9c:	74 25                	je     2c0fc3 <defrag+0x31>
        flist_node *tmp2 = tmp1->next;
  2c0f9e:	48 8b 42 10          	mov    0x10(%rdx),%rax
        while (tmp2->free && tmp2 != NULL) {
  2c0fa2:	48 83 78 08 00       	cmpq   $0x0,0x8(%rax)
  2c0fa7:	74 11                	je     2c0fba <defrag+0x28>
            tmp1->size += tmp2->size;
  2c0fa9:	48 8b 08             	mov    (%rax),%rcx
  2c0fac:	48 01 0a             	add    %rcx,(%rdx)
            tmp2 = tmp2->next;
  2c0faf:	48 8b 40 10          	mov    0x10(%rax),%rax
        while (tmp2->free && tmp2 != NULL) {
  2c0fb3:	48 83 78 08 00       	cmpq   $0x0,0x8(%rax)
  2c0fb8:	75 ef                	jne    2c0fa9 <defrag+0x17>
        }
        tmp1->next = tmp2;
  2c0fba:	48 89 42 10          	mov    %rax,0x10(%rdx)
  2c0fbe:	48 89 c2             	mov    %rax,%rdx
  2c0fc1:	eb db                	jmp    2c0f9e <defrag+0xc>
        tmp1 = tmp1->next;
    }
}
  2c0fc3:	c3                   	ret    

00000000002c0fc4 <heap_info>:

int heap_info(heap_info_struct *info) {
  2c0fc4:	55                   	push   %rbp
  2c0fc5:	48 89 e5             	mov    %rsp,%rbp
  2c0fc8:	41 57                	push   %r15
  2c0fca:	41 56                	push   %r14
  2c0fcc:	41 55                	push   %r13
  2c0fce:	41 54                	push   %r12
  2c0fd0:	53                   	push   %rbx
  2c0fd1:	48 83 ec 28          	sub    $0x28,%rsp
  2c0fd5:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    size_t num_allocs = 0;
    size_t free_space = 0;
    size_t largest_free_chunk = 0;

    // iterate through free list and make initial calculations
    flist_node *tmp = head.next;
  2c0fd9:	48 8b 05 50 10 00 00 	mov    0x1050(%rip),%rax        # 2c2030 <head+0x10>
    while (tmp != NULL) {
  2c0fe0:	48 85 c0             	test   %rax,%rax
  2c0fe3:	74 42                	je     2c1027 <heap_info+0x63>
    size_t largest_free_chunk = 0;
  2c0fe5:	41 bd 00 00 00 00    	mov    $0x0,%r13d
    size_t free_space = 0;
  2c0feb:	41 be 00 00 00 00    	mov    $0x0,%r14d
    size_t num_allocs = 0;
  2c0ff1:	41 bf 00 00 00 00    	mov    $0x0,%r15d
    size_t size = 0;
  2c0ff7:	bb 00 00 00 00       	mov    $0x0,%ebx
  2c0ffc:	eb 11                	jmp    2c100f <heap_info+0x4b>
            free_space += sizeof(flist_node) + tmp->size;
            if (tmp->size > largest_free_chunk) {
                largest_free_chunk = tmp->size;
            }
        } else
            num_allocs++;
  2c0ffe:	49 83 c7 01          	add    $0x1,%r15

        size++;
  2c1002:	48 83 c3 01          	add    $0x1,%rbx
        tmp = tmp->next;
  2c1006:	48 8b 40 10          	mov    0x10(%rax),%rax
    while (tmp != NULL) {
  2c100a:	48 85 c0             	test   %rax,%rax
  2c100d:	74 2f                	je     2c103e <heap_info+0x7a>
        if (tmp->free) {
  2c100f:	48 83 78 08 00       	cmpq   $0x0,0x8(%rax)
  2c1014:	74 e8                	je     2c0ffe <heap_info+0x3a>
            free_space += sizeof(flist_node) + tmp->size;
  2c1016:	48 8b 10             	mov    (%rax),%rdx
  2c1019:	4e 8d 74 32 18       	lea    0x18(%rdx,%r14,1),%r14
            if (tmp->size > largest_free_chunk) {
  2c101e:	49 39 d5             	cmp    %rdx,%r13
  2c1021:	4c 0f 42 ea          	cmovb  %rdx,%r13
  2c1025:	eb db                	jmp    2c1002 <heap_info+0x3e>
    size_t largest_free_chunk = 0;
  2c1027:	41 bd 00 00 00 00    	mov    $0x0,%r13d
    size_t free_space = 0;
  2c102d:	41 be 00 00 00 00    	mov    $0x0,%r14d
    size_t num_allocs = 0;
  2c1033:	41 bf 00 00 00 00    	mov    $0x0,%r15d
    size_t size = 0;
  2c1039:	bb 00 00 00 00       	mov    $0x0,%ebx
    }

    // create temporary array of structs to sort all values
    heap_info_node *struct_array =
        (heap_info_node *)malloc(sizeof(heap_info_node) * size);
  2c103e:	48 89 df             	mov    %rbx,%rdi
  2c1041:	48 c1 e7 04          	shl    $0x4,%rdi
  2c1045:	e8 03 fe ff ff       	call   2c0e4d <malloc>
  2c104a:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    if (struct_array == NULL) {
  2c104e:	48 85 c0             	test   %rax,%rax
  2c1051:	74 14                	je     2c1067 <heap_info+0xa3>
        info->ptr_array = (void **)NULL;
        // return ERROR;
    }

    // populate temporary array as necessary
    tmp = head.next;
  2c1053:	48 8b 05 d6 0f 00 00 	mov    0xfd6(%rip),%rax        # 2c2030 <head+0x10>
    size_t i = 0;
    while (tmp != NULL) {
  2c105a:	48 85 c0             	test   %rax,%rax
  2c105d:	74 4d                	je     2c10ac <heap_info+0xe8>
    size_t i = 0;
  2c105f:	41 bc 00 00 00 00    	mov    $0x0,%r12d
  2c1065:	eb 1f                	jmp    2c1086 <heap_info+0xc2>
        info->size_array = (long *)NULL;
  2c1067:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
  2c106b:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
  2c1072:	00 
        info->ptr_array = (void **)NULL;
  2c1073:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
  2c107a:	00 
  2c107b:	eb d6                	jmp    2c1053 <heap_info+0x8f>
            struct_array[i].size = tmp->size;
            struct_array[i].ptr = (void *)((uintptr_t)tmp + 
                                    sizeof(flist_node));
            i++;
        }
        tmp = tmp->next;
  2c107d:	48 8b 40 10          	mov    0x10(%rax),%rax
    while (tmp != NULL) {
  2c1081:	48 85 c0             	test   %rax,%rax
  2c1084:	74 2c                	je     2c10b2 <heap_info+0xee>
        if (!tmp->free) {
  2c1086:	48 83 78 08 00       	cmpq   $0x0,0x8(%rax)
  2c108b:	75 f0                	jne    2c107d <heap_info+0xb9>
            struct_array[i].size = tmp->size;
  2c108d:	4c 89 e2             	mov    %r12,%rdx
  2c1090:	48 c1 e2 04          	shl    $0x4,%rdx
  2c1094:	48 03 55 c8          	add    -0x38(%rbp),%rdx
  2c1098:	48 8b 08             	mov    (%rax),%rcx
  2c109b:	48 89 0a             	mov    %rcx,(%rdx)
            struct_array[i].ptr = (void *)((uintptr_t)tmp + 
  2c109e:	48 8d 48 18          	lea    0x18(%rax),%rcx
  2c10a2:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
            i++;
  2c10a6:	49 83 c4 01          	add    $0x1,%r12
  2c10aa:	eb d1                	jmp    2c107d <heap_info+0xb9>
    size_t i = 0;
  2c10ac:	41 bc 00 00 00 00    	mov    $0x0,%r12d
    }

    // perform merge sort algorithm on the array of structs
    merge_sort(struct_array, 0, size, comp_structs);
  2c10b2:	b9 91 0b 2c 00       	mov    $0x2c0b91,%ecx
  2c10b7:	48 89 da             	mov    %rbx,%rdx
  2c10ba:	be 00 00 00 00       	mov    $0x0,%esi
  2c10bf:	48 8b 7d c8          	mov    -0x38(%rbp),%rdi
  2c10c3:	e8 1d fd ff ff       	call   2c0de5 <merge_sort>

    // create return arrays to be passed onto the user
    long *size_array = (long *)malloc(sizeof(long) * size);
  2c10c8:	48 8d 04 dd 00 00 00 	lea    0x0(,%rbx,8),%rax
  2c10cf:	00 
  2c10d0:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
  2c10d4:	48 89 c7             	mov    %rax,%rdi
  2c10d7:	e8 71 fd ff ff       	call   2c0e4d <malloc>
  2c10dc:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    if (size_array == NULL) {
  2c10e0:	48 85 c0             	test   %rax,%rax
  2c10e3:	0f 84 90 00 00 00    	je     2c1179 <heap_info+0x1b5>
        info->size_array = (long *)NULL;
        info->ptr_array = (void **)NULL;
        return ERROR;
    }

    void **ptr_array = (void **)malloc(sizeof(void *) * size);
  2c10e9:	48 8b 7d b0          	mov    -0x50(%rbp),%rdi
  2c10ed:	e8 5b fd ff ff       	call   2c0e4d <malloc>
  2c10f2:	48 89 c7             	mov    %rax,%rdi
    if (ptr_array == NULL) {
  2c10f5:	48 85 c0             	test   %rax,%rax
  2c10f8:	0f 84 96 00 00 00    	je     2c1194 <heap_info+0x1d0>
        info->ptr_array = (void **)NULL;
        return ERROR;
    }

    // copy sorted information into the return arrays
    for (size_t j = 0; j < size; j++)
  2c10fe:	48 85 db             	test   %rbx,%rbx
  2c1101:	74 47                	je     2c114a <heap_info+0x186>
        size_array[i] = struct_array[i].size;
  2c1103:	4c 89 e0             	mov    %r12,%rax
  2c1106:	48 c1 e0 04          	shl    $0x4,%rax
  2c110a:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
  2c110e:	48 01 c2             	add    %rax,%rdx
  2c1111:	49 c1 e4 03          	shl    $0x3,%r12
  2c1115:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
  2c1119:	4a 8d 34 20          	lea    (%rax,%r12,1),%rsi
    for (size_t j = 0; j < size; j++)
  2c111d:	b8 00 00 00 00       	mov    $0x0,%eax
        size_array[i] = struct_array[i].size;
  2c1122:	48 8b 0a             	mov    (%rdx),%rcx
  2c1125:	48 89 0e             	mov    %rcx,(%rsi)
    for (size_t j = 0; j < size; j++)
  2c1128:	48 83 c0 01          	add    $0x1,%rax
  2c112c:	48 39 d8             	cmp    %rbx,%rax
  2c112f:	75 f1                	jne    2c1122 <heap_info+0x15e>
    for (size_t j = 0; j < size; j++)
        ptr_array[i] = struct_array[i].ptr;
  2c1131:	49 01 fc             	add    %rdi,%r12
  2c1134:	b8 00 00 00 00       	mov    $0x0,%eax
  2c1139:	48 8b 4a 08          	mov    0x8(%rdx),%rcx
  2c113d:	49 89 0c 24          	mov    %rcx,(%r12)
    for (size_t j = 0; j < size; j++)
  2c1141:	48 83 c0 01          	add    $0x1,%rax
  2c1145:	48 39 d8             	cmp    %rbx,%rax
  2c1148:	75 ef                	jne    2c1139 <heap_info+0x175>

    // set all final values in the heap info struct
    info->num_allocs = num_allocs;
  2c114a:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
  2c114e:	44 89 38             	mov    %r15d,(%rax)
    info->size_array = size_array;
  2c1151:	48 8b 75 c0          	mov    -0x40(%rbp),%rsi
  2c1155:	48 89 70 08          	mov    %rsi,0x8(%rax)
    info->ptr_array = ptr_array;
  2c1159:	48 89 78 10          	mov    %rdi,0x10(%rax)
    info->free_space = free_space;
  2c115d:	44 89 70 18          	mov    %r14d,0x18(%rax)
    info->largest_free_chunk = largest_free_chunk;
  2c1161:	44 89 68 1c          	mov    %r13d,0x1c(%rax)

    return SUCCESS;
  2c1165:	b8 00 00 00 00       	mov    $0x0,%eax
}
  2c116a:	48 83 c4 28          	add    $0x28,%rsp
  2c116e:	5b                   	pop    %rbx
  2c116f:	41 5c                	pop    %r12
  2c1171:	41 5d                	pop    %r13
  2c1173:	41 5e                	pop    %r14
  2c1175:	41 5f                	pop    %r15
  2c1177:	5d                   	pop    %rbp
  2c1178:	c3                   	ret    
        info->size_array = (long *)NULL;
  2c1179:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
  2c117d:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
  2c1184:	00 
        info->ptr_array = (void **)NULL;
  2c1185:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
  2c118c:	00 
        return ERROR;
  2c118d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  2c1192:	eb d6                	jmp    2c116a <heap_info+0x1a6>
        info->size_array = (long *)NULL;
  2c1194:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
  2c1198:	48 c7 40 08 00 00 00 	movq   $0x0,0x8(%rax)
  2c119f:	00 
        info->ptr_array = (void **)NULL;
  2c11a0:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
  2c11a7:	00 
        return ERROR;
  2c11a8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  2c11ad:	eb bb                	jmp    2c116a <heap_info+0x1a6>

00000000002c11af <app_printf>:
#include "process.h"

// app_printf
//     A version of console_printf that picks a sensible color by process ID.

void app_printf(int colorid, const char* format, ...) {
  2c11af:	55                   	push   %rbp
  2c11b0:	48 89 e5             	mov    %rsp,%rbp
  2c11b3:	48 83 ec 50          	sub    $0x50,%rsp
  2c11b7:	49 89 f2             	mov    %rsi,%r10
  2c11ba:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
  2c11be:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
  2c11c2:	4c 89 45 f0          	mov    %r8,-0x10(%rbp)
  2c11c6:	4c 89 4d f8          	mov    %r9,-0x8(%rbp)
    int color;
    if (colorid < 0) {
        color = 0x0700;
  2c11ca:	be 00 07 00 00       	mov    $0x700,%esi
    if (colorid < 0) {
  2c11cf:	85 ff                	test   %edi,%edi
  2c11d1:	78 2e                	js     2c1201 <app_printf+0x52>
    } else {
        static const uint8_t col[] = { 0x0E, 0x0F, 0x0C, 0x0A, 0x09 };
        color = col[colorid % sizeof(col)] << 8;
  2c11d3:	48 63 ff             	movslq %edi,%rdi
  2c11d6:	48 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rdx
  2c11dd:	cc cc cc 
  2c11e0:	48 89 f8             	mov    %rdi,%rax
  2c11e3:	48 f7 e2             	mul    %rdx
  2c11e6:	48 89 d0             	mov    %rdx,%rax
  2c11e9:	48 c1 e8 02          	shr    $0x2,%rax
  2c11ed:	48 83 e2 fc          	and    $0xfffffffffffffffc,%rdx
  2c11f1:	48 01 c2             	add    %rax,%rdx
  2c11f4:	48 29 d7             	sub    %rdx,%rdi
  2c11f7:	0f b6 b7 1d 16 2c 00 	movzbl 0x2c161d(%rdi),%esi
  2c11fe:	c1 e6 08             	shl    $0x8,%esi
    }

    va_list val;
    va_start(val, format);
  2c1201:	c7 45 b8 10 00 00 00 	movl   $0x10,-0x48(%rbp)
  2c1208:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c120c:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
  2c1210:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
  2c1214:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    cursorpos = console_vprintf(cursorpos, color, format, val);
  2c1218:	48 8d 4d b8          	lea    -0x48(%rbp),%rcx
  2c121c:	4c 89 d2             	mov    %r10,%rdx
  2c121f:	8b 3d d7 7d df ff    	mov    -0x208229(%rip),%edi        # b8ffc <cursorpos>
  2c1225:	e8 4b f8 ff ff       	call   2c0a75 <console_vprintf>
    va_end(val);

    if (CROW(cursorpos) >= 23) {
        cursorpos = CPOS(0, 0);
  2c122a:	3d 30 07 00 00       	cmp    $0x730,%eax
  2c122f:	ba 00 00 00 00       	mov    $0x0,%edx
  2c1234:	0f 4d c2             	cmovge %edx,%eax
  2c1237:	89 05 bf 7d df ff    	mov    %eax,-0x208241(%rip)        # b8ffc <cursorpos>
    }
}
  2c123d:	c9                   	leave  
  2c123e:	c3                   	ret    

00000000002c123f <kernel_panic>:


// kernel_panic, assert_fail
//     Call the INT_SYS_PANIC system call so the kernel loops until Control-C.

void kernel_panic(const char* format, ...) {
  2c123f:	55                   	push   %rbp
  2c1240:	48 89 e5             	mov    %rsp,%rbp
  2c1243:	53                   	push   %rbx
  2c1244:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
  2c124b:	48 89 fb             	mov    %rdi,%rbx
  2c124e:	48 89 75 c8          	mov    %rsi,-0x38(%rbp)
  2c1252:	48 89 55 d0          	mov    %rdx,-0x30(%rbp)
  2c1256:	48 89 4d d8          	mov    %rcx,-0x28(%rbp)
  2c125a:	4c 89 45 e0          	mov    %r8,-0x20(%rbp)
  2c125e:	4c 89 4d e8          	mov    %r9,-0x18(%rbp)
    va_list val;
    va_start(val, format);
  2c1262:	c7 45 a8 08 00 00 00 	movl   $0x8,-0x58(%rbp)
  2c1269:	48 8d 45 10          	lea    0x10(%rbp),%rax
  2c126d:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
  2c1271:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
  2c1275:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    char buf[160];
    memcpy(buf, "PANIC: ", 7);
  2c1279:	ba 07 00 00 00       	mov    $0x7,%edx
  2c127e:	be e7 15 2c 00       	mov    $0x2c15e7,%esi
  2c1283:	48 8d bd 08 ff ff ff 	lea    -0xf8(%rbp),%rdi
  2c128a:	e8 8d ef ff ff       	call   2c021c <memcpy>
    int len = vsnprintf(&buf[7], sizeof(buf) - 7, format, val) + 7;
  2c128f:	48 8d 4d a8          	lea    -0x58(%rbp),%rcx
  2c1293:	48 89 da             	mov    %rbx,%rdx
  2c1296:	be 99 00 00 00       	mov    $0x99,%esi
  2c129b:	48 8d bd 0f ff ff ff 	lea    -0xf1(%rbp),%rdi
  2c12a2:	e8 49 f8 ff ff       	call   2c0af0 <vsnprintf>
  2c12a7:	8d 50 07             	lea    0x7(%rax),%edx
    va_end(val);
    if (len > 0 && buf[len - 1] != '\n') {
  2c12aa:	85 d2                	test   %edx,%edx
  2c12ac:	7e 0f                	jle    2c12bd <kernel_panic+0x7e>
  2c12ae:	83 c0 06             	add    $0x6,%eax
  2c12b1:	48 98                	cltq   
  2c12b3:	80 bc 05 08 ff ff ff 	cmpb   $0xa,-0xf8(%rbp,%rax,1)
  2c12ba:	0a 
  2c12bb:	75 2a                	jne    2c12e7 <kernel_panic+0xa8>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
    }
    (void) console_printf(CPOS(23, 0), 0xC000, "%s", buf);
  2c12bd:	48 8d 9d 08 ff ff ff 	lea    -0xf8(%rbp),%rbx
  2c12c4:	48 89 d9             	mov    %rbx,%rcx
  2c12c7:	ba ef 15 2c 00       	mov    $0x2c15ef,%edx
  2c12cc:	be 00 c0 00 00       	mov    $0xc000,%esi
  2c12d1:	bf 30 07 00 00       	mov    $0x730,%edi
  2c12d6:	b8 00 00 00 00       	mov    $0x0,%eax
  2c12db:	e8 da f7 ff ff       	call   2c0aba <console_printf>
    asm volatile ("int %0" : /* no result */
  2c12e0:	48 89 df             	mov    %rbx,%rdi
  2c12e3:	cd 30                	int    $0x30
 loop: goto loop;
  2c12e5:	eb fe                	jmp    2c12e5 <kernel_panic+0xa6>
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
  2c12e7:	48 63 c2             	movslq %edx,%rax
  2c12ea:	81 fa 9f 00 00 00    	cmp    $0x9f,%edx
  2c12f0:	0f 94 c2             	sete   %dl
  2c12f3:	0f b6 d2             	movzbl %dl,%edx
  2c12f6:	48 29 d0             	sub    %rdx,%rax
  2c12f9:	48 8d bc 05 08 ff ff 	lea    -0xf8(%rbp,%rax,1),%rdi
  2c1300:	ff 
  2c1301:	be 7c 13 2c 00       	mov    $0x2c137c,%esi
  2c1306:	e8 d3 ef ff ff       	call   2c02de <strcpy>
  2c130b:	eb b0                	jmp    2c12bd <kernel_panic+0x7e>

00000000002c130d <assert_fail>:
    panic(buf);
 spinloop: goto spinloop;       // should never get here
}

void assert_fail(const char* file, int line, const char* msg) {
  2c130d:	55                   	push   %rbp
  2c130e:	48 89 e5             	mov    %rsp,%rbp
  2c1311:	48 89 f9             	mov    %rdi,%rcx
  2c1314:	41 89 f0             	mov    %esi,%r8d
  2c1317:	49 89 d1             	mov    %rdx,%r9
    (void) console_printf(CPOS(23, 0), 0xC000,
  2c131a:	ba f8 15 2c 00       	mov    $0x2c15f8,%edx
  2c131f:	be 00 c0 00 00       	mov    $0xc000,%esi
  2c1324:	bf 30 07 00 00       	mov    $0x730,%edi
  2c1329:	b8 00 00 00 00       	mov    $0x0,%eax
  2c132e:	e8 87 f7 ff ff       	call   2c0aba <console_printf>
    asm volatile ("int %0" : /* no result */
  2c1333:	bf 00 00 00 00       	mov    $0x0,%edi
  2c1338:	cd 30                	int    $0x30
 loop: goto loop;
  2c133a:	eb fe                	jmp    2c133a <assert_fail+0x2d>
