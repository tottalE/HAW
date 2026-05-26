/*
	* Author: Jinju Ok
	* Digit Sum
	* Ask birth and calculate digits.
	* 2025.11.09
*/

#define _CRT_SECURE_NO_DEPRECATE
#include <stdio.h>

int main(void)
{
	int birthYear, digitSum;

	// print each values out.
	printf("Digit calculator:\n-----------------\n");
	printf("Please Enter your year of birth: ");
	scanf("%d", &birthYear);
	printf("\n");

	// calculate for each digit by calcuating remainder. 
	// Should remain only each digits to divide to count each digits.
	digitSum = birthYear / 1000 + birthYear % 1000 / 100 + birthYear  % 100 / 10 + birthYear % 10;
	printf("Digit Sum: %d", digitSum);
	return 0;
}