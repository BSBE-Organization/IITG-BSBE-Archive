clc
clear

[product,l,m,h,il,im,ih,cl,cm,ch,SP,rm1,rm2,rm3,n] = ProductionPlanningData;

Budget = 1000;                              % Budget available

lb = zeros(1,5*n);
ub = zeros(1,5*n);

ub(1:n) = Budget./l;
ub(n+1:2*n) = Budget./m;
ub(2*n+1:3*n) = Budget./h;
ub(3*n+1:4*n) = m';
ub(4*n+1:5*n) = h';

prob = @Main;
Np = 101;
T = 50;

[bestsol,bestfitness,BestFitIter] = TLBO(prob,lb,ub,Np,T);
disp(bestfitness)