/*
	* Author: Jinju Ok
	* Algorithmic operations for integer numbers
	* This program gets two input numbers and prints 4 calcuation of those
	* 2025.11.09
*/
#define _CRT_SECURE_NO_DEPRECATE
#include <stdio.h>

int main(void)
{
	int num1, num2;
	
	// Get a input from user for each integer variable.
	printf("Simple calculator:\n-----------------\n");
	printf("1st operand: ");
	scanf("%d", &num1);
	printf("2st operand: ");
	scanf("%d", &num2);
	printf("\n");
	// Calculate add, substract, multiply, divide and find remainder.
	printf("%d + %d = %d\n", num1, num2, num1 + num2);
	printf("%d - %d = %d\n", num1, num2, num1 - num2);
	printf("%d * %d = %d\n", num1, num2, num1 * num2);
	printf("%d / %d = %d\n", num1, num2, num1 / num2);
	printf("%d %% %d = %d\n", num1, num2, num1 % num2);
	getchar();
	return 0;
}