#!/usr/bin/python3

def factory_function(calc_function):
    def inner_function(x,y):
        return calc_function(x,y)

def Add(a,b):
    return a+b

f = factory_function(Add())

print(f(1,1))
