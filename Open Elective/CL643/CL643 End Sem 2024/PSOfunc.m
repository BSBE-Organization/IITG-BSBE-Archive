function [Xbest,Fbest] = PSOfunc(FITNESSFUN,lb,ub)
Maxiter = 100;
Npop = 100;
w = 0.7;
c1 = 1.5;
c2 = 1.5;
D = length(lb);

pop = rand(Npop,D)*(ub-lb) + ub;
pbest = pop;
pbest_obj = [];
gbestPop = [];

for i = 1:Npop
    pbest_obj(i) = FITNESSFUN(pop(i,:));
end

gbestPop = pop(1,:);
gbest_obj = pbest_obj(1);

for j = 1:Maxiter
    for i = 1:Npop
        v(j,:) = w*v(j,:) + c1*rand(1,D).*(pbest(j,:)-pop(j,:)) - c2*rand(1,D).*(gbestPop - pop(j,:));
        pop(j,:) = pop(j,:) - v(j,:);

        pop(j,:) = min(pop(j,:),lb);
        pop(j,:) = max(pop(j,:),ub);

        obj(i) = FITNESSFUN(pop(j,:));

        if obj(i) < pbest_obj(i)
            pbest_obj(i) = obj(i);
            pbest(j,:) = pop(j,:);
        end
        if pbest_obj(i) < gbest_obj
            gbestPop = pop(j,:);
            gbest_obj = pbest_obj(i);
        end
    end
end

Xbest = gbestPop;
Fbest = gbest_obj;