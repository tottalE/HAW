/*
	* Author: Jinju Ok
	* Chessboard fields
	* Print 2-dimensional order with for-loops.
	* 2025.11.21
*/

#include <stdio.h>
#define SIZE 8

int main(void)
{	
	for (int i = SIZE; i >= 1; i--)
	{
		printf("+----+----+----+----+----+----+----+----+\n|");
		
		// print same number(i) and different char
		for (int j = 0; j < SIZE; j++)
			printf(" %c%d |", 'a' + j, i);

		printf("\n"); // after finishing a-h, start next prints row

	}
	printf("+----+----+----+----+----+----+----+----+");

	return 0;
}

