def plus20and30():
   x = 0
   x += 10
   x += 20
   print("x=",x)
def oddOReven(x):
   if x < 0 :
      print("x is minus,please give a positve numver")
   else :
    if x%2 != 0 :
        print(x," is odd")
    else :
        print(x," is even")
def sumof():
   sum = 0
   for i in range(11,21):
       sum += i
   print("sum:",sum)
plus20and30()
oddOReven(30)
sumof()
