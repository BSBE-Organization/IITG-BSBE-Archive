function [lb,ub,fobj] = FunctionDetails(F,dim)


switch F
    case 1
        fobj = @Rosenbrock;
        lb = ones(1,dim)*(-100);
        ub = ones(1,dim)*(100);
        
        
    case 2
        fobj = @SphereNew;
        lb = ones(1,dim)*(-100);
        ub = ones(1,dim)*(100);
        
        
    case 3
        fobj = @Griewank;
        lb = ones(1,dim)*(-100);
        ub = ones(1,dim)*(100);
        
        
    case 4
        fobj = @Rastrigin;
        lb = ones(1,dim)*(-5.12);
        ub = ones(1,dim)*(5.12);
        
        
    case 5
        fobj = @Schaffer;
        lb = -30*ones(1,dim);
        ub = 30*ones(1,dim);        
end

end

