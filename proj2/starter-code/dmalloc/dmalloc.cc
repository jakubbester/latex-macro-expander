#define M61_DISABLE 1
#include "dmalloc.hh"
#include <cstdlib>
#include <cstring>
#include <cstdio>
#include <cinttypes>
#include <cassert>
#include <iterator>
#include <map>
using namespace std;

// (Helper functions, types, structs, macros, globals, etc.)
unsigned long long nactive = 0;
unsigned long long active_size = 0;
unsigned long long ntotal = 0;
unsigned long long total_size = 0;
unsigned long long nfail = 0;
unsigned long long fail_size = 0;
uintptr_t heap_min = UINTPTR_MAX;
uintptr_t heap_max = 0;

#define DEADBEEF 3735928559 // 0xdeadbeef
size_t underflow_canary = DEADBEEF; 
size_t overflow_canary = DEADBEEF;

void *head = nullptr;
void *storage = nullptr;
void *tail = nullptr;

typedef struct _header {
    size_t sz;
    size_t deadbeef;
    bool free;
    void *next;
    void *prev;
    const char *file;
    long line;
} header;

bool check_addition_overflow(size_t a, size_t b) {
    size_t result = a + b;
    if (result < a) {
      return true;
    }
    if (result < b) {
      return true;
    }
    return false;
}

bool check_multiplication_overflow(size_t a, size_t b) {
    size_t result = a * b;
    if (a == result / b) {
      return false;
    }
    return true;
}

size_t alignof_sixteen(size_t a) {
    if (a % 16 != 0) {
      return 16 - (a % 16);
    } else {
      return 0;
    }
}

#define THRESHOLD 0.20
#define ARRAY_SIZE (size_t)(1 / THRESHOLD)

typedef struct _symbol {
    const char *file;
    long line;
    size_t count;
} symbol;

map<void *, header *> active_allocations;

size_t eliminated = 0;
size_t symbols_size = 0;
symbol symbols[ARRAY_SIZE] = {{nullptr, 0, 0}, {nullptr, 0, 0}, {nullptr, 0, 0}, {nullptr, 0, 0}, {nullptr, 0, 0}};

int symbols_compare(const void *value1, const void *value2) {
    const symbol *left_value = (const symbol *)value1;
    const symbol *right_value = (const symbol *)value2;
    double left_result = (double)(left_value->count + eliminated) / total_size * 100;
    double right_result = (double)(right_value->count + eliminated) / total_size * 100;
    return (int)(right_result - left_result);
}

/// dmalloc_malloc(sz, file, line)
///    Return a pointer to `sz` bytes of newly-allocated dynamic memory.
///    The memory is not initialized. If `sz == 0`, then dmalloc_malloc must
///    return a unique, newly-allocated pointer value. The allocation
///    request was at location `file`:`line`.

void *dmalloc_malloc(size_t sz, const char* file, long line) {
    (void) file, (void) line;   // avoid uninitialized variable warnings
    size_t header_size = sizeof(header) + alignof_sixteen(sizeof(header));
    size_t underflow_canary_size = sizeof(underflow_canary) + alignof_sixteen(sizeof(underflow_canary));
    size_t payload_size = sz;
    size_t overflow_canary_size = sizeof(overflow_canary);
    if (check_addition_overflow(header_size + underflow_canary_size + overflow_canary_size, payload_size)) {
      nfail++;
      fail_size += sz;
      return nullptr;
    }
    void *ptr = base_malloc(header_size + underflow_canary_size + payload_size + overflow_canary_size);
    if (ptr) {
      uintptr_t pos1 = (uintptr_t)ptr;
      uintptr_t pos2 = pos1 + header_size;
      uintptr_t pos3 = pos2 + underflow_canary_size;
      uintptr_t pos4 = pos3 + payload_size;
      nactive++;
      active_size += sz;
      ((header *)pos1)->sz = sz;
      ((header *)pos1)->free = false;
      ((header *)pos1)->deadbeef = DEADBEEF;
      ((header *)pos1)->file = file;
      ((header *)pos1)->line = line;
      *(size_t *)(pos2) = underflow_canary;
      *(size_t *)(pos4) = overflow_canary;
      ntotal++;
      total_size += sz;
      if (pos3 > heap_max) {
        heap_max = pos4 + overflow_canary_size;
      }
      if (pos1 < heap_min) {
        heap_min = pos1;
      }
      if (head == nullptr) {
        head = (void *)pos1;
        ((header *)pos1)->next = nullptr;
        ((header *)pos1)->prev = nullptr;
        tail = (void *)pos1;
        storage = (void *)pos1;
      } else {
        ((header *)pos1)->next = nullptr;
        ((header *)pos1)->prev = storage;
        tail = (void *)pos1;
        ((header *)storage)->next = (void *)pos1;
        storage = (void *)pos1;
      }
      active_allocations.insert(pair<void *, header *>((void *)pos3, (header *)ptr));
      bool present = false;
      for (size_t i = 0; i < symbols_size; i++) {
        if (strcmp(file, symbols[i].file) == 0 && line == symbols[i].line) {
          symbols[i].count += ((header *)pos1)->sz;
          present = true;
        }
      }
      if (!present) {
        if (symbols_size == ARRAY_SIZE) {
          size_t smallest = SIZE_MAX;
          size_t index = 0;
          for (size_t i = 0; i < symbols_size; i++) {
            if (symbols[i].count < smallest) {
              smallest = symbols[i].count;
              index = i;
            }
          }
          if (((header *)pos1)->sz < smallest) {
            smallest = ((header *)pos1)->sz;
            index = 6;
          }
          for (size_t i = 0; i < symbols_size; i++) {
            symbols[i].count -= smallest;
          }
          if (index < 6) {
            symbols[index].file = file;
            symbols[index].line = line;
            symbols[index].count = ((header *)pos1)->sz;
          }
          eliminated += smallest;
        } else {
          symbols[symbols_size].file = file;
          symbols[symbols_size].line = line;
          symbols_size++;
        }
      }
    } else {
      nfail++;
      fail_size += sz;
      return nullptr;
    }
    return (void *)((uintptr_t)ptr + header_size + underflow_canary_size);
}


/// dmalloc_free(ptr, file, line)
///    Free the memory space pointed to by `ptr`, which must have been
///    returned by a previous call to dmalloc_malloc. If `ptr == NULL`,
///    does nothing. The free was called at location `file`:`line`.

void dmalloc_free(void *ptr, const char *file, long line) {
    (void) file, (void) line;   // avoid uninitialized variable warnings
    if (ptr != nullptr) {
      size_t header_size = sizeof(header) + alignof_sixteen(sizeof(header));
      size_t underflow_canary_size = sizeof(underflow_canary) + alignof_sixteen(sizeof(underflow_canary));
      uintptr_t pos1 = (uintptr_t)ptr - underflow_canary_size - header_size;
      uintptr_t pos2 = pos1 + header_size;
      uintptr_t pos3 = pos2 + underflow_canary_size;
      if (pos1 < heap_min || pos3 > heap_max || pos1 > pos3 || heap_min == UINTPTR_MAX || heap_max == 0) {
        fprintf(stderr, "MEMORY BUG: %s:%ld: invalid free of pointer %p, not in heap\n", file, line, (void *)pos3);
        exit(EXIT_FAILURE);
      }
      size_t payload_size = ((header *)pos1)->sz;
      uintptr_t pos4 = pos3 + payload_size;
      
      if (((header *)pos1)->free) {
        fprintf(stderr, "MEMORY BUG: %s:%ld: invalid free of pointer %p, double free\n", file, line, (void *)pos3);
        exit(EXIT_FAILURE);
      }
      if (!((header *)pos1)->free) {
        ((header *)pos1)->free = true;
      }
      if (((header *)pos1)->deadbeef != DEADBEEF || active_allocations.find(ptr) == active_allocations.end()) {
        header *tmp = (header *)head;
        while (tmp != nullptr && (uintptr_t)tmp + header_size + underflow_canary_size < pos3) {
          tmp = (header *)tmp->next;
        }
        if (tmp == nullptr && pos3 < heap_max) {
          uintptr_t prev_pos1 = (uintptr_t)tail;
          uintptr_t prev_pos3 = (uintptr_t)tail + header_size + underflow_canary_size;
          uintptr_t overlap = pos3 - prev_pos3;
          fprintf(stderr, "MEMORY BUG: %s:%ld: invalid free of pointer %p, not allocated\n  %s:%ld: %p is %zu bytes inside a %zu byte region allocated here\n", file, line, (void *)pos3, ((header *)prev_pos1)->file, ((header *)prev_pos1)->line, (void *)pos3, overlap, ((header *)prev_pos1)->sz);
          exit(EXIT_FAILURE);
        } else if (tmp == nullptr) {
          fprintf(stderr, "MEMORY BUG: %s:%ld: invalid free of pointer %p, not allocated\n", file, line, (void *)pos3);
          exit(EXIT_FAILURE);
        } else {
          uintptr_t prev_pos1 = (uintptr_t)tmp->prev;
          uintptr_t prev_pos3 = (uintptr_t)prev_pos1 + header_size + underflow_canary_size;
          uintptr_t overlap = pos3 - prev_pos3;
          fprintf(stderr, "MEMORY BUG: %s:%ld: invalid free of pointer %p, not allocated\n  %s:%ld: %p is %zu bytes inside a %zu byte region allocated here\n", file, line, (void *)pos3, ((header *)prev_pos1)->file, ((header *)prev_pos1)->line, (void *)pos3, overlap, ((header *)prev_pos1)->sz);
          exit(EXIT_FAILURE);
        }
      }
      if (head == tail) {
        head = nullptr;
        storage = nullptr;
        tail = nullptr;
      } else if ((void *)pos1 == head) {
        head = ((header *)pos1)->next;
        ((header *)((header *)pos1)->next)->prev = nullptr;
      } else if ((void *)pos1 == tail) {
        tail = ((header *)pos1)->prev;
        ((header *)((header *)pos1)->prev)->next = nullptr;
      } else {
        ((header *)((header *)pos1)->prev)->next = ((header *)pos1)->next;
        ((header *)((header *)pos1)->next)->prev = ((header *)pos1)->prev;
      }
      if (*(size_t *)pos2 != *(size_t *)pos4) {
        fprintf(stderr, "MEMORY BUG: detected wild write during free of pointer %p\n", (void *)pos3);
        exit(EXIT_FAILURE);
      }
      nactive--;
      active_size -= ((header *)pos1)->sz;
      base_free((void *)pos1);
    }
}


/// dmalloc_calloc(nmemb, sz, file, line)
///    Return a pointer to newly-allocated dynamic memory big enough to
///    hold an array of `nmemb` elements of `sz` bytes each. If `sz == 0`,
///    then must return a unique, newly-allocated pointer value. Returned
///    memory should be initialized to zero. The allocation request was at
///    location `file`:`line`.

void *dmalloc_calloc(size_t nmemb, size_t sz, const char *file, long line) {
    if (check_multiplication_overflow(nmemb, sz)) {
      nfail++;
      fail_size += nmemb * sz;
      return nullptr;
    }
    void* ptr = dmalloc_malloc(nmemb * sz, file, line);
    if (ptr) {
        memset(ptr, 0, nmemb * sz);
    }
    return ptr;
}


/// dmalloc_get_statistics(stats)
///    Store the current memory statistics in `*stats`.

void dmalloc_get_statistics(dmalloc_statistics *stats) {
    // Stub: set all statistics to enormous numbers
    memset(stats, 255, sizeof(dmalloc_statistics));
    stats->nactive = nactive;
    stats->active_size = active_size;
    stats->ntotal = ntotal;
    stats->total_size = total_size;
    stats->nfail = nfail;
    stats->fail_size = fail_size;
    stats->heap_min = heap_min;
    stats->heap_max = heap_max;
}


/// dmalloc_print_statistics()
///    Print the current memory statistics.

void dmalloc_print_statistics() {
    dmalloc_statistics stats;
    dmalloc_get_statistics(&stats);

    printf("alloc count: active %10llu   total %10llu   fail %10llu\n",
           stats.nactive, stats.ntotal, stats.nfail);
    printf("alloc size:  active %10llu   total %10llu   fail %10llu\n",
           stats.active_size, stats.total_size, stats.fail_size);
}


/// dmalloc_print_leak_report()
///    Print a report of all currently-active allocated blocks of dynamic
///    memory.

void dmalloc_print_leak_report() {
    header *tmp = (header *)head;
    while (tmp != nullptr) {
      uintptr_t pos2 = (uintptr_t)tmp + sizeof(header) + alignof_sixteen(sizeof(header)) + sizeof(underflow_canary) + alignof_sixteen(sizeof(underflow_canary));
      printf("LEAK CHECK: %s:%ld: allocated object %p with size %zu\n", tmp->file, tmp->line, (void *)pos2, tmp->sz);
      tmp = (header *)tmp->next;
    }
}


/// dmalloc_print_heavy_hitter_report()
///    Print a report of heavily-used allocation locations.

void dmalloc_print_heavy_hitter_report() {
    qsort(symbols, symbols_size, sizeof(symbol), symbols_compare);
    for (size_t i = 0; i < ARRAY_SIZE; i++) {
      if (symbols[i].file == nullptr || symbols[i].line == 0 || symbols[i].count == 0) {
        break;
      }
      printf("HEAVY HITTER: %s:%ld: %ld bytes (~%.1f%%)\n", symbols[i].file, symbols[i].line, symbols[i].count + eliminated, (double)(symbols[i].count + eliminated) / total_size * 100);
    }
}
