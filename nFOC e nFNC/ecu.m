function e = ecu(fck,C)
    
    if C <=50
        e = 3.5;
    else
        e = 2.6 + 35*((90-fck/10^6)/100)^4; 
    end
end