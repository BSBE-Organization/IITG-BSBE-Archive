clc;
A=[-3 -3 -8
    6 13 6];
b=[-64; 154];

lb = [0 0 0];
ub = [inf inf inf];
fun = @funQ1;
nvars = 3;
IntCon = 2;

x = ga(fun,nvars,A,b,[],[],lb,ub,@nonlconQ3,IntCon);
disp(x)