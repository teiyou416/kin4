import math
import sys

def oddOReven(x):
    if x%2 != 0 :
        print(x," is odd")
    else :
        print(x," is even")
        
def isInround(x,y):
    sum = math.sqrt(x**2+y**2)
    if sum <= 10 :
        print("is in round")
    else :
        print("not in round")

def maxANDmin():
    list = []
    while True :
        num = int(input("input number:"))
        if num == 0 :
            print("input stopped")
            print("min:",min(list))
            print("max:",max(list))
            break
        elif num < 0 :
            print("please input a positive number")
            continue
        else :
            list.append(num)
            continue

def isPrime():
    x = int(input("give a number:"))
    if x <= 1 :
        return False
    i = 2
    while i**2 <= x:
        if x % i == 0 :
            return False
        i += 1
    return True

def numofPrime():
    x = int(input("give a number:")) 
    sum = 0
    for i in range(2,x+1):
       is_prime = True
       for z in range(2,int(i**0.5)+1):
           if i%z == 0 :
               is_prime = False
               break
       if is_prime:
            sum += 1
    print(sum)

def factor():
    n = int(input("input:"))
    if n <= 0 :
        print("give a positive number ")
        return
    factors = []
    divisor = 2
    while n > 1:
            while n % divisor == 0:  
                factors.append(divisor)
                n //= divisor 
            divisor += 1
            if divisor * divisor > n:  
                if n > 1:  
                    factors.append(n)
                break
    print("prime factor: " + " × ".join(map(str, factors)))   
