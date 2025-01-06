clc
clear
close all
rng(1,'twister');

[cost, time, stationcost, stationtime] = VRPData;

%% Problem settings
number_of_orders = length(stationcost);
number_of_buses = 8;

nvars = 2*number_of_orders;
Aeq = [];
A = [];
beq = [];
b = [];
intcon = 1:nvars;

lb = ones(1,2*number_of_orders);
ub = ones(1,2*number_of_orders);

for i = 1:number_of_orders
    ub(i) = number_of_buses;
    ub(i+number_of_orders) = number_of_orders;
end

fun = @VRP;
NRuns = 25;
bestf = zeros(NRuns);

for i = 1:NRuns
    [bestsol,bestf(i)] = gamultiobj(fun, nvars, A, b, Aeq, beq, lb, ub, [], intcon);
end

disp(mean(bestf))