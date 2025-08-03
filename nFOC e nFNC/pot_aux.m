function pot_aux = pot_aux (epsilon, sigmacd, epsilonc2,n,m)

if (m == 0)
    if (epsilon <= 0)
        pot_aux = 0;
    elseif (epsilon < epsilonc2 && epsilon > 0)
        pot_aux = sigmacd*(epsilon-(1/(n+1))*epsilonc2*(1-(1-(epsilon/epsilonc2))^(n+1)));
    elseif (epsilon >= epsilonc2)
        pot_aux = sigmacd*(epsilon - epsilonc2/(n+1));
    end
elseif (m == 1)
    if (epsilon <= 0)
        pot_aux = 0;
    elseif (epsilon < epsilonc2 && epsilon > 0)
        pot_aux = sigmacd*(epsilon^2/2 + epsilonc2^2*((-1/(n+1))*(1 - (1 - epsilon/epsilonc2)^(n+1))+(1/(n+2))*(1 - (1 - epsilon/epsilonc2)^(n+2))));
    elseif (epsilon >= epsilonc2)
        pot_aux = sigmacd*(epsilon^2/2 - epsilonc2^2/((n+1)*(n+2)));
    end
end
end