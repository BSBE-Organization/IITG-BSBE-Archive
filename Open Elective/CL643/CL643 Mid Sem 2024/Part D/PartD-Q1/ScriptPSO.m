clc
clear


rng(2,'twister')

NPop = 100;
Maxiter = 50;
w = 0.5; c1 = 2; c2 = 2;

[Xbest,Fbest] = PSOfunc(FITNESSFCN,NPop,lb,ub,Maxiter,w,c1,c2)