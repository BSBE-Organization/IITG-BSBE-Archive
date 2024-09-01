function F = Griewank(X)
[ros, D] = size(X);
d = 1:1:D;
d = sqrt(d);
F = zeros(ros, 1);
for k = 1: ros
    x = X(k,:);      
    F(k) = 1+((1/4000)*sum((x).^2)) - prod(cos(x./d.^0.5)) ;
end
