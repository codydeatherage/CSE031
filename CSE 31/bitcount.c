/*
	Name: Rocky Lo
	Lab Section Time: Thursday 2:30 - 4:20 PM
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int bitCount(unsigned int n);

int main(int argc, char *argv[]) {

	int v = 0;
	int i;
		if(argc > 2) {
			printf("too many documents\n");
			return 0;
		}
		else if(argc > 1) {
			for(int i = 0; i < strlen(argve[1]); ++i) {
				v = (v * 10) + argv[1][i]-'0';
			}
		}
		else {

			printf ("# 1-bits in base 2 representation of %u = %d, should be 0\n", 0, bitCount(0));

			printf ("# 1-bits in base 2 representation of %u = %d, should be 1\n", 1, bitCount(1));

       			printf ("# 1-bits in base 2 representation of %u = %d, should be 16\n", 2863311530u, bitCount(2863311530u));

        		printf ("# 1-bits in base 2 representation of %u = %d, should be 1\n", 536870912, bitCount(536870912));

        		printf ("# 1-bits in base 2 representation of %u = %d, should be 32\n", 4294967295u, bitCount(4294967295u));

			return 0;
		}
}

int bitCount(unsigned int n) {

	unsigned int count = 0;

		while(n) {
			count += n &1;
			n >>= 1;
		}

}
