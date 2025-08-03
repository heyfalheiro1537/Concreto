function I = I(sigmacd, epsilon,m,n,epsilonc2)

if (m == 1)
    if (epsilon < 0)
        I = 0;
    else
        I = epsilon - epsilonc2 * t_k(1,n,epsilonc2,epsilon);
    end

elseif (m == 2)
    if (epsilon < 0)
        I = 0;
    else
        I = epsilon^2/2 - epsilonc2/(n + 1)*(epsilon - epsilonc2*t_k(2,n,epsilonc2,epsilon));
    end

elseif (m == 3)
    if (epsilon < 0)
        I = 0;
    else
        I = epsilon^3/6 - epsilonc2/(n + 1)*(epsilon^2/2 - epsilonc2/(n + 2)*(epsilon - epsilonc2*t_k(3,n,epsilonc2,epsilon)));
    end
end

I = sigmacd*I;
