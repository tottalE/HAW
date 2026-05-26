/*
	* Author: Jinju Ok
	* Algorithmic operations for integer numbers
	* This program prints 4 calcuation of numbers
	* 2025.11.09
*/

#include <stdio.h>

int main(void)
{
	int num1 = 7, num2 = 3;

	// print each values out.
	printf("Simple calculator:\n-----------------\n");
	printf("1st operand: %d\n", num1);
	printf("1st operand: %d\n", num2);
	printf("\n");
	// calculate each value and put number in sentence. 
	printf("%d + %d = %d\n", num1, num2, num1 + num2);
	printf("%d - %d = %d\n", num1, num2, num1 - num2);
	printf("%d * %d = %d\n", num1, num2, num1 * num2);
	printf("%d / %d = %d\n", num1, num2, num1 / num2);
	printf("%d %% %d = %d\n", num1, num2, num1 % num2);
	return 0;
}