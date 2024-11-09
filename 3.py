import numpy as np
x=[20,15,25,30,5]
y=[35,20,30,40,15]
hatx=sum(x)/len(x)
haty=sum(y)/len(y)
print("hatx",hatx)
print("haty",haty)
Sxx=sum((x[i]-hatx)**2 for i in range(len(x)))
Syy=sum((y[i]-haty)**2 for i in range(len(y)))
Sxy=sum((x[i]-hatx)*(y[i]-haty) for i in range(len(x)))
print("Sxx",Sxx)
print("Sxy",Sxy)
print("Syy",Syy)
belta1= Sxy/Sxx
belta2= haty-belta1*hatx
print("belta1",belta1)
print("belta2",belta2)
