#include <stdio.h> 

int fOne() { 
	printf(" This is function one\n");
	return 1;
} 

int fTwo() { printf(" This is function two\n");
	return 2;
} 


int main() { 
	
	int value;
	int (* functionPtr) ();
	
	functionPtr = fOne;
	printf(" functionPtr is 0x% 08x\n", functionPtr);

	value = functionPtr();
	printf(" value returned was %d\n", value);

	functionPtr = fTwo;
	printf(" functionPtr is 0x% 08x\n", functionPtr);

	value = functionPtr();
	printf(" value returned was %d\n", value);
}
