 /* include files */
#define _CRT_SECURE_NO_DEPRECATE
#define _USE_MATH_DEFINES
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

extern double getRouteLengthKm(const double lats[], const double lons[], int n);

/* Main function */
int main(void)
{
	int wayPoints;
	double *lats, *lons;

	printf("Enter number of waypoints: ");

	while (!scanf("%d", &wayPoints) || wayPoints < 2)
	{
		printf("Try again (expected number >= 2): ");

		/* Keyboard buffer */
		while (getchar() != '\n')
			continue;
	}

	//Allocate memory
	lats = (double*)malloc(wayPoints * sizeof(double));
	lons = (double*)malloc(wayPoints * sizeof(double));

	// Check memory allocation
	if((lats == NULL) || (lons == NULL))
		exit(EXIT_FAILURE);

	printf("Enter waypoints as \"<latitude> <longitude>\"\n");
	
	for (int i = 0; i < wayPoints; i++)
	{
		double lat;
		double lon;

		printf("Waypoint%d: ", i+1);

		/* Keyboard buffer */
		while (getchar() != '\n')
			continue;

		if (scanf("%lf %lf", &lat, &lon) != 2)
		{
			i--;
			printf("Invalid input (expected \"<latitude> <longitude>): oops\"\n");
			continue;
		}

		lats[i] = lat;
		lons[i] = lon;
	}

	printf("By taking this route you will trave %0.2lf km", getRouteLengthKm(lats, lons, wayPoints));

	free(lats);
	free(lons);

	return 0;
}
