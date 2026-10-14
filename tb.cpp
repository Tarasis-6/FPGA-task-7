#include <climits>
#include <cstdio>
#include <cstdlib>
#include "moving_max.h"

static void ref_moving_max(int in[N_SAMPLES], int out[N_SAMPLES]);
static int check_vector(int in[N_SAMPLES], int tag);



int main(){

	const int NUM_VECTORS = 5;

	int in[N_SAMPLES];
	int total = 0;


	for (int k = 0; k < NUM_VECTORS; k++){
		switch (k) {
		    case 0:
		    	for (int i = 0; i < N_SAMPLES; i++) in[i] = i;
		        break;
		    case 1:
		    	for (int i = 0; i < N_SAMPLES; i++) in[i] = 7;
		        break;
		    case 2:
		    	srand(1);
		    	for (int i = 0; i < N_SAMPLES; i++) in[i] = rand() % 2001 - 1000;
		    	break;
		    case 3:
		    	for (int i = 0; i < N_SAMPLES; i++) in[i] = 256 - i;
		    	break;
		    case 4:
		    	for (int i = 0; i < N_SAMPLES; i++){ in[i] = 0;}in[20] = 1000;
		    	break;
		    default:
		    	for (int i = 0; i < N_SAMPLES; i++) in[i] = i;
		}
    	total += check_vector(in, k);

	}


	if (total > 0)
		printf("FAIL: %d mismatches\n",total);
	else
		printf("PASS\n");


	return total ? 1 : 0;
}

static void ref_moving_max(int in[N_SAMPLES], int out[N_SAMPLES]){

	int start = 0;

	for(int n = 0; n < N_SAMPLES; n++){

		start = n - (WINDOW-1);
		if(start<0){
			start = 0;
		}
		int best = in[start];

		for(int m = start; m <= n; m++){
			if(best < in[m]){
				best = in[m];
			}

		}
		out[n] = best;

	}


}

static int check_vector(int in[N_SAMPLES], int tag){

	int dut_out[N_SAMPLES], ref_out[N_SAMPLES];

	moving_max(in, dut_out);
	ref_moving_max(in, ref_out);

	int errors = 0;
	for (int n = 0; n < N_SAMPLES; n++) {
	    if (dut_out[n] != ref_out[n]) {
	    	printf("tag = %d n=%d dut=%d ref=%d\n", tag, n, dut_out[n], ref_out[n]);
	        errors++;
	    }
	}

	return errors;
}

