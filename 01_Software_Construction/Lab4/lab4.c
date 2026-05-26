/*
	* Author: Jinju Ok
	* Lab 4: Arrays & pointers
	* 2026.01.06
	* 
	* ,10.022918

*/

#include <stdio.h>
#include <math.h> // include math library for fabs(), cos(), sin(), acos(), sqrt()
#define _USE_MATH_DEFINES
#include "lab3b.h" // add header file to link distanceKm()
#define HAW_SIZE 9
#define W_SIZE 7

double getRouteLengthKm(const double lats[], const double lons[], int n);
double getMaximumDistance(const double coords[][2], int n, int* indexA, int* indexB);

int main(void)
{
	int indexA = 0;
	int indexB = 0;
	double maxDistance;
	// 1. Coordinates around HAW 
	double hawLatitudes[HAW_SIZE] = { 53.557029, 53.557166, 53.557274, 53.560288,
							   53.561306, 53.562015, 53.558241, 53.557900, 53.557203 };
	double hawLongitudes[HAW_SIZE] = { 10.021343, 10.020297, 10.014906, 10.015426,
								10.016568, 10.023244, 10.022142, 10.022632 };

	// Print Route
	printf("Route Length: %f\n", getRouteLengthKm(hawLatitudes, hawLongitudes, HAW_SIZE));


	// 2. Coordinates around the world

	char* names[W_SIZE] = { "HAW Hamburg", "Eiffel Tower", "Palma de Mallorca", "Las Vegas",
						"Copacabana", "Waikiki Beach", "Surfer's Paradise" };

	double coordinates[7][2] = { { 53.557078, 10.023109 },
								{ 48.858363, 2.294481 },
								{ 39.562553, 2.661927 },
								{ 36.156214, -115.148736 },
								{ -22.971177, -43.182543 },
								{ 21.281004, -157.837456 },
								{ -28.002695, 153.431781 } }; // put latitudes' and longitudes' address in array

	maxDistance = getMaximumDistance(coordinates, 7, &indexA, &indexB);
	printf("%s and %s have the largest distance (%f km).\nYou'd better not walk. Take a flight, instead.", 
		names[indexA], names[indexB], maxDistance);

	return 0;
}

double getRouteLengthKm(const double lats[], const double lons[], int n)
{
	double routeLength = 0;
	
	for (int i = 0; i < n - 1; i++)
	{
		routeLength += distanceKm(lats[i], lons[i], lats[i + 1], lons[i + 1]);
	}

	return routeLength;
}

// return: max distance, row indices of max lat, long
double getMaximumDistance(const double coords[][2], int n, int *indexA, int *indexB)
{
	double maxVal = 0;
	double tempVal;

	for (int i = 0; i < n; i++)
		for (int j = i + 1; j < n; j++)
		{
			tempVal = distanceKm(coords[i][0], coords[i][1], coords[j][0], coords[j][1]);
			if (maxVal < tempVal) {
				maxVal = tempVal;
				*indexA = i;
				*indexB = j;
			}
		}

	return maxVal;
}
