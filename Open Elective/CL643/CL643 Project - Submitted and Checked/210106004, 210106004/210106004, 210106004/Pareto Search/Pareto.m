clc
clear
close all
rng(1,'twister')

[cost, time, stationcost, stationtime] = VRPData;

%% Problem settings
number_of_orders = length(stationcost);
number_of_buses = 8;

nvars = 2*number_of_orders;
Aeq = [];
A = [];
beq = [];
b = [];

lb = ones(1,2*number_of_orders);
ub = ones(1,2*number_of_orders);

for i = 1:number_of_orders
    ub(i) = number_of_buses;
    ub(i+number_of_orders) = number_of_orders;
end

fun = @VRP;

[bestsol,bestf] = paretosearch(fun, nvars, A, b, Aeq, beq, lb, ub);

% Plot Pareto front
figure;
plot(bestf(:, 1), bestf(:, 2), 'o');
xlabel('Objective 1: Total Cost');
ylabel('Objective 2: Maximum Time');
title('Pareto Front');
grid on;