#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>


void main(int argc, char *argv[])
{
	static uid_t ruid, euid, tmpruid, tmpeuid;
	ruid = getuid();	// Save current real user id
	euid = geteuid();	// Save the effective user id

	int errnum;

	printf("Before setuid:\n");
	system("id");
	printf("Real: %d\n", ruid);
	printf("effective: %d\n\n", euid);

	if (!(setuid(0)==0)){ 	//Get root(owner) priviledges
		printf("\nSetuid failed.\n");

		errnum = errno;
		fprintf(stderr, "Value of errno: %d\n", errno);
		perror("Error printed by perror");
	}

	printf("\nAfter setuid:\n");
	system("id");
	printf("Real: %d\n", getuid());
	printf("effective: %d\n", geteuid());



	if (!(setuid(ruid)==0)){ 	//Drop priviledges back to user id
		printf("\nSetuid failed.\n");
		errnum = errno;
		fprintf(stderr, "Value of errno: %d\n", errno);
		perror("Error printed by perror");
	}

	printf("\nAfter setuid restore:\n");
	system("id");
	printf("Real: %d\n", getuid());
	printf("effective: %d\n", geteuid());


	if (!(setuid(0)==0)){ 	//Get root(owner) priviledges
		printf("\nSetuid failed.\n");

		errnum = errno;
		fprintf(stderr, "Value of errno: %d\n", errno);
		perror("Error printed by perror");
	}

	printf("\nAfter setuid:\n");
	system("id");
	printf("Real: %d\n", getuid());
	printf("effective: %d\n", geteuid());

	return;
}
