function K = K(sigmacd, epsilon,m,n,epsilonc2)

if (m == 1)
    if (epsilon < 0)
        K = 0;
    else
        K = epsilon^3/3 - epsilonc2/(n + 1)*(epsilon^2/2 - (epsilonc2)^2*(t_k(2,n,epsilonc2,epsilon) - t_k(3,n,epsilonc2,epsilon)));
    end
    K = sigmacd * K;
end

