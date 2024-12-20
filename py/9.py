def gcd():
    a = int(int(input("Enter the first number: ")))
    b = int(input("Enter the second number: "))
    while b != 0:
        t = a % b
        a = b
        b = t
    return a
def selectsort(arr):
    for i in range(len(arr)-1):
        minindex = i
        for j in range(i+1,len(arr)):
            if arr[j]<arr[minindex]:
                minindex = j
        if i != minindex :
            arr[i],arr[minindex] = arr[minindex],arr[i]
        print(f"step {i+1} : {arr}")
        print(f"minindex:{arr[minindex]}")
arr = [5,2,3,1,8,9,0,7,4,6]

