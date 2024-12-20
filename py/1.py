import cmath
x=[35,20,30,40,15]
y=[20,15,25,30,5]
avex=sum(x)/len(x)
avey=sum(y)/len(y)
print("the ave of x:",avex)
print("the ave of y:",avey)
def Sxy(x,y,ax,ay):
    return (x-ax)*(y-ay)
def S(a,b):
    return (a-b)**2
Sxx= sum(S(x[i],avex)for i in range (len(x)))
sumSx = Sxx/len(x)
sumSy = sum(S(y[i],avey)for i in range (len(y)))/len(x)
Sxy = sum(Sxy(x[i],y[i],avex,avey)for i in range(len(x)))
Cov = Sxy/len(x)
r = Cov/cmath.sqrt(sumSx*sumSy)
bet1 = Sxy/Sxx
bet2 = avey-bet1*avex
print("the Sx^2:",sumSx)
print("the Sxx :",Sxx)
print("the Sxy :",Sxy)
print("the Sy^x:",sumSy)
print("the Cov:",Cov)
print("the r:",r)
print(bet1)
print(bet2)
