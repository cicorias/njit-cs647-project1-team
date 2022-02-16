#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

void vulnFileCopy(char* userName);
void usage();

void main(int argc, char *argv[])
{
	if (!(setreuid(1005, 1005)==0))
		printf("\nSetuid failed.\n");

	if (argc == 2)
		vulnFileCopy(argv[1]);
	else
		usage();

	return;
}

void vulnFileCopy(char* userName)
{
	char data[200];
	char fileName[32];
	unsigned int i;
	FILE * fp;
	unsigned int size;

	//Initialize data to help vizualize stack contents
	i = 0;
	while (i < 200) {
		data[i] = 'A'; i++;
	}
	i = 0;
	while (i < 32) {
		fileName[i] = 'B'; i++;
	}


	printf("\nHello ");
	printf(userName);
	printf("\n");

	printf("\nEnter file name: ");
	gets(fileName);

	fp = fopen(fileName,"r");
	if (fp == NULL)	{
		perror("\nERROR Opening file. Exiting...\n");
		exit(0);
	}
	fseek(fp, 0, SEEK_END); //Get file size
	size = ftell(fp);
	rewind(fp);

	i = 0;
	while (i < size) //Copy data from input file to data buffer
	{
		data[i] = fgetc(fp);
		i++;
	}

	fclose(fp);
	printf("\nDone copying.\n");
	return;
}


void usage()
{
	printf("\nUsage: ./vulnFileCopy [user_name]\n");
}
