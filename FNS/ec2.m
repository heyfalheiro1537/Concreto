function e = ec2(fck,C)

    if C <=50
        e = 2;
    else
        e = 2 + 0.085*( fck/10^6 -50)^0.53; 
    end
end