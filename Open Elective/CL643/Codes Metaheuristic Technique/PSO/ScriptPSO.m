clc
clear


rng(2,'twister')

F = 2;
dim = 2;
[lb,ub,dim,FITNESSFCN] = FunctionDetails(F,dim);

NPop = 100;
Maxiter = 50;
w = 0.5; c1 = 2; c2 = 2;

[Xbest,Fbest] = PSOfunc(FITNESSFCN,NPop,lb,ub,Maxiter,w,c1,c2)


%% adaptive parameters
k = 1;
phi1 = 2.05;
phi2 = 2.05;
phi = phi1 + phi2;
chi = 2*k/abs(2-phi-sqrt(phi^2-4*phi));
c1 = chi*phi1;
c2 = chi*phi2;
wdamp = 0.8;

[Xbest,Fbest] = PSOfunc1(FITNESSFCN,NPop,lb,ub,Maxiter,w,wdamp,c1,c2)