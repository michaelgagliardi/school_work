% MG
% ECE 202 Fall 2020
% 9.2.2020
%class 5: conditionals, inputs, and displaying text
% phase 4: focus on getting user to input valid numbers

%finding the are under x^n between a and b

%assume that n = integer


clear


repeat = 1;
while repeat == 1
    
    % -------- input n -----------
    checkn = 0;
    while checkn == 0
    
    n = input("Enter exponent n in x^n: ");
    
        if mod(n,1) == 0
            checkn = 1;
        else 
            fprintf("\nExponent n must be an integer.\n\n")
        end
    end
    % --------input a --------
   
    checka = 0;
    while checka == 0
       
        a = input("Enter the lower limit a: ");
        
        if ((n == -1) && (a > 0)) || (n ~= -1)
            checka=1;
        else
            fprintf("\nThe value of a must be positive.\n\n")
        end
    end
     
    
 % ------- input b ------

    checkb = 0;
    while checkb == 0
        b = input("Enter the lower limit b: ");
        
        if ((n == -1) && (b > 0)) || (n ~= -1)
            checkb=1;
        else
            fprintf("\nThe value of b must be positive.\n\n")
        end
    end
    
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