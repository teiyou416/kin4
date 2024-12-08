import math
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
