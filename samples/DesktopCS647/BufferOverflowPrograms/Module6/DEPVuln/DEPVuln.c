#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

void vulnFunction(char *input) {
	char buffer[16] = {'\0'};

	printf("Hint: Address of buffer: %p\n", &buffer);

	strcpy(buffer, input); //copy input to buffer
	printf("Hello %s!\n",buffer);
}

int main(int argc, char *argv[]) {

	if (!(setreuid(1005, 1005)==0)) 	//Get studentroot(owner) priviledges
		printf("\nSetuid failed.\n");

	if (argc > 1)
		vulnFunction(argv[1]);
}
