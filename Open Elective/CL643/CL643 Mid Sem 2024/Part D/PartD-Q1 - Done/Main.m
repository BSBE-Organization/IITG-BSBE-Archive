clear
close all

%% Problem settings(lower bound, upper bound, objective function)
withC = @SKSwithC;
withoutC = @SKSwithoutC;
[product,l,m,h,il,im,ih,cl,cm,ch,SalePrice,rm1,rm2,rm3] = ProductionPlanningData; % Accessing the data from the function
lb = zeros(1,length(h));
ub = h';
w = 0.7;
c1 = 1.5;
c2 = 1.5;
Pc = 0.8;
F = 0.8;

%% Set Algorithm parameters over here
f1 = zeros(10100,5);
f2 = zeros(10100,5);
f3 = zeros(10100,5);
f4 = zeros(10100,5);
f5 = zeros(10100,5);
f6 = zeros(10100,5);

NRuns = 5;
for i = 1:NRuns
    [~,~,f1(:,i)] = TLBOwithoutC(withoutC,lb,ub,100,50);
    [~,~,f2(:,i)] = PSOwithoutC(withoutC,lb,ub,100,100,w,c1,c2);
    [~,~,f3(:,i)] = DEwithoutC(withoutC,lb,ub,100,100,Pc,F);

    [~,~,f4(:,i)] = TLBOwithC(withC,lb,ub,100,50);
    [~,~,f5(:,i)] = PSOwithC(withC,lb,ub,100,100,w,c1,c2);
    [~,~,f6(:,i)] = DEwithC(withC,lb,ub,100,100,Pc,F);
end

%% Code for calculating the Stat table
for j = 1:5
    for i = 2:10100
        f1(i,j) = min(f1(i-1,j),f1(i,j));
        f2(i,j) = min(f2(i-1,j),f2(i,j));
        f3(i,j) = min(f3(i-1,j),f3(i,j));
        f4(i,j) = min(f4(i-1,j),f4(i,j));
        f5(i,j) = min(f5(i-1,j),f5(i,j));
        f6(i,j) = min(f6(i-1,j),f6(i,j));
    end
end

a = zeros(10100,6);
for i = 1:10100
    a(i,1) = mean(f1(i,:));
    a(i,2) = mean(f2(i,:));
    a(i,3) = mean(f3(i,:));
    a(i,4) = mean(f4(i,:));
    a(i,5) = mean(f5(i,:));
    a(i,6) = mean(f6(i,:));
end

%% Code for plotting convergence curve
%x - axis (number of function evlaution 1 to 10,100)
%y - axis (mean of fitness function value over 5 runs; the best achieved till that particular iteration)
x = 1:10100;
figure
scatter(x,a,0.1);
hold on;

%% Answers 
Answer = zeros(6,4);

% This is the mean of obj function value of all the runs of an algorithm
for i = 1:6
    Answer(i,1) = a(10100,i);
end

% This is the best obj function values of all the runs of an algorithm
Answer(1,2) = min(f1(10100,:));
Answer(2,2) = min(f2(10100,:));
Answer(3,2) = min(f3(10100,:));
Answer(4,2) = min(f4(10100,:));
Answer(5,2) = min(f5(10100,:));
Answer(6,2) = min(f6(10100,:));

disp(Answer);