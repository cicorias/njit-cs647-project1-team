#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void vulnFunction(char *input) {
	char buffer[16] = {'\0'};

	strcpy(buffer, input); //copy input to buffer
	printf("Hello %s!\n",buffer);
}

int main(int argc, char *argv[]) {

	if (argc > 1)
		vulnFunction(argv[1]);
	else
		printf("Usage: %s [Name]\n", argv[0]);
}


 
