#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void function (char a, char b, char c, char * input) 
{
	char buffer[8] = {'A','A','A','A','A','A','A','A'};
	strcpy(buffer, input);
}

void main(int argc, char* argv[]) {
	int x;

	x = 0;
	function(1,2,3,argv[1]);
	x = 1;

	if (x == 0)
		printf("::: You win :::\n");
	else 
		printf("::: You lose :::\n");
}
