function sigma = sigma_sc(f_yd,e_yd,x,xlim3,xlim,e_cu,d,dc)

    if (0 <= x) && (x <= xlim3)
        e_st = @(x) 10*(x-dc)/(d-x);
    elseif (xlim3 < x) && (x <= d)
        e_st = @(x) e_cu * (x - dc) / x;
    else
        e_st = NaN; % or another value to handle cases outside the defined ranges
    end
    
    if e_st(x) <= e_yd
       sigma = (f_yd * e_st(x))/e_yd;
    else
        sigma = f_yd;
    end
    
end