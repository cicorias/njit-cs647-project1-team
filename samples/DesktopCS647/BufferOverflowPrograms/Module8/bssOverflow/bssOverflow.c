#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define BUFFER_SIZE 16	

int main(int argc, char* argv[]){

	unsigned int delta;

	// buffers are static, so they are in the bss segment
	static char buffer1[BUFFER_SIZE];
	static char buffer2[BUFFER_SIZE];

	// buffer1 is referenced before buffer2, it has the lower address
	memset(buffer1, 'A', BUFFER_SIZE-1);
	memset(buffer2, 'B', BUFFER_SIZE-1);

	// delta is the difference between the addresses (in bytes)
	delta = (unsigned int)buffer2 - (unsigned int)buffer1;

	// Display the addresses of the buffers and the difference between them
	printf("buffer1: %p, buffer2 %p, "\
		   "delta: 0x%x (%d) bytes\n", buffer1, buffer2, delta, delta);

	// null-terminate the buffers
	buffer1[BUFFER_SIZE-1] = '\0';
	buffer2[BUFFER_SIZE-1] = '\0';

	printf("BEFORE: \n\tbuffer1 contents: %s\n\t"\
		   "buffer2 contents: %s\n", buffer1, buffer2);

	printf("\noverflowing buffer1...\n");

	// Overflow buffer1 and write over it to overflow half of buffer2
	memset(buffer1, 'C', (delta + BUFFER_SIZE/2));

	// null terminate the buffer to print it as a string
	buffer1[BUFFER_SIZE-1] = '\0';
	printf("AFTER: \n\tbuffer1 contents: %s\n\t"\
		   "buffer2 contents: %s\n", buffer1, buffer2);
}
