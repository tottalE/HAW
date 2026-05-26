/* THIRD LAB SO1(08 / 12 / 2025)
15.1 Theory: Geographic coordinates and distances
Hemispheres */

#include <stdio.h>  // include standard input/output header file for printf and getchar

// Step 2: Function prototypes
// Declare the functions so main() knows about them before they are defined
int isNorthernHemisphere(double latitude);
int isSouthernHemisphere(double latitude);

int main(void) // main function - starting point of the program
{
	// Step 3: Declare and initialize test latitude values
	double lat1 = 45.0; // Northern hemisphere example
	double lat2 = -30.0; // Southern hemisphere example
	double lat3 = 0.0; // Equator example

	// Step 4: Test northern and southern hemisphere functions with lat1
	// Print the result of checking if lat1 is in the northern hemisphere
	printf("Latitude %.1f is in northern hemisphere? %d\n", lat1, isNorthernHemisphere(lat1));
	// Print the result of checking if lat1 is in the southern hemisphere
	printf("Latitude %.1f is in southern hemisphere? %d\n", lat1, isSouthernHemisphere(lat1));

	// Step 5: Test northern and southern hemisphere functions with lat2
	printf("Latitude %.1f is in northern hemisphere? %d\n", lat2, isNorthernHemisphere(lat2));
	printf("Latitude %.1f is in southern hemisphere? %d\n", lat2, isSouthernHemisphere(lat2));

	// Step 6: Test northern and southern hemisphere functions with lat3 (equator)
	printf("Latitude %.1f is in northern hemisphere? %d\n", lat3, isNorthernHemisphere(lat3));
	printf("Latitude %.1f is in southern hemisphere? %d\n", lat3, isSouthernHemisphere(lat3));

	// Step 7: Keep the console window open until a key is pressed
	getchar();

	// Step 8: End the program
	return 0;
}

// Step 9: Define function to check if a latitude is in the northern hemisphere
int isNorthernHemisphere(double latitude)
{
	// Step 9a: If the latitude is greater than 0, it is northern hemisphere
	if (latitude > 0)
		return 1; // Step 9b: Return 1 (true) if northern
	else
		return 0; // Step 9c: Return 0 (false) otherwise
}

// Step 10: Define function to check if a latitude is in the southern hemisphere
int isSouthernHemisphere(double latitude)
{
	// Step 10a: If the latitude is less than 0, it is southern hemisphere
	if (latitude < 0)
		return 1; // Step 10b: Return 1 (true) if southern
	else
		return 0; // Step 10c: Return 0 (false) otherwise
}
