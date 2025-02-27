###ECE 241 Homework 1 Question 2  Michael Gagliardi Due 09/01/2020

## 2)
class solver:
    def __init__(self):
        self=self

    a = int(input("Input a value for 'a' to solve for 'x' in ax-2b=c:")) ##taking inputs
    b = int(input("Input a value for 'b' to solve for 'x' in ax-2b=c:"))
    c = int(input("Input a value for 'c' to solve for 'x' in ax-2b=c:"))

    def monomial(a, b, c):
        if a==0 and b != -(2*c): ##taking zeros into account to prevent error code
            return "No solution for the given variables"
        elif a==0 and b == -(2*c):
            return "Solution: x= all real numbers"
        else:
            x = ((c + 2 * b) / a) ###solving equation and printing result
            return ("Equation: %s*x-2*%s=%s" % (a, b, c) + " Solution: x=%s" % (x))

    def polynomial(a, b, c):
        if a==0 and (2*b)**(1/2)!=c: ##taking zeros into account to prevent errors
            return "No real solution for the given variables"
        elif a==0 and (2*b)**(1/2) == 2*c:
            return "Solution: x= all real numbers"
        else:
            x = ((c ** 2 - 2 * b) / a) ##solving equation and returning result
            return ("Equation: sqrt(%sx+2*%s)=%s" % (a, b, c) + " Solution: x=%s" % (x))

    print(monomial(a, b, c))
    print(polynomial(a, b, c))

solver



