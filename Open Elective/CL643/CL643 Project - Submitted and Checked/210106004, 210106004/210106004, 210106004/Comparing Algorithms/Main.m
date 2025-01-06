clc
clear
close all
rng(1,'twister');

[cost, time, stationCost, stationTime, MaxTime, MaxCapacity, U] = VRPData;

%% Problem settings
number_of_orders = 24;
number_of_buses = 8;

lb = ones(1,2*number_of_orders);
ub = ones(1,2*number_of_orders);

for i = 1:number_of_orders
    ub(i) = number_of_buses;
    ub(i+number_of_orders) = number_of_orders;
end

fun= @VRP;     % Fitness function

w = 0.7;
c1 = 1.5;
c2 = 1.5;
Pc = 0.8;
F = 0.8;
NRuns = 25;

%% Set Algorithm parameters over here
f1 = zeros(10100,NRuns);
f2 = zeros(10100,NRuns);
f3 = zeros(10100,NRuns);

for i = 1:NRuns
    [~,~,f1(:,i)] = TLBO(fun,lb,ub,100,50);
    [~,~,f2(:,i)] = PSO(fun,lb,ub,100,100,w,c1,c2);
    [~,~,f3(:,i)] = DE(fun,lb,ub,100,100,Pc,F);
end

%% Code for calculating the Stat table
for j = 1:NRuns
    for i = 2:10100
        f1(i,j) = min(f1(i-1,j),f1(i,j));
        f2(i,j) = min(f2(i-1,j),f2(i,j));
        f3(i,j) = min(f3(i-1,j),f3(i,j));
    end
end

a = zeros(10100,3);
for i = 1:10100
    a(i,1) = mean(f1(i,:));
    a(i,2) = mean(f2(i,:));
    a(i,3) = mean(f3(i,:));
end

%% Code for plotting convergence curve
%x - axis (number of function evlaution 1 to 10,100)
%y - axis (mean of fitness function value over 25 runs; the best achieved till that particular iteration)
x = 1:10100;
figure;
scatter(x,a,0.1);
hold on;

title('Different Algorithms Objective Function vs Iterations','FontSize',12);
legend('TLBO','PSO','DE');

disp(min(a(:,1)))
disp(min(a(:,2)))
disp(min(a(:,3)))