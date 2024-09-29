clc                                 % To clear the command window
clear                               % To clear the workspace

%% Problem settings
[product,l,m,h,il,im,ih,cl,cm,ch,SP,rm1,rm2,rm3,nProcess] = ProductionPlanningData;
lb = zeros(1,nProcess);
ub = h';

prob = @SKS_ProductionPlanning;     % Fitness function

%% Parameters for Differential Evolution
Np = 101;                         % Population Size
T = 100;                             % No. of iterations
Pc = 0.8;                           % crossover probability
F = 0.85;                           % Scaling factor

bestf = zeros(25,1);
for i=1:25
[bestsol,bestf(i)] = DifferentialEvolution(prob,lb,ub,Np,T,Pc,F);
end

for i = 2:25
    bestf(i) = min(bestf(i-1),bestf(i));
end
disp(bestf)