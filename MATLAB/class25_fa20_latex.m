% BL
% 10/19/20
% class 25
% embedding LaTeX into MATLAB (TEXT, TITLE, XLABEL, YLABEL)

clear; clf;

plot(1,1)   % create a frame to add text boxes into

% MATLAB already has TeX rendering, as we used in the previous class.

text(0.1, 1.9, 'f^{\prime\prime}(t) = sin(t)', ...
    'FontSize', 20)

% The result does not look like an equation.


% By adding a LaTeX interpreter, we can format equations better.

text(1.1, 1.9, '$$ f^{\prime\prime}(t) = \sin(t) $$', ...
    'FontSize', 20, 'Interpreter', 'latex')

% Two $ are needed at the beginning and the end.  
% \sin one of many pre-defined commands and functions, 
% in this case to avoid rendering sin as three variables, s i n, in italics


% {} can also be used to delimit parts of the equation.  For instance,
% let's remove the parentheses around t.  The command \sint would not be 
% interpreted correctly, so we should add {} around the t.

text(1.6, 1.9, '$$ f^{\prime\prime}(t) = \sin{t} $$', ...
    'FontSize', 20, 'Interpreter', 'latex')


% Here are some more examples...

% The Pythagorean Theorem

text(0.1, 1.7, '$$ a^2 + b^2 = c^2 $$', ...
    'FontSize', 20, 'Interpreter', 'latex')

% Note that no {} are needed around each exponent, 
% because it's only 1 character.


% Here is a damped sinusoid.  There are lots of special characters
% available in TeX, and you can often predict what they will be, as here
% for \alpha and \omega.  We again need {t} to avoid confusion and also to
% avoid extra spaces between the symbols and t.

text(0.1, 1.5, '$$ g(t) = e^{-\alpha{t}}\cos(\omega{t}) $$', ...
    'Interpreter', 'latex', 'FontSize', 20)


% Here are all the building blocks of mathematics in one equation.

text(0.1, 1.3, '$$ 1 + e^{j\pi} = 0 $$', ...
    'FontSize', 20, 'Interpreter', 'latex')


% For some people j is too close to e, so let's add some space using \,.

text(1.1, 1.3, '$$ 1 + e^{\,j\pi} = 0 $$', ...
    'FontSize', 20, 'Interpreter', 'latex')


% Euler's identity

text(0.1, 1.1, '$$ e^{\,j\theta} = \cos\theta + j\sin\theta\ \rm{(Euler''s\ Identity)} $$', ...
    'FontSize', 20, 'Interpreter', 'latex')

% To add "(Euler's Identity)" in a non-italicized font (usually refered to 
% as a "roman" font), we add some spaces using \ , then use the \rm function.
% Note that {} are used to delimit everything that is non-italicized.  Note
% also that two '' are needed to get one apostrophe, and another \  is
% needed to get space between "Euler's" and "Identity".


% Note that LaTeX is using the \prime symbol for the apostrophe, so let's
% put "(Euler's Identity)" outside the $$, and see what that looks like.

text(1.1, 1.1, '$$ e^{\,j\theta} = \cos\theta + j\sin\theta $$ (Euler''s Identity)', ...
    'FontSize', 20, 'Interpreter', 'latex')

% Some people prefer how this looks, with a normal apostrophe, although we
% still need two '.  Note that no extra spaces need to be added using \ .


% Here is a variation of Euler's identity.  (I prefer \varphi over \phi.)

text(0.1, 0.9, '$$ \cos\varphi = {1\over{2}}(e^{\,j\varphi} + e^{-j\varphi}) $$', ...
    'FontSize', 20, 'Interpreter', 'latex')

% This is the default for something rendered as a stand-alone equation,
% with a "normal" sized font for the 1 and 2 of 1/2.

% Note that no extra space (\,) is needed in the second term on the right
% side, because the minus sign moves the j away from the e.


% You might prefer to use a single $, even if it's a stand-alone equation,
% i.e., this is what it looks like when the equation is formatted to be in
% line with text.

% I have also added \left and \right to the left of ( and ), so that the
% parentheses re-size automatically to fit the expression inside them.  
% In this case, they are only slightly larger than the original version.

text(1.1, 0.9, '$ \cos\varphi = {1\over{2}}\left(e^{\,j\varphi} + e^{-j\varphi}\right) $', ...
    'FontSize', 20, 'Interpreter', 'latex')


% There are also automatic square brackets [] and curly braces {}.  Note 
% that we need to add \ to the left of the curly braces, as {} are used as
% delimiters already and will not render otherwise.

text(0.1, 0.6, ...
    '$$ 2\cdot\left\{ 3+4\cdot\left[ 5+6\cdot\left({1\over{7}}+{1\over{8}}\right) \right] \right\} $$', ...
    'FontSize', 20, 'Interpreter', 'latex')


% Here is the same equation rendered using one $ instead of two.

text(1.1, 0.6, ...
    '$ 2\cdot\left\{ 3+4\cdot\left[ 5+6\cdot\left({1\over{7}}+{1\over{8}}\right) \right] \right\} $', ...
    'FontSize', 20, 'Interpreter', 'latex')


% Here is a slight variation to see the curly braces even taller, by
% changing \cdot to \over and adding {} to make it clear what the 
% numerator and denominator are intended to be.

text(0.1, 0.3, ...
    '$$ 2\cdot\left\{ 3+{4\over\left[ 5+6\cdot\left({1\over{7}}+{1\over{8}}\right) \right]} \right\} $$', ...
    'FontSize', 20, 'Interpreter', 'latex')


% Finally, we can make an equation robust using SPRINTF.

% Define two parameters...

alph = 40; w = 50;   % alpha in Hz, w in rad/s

% ... then render a damped sinusoid.

text(1.1, 1.5, sprintf('$$ g(t) = e^{-%g{t}}\\cos(%g{t}) $$', alph, w), ...
    'FontSize', 20, 'Interpreter', 'latex')

% Don't confuse the formatting of the numbers (%g) with the variable name 
% g in g(t).  Also, note that we need two \ for each special function.


