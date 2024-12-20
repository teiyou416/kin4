import turtle
def draw_pentagram(size):
    turtle.speed(5)  
    turtle.penup()
    turtle.goto(-size // 2, size // 3)  
    turtle.pendown()
    
    for _ in range(5):
        turtle.forward(size)
        turtle.right(144)  
    
    turtle.done()  
draw_pentagram(200)
