#include <stdio.h>

int main()
{
	int cards[2];

	scanf("%d %d", &cards[0], &cards[1]);

	system("sleep 2s");

	printf("%d", (cards[0] == cards[1]) ? cards[0] : (cards[0] > cards[1] ? cards[0] : cards[1]));

	return 0;
}