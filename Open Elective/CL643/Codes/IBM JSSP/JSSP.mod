{int} I = ...;    // Set of jobs
{string} M = ...;    // Set of machines

// Parameters

float C[I][M] = ...;    // Cost coefficients
float p[I][M] = ...;    // Processing times
float r[I] = ...;       // Release times
float d[I] = ...;       // Due dates
float U = ...;          // Big-M value

// Decision Variables

dvar float+ ts[I];                      // Start times (24)
dvar boolean x[I][M];                   // Assignment variables (25)
dvar boolean y[i in I][i1 in I];        // Sequencing variables (26)

// Objective Function (15)
minimize sum(i in I) sum(m in M) C[i][m] * x[i][m];

subject to {
  
   // Constraint (16): Start time ≥ release time
   forall(i in I)
      ts[i] >= r[i];

   // Constraint (17): Start time + processing ≤ due date
   forall(i in I)
      ts[i] <= d[i] - sum(m in M) p[i][m] * x[i][m];
      
   // Constraint (18): Each job must be assigned to exactly one machine
   forall(i in I)
      sum(m in M) x[i][m] == 1;

   // Constraint (19): Machine capacity constraint
  forall(m in M)
    sum(i in I) (x[i][m] * p[i][m]) <= (max(i in I) d[i]) - (min(i in I) r[i]);

   // Constraint (20): Sequencing variable relationship with assignments
   forall(ordered i,i1 in I, m in M)
      y[i][i1] + y[i1][i] >= x[i][m] + x[i1][m] - 1;

   // Constraint (21): Start time relationship between jobs
    forall(i in I, i1 in I : i != i1)
    ts[i1] >= ts[i] + sum(m in M) (p[i][m] * x[i][m]) - U * (1 - y[i][i1]);
    
   // Constraint (22): No simultaneous sequencing
   forall(ordered i,i1 in I)
      y[i][i1] + y[i1][i] <= 1;

   // Constraint (23): Machine conflict resolution
   forall(ordered i,i1 in I, m,m1 in M: m != m1)
      y[i][i1] + y[i1][i] + x[i][m] + x[i1][m1] <= 2;
}