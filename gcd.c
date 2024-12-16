#include <stdio.h>
int gcd(int a, int b)
{
    while (b)
    {
        int temp=b;
        b = a%b;
        a = temp;
    }
    return a;
}
int main(){
    gcd(18254913,12178058);	
}

