#include "malloc.h"

// DEFINE MACROS
#define ALIGNMENT_EIGHT 8

#define SUCCESS 0
#define ERROR -1

#define FALSE 0
#define TRUE 1

// DEFINE LINKED LIST NODE STRUCTURES
typedef struct _flist_node flist_node;

struct _flist_node {
    size_t size;
    size_t free;
    flist_node *next;
};

typedef struct _heap_info_node {
    long size;
    void *ptr;
} heap_info_node;

// DECLARE GLOBAL VARIABLES
static flist_node head = {0, 0, (flist_node *)NULL};

// DECLARE AND DEFINE HELPER FUNCTIONS

// alignof_eight()
//    Aligns the value passed into it to the nearest multiple of eight. It
//    returns the value that will bring the value passed into it to the nearest
//    multiple of eight.

size_t alignof_eight(size_t sz) {
    return ALIGNMENT_EIGHT - sz + (sz & ~(ALIGNMENT_EIGHT - 1));
}

// comp_structs()
//    Compare and sort struct array based on the sizes of alloc'd blocks.

int comp_structs(const void *p1, const void *p2) {
    const heap_info_node a = *(heap_info_node *)p1;
    const heap_info_node b = *(heap_info_node *)p2;
    return a.size <= b.size ? TRUE : FALSE;
}

// NOTE: I utilized GeeksForGeeks as a refresher for the implementation of the
//       merge sort algorithm. I was sure to utilize the Gilligan Island rule
//       and performed a mind-numbing activity to implement the code from
//       memory.

// CITATION:
//    GeeksForGeeks (22 Apr, 2022) Merge Sort source code.
//    https://www.geeksforgeeks.org/merge-sort/

// merge()
//    Merges two arrays together to be used by the function responsible for
//    the merge sort algorithm.

void merge(heap_info_node *array, size_t left, size_t center, size_t right,
           int (*compare)(const void *, const void *)) {
    // calculate the lengths of the subarrays
    size_t len1 = center - left + 1;
    size_t len2 = right - center;

    // create temporary storage arrays
    // heap_info_node *temp1[len1]
    heap_info_node temp1[len1];
    heap_info_node temp2[len2];

    // copy all data over into the storage arrays
    for (size_t i = 0; i < len1; i++)
        temp1[i] = array[left + i];
    for (size_t i = 0; i < len2; i++)
        temp2[i] = array[center + i + 1];

    size_t i = 0;
    size_t j = 0;
    size_t k = left;
    
    // compare and set values in array accordingly
    while (i < len1 && j < len2) {
        if ((*compare)(&temp1[i], &temp2[j])) {
            array[k] = temp1[i];
            i++;
        } else {
            array[k] = temp2[j];
            j++;
        }
        k++;
    }

    // add on the rest of the items in the first storage array
    while (i < len1) {
        array[k] = temp1[i];
        i++;
        k++;
    }

    // add on the rest of the items in the second storage array
    while (j < len2) {
        array[k] = temp2[j];
        j++;
        k++;
    }
}

// merge_sort()
//    Standard implemention of the merge sort algorithm. It takes in a
//    specialized function to compare the specific values of the array.

void merge_sort(heap_info_node *array, size_t left, size_t right,
                int (*compare)(const void *, const void *)) {
    // check indices as base case for the recursion
    if (left < right) {
        // calculate the center of the array    
        size_t center = (left + right - 1) / 2;

        // recursively call the merge_sort() algorithm to sort subsections
        merge_sort(array, left, center, compare);
        merge_sort(array, center + 1, right, compare);

        // merge all resulting arrays back into one
        merge(array, left, center, right, compare);
    }
}

// IMPLEMENT REQUIRED FUNCTIONS
void *malloc(uint64_t numbytes) {
    if (numbytes == 0)
        return NULL;

    size_t size = sizeof(flist_node) + numbytes + 
                    alignof_eight(sizeof(flist_node) + numbytes);
    
    flist_node *tmp = head.next;
    flist_node **ptr = &head.next;

    while (tmp != NULL) {
        if (tmp->free && tmp->size >= size) {
            // check if you can assign a free block after the allocation
            size_t difference = tmp->size - size;
            if (difference > sizeof(flist_node)) {
                flist_node *nblock = (flist_node *)((uintptr_t)tmp + size);
                nblock->size = difference;
                nblock->free = 1;
                nblock->next = tmp->next;
                *ptr = nblock;
            } else {
                size += difference;
                *ptr = tmp->next;
            }

            return (void *)((uintptr_t)tmp + sizeof(flist_node));
        }

        ptr = &(tmp->next);
        tmp = tmp->next;
    }

    tmp = (flist_node *)sbrk(size);
    tmp->size = size;
    tmp->free = 0;
    tmp->next = (flist_node *)NULL;

    return (void *)((uintptr_t)tmp + sizeof(flist_node));
}

void free(void *firstbyte) {
    // free the location by setting the corresponding bit
    flist_node *tmp = (flist_node *)((uintptr_t)firstbyte - 
                        sizeof(flist_node));
    tmp->free = 1;
}

void *calloc(uint64_t num, uint64_t sz) {
    // alloc new space and set all memory to zero
    void *ptr = malloc(num * sz);
    memset(ptr, 0, num * sz);
    return ptr;
}

void *realloc(void *ptr, uint64_t sz) {
    // error handling (multiple cases)
    if (ptr == NULL)
        return malloc(sz);

    if (ptr != NULL && sz == 0) {
        free(ptr);
        return NULL;
    }

    // alloc new space for the information
    void *nptr = malloc(sz);

    // find locations of full size (this includes flist_node and the block)
    flist_node *nptr_node = (flist_node *)((uintptr_t)nptr - 
                                sizeof(flist_node));
    flist_node *ptr_node = (flist_node *)((uintptr_t)ptr - 
                                sizeof(flist_node));

    // copy over all of the information and free the old space
    memcpy(nptr_node, ptr_node, ptr_node->size);
    free(ptr);

    return nptr;
}

void defrag() {
    // loop through list to find all adjacent free blocks and combine them
    flist_node *tmp1 = head.next;
    while (tmp1 != NULL) {
        flist_node *tmp2 = tmp1->next;
        while (tmp2->free && tmp2 != NULL) {
            tmp1->size += tmp2->size;
            tmp2 = tmp2->next;
        }
        tmp1->next = tmp2;
        tmp1 = tmp1->next;
    }
}

int heap_info(heap_info_struct *info) {
    // initialize all temporary variables
    size_t size = 0;
    size_t num_allocs = 0;
    size_t free_space = 0;
    size_t largest_free_chunk = 0;

    // iterate through free list and make initial calculations
    flist_node *tmp = head.next;
    while (tmp != NULL) {
        if (tmp->free) {
            free_space += sizeof(flist_node) + tmp->size;
            if (tmp->size > largest_free_chunk) {
                largest_free_chunk = tmp->size;
            }
        } else
            num_allocs++;

        size++;
        tmp = tmp->next;
    }

    // create temporary array of structs to sort all values
    heap_info_node *struct_array =
        (heap_info_node *)malloc(sizeof(heap_info_node) * size);
    if (struct_array == NULL) {
        info->size_array = (long *)NULL;
        info->ptr_array = (void **)NULL;
        // return ERROR;
    }

    // populate temporary array as necessary
    tmp = head.next;
    size_t i = 0;
    while (tmp != NULL) {
        if (!tmp->free) {
            struct_array[i].size = tmp->size;
            struct_array[i].ptr = (void *)((uintptr_t)tmp + 
                                    sizeof(flist_node));
            i++;
        }
        tmp = tmp->next;
    }

    // perform merge sort algorithm on the array of structs
    merge_sort(struct_array, 0, size, comp_structs);

    // create return arrays to be passed onto the user
    long *size_array = (long *)malloc(sizeof(long) * size);
    if (size_array == NULL) {
        info->size_array = (long *)NULL;
        info->ptr_array = (void **)NULL;
        return ERROR;
    }

    void **ptr_array = (void **)malloc(sizeof(void *) * size);
    if (ptr_array == NULL) {
        info->size_array = (long *)NULL;
        info->ptr_array = (void **)NULL;
        return ERROR;
    }

    // copy sorted information into the return arrays
    for (size_t j = 0; j < size; j++)
        size_array[i] = struct_array[i].size;
    for (size_t j = 0; j < size; j++)
        ptr_array[i] = struct_array[i].ptr;

    // set all final values in the heap info struct
    info->num_allocs = num_allocs;
    info->size_array = size_array;
    info->ptr_array = ptr_array;
    info->free_space = free_space;
    info->largest_free_chunk = largest_free_chunk;

    return SUCCESS;
}
