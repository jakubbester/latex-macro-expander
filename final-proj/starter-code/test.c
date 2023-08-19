#include <stdio.h>
#include <stdlib.h>

// comp_sizes()
//    Compare and sort array based on the sizes of alloc'd blocks.

int comp_sizes(const void *p1, const void *p2) {
    return *(const int *)p1 <= *(const int *)p2 ? 1 : 0;
}

// NOTE: I utilized GeeksForGeeks as a refresher for the implementation of the
//       merge sort algorithm. I was sure to utilize the Gilligan Island rule
//       and performed a mind-numbing activity to implement the code from
//       memory.

// CITATION
//    GeeksForGeeks (22 Apr, 2022) Merge Sort source code.
//    https://www.geeksforgeeks.org/merge-sort/

// merge()
//    Merges two arrays together to be used by the function responsible for
//    the merge sort algorithm.

void merge(int *array, size_t left, size_t center, size_t right,
           int (*compare)(const void *, const void *)) {
    // calculate the lengths of the subarrays
    size_t len1 = center - left + 1;
    size_t len2 = right - center;

    // create temporary storage arrays
    int temp1[len1];
    int temp2[len2];

    // int *temp1 = (int *)malloc(len1 * sizeof(int));
    // int *temp2 = (int *)malloc(len2 * sizeof(int));

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

    // free(temp1);
    // free(temp2);
}

// merge_sort()
//    Standard implemention of the merge sort algorithm. It takes in a
//    specialized function to compare the specific values of the array.

void merge_sort(int *array, size_t left, size_t right,
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

int main() {
    int array[10] = {10, 3, 5, 4, 7, 6, 7, 1, 9, 10};
    for (size_t i = 0; i < 10; i++) {
        printf("%d ", array[i]);
    }
    printf("\n");
    merge_sort(array, 0, 10, comp_sizes);
    for (size_t i = 0; i < 10; i++) {
        printf("%d ", array[i]);
    }
    printf("\n");
}
