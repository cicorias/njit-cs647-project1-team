#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void vulnFunction(char *input) {
	char buffer[16] = {'\0'};

	printf("Hello ");
	printf(input);
	printf("\n");

	strcpy(buffer, input); //copy input to buffer
}

int main(int argc, char *argv[]) {

	if (argc > 1)
		vulnFunction(argv[1]);
}
