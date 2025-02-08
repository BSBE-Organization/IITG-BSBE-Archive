function [TotalProRed,TotalInvRed,TotalR1Reqd,TotalR2Reqd,TotRev,xupdate] = SKS_ProductionPlanningLM(x)
xupdate = x;

[product,l,m,h,il,im,ih,cl,cm,ch,SalePrice,rm1,rm2,rm3,nProcess] = ProductionPlanningData; % Accessing the data from the function

nProcess = length(l);                             % determing the number of processes CHANGED

PC = zeros(nProcess,1);                     % Initialization of variable to store the production cost for each process
IC = zeros(nProcess,1);                     % Initialization of variable to store the investment cost for each process
R1Reqd = zeros(nProcess,1);                 % Initialization of variable to store the raw material 1 required for each process
R2Reqd = zeros(nProcess,1);                 % Initialization of variable to store the raw material 2 required for each process
Revenue = zeros(nProcess,1);

for j = 1: nProcess
    
    if x(j) > l(j) && x(j) < m(j)             % if the production is in between low and medium level
        
        PC(j) = ((cm(j) - cl(j))/(m(j) - l(j)))*(x(j) - l(j)) + cl(j);  % Determining the production cost for the range l to m
        IC(j) = ((im(j) - il(j))/(m(j) - l(j)))*(x(j) - l(j)) + il(j);  % Determining the investment cost  for the range l to m
        R1Reqd(j) = x(j)*rm1(j);                % Determining the raw material 1 required for process
        R2Reqd(j) = x(j)*rm2(j);                % Determining the raw material 2 required for process
        Revenue(j) = SalePrice(j)*x(j);          % Determining the revenue genereated by selling the product from the process j
         
    else
        xupdate(j) = 0;               % Assigning penalty for violating the domain hole constraints

    end
    
end

TotalInvRed = sum(IC);
TotalR1Reqd = sum(R1Reqd);
TotalR2Reqd = sum(R2Reqd);
TotalProRed = sum(PC);
TotRev = sum(Revenue);