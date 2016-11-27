#include <stdio.h>
#include <stdlib.h>

int main()
{
	int size;

	scanf("%d", &size);
	int cards[size];

	int i = 0;
	while(scanf("%d", &cards[i++]) && i < size);

	int sum = 0;
	for(int i = 0; i < size; i++)
		sum += cards[i];

	printf("%d\n%d", sum, sum+1);

	return 0;
}