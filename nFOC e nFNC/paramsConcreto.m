function [etac,sigmacd,epsilonc2,epsiloncu,n] = paramsConcreto(tipoc,gamac)

if (tipoc > 40)
    etac = (40/tipoc)^(1/3);
else
    etac = 1;
end
fck = tipoc;
fcd = fck/gamac; 
sigmacd = 0.85*fcd; %caso usando norma de 2024 pra frente multiplicar por etac

if (tipoc < 50)
    epsilonc2 = 2;
    epsiloncu = 3.5;
    n = 2;
else
    epsilonc2 = 2 + 0.085*((fck-50)^0.53);
    epsiloncu = 2.6 + 35*(((90-fck)/100)^4);
    n = 1.4 + (23.4)*(((90-fck)/100)^4);
end