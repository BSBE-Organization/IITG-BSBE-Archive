clc
clear
close all


%% Algorithm parameters
Np = 10;                            % Population Size
T = 50;                             % No. of iterations


dim = 4;

NRuns = 10;
NProb = 5;

bestfitness = NaN(NRuns,NProb);
Stat = NaN(NProb,5);

for j = 1:NProb
    
    [lb,ub,prob] = FunctionDetails(j,dim);
    
    for i = 1:NRuns
        rng(i,'twister')                % Controlling the random number generator used by rand, randi
        [~,bestfitness(i,j),~,~,~] = TLBO(prob,lb,ub,Np,T);
    end
    
    Stat(j,1) = min(bestfitness(:,j));             % Determining the best fitness function value
    Stat(j,2) = max(bestfitness(:,j));             % Determining the worst fitness function value
    Stat(j,3) = mean(bestfitness(:,j));            % Determining the mean fitness function value
    Stat(j,4) = median(bestfitness(:,j));          % Determining the median fitness function value
    Stat(j,5) = std(bestfitness(:,j));             % Determining the standard deviation
    
end