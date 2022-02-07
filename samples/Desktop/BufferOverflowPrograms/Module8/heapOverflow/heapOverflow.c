#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define BUFFER_SIZE 16

int main(int argc, char* argv[]){

	unsigned int delta;

	// buffer1 and 2 are on the heap
	char *buffer1 = (char *)malloc(BUFFER_SIZE);
	char *buffer2 = (char *)malloc(BUFFER_SIZE);

	// delta is the difference between the addresses in bytes
	delta = (unsigned int)buffer2 - (unsigned int)buffer1;

	// Display the addresses of the buffers and difference between them
	printf("buffer1: %p, buffer2 %p, "\
		   "difference: 0x%x (%d) bytes\n", buffer1, buffer2, delta, delta);

	// Set buffer1 to all A characters
	memset(buffer1, 'A', BUFFER_SIZE-1);
	buffer1[BUFFER_SIZE-1] = '\0';

	// Set buffer2 to all B characters
	memset(buffer2, 'B', BUFFER_SIZE-1);
	buffer2[BUFFER_SIZE-1] = '\0';

	printf("BEFORE:\n\tbuffer1 contents: %s\n\t"\
		   "buffer2 contents: %s \n", buffer1, buffer2);

	// Overflow buffer1 and write over it to overflow half of buffer2
	memset(buffer1, 'C', (delta + BUFFER_SIZE/2));
	buffer1[BUFFER_SIZE-1] = '\0';

	printf("After:\n\tbuffer1 contents: %s\n\t"\
		   "buffer2 contents: %s \n", buffer1, buffer2);


	free(buffer1);
	free(buffer2);

	return 0;
}
