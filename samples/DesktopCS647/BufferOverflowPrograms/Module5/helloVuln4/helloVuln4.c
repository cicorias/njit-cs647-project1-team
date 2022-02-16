#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void vulnFunction(char *input) {
	char buffer[16] = {'\0'};

	printf("Address of %s: %p\n", "shellcode", getenv("shellcode"));

	strcpy(buffer, input); //copy input to buffer
	printf("Hello %s!\n",buffer);
}

int main(int argc, char *argv[]) {

	vulnFunction(argv[1]);
}
