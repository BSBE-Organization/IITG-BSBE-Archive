clc                                 % To clear the command window
clear                               % To clear the workspace

%% Problem settings
lb = [0 0 0 0 0];                         % Lower bound
ub = [10 10 10 10 10];                       % Upper bound
prob = @SphereNew;                  % Fitness function


%% Parameters for Differential Evolution
Np = 5;                             % Population Size
T = 100;                             % No. of iterations
Pc = 0.8;                           % crossover probability
F = 0.85;                           % Scaling factor

rng(1,'twister')

[bestsol,bestfitness] = DifferentialEvolution(prob,lb,ub,Np,T,Pc,F)