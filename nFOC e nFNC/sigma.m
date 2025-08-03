function sigma = sigma(sigmacd,epsilon)
    
    if epsilon < 0
        sigma = 0;
    elseif epsilon <=2
        sigma = sigmacd*epsilon*(4-epsilon)/4;
    else
        sigma = sigmacd;
    end

end