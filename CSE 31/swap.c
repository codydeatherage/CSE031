#include<iostream>
using namespace std;

int main() {
	int a = 1, b = 2;
	proc();
	swap(&a, &b);
}

void proc() {
	int i = 0;
}

void swap(int *px, int *py) {
	int *temp;
	*temp = *px;
	*px = *py;
	*py = *temp;
}
