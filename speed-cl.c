#include <stdio.h>

/* Function to calculate the age-to-age factors */
void get_factor(double *vec, double *fact, int p)
{
	int j, m;
	double tmp[2];
	for(j = 0; j < p-1; ++j)
	{
		tmp[0] = 0.; tmp[1] = 0.;
		for(m = 0; m < (p - (j + 1)); ++m)
		{
			//printf("j, m: %d, %d\n", j, m);
			tmp[0] += vec[(m + j*p)];
			tmp[1] += vec[(m + (1 + j)*p)];
		}
		fact[j] = tmp[1]/tmp[0];
	}
}

/* chain ladder function*/
void cl(double *vec, double *fact, int p)
{
	int i, j, k;
	for(i = p - 1; i > 0; --i)
	{
		for(j = 0; j < p - i; ++j)
		{
			k = p*i + (p - i) + j*p;
			vec[k] = vec[k - p]*fact[i+j-1];
		}
	}
}
