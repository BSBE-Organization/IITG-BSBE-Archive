clc
clear
close all

%% Problem settings
lb = [-100 -100 -100 -100];         % Lower bound
ub = [100 100 100  100];            % Upper bound
prob = @Rosenbrock;                 % Fitness function

%% Algorithm parameters
Np = 10;                            % Population Size
T = 50;                             % No. of iterations


[bestsol,bestfitness,BestFitIter,P,f] = TLBO(prob,lb,ub,Np,T)



