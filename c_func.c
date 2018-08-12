#include <stdio.h>
#include <time.h>

int add1(int x)
{
  return x+1;
}

int main(void)
{
	int n = 0;
	clock_t time1 = clock();

	for(int i=0; i<100000000;i++){
		n = add1(n);
	}

	clock_t time2 = clock() - time1;
	float time = (float)time2 / (float)1000000;

	printf("%d\n", n);
	printf("time:%f\n", time);

	return 0;
}
