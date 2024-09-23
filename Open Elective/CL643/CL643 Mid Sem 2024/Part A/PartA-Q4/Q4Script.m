clc
clear
close all

%% Problem settings
[product,l,m,h,il,im,ih,cl,cm,ch,SP,rm1,rm2,rm3,nProcess] = ProductionPlanningData;
lb = zeros(1,nProcess);
ub = h';

prob = @SKS_ProductionPlanning;     % Fitness function

%% Algorithm parameters
Np = 100;                            % Population Size
T = 100;                             % No. of iterations

[bestsol,bestfitness,BestFitIter,~,~] = TLBO(prob,lb,ub,Np,T)



