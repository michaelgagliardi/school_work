% MG
% ECE 202 Fall 2020
% 9.2.2020
%class 5: conditionals, inputs, and displaying text
% phase 3: add WHILE loop to repeat, speed up development
%finding the are under x^n between a and b

clear


repeat = 1;
while repeat == 1
    
    
    n = input("Enter exponent n in x^n: ");
    a = input("Enter lower limit a: "); 
    b = input("Enter upper limit b: ");

    if n ~= -1 % >, <, >=, <=, ==, &&(and), ||(or)
        np1 = n+1
        A = (b^np1 - a^np1)/np1
    else
        if (a<=0) || (b <= 0)
            disp("no real-valued area is possible")
        else
            A = log(b) - log(a)
        end
    end
    
    repeat=input("Again? (1 = yes) ");
end
