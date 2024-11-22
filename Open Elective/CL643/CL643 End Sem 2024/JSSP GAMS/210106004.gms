Set
    i / 1*7 /
    m / 1*3 /;
    
Alias
    (i,j)
    (m,n);
    
Parameters p(i,m) /
    1.1 10
    1.2 14
    1.3 12
    2.1 6
    2.2 8
    2.3 7
    3.1 11
    3.2 16
    3.3 13
    4.1 6
    4.2 12
    4.3 8
    5.1 10
    5.2 16
    5.3 12
    6.1 7
    6.2 12
    6.3 10
    7.1 10
    7.2 8
    7.3 10 /;

Parameters c(i,m) /
    1.1 10
    1.2 6
    1.3 8
    2.1 8
    2.2 5
    2.3 6
    3.1 12
    3.2 7
    3.3 10
    4.1 10
    4.2 6
    4.3 8
    5.1 8
    5.2 5
    5.3 7
    6.1 12
    6.2 7
    6.3 10
    7.1 12
    7.2 7
    7.3 10 /;

Parameters r(i)/
    1 2
    2 3
    3 4
    4 5
    5 10
    6 1
    7 2 /;

Parameters d(i)/
    1 16
    2 13
    3 21
    4 28
    5 24
    6 28
    7 23 /;

Scalars
    U / 100 /
    min
    max;
    
max = smax(i,d(i));
min = smin(i,r(i));

Binary Variables
    x(i,m)
    y(i,j);

Free Variables
    t(i)
    obj;

Equations
    eq1
    eq2
    eq3
    eq4
    eq5
    eq6
    eq7
    eq8
    objeq;
    
eq1(i).. t(i) =g= r(i);

eq2(i).. t(i) =l= d(i) - sum(m, p(i,m)*x(i,m));

eq3(i).. sum(m, x(i,m)) =e= 1;

eq4(m).. sum(i, p(i,m)*x(i,m)) =l= max - min;

eq5(i,j)$(ord(i) < ord(j)).. y(i,j) + y(j,i) =l= 1;

eq6(i,j,m)$(ord(i) < ord(j)).. y(i,j) + y(j,i) =g= x(i,m) + x(j,m) - 1;

eq7(i,j,m,n)$(ord(i) < ord(j) and ord(n) <> ord(n)).. y(i,j) + y(j,i) + x(i,m) + x(j,n) =l= 2;

eq8(i,j)$(ord(i) <> ord(j)).. t(j) =g= t(i) + sum(m, p(i,m)*x(i,m)) - U*(1 - y(i,j));

objeq.. obj =e= sum((i,m), c(i,m)*x(i,m));

Model JSSP / all /;
Solve JSSP using mip minimizing obj;