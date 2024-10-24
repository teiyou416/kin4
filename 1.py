import cmath
x=[38,40,34,41,34,38,42,36,35,39]
y=[81,82,78,81,75,79,83,79,77,80]
avex=sum(x)/10
avey=sum(y)/10
print("the ave of x:",avex)
print("the ave of y:",avey)
def Sxy(x,y,ax,ay):
    return (x-ax)*(y-ay)
def S(a,b):
    return (a-b)**2
Sxx= sum(S(x[i],avex)for i in range (len(x)))
sumSx = Sxx/10
sumSy = sum(S(y[i],avey)for i in range (len(y)))/10
Sxy = sum(Sxy(x[i],y[i],avex,avey)for i in range(len(x)))
Cov = Sxy/10
r = Cov/cmath.sqrt(sumSx*sumSy)
bet1 = Sxy/Sxx
bet2 = avey-bet1*avex
print("the Sx^2:",sumSx)
print("the Sy^x:",sumSy)
print("the Cov:",Cov)
print("the r:",r)
print(bet1)
print(bet2)
