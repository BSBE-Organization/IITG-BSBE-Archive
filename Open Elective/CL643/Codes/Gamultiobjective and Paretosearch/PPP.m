% Data setup
[product, l, m, h, il, im, ih, cl, cm, ch, SP, rm1, rm2, rm3, Np] = ProductionPlanningData;

B = 1000000000;
R1 = 1000000;
R2 = 1000000;


nvars = 6*Np;
Aeq = [];
A = [];
beq = [];
b = [];
lb = zeros(Np * 6, 1);
ub = ones(Np * 6, 1) * inf;
for i = 3*Np+1 : 4*Np
    ub(i) = inf;
end

% Fitness function
fun = @SKS_ProductionPlanning;

[x, fval] = gamultiobj(fun, nvars, A, b, Aeq, beq, lb, ub);
