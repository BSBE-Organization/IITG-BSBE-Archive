function F = Sphere(X)
[ros, d] = size(X);
F = zeros(ros, 1);
for k = 1:ros
    x = X(k,:);   
    F(k) = sum(x.^2);
end