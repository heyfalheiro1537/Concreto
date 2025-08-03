function Rc = Rcca(Sigma_cd, b, d, e_c2, e_cu, n_concreto, x, xlim2b, xlim3, xlim)
  
    kx = x / d;
    

    if (0 <= x) && (x <= xlim2b)
        Rc = Sigma_cd * b * d^2 * ( ...
            (kx^2 / 2) - (e_c2 * (1 - kx) / (10 * (n_concreto + 1)))* (kx - (e_c2 * (1 - kx) / (10 * (n_concreto + 2)))* (1 - (1 - 10 * kx / (e_c2 * (1 - kx)))^(n_concreto + 2)) ));
    

    elseif (xlim2b < x) && (x <= xlim3)
        Rc = Sigma_cd * b * d^2 * ((kx^2 / 2)- (e_c2 * (1 - kx) / (10 * (n_concreto + 1)))* (kx - (e_c2 * (1 - kx) / (10 * (n_concreto + 2)))));
    
   
    elseif (xlim3 < x) && (x <= d)
        Rc = Sigma_cd * b * d^2 * ((kx^2) * (1/2 - (e_c2 / (e_cu * (n_concreto + 1))) * (1 - e_c2 / (e_cu * (n_concreto + 2)))));
    
   
    else
        Rc = NaN;
    end
end


