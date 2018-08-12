#include <stdio.h>
#include <dlfcn.h>
#include <time.h>

int main(void)
{
	int (*add1)(int x);
	void *handle = dlopen("./libcint.so", RTLD_LAZY);

	add1 = dlsym(handle, "add1");

	clock_t time1 = clock();
	int n = 0;
	//(defparameter *test-scale* 100000000)
	for(int i=0; i<100000000;i++){
		n = add1(n);
	}
	clock_t time2 = clock() - time1;

	printf("%d\n", n);
	printf("time:%d\n", time2);

	return 0;
}
