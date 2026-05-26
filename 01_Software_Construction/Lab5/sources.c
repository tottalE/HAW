#define _USE_MATH_DEFINES
#include <math.h> // include math library for fabs(), cos(), sin(), acos(), sqrt()
#include <stdio.h>

double distanceKm(double lat1, double lon1, double lat2, double lon2);
double getRouteLengthKm(const double lats[], const double lons[], int n);


double getRouteLengthKm(const double lats[], const double lons[], int n)
{
	double routeLength = 0;

	for (int i = 0; i < n - 1; i++)
	{
		routeLength += distanceKm(lats[i], lons[i], lats[i + 1], lons[i + 1]);
	}

	return routeLength;
}

double distanceKm(double lat1, double lon1, double lat2, double lon2)
{
	// Step 1: Convert all angles from degrees ? radians
	double lat1Rad = lat1 * (M_PI / 180.0);
	double lat2Rad = lat2 * (M_PI / 180.0);
	double lon1Rad = lon1 * (M_PI / 180.0);
	double lon2Rad = lon2 * (M_PI / 180.0);

	// Step 2: Apply formula (15.4)
	// d = 6378.388 * acos( sin(lat1)*sin(lat2) + cos(lat1)*cos(lat2)*cos(lon2 - lon1) )
	double globalDist = 6378.388 * acos(sin(lat1Rad) * sin(lat2Rad) + cos(lat1Rad) * cos(lat2Rad) * cos(lon2Rad - lon1Rad));

	// Step 3: Return the computed distance
	return globalDist;
}