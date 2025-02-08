Sets
    i / Prop1*Prop24 /
    j / Rev1*Rev10 /
    p / 1*3 /;
    
Table w(i,j)
        Rev1   Rev2   Rev3   Rev4   Rev5   Rev6   Rev7   Rev8   Rev9   Rev10
Prop1   1      2      24     24     24     24     10     2      3      24
Prop2   2      0      24     24     24     24     11     4      1      24
Prop3   12     0      6      24     8      2      12     24     5      1
Prop4   10     3      3      1      5      14     0      5      12     24
Prop5   3      12     11     24     24     16     24     6      5      24
Prop6   24     6      8      24     0      13     7      7      1      8
Prop7   6      4      24     24     24     24     6      1      1      24
Prop8   24     24     24     24     10     8      24     24     12     1
Prop9   24     24     24     24     4      9      24     24     12     4
Prop10  12     10     2      1      24     3      5      24     3      1
Prop11  10     24     24     1      11     24     24     24     12     24
Prop12  24     24     5      1      7      7      24     24     12     8
Prop13  24     5      1      24     24     15     4      24     3      4
Prop14  6      24     12     1      24     0      3      24     12     24
Prop15  24     9      4      24     24     12     2      9      5      24
Prop16  24     1      7      1      3      6      24     24     12     4
Prop17  24     24     24     24     9      1      24     24     12     4
Prop18  24     24     24     24     2      4      24     24     12     4
Prop19  8      8      24     24     24     24     1      8      9      24
Prop20  24     24     9      7      6      5      24     24     12     6
Prop21  24     24     10     7      12     11     8      10     7      24
Prop22  8      11     24     24     24     0      24     24     12     24
Prop23  6      24     24     24     24     10     9      3      9      24
Prop24  24     7      24     7      1      0      24     24     12     8 ;
    
Scalars
    N / 24 /
    M / 10 /
    K / 3 /;
    
Binary Variables
    y(i,j)
    D(p,i,j);
    
Variables
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

Objective.. z =e= sum((i,j), w(i,j)*y(i,j));

Model PanelAssignment /all/;
Solve PanelAssignment using mip minimising z;
Display y.l, D.l;