import numpy as np
a=[35,20,30,40,15] 
b=[20,15,25,30,5]
c=[25,10,15,20,10]
hata=sum(a)/len(a)
hatb=sum(b)/len(b)
hatc=sum(c)/len(c)
print("hata:",hata)
print("hatb:",hatb)
print("hatc",hatc)
S11 = sum((b[i] - hatb) ** 2 for i in range(len(b)))
S22 = sum((c[i] - hatc) ** 2 for i in range(len(c)))
S12 = sum((b[i]-hatb)*(c[i]-hatc) for i in range(len(a)))
S1y = sum((b[i]-hatb)*(a[i]-hata) for i in range(len(a)))
S2y = sum((c[i]-hatc)*(a[i]-hata) for i in range(len(a)))
print("S11:",S11)
print("S22:",S22)
print("S12",S12)
print("S1y",S1y)
print("S2y",S2y)
S=np.array([[S11,S12],[S12,S22]])
S1=np.linalg.inv(S)
print(S1)
hatB1=S1[0][0]*S1y+S1[0][1]*S2y
print(hatB1)
hatB2=S1[1][0]*S1y+S1[1][1]*S2y
print(hatB2)
hatB0=hata-hatB1*hatb-hatB2*hatc
print(hatB0)
print(hatB0+hatB1*35+hatB2*28)
