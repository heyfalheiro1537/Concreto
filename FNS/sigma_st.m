function sigma = sigma_st(f_yd,e_yd,x,xlim3,xlim,e_cu,d)

    if (0 <= x) && (x <= xlim3)
        e_st = @(x) 10;
    elseif (xlim3 < x) && (x <= d)
        e_st = @(x) e_cu * (d - x) / x;
    else
        e_st = NaN; % or another value to handle cases outside the defined ranges
    end
    
    if e_st(x) <= e_yd
       sigma = (f_yd * e_st(x))/e_yd;
    else
        sigma = f_yd;
    end
    
end