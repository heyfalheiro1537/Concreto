function t_k = t_k(k, n, c, epsilon)

if (epsilon >= 0 && epsilon < c)
    t_k = 1/(n + k)*(1 - (1 - epsilon/c)^(n + k));
elseif (epsilon >= c)
    t_k = 1/(n + k);
end
