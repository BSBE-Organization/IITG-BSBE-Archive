clc;
A=[-3 -3 -8
    6 13 6];
b=[-64; 154];

Aeq = [7 0 14
       9 13 0];
beq = [84; 122];

lb = [0 0 0];
ub = [inf inf inf];
fun = @funQ1;
nvars = 3;

x = ga(fun,nvars,A,b,Aeq,beq,lb,ub,@nonlconQ1);
disp(x)

x0  = [0 0 0];

x = fmincon(fun,x0,A,b,Aeq,beq,lb,ub,@nonlconQ1);
disp(x)