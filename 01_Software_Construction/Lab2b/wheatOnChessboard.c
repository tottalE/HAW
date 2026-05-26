/*
	* Author: Jinju Ok
	* Wheat on chessboard problem.
	* 2025.11.21
*/

#include <stdio.h>
#define SIZE 64

int main(void)
{
	double wGrain = 7.358e17;
	double product = 1; // number of grains
	double total = 0; // sum of grains

	printf("Field |       On field       |     Sum\n");
	
	for (int i = 0; i < SIZE; i++)
	{
		if (i % 8 == 0)
			printf("------+----------------------+--------------------------------\n");

		if (i != 0)
			product = product * 2;

		total += product;

		printf("%5.0d | %20.f | %20.f (= %.1e)\n", i + 1, product, total, total);
	}
	printf("------+----------------------+--------------------------------\n\n");

	printf("overall weight: %f", total);
	printf("relation p : %f", product * 55 / wGrain);

	return 0;
}