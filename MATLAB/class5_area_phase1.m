% MG
% ECE 202 Fall 2020
% 9.2.2020
%class 5: conditionals, inputs, and displaying text
% phase 1: getting something working quickly

%finding the are under x^n between a and b

clear

n = 2; a = 1; b = 4;

if n ~= -1 % >, <, >=, <=, ==, &&(and), ||(or)
    np1 = n+1
    A = (b^np1 - a^np1)/np1
else 
    A = log(b) - log(a)
end
