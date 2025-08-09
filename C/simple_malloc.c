#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void CHECK_IF_NULL(int *ptr)
{
	if (ptr == NULL)
	{
		free(ptr);
		printf("Memory Allocation failed!");
	}
}

int main()
{
	int x = 0;
	char ans[2] = "\0";

	printf("Hello User\n");
	printf("How many numbers to print? > ");
	if (scanf("%d", &x) != 1)
	{
		printf("Invalid input!\n");
		return 1;
	}

	int *ptr = (int *)malloc(x * sizeof(int));
	CHECK_IF_NULL(ptr);

	for(int i=0;i<x;i++)
	{
		ptr[i] = i*i;
	}

	for(int i=0;i<x;i++)
	{
		printf("{%d} ", ptr[i]);
	}
	free(ptr);
	ptr = NULL;
	printf("\nDo you want to add more/less numbers? [Y/N] > ");
	scanf("%s", ans);
	if (strcmp(ans, "Y") == 0 || strcmp(ans, "y") == 0)
	{
        	printf("How many numbers to print? > ");
        	scanf("%d", &x);
		int *new_ptr;
		ptr = new_ptr;
        	new_ptr = (int *)realloc(ptr, x * sizeof(int));
        	CHECK_IF_NULL(new_ptr);

       		 for(int i=0;i<x;i++)
		 {
                	ptr[i] = i*i;
                	printf("{%d} ", ptr[i]);
        	 }

	}
	else if(strcmp(ans, "N") == 0 || strcmp(ans, "n") == 0)
	{
		free(ptr);
		return 0;
	}
	else
	{
		return 1;
	}

	free(ptr);
	printf("\n");
	return 0;
}