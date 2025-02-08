Sets
    i / Prop1*Prop10 /
    j / Rev1*Rev5 /
    p / 1*4 /;
    
Table w(i,j)
            Rev1   Rev2   Rev3   Rev4   Rev5
    Prop1   3      1       10      3       0
    Prop2   6      2       9       6       1
    Prop3   4      3       8       4       4
    Prop4   0      4       7       8       6
    Prop5   1      5       6       1       2
    Prop6   2      6       5       2       3
    Prop7   8      7       4       8       5
    Prop8   5      8       3       5       0
    Prop9   10     9       2       8       7
    Prop10  3      10      1       3       10 ;
    
Scalars
    N / 10 /
    M / 5 /
    K / 4 /;
    
Alias (j,jj);

Binary Variables
    y(i,j)
    x(i,j,jj)
    D(p,i,j);
    
Variables
    sl(i,j,jj)
    z;
    
Equations
    A1
    A2
    A3
    A4
    A5
    A6
    A7
    A8
    A9
    A10
    A11
    A12
    A13
    A14
    Objective;

A1(j).. sum(i, y(i,j)) =g= floor(N*K/M);

A2(j).. sum(i, y(i,j)) =l= ceil(N*K/M);

A3(p,j).. sum(i, D(p,i,j)) =g= floor(N/M);

A4(p,j).. sum(i, D(p,i,j)) =l= ceil(N/M);

A5(i,j).. w(i,j)*y(i,j) =g= y(i,j);

A6(i).. sum(j, y(i,j)) =e= K;

A7(p,i).. sum(j, D(p,i,j)) =e= 1;

A8(p,i,j).. D(p,i,j) =l= y(i,j);

A9(i,j).. sum(p, D(p,i,j)) =e= y(i,j);

A10(i,j,jj)$(ord(j)<>ord(jj)).. D('1',i,j) + D('2',i,j) - x(i,j,jj) =l= 1;

A11(i,j,jj)$(ord(j)<>ord(jj)).. D('2',i,j) + D('3',i,j) - x(i,j,jj) =l= 1;

A12(i,j,jj)$(ord(j)<>ord(jj)).. D('3',i,j) + D('4',i,j) - x(i,j,jj) =l= 1;

A13(i,j,jj)$(ord(j)<>ord(jj)).. -N*(1 - x(i,j,jj)) =l= w(i,jj) - w(i,j) + sl(i,j,jj);

Objective.. z =e= sum((i,j), w(i,j)*y(i,j));

Model PanelAssignment /all/;
Solve PanelAssignment using mip minimising z;
Display D.l, x.l, sl.l, sl.l;