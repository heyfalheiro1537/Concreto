function J = J(sigmacd, epsilon,m,n,epsilonc2)

if (m == 1)
    if (epsilon < 0)
        J = 0;
    else
        J = epsilon^2/2 - (epsilonc2)^2*(t_k(1,n,epsilonc2,epsilon) - t_k(2,n,epsilonc2,epsilon));
    end

elseif (m == 2)
    if (epsilon < 0)
        J = 0;
    else
        J = epsilon^3/3 - (epsilonc2)^3*(t_k(1,n,epsilonc2,epsilon) - 2*t_k(2,n,epsilonc2,epsilon) + t_k(3,n,epsilonc2,epsilon));
    end
end

J = sigmacd*J;