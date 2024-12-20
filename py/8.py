import turtle
import math
print("input n :")
n = int(input())
def draw_polygon(n, radius):
    if n < 3:
        print("正n角形は3以上の整数を指定してください。")
        return
    
    turtle.speed(5)  
    angle = 360 / n  
    side_length = 2 * radius * math.sin(math.pi / n)  
    
    turtle.penup()
    turtle.goto(0, -radius) 
    turtle.setheading(90 - (angle / 2))  
    turtle.pendown()
    
    for _ in range(n):
        turtle.forward(side_length)
        turtle.left(angle)
    
    #turtle.done()  

draw_polygon(n,radius=100)
