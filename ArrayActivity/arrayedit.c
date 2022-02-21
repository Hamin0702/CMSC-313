#include <stdio.h>


void display (int *arr[]) {

	for (int i = 0; i <10; ++i)
		printf (" %d \n", *arr[i]);



}




void edit (int *arr[], int val, int index) {
	++val;
	index = index%10;
	arr[index] = &val;

}


