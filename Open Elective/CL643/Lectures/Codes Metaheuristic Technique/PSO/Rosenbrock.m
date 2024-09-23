function F = Rosenbrock(X)
[ros, d] = size(X);
F = zeros(ros, 1);

for k = 1:ros
    x = X(k,:);
    f = zeros(d,1);
    for i = 1: d-1
        f(i) = 100*(x(i)^2 - x(i+1))^2 + (1 - x(i))^2;
    end
    F(k) =  sum(f);
end


