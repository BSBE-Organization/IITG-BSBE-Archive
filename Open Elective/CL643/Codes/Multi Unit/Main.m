function f = Main(x)

Budget = 1000;                              % Budget available
AvailRaw1 = 500;                            % Amount of raw material 1 available
AvailRaw2 = 500;                            % Amount of raw material 2 available

[product,l,m,h,il,im,ih,cl,cm,ch,SP,rm1,rm2,rm3,n] = ProductionPlanningData;

L = x(1:n);
M = x(n+1:2*n);
H = x(2*n+1:3*n);
XLM = x(3*n+1:4*n);
XMH = x(4*n+1:5*n);

for i = 1:n
    PCL(i) = L(i)*cl(i);
    ICL(i) = L(i)*il(i);
    RM1L(i) = L(i)*rm1(i);
    RM2L(i) = L(i)*rm2(i);
    SP1(i) = L(i)*SP(i);

    PCM(i) = M(i)*cm(i);
    ICM(i) = M(i)*im(i);
    RM1M(i) = M(i)*rm1(i);
    RM2M(i) = M(i)*rm2(i);
    SP2(i) = M(i)*SP(i);

    PCH(i) = H(i)*ch(i);
    ICH(i) = H(i)*ih(i);
    RM1H(i) = H(i)*rm1(i);
    RM2H(i) = H(i)*rm2(i);
    SP3(i) = H(i)*SP(i);
end

[PC1,IC1,RM11,RM21,SP4,~] = SKS_ProductionPlanningLM(XLM);
[PC2,IC2,RM12,RM22,SP5,~] = SKS_ProductionPlanningLM(XMH);

RM1 = RM1L + RM1M + RM1H + RM11 + RM12;
RM2 = RM2L + RM2M + RM2H + RM21 + RM22;
IC = ICL + ICM + ICH + IC1 + IC2;
PC = PCL + PCM + PCH + PC1 + PC2;
Revenue = SP1 + SP2 + SP3 + SP4 + SP5;

TotalInvRed = sum(IC);
penalty_IC = 0;
if  TotalInvRed > Budget                         % Checking for violation of the investment cost constraint
    penalty_IC = (TotalInvRed - Budget)^2;       % Determining the penalty due to violation for investment cost
end

penalty_R1 = 0;
TotalR1Reqd = sum(RM1);
if TotalR1Reqd > AvailRaw1                       % Checking for violation of the raw material 1 constraint
    penalty_R1 = (TotalR1Reqd  - AvailRaw1)^2;   % Determining the penalty due to violation for raw material 1
end

penalty_R2 = 0;
TotalR2Reqd = sum(RM2);
if TotalR2Reqd > AvailRaw2                       % Checking for violation of the raw material 2 constraint CHANGED
    penalty_R2 = (TotalR2Reqd  - AvailRaw2)^2;   % Determining the penalty due to violation for raw material 2
end

profit = sum(Revenue) - sum(PC);                 % Determining the profit (objective) CHANGED
f = -profit + 10^15*(penalty_IC + penalty_R1 + penalty_R2);   % Determining the fitness function value