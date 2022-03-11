# define a function that takes argument x and adds 10 to it, then it multiplies that by 20

def func(x):
    return x + 10 * 20


# write the derivative of the function x^4 - x
def derivative(x):
    return 4 * x ** 3 - 1

# define a function that takes an argument x
# and it returns "Kaskaceli" if x is greater than or equal to 1, return "hskvox",
# and if x is greater than 90, return "standart"
# if x turns out to be greater than 180, return "kaskaceli"
# and finally, if x is 270 or greater, return "anhusali"

def func2(x):
    if x >= 1:
        return "Kaskaceli"
    elif x >= 90:
        return "standart"
    elif x >= 180:
        return "kaskaceli"
    elif x >= 270:
        return "anhusali"
