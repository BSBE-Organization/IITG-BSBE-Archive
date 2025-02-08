int N = 10;
int M = 5;
int K = 4;

range i = 1..N; // Properties: Prop1 to Prop10
range j = 1..M; // Revenue categories: Rev1 to Rev5
range jj = 1..M; // Revenue categories: Rev1 to Rev5
range p = 1..K; // Panels: 1 to 4

// Input data for the weight matrix (w) based on properties and revenue categories
int w[1..10][1..5] = [
    [3, 1, 10, 3, 0],
    [6, 2, 9, 6, 1],
    [4, 3, 8, 4, 4],
    [0, 4, 7, 8, 6],
    [1, 5, 6, 1, 2],
    [2, 6, 5, 2, 3],
    [8, 7, 4, 8, 5],
    [5, 8, 3, 5, 0],
    [10, 9, 2, 8, 7],
    [3, 10, 1, 3, 10]
];

// Decision variables
dvar boolean y[i][j];           // Binary variable for property assignment
dvar boolean x[i][j][j];         // Pairwise assignment
dvar boolean D[p][i][j];         // Decision for panel assignment
dvar int+ sl[i][j][j];           // Slack variable for ordering conditions

// Objective function
minimize sum(i in i, j in j) w[i][j] * y[i][j];

// Constraints
subject to {
    // Constraints A1 and A2: Revenue categories allocation
    forall(j in j)
        sum(i in i) y[i][j] >= floor(N * K / M);
    forall(j in j)
        sum(i in i) y[i][j] <= ceil(N * K / M);

    // Constraints A3 and A4: Panel assignments
    forall(p in p, j in j)
        sum(i in i) D[p][i][j] >= floor(N / M);
    forall(p in p, j in j)
        sum(i in i) D[p][i][j] <= ceil(N / M);

    // Constraint A5: Weight assignment for binary y
    forall(i in i, j in j)
        w[i][j] * y[i][j] >= y[i][j];

    // Constraint A6: Number of properties per panel
    forall(i in i)
        sum(j in j) y[i][j] == K;

    // Constraint A7: One panel per property
    forall(p in p, i in i)
        sum(j in j) D[p][i][j] == 1;

    // Constraints A8 and A9: Dependency of D and y
    forall(p in p, i in i, j in j) 
        D[p][i][j] <= y[i][j];
    forall(i in i, j in j)
        sum(p in p) D[p][i][j] == y[i][j];

    // Constraints A10 to A13: Ordering constraints with slack
    forall(i in i, j in j, jj in jj: j != jj) {
        D[1][i][j] + D[2][i][j] - x[i][j][jj] <= 1;
        D[2][i][j] + D[3][i][j] - x[i][j][jj] <= 1;
        D[3][i][j] + D[4][i][j] - x[i][j][jj] <= 1;
        -N * (1 - x[i][j][jj]) <= w[i][jj] - w[i][j] + sl[i][j][jj];
    }
}