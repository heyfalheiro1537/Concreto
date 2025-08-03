
function Rc = Rcc (Sigma_cd,b,d,e_c2,e_cu, n_concreto,x,xlim2b,xlim3)
    if (0 <= x) && (x <= xlim2b)
        Rc = (Sigma_cd * b * d) * ( x/d - (e_c2 * (1 - x/d) / (10 * (n_concreto + 1))) * (1 - (1 - 10 * (x/d) / (e_c2 * (1 - x/d)))^(n_concreto + 1) ));
    elseif (xlim2b < x) && (x <= xlim3)
        Rc = (Sigma_cd * b * d) * ( x/d - (e_c2 * ( 1 - x/d ) / ( 10 * (n_concreto + 1) )  ) );
    elseif (xlim3 < x) && (x <= d)
        Rc = (Sigma_cd * b * d) * ((x/d)*(1 - e_c2/(e_cu*(n_concreto+1))));
    else 
        Rc = NaN;
    end
end