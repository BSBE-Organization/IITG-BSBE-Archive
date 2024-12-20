clc
clear
close all

%% Problem settings
lb = [-100 -100 -100 -100];         % Lower bound
ub = [100 100 100  100];            % Upper bound
prob = @SphereNew;                 % Fitness function

%% Algorithm parameters
Np = 10;                            % Population Size
T = 50;                             % No. of iterations


NRuns = 10;

bestsol = NaN(NRuns,length(lb));
bestfitness = NaN(NRuns,1);
BestFitIter = NaN(NRuns,T+1);

for i = 1:NRuns
    rng(i,'twister')                % Controlling the random number generator used by rand, randi
    [bestsol(i,:),bestfitness(i),BestFitIter(i,:),~,~] = TLBO(prob,lb,ub,Np,T);
    plot(BestFitIter(i,:),'*')
    hold on
end
xlabel('No. of Iterations');
ylabel('Best Fitness of the iteration')

figure
plot(mean(BestFitIter),'*');
xlabel('No. of Iterations');
ylabel('Mean Fitness')



