function [bestsol,bestfitness,BestFitIter,P,f] = DEwithoutC(prob,lb,ub,Np,T,Pc,F)

%% Starting of DE
f = NaN(Np,1);                     % Vector to store the fitness function value of the population members

fu = NaN(Np,1);                    % Vector to store the fitness function value of the New population members

D = length(lb);                    % Determining the number of decision variables in the problem

U = NaN(Np,D);                     % Matrix to store the trial solutions

BestFitIter = [];           % Vector to store the best fitness function value in every iteration

P = repmat(lb,Np,1) + repmat((ub-lb),Np,1).*rand(Np,D);   % Generation of the initial population

for p = 1:Np
    f(p) = prob(P(p,:));           % Evaluating the fitness function of the initial population
    BestFitIter(end+1) = f(p);
end

%% Iteration loop
for t = 1: T
    
    for i = 1:Np
        
        %% Mutation
        Candidates = [1:i-1 i+1:Np];            % Ensuring that the current member is not the partner
        idx = Candidates(randperm(Np-1,3));     % Selection of three random parters
        
        X1 = P(idx(1),:);                       % Assigning randomly selected solution 1
        X2 = P(idx(2),:);                       % Assigning randomly selected solution 2
        X3 = P(idx(3),:);                       % Assigning randomly selected solution 3
        
        V =  X1 + F*(X2 - X3);                  % Generating the donor vector
        
        
        %% Crossover
        
        del = randi(D,1);                        % Generating the random varibale delta
        for j = 1:D
            
            if (rand <= Pc) || del == j          % Check for donor vector or target vector
                U(i,j) = V(j);                   % Accept variable from donor vector
            else
                U(i,j) = P(i,j);                 % Accept variable from target vector
            end
            
        end
    end
    
    %% Bounding and Greedy Selection
    for j = 1:Np
        
        U(j,:) = min(ub,U(j,:));                % Bounding the violating variables to their upper bound
        U(j,:) = max(lb,U(j,:));                % Bounding the violating variables to their lower bound
        
        fu(j) = prob(U(j,:));                   % Evaluating the fitness of the trial solution
        BestFitIter(end+1) = fu(j);
        if fu(j) < f(j)                         % Greedy selection
            P(j,:) = U(j,:);                    % Include the new solution in population
            f(j) = fu(j);                       % Include the fitness function value of the new solution in population
        end
    end
    
end

[bestfitness,ind] = min(f);
bestsol = P(ind,:);