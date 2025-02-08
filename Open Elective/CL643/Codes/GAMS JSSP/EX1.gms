set i / 1*7 /;
set m / 1*3 /;
alias (i,ip);
alias (m,mp);

Parameters p(i, m) /
    1.1 10, 1.2 14, 1.3 12,
    2.1 6, 2.2 8, 2.3 7,
    3.1 11, 3.2 16, 3.3 13,
    4.1 6, 4.2 12, 4.3 8,
    5.1 10, 5.2 16, 5.3 12,
    6.1 7, 6.2 12, 6.3 10,
    7.1 10, 7.2 13, 7.3 10 /;

Parameters c(i, m) /
    1.1 10, 1.2 6, 1.3 8,
    2.1 8, 2.2 5, 2.3 6,
    3.1 12, 3.2 7, 3.3 10,
    4.1 10, 4.2 6, 4.3 8,
    5.1 8, 5.2 5, 5.3 6,
    6.1 12, 6.2 7, 6.3 10,
    7.1 12, 7.2 10, 7.3 11 /;

Parameters r(i) /
    1 2,
    2 3,
    3 4,
    4 5,
    5 10,
    6 1,
    7 2 /;

Parameters d(i)/
    1 33,
    2 34,
    3 31,
    4 33,
    5 34,
    6 34,
    7 33 /;

Scalars
    U / 1000 /
    maxd
    minr;

maxd = smax(i,d(i));
minr = smin(i,r(i));

Binary Variables
    x(i,m)
    y(i,ip);

Positive Variable t(i);

Free Variable obj;

Equations
    eq1
    eq2
    eq3
    eq4
    eq5
    eq6
    eq7
    eq8
    objdef;

eq1(i).. t(i) =g= r(i);

eq2(i).. t(i) =l= d(i) - sum(m, p(i,m)*x(i,m));

eq3(m).. sum(i, p(i,m)*x(i,m)) =l= maxd - minr;

eq4(i).. sum(m, x(i,m)) =e= 1;

eq5(i,ip)$(ord(i) < ord(ip)).. y(i,ip) + y(ip,i) =l= 1;

eq6(i,ip,m)$(ord(i) < ord(ip)).. y(i,ip) + y(ip,i) =g= x(i,m) + x(ip,m) - 1;

eq7(i,ip,m,mp)$(ord(i) < ord(ip) and ord(m) <> ord(mp)).. y(i,ip) + y(ip,i) + x(i,m) + x(ip,mp) =l= 2;

eq8(i,ip)$(ord(i) <> ord(ip)).. t(ip) =g= t(i) + sum(m, p(i,m)*x(i,m)) - U*(1 - y(i,ip));

objdef.. obj =e= sum((i,m), c(i,m)*x(i,m));

Model JSSP /all/;
Solve JSSP using mip minimizing obj;