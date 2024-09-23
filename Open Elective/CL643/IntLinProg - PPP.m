[product,l,m,h,il,im,ih,cl,cm,ch,SP,rm1,rm2,rm3,Np] = ProductionPlanningData;

A=zeros((Np*3+2+1),Np*6);

U=10000;
B=1000;
R1=50;
R2=50;

%L Y H X Z M
%B matrix
b=zeros(Np*3+2+1,1);

%A matrix
for i=1:Np
    % Lj- Yj<=0
    A(i,i)=1;
    A(i,Np+i)=-1;

    % Hj+ Yj <=1
    A(Np+i,Np+i)=1;
    A(Np+i,2*Np+i)=1;
    b(Np+i,1)=1;

    % Xj - U.Zj <= 0
    A(2*Np+i,3*Np+i)=1;
    A(2*Np+i,4*Np+i)=-U;

    %budget
    A(3*Np+1,i)=il(i);
    A(3*Np+1,2*Np+i)=ih(i);
    A(3*Np+1,5*Np+i)=im(i);
 
    A(3*Np+2,3*Np+i)=rm1(i);
    A(3*Np+3,3*Np+i)=rm2(i);
end

b(3*Np+1,1)=B;
b(3*Np+2,1)=R1;
b(3*Np+3,1)=R2;

%L Y H X Z M
Aeq=zeros(Np*2,Np*6);
beq=zeros(Np*2,1);

for i=1:Np
    Aeq(i,i)=1
    Aeq(i,Np*2+i)=1;
    Aeq(i,Np*4+i)=-1;
    Aeq(i,Np*5+i)=1;

    Aeq(Np+i,i)=l(i);
    Aeq(Np+i,Np*2+i)=h(i);
    Aeq(Np+i,Np*5+i)=m(i);
    Aeq(Np+i,Np*3+i)=-1; %X
end

f=zeros(Np*6,1);
p=1;

for i=1:Np
    f(i,1)=cl(i);
    f(3*Np+i,1)=-SP(i);
    f(2*Np+i,1)=ch(i);
    f(5*Np+i,1)=cm(i);
end

lb=zeros(Np*6,1);
ub=Inf(Np*6,1);

for i=1:Np
    ub(Np+i,1)=1;
    ub(4*Np+i,1)=1;
end

intcon=[linspace(Np+1,2*Np,Np) linspace(3*Np+1,4*Np,Np) linspace(4*Np+1,5*Np,Np) ];

[x,fval,exitflag,output] = intlinprog(f,intcon,A,b,Aeq,beq,lb,ub);

disp(X)