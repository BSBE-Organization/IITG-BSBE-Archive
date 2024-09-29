clc
clear

% rng(2,'twister')

NPop = 10100;
Maxiter = 25;
w = 0.5; c1 = 2; c2 = 2;

%% Problem settings
[product,l,m,h,il,im,ih,cl,cm,ch,SP,rm1,rm2,rm3,nProcess] = ProductionPlanningData;
lb = zeros(1,nProcess);
ub = h';

prob = @SKS_ProductionPlanning;     % Fitness function

[Xbest,Fbest,BestFitIter] = PSOfunc(prob,NPop,lb,ub,Maxiter,w,c1,c2);