[product,l,m,h,il,im,ih,cl,cm,ch,SP,rm1,rm2,rm3,Np] = ProductionPlanningDataPart2;

B=1000;
R1=1000;
R2=1000;
R3=1000;
U=1000;

% L M H X Y Z
Aeq = zeros(Np*2,Np*6);
A = zeros(Np*3+4,Np*6);
beq = zeros(Np*2,1);
b = zeros(Np*3+4,1);
lb = zeros(Np*6,1);
ub = inf(Np*6,1);
f = zeros(Np*6,1);
intcon = zeros(3*Np,1);

for i=1:Np
    % L+M+H=Z
    Aeq(i,i)=1;
    Aeq(i,Np+i)=1;
    Aeq(i,2*Np+i)=1;
    Aeq(i,5*Np+i)=-1;

    % l.L+m.M+h.H=X
    Aeq(Np+i,i)=l(i);
    Aeq(Np+i,Np+i)=m(i);
    Aeq(Np+i,2*Np+i)=h(i);
    Aeq(Np+i,3*Np+i)=-1;

    % L-Y<=0
    A(i,i)=1;
    A(i,4*Np+i)=-1;

    % H+Y<=1
    A(Np+i,i)=1;
    A(Np+i,4*Np+i)=-1;

    % X-U.Z<=1
    A(2*Np+i,3*Np+i)=1;
    A(2*Np+i,5*Np+i)=-U;

    % Budget
    A(3*Np+1,i)=il(i);
    A(3*Np+1,Np+i)=im(i);
    A(3*Np+1,2*Np+i)=ih(i);

    A(3*Np+2,3*Np+i)=rm1(i);
    A(3*Np+3,3*Np+i)=rm2(i);
    A(3*Np+4,3*Np+i)=rm3(i);

    % f = PC - SP.X
    f(i,1)=cl(i);
    f(Np+i,1)=cm(i);
    f(2*Np+i,1)=ch(i);
    f(3*Np+i,1)=-SP(i);

    % up
    ub(4*Np+i,1) = 1;
    ub(5*Np+i,1) = 1;

    % intcon
    intcon(i,1) = 3*Np+i;
    intcon(Np+i,1) = 4*Np+i;
    intcon(2*Np+i,1) = 5*Np+i;

end

b(3*Np+1,1)=B;
b(3*Np+2,1)=R1;
b(3*Np+3,1)=R2;
b(3*Np+4,1)=R3;

[x,fval,exitflag,output] = intlinprog(f,intcon,A,b,Aeq,beq,lb,ub);

disp(x)