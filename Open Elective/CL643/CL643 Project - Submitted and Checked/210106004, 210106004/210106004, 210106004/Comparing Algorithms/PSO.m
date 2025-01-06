function [bestsol,bestfitness,BestFitIter,P,f] = PSO(prob,lb,ub,Np,T,w,c1,c2)

f = NaN(Np,1);                      % Vector to store the fitness function value of the population members

BestFitIter = [];           % Vector to store the best fitness function value in every iteration

%% Particle Swarm Optimization

D = length(lb);                     % Determining the number of decision variables in the problem

P = repmat(lb,Np,1) + repmat((ub-lb),Np,1).*rand(Np,D);   % Generation of the initial population
v = repmat(lb,Np,1) + repmat((ub-lb),Np,1).*rand(Np,D);   % Generation of the initial population

for p = 1:Np
    f(p) = prob(P(p,:));            % Evaluating the fitness function of the initial population
    BestFitIter(end+1) = f(p);
end

pbest = P;                          % Initialize the personal best solutions
f_pbest = f;                        % Initialize the fitness of the personal best solutions


[f_gbest,ind] = min(f_pbest);       % Determining the best objective function value
gbest = P(ind,:);                   % Determining the best solution

for t = 1:T
    
    for p = 1:Np
        
        v(p,:) = w*v(p,:) + c1*rand(1,D).*(pbest(p,:)-P(p,:)) + c2*rand(1,D).*(gbest - P(p,:)); % generate new velocity
        
        P(p,:) = P(p,:) + v(p,:);   % Update the position (generate new solution)
        
        P(p,:) = max(P(p,:),lb);    % Bounding the violating variables to their lower bound
        P(p,:) = min(P(p,:),ub);    % Bounding the violating variables to their upper bound
        
        P(p,:) = round(P(p,:));

        f(p) = prob(P(p,:));        % Determining the fitness of the new solution
        BestFitIter(end+1) = f(p);
        
        if f(p) < f_pbest(p)
            
            f_pbest(p) = f(p);      % updating the fitness function value of the personal best solution
            pbest(p,:) =  P(p,:);   % updating the personal best solution
            
            if f_pbest(p)< f_gbest
                
                f_gbest = f_pbest(p); % updating the fitness function value of the global best solution
                gbest = pbest(p,:);   % updating the global best solution
                
            end
            
        end
    end
    
end

bestfitness = f_gbest;
bestsol = gbest;