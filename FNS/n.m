function n_concreto = n(fck,C)
    
    if C <=50
        n_concreto = 2;
    else
        n_concreto = 1.4 + 23.4*((90-fck/10^6)/100)^4; 
    end
end