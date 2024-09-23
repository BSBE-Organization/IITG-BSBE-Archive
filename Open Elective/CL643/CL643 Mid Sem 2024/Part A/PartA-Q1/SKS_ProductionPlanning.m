function f = SKS_ProductionPlanning(x)

[product,l,m,h,il,im,ih,cl,cm,ch,SalePrice,rm1,rm2,rm3] = ProductionPlanningData; % Accessing the data from the function

numProcess = length(l);                             % determing the number of processes

Budget = 1000;                              % Budget available
AvailRaw1 = 500;                            % Amount of raw material 1 available
AvailRaw2 = 500;                            % Amount of raw material 2 available

PC = zeros(nProcess,1);                     % Initialization of variable to store the production cost for each process
IC = zeros(nProcess,1);                     % Initialization of variable to store the investment cost for each process
R1Reqd = zeros(nProcess,1);                 % Initialization of variable to store the raw material 1 required for each process
R2Reqd = zeros(nProcess,1);                 % Initialization of variable to store the raw material 2 required for each process
Revenue = zeros(nProcess,1);                % Initialization of variable to store the revenue genereated for each process
penalty_domain = zeros(nProcess,1);         % Initialization of variable to store the penalty due to violation of domain for each process

for j = 1: nProcess
    
    if x(j) >= l(j) && x(j) <= m(j)             % if the production is in between low and medium level
        
        PC(j) = ((cm(j) - cl(j))/(m(j) - l(j)))*(x(j) - l(j)) + cl(j);  % Determining the production cost for the range l to m
        IC(j) = ((im(j) - il(j))/(m(j) - l(j)))*(x(j) - l(j)) + il(j);  % Determining the investment cost  for the range l to m
        R1Reqd(j) = x(j)*rm1(j);                % Determining the raw material 1 required for process
        R2Reqd(j) = x(j)*rm2(j);                % Determining the raw material 2 required for process
        Revenue(j) = SalePrice(j)*x(j);         % Determining the revenue genereated by selling the product from the process j
        
        
    elseif x(j) > m(j) && x(j) <= h(j)          % if the production is in between medium and high level
        
        PC(j) = ((ch(j) - cm(j))/(h(j) - m(j)))*(x(j) - m(j)) + cm(j);  % Determining the production cost
        IC(j) = ((ih(j) - im(j))/(h(j) - m(j)))*(x(j) - m(j)) + im(j);  % Determining the investment cost
        R1Reqd(j) = x(j)*rm1(j);                 % Determining the raw material 1 required for process
        R2Reqd(j) = x(j)*rm2(j);                 % Determining the raw material 2 required for process
        Revenue(j) = SalePrice(j)*x(j);          % Determining the revenue genereated by selling the product from the process j
        
        
    elseif 0 < x(j) &&  x(j) < l(j)              % if the production is greater than zero but less than the low level
        
        penalty_domain(j) = 0;               % Assigning penalty for violating the domain hole constraints

    end
    
end

TotalInvRed = sum(IC);
penalty_IC = 0;
if  TotalInvRed > Budget                         % Checking for violation of the investment cost constraint
    penalty_IC = (TotalInvRed - Budget)^2;       % Determining the penalty due to violation for investment cost
end

penalty_R1 = 0;
TotalR1Reqd = sum(R1Reqd);
if TotalR1Reqd > AvailRaw1                       % Checking for violation of the raw material 1 constraint
    penalty_R1 = (TotalR1Reqd  - AvailRaw1)^2;   % Determining the penalty due to violation for raw material 1
end

penalty_R2 = 0;
TotalR2Reqd = sum(R2Reqd);
if TotalR2Reqd < AvailRaw2                       % Checking for violation of the raw material 2 constraint
    penalty_R2 = (TotalR2Reqd  - AvailRaw2)^2;   % Determining the penalty due to violation for raw material 2
end

profit = sum(Revenue) - PC;                 % Determining the profit (objective)

f = -profit + 10^15*(penalty_IC + penalty_R1 + penalty_R2 + sum(penalty_domain));   % Determining the fitness function value