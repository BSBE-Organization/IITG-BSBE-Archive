function F = Schaffer(X)
[ros, d] = size(X);
F = zeros(ros, 1);
for k = 1:ros
    x = X(k,:);
    x1 = x(1);
    x2 = x(2);
    fact1 = (sin(x1^2-x2^2))^2 - 0.5;
    fact2 = (1 + 0.001*(x1^2+x2^2))^2;
    F(k) = 0.5 + fact1/fact2;
end
