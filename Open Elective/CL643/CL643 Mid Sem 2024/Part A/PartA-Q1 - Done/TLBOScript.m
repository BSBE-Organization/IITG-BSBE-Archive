clc
clear
close all

%% Problem settings
[product,l,m,h,il,im,ih,cl,cm,ch,SP,rm1,rm2,rm3,nProcess] = ProductionPlanningData;
lb = zeros(1,nProcess);
ub = h';

prob = @SKS_ProductionPlanning;     % Fitness function

%% Algorithm parameters
Np = 101;                            % Population Size
T = 100;                             % No. of iterations

bestf = zeros(25,1);
for i=1:25
    [bestsol,bestf(i)] = TLBO(prob,lb,ub,Np,T);
end

for i = 2:25
    bestf(i) = min(bestf(i-1),bestf(i));
end
disp(bestf)