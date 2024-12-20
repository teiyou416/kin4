import math
car = [0,1,2,3,4,5,6,7,8,9,10,11,12]
num = [2,5,7,12,8,8,4,5,4,1,3,0,1]
print(len(car),len(num))
sum = 0
for i in range(len(car)):
    sum += car[i]*num[i]
hatx = sum/60
print(hatx)    
# for i in range(0,6):
#     print(math.factorial(i))
sumx = 0
kano = []
for i in range(0,13):
    px=((hatx**i)*math.exp(-hatx))/math.factorial(i)
    sumx += px*60
    kano.append(px*60)
    print(i,px*60)
sumy = 0
for i in range(0,13):
    sumy += (num[i]-kano[i])**2
    X2=sumy/hatx
print(sumx)
print("sumy=",sumy)
print("X2=",X2)
