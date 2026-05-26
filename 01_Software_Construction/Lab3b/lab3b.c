
/* THIRD LAB SO1(08 / 12 / 2025)
15.1 Theory: Geographic coordinates and distances
Distances*/

#define _USE_MATH_DEFINES
#include <stdio.h> // include standard input/output header file for printf and getchar
#include <math.h> // include math library for fabs(), cos(), sin(), acos(), sqrt()
#include "lab3b.h"

// Step 1: Function prototypes
// These functions compute distances between two geographic locations.
double localDistanceKm(double, double, double, double);
double distanceKm(double, double, double, double);


// Function: localDistanceKm
// Purpose : Calculate approximate distance using Pythagoras (formula 15.3)
// Inputs  : lat1, lon1 = coordinates of first location (degrees)
//           lat2, lon2 = coordinates of second location (degrees)
// Returns : distance in kilometers (double)
double localDistanceKm(double lat1, double lon1, double lat2, double lon2)
{
	// Step 1: Compute ?y
	// ?y = 111.3 * absolute difference in latitude (still in degrees)
	double deltaY = 111.3 * fabs(lat1 - lat2);

	// Step 2: Compute average latitude IN RADIANS
	// (lat1 + lat2)/2 gives average latitude in degrees ? convert to radians for cosine()
	double avgLatRad = ((lat1 + lat2) / 2.0) * (M_PI / 180.0);

	// Step 3: Compute ?x using formula (15.2)
	// ?x = 111.3 * cos(average latitude in radians) * |lon1 - lon2|
	double deltaX = 111.3 * cos(avgLatRad) * fabs(lon1 - lon2);

	// Step 4: Use Pythagoras (15.3)
	// distance = sqrt(?x² + ?y²)
	double localDist = sqrt(deltaX * deltaX + deltaY * deltaY);

	// Step 5: Return the computed distance
	return localDist;
}

// Function: distanceKm
// Purpose : Calculate accurate global distance using formula (15.4)
// Inputs  : lat1, lon1, lat2, lon2 in degrees
// Returns : distance in kilometers (double)
// Notes   : All trigonometric functions require radians!
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

/*
Table 15.1: Distance of selected locations to HAW Hamburg

Location            Latitude       Longitude      Global (15.4)   Local (15.3)
------------------------------------------------------------------------------
HAW Hamburg         53.557078      10.023109      0.0 km          0.0 km
Eiffel Tower        48.858363       2.294481      750.3 km        750.9 km
Palma de Mallorca   39.562553       2.661947      1654.5 km       1656.3 km
Las Vegas           36.156214    -115.148736      8745.6 km      10063.9 km
Copacabana         -22.971177     -43.182543      9932.3 km      10255.6 km
Waikiki Beach       21.281004    -157.837456     11625.4 km      15266.8 km
Surfer's Paradise  -28.002695     153.431781     15921.1 km      18019.6 km
*/