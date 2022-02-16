#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void function (char a, char b, char c)
{
	char buffer[8] = {'A','A','A','A','A','A','A','A'};
	int* ret;

	//Set pointer to return address by adding 16 byte offset
	ret = &ret + 4; //Note: adds 4*4 due to pointer '+' definition

	//Overwrite return address with "0x0804????"
	(*ret) = 0x08040000;
}

void main() {
	int x;

	x = 0;
	function(1,2,3);
	x = 1;


	printf("::: Great job! :::\n");

}
