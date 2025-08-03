function [v,u] = esforcosresistivos(tipoc, tipos,b,h,diametro_bitola,nc,ys,nbarras,epsilon0,k,epsilonc2,epsiloncu,n)

gamaf = 1.4;
gamac = 1.4;
gamas = 1.15;

%-------------Dados do problema

A = b*h;
S = 0;

ytopo = +h/2;
ybase = -h/2;

if (tipoc > 40)
    etac = (40/tipoc)^(1/3);
else
    etac = 1;
end

fck = tipoc;
fcd = fck/gamac; %f de desing
sigmacd = 0.85*fcd*etac; %tensao maxima de calculo

fyk = tipos*10; %agora em MPa
fyd = fyk/gamas;
Es = 210*10^3;
epsilonyd = 1000*fyd/Es;

As = 0.25*pi*(diametro_bitola^2)*nbarras;

%------parametros

tol = 1e-10; %tolerancia para aceitar resultados proximos de 0

%------contribuicao da armadura

Ns = 0;
Ms = 0;

for i=1:nc
    epsilonsi = epsilon0 + k*ys(i);
    Ns = Ns + sigmasi(epsilonsi, fyd, epsilonyd)*As(i);
    Ms = Ms + sigmasi(epsilonsi, fyd, epsilonyd)*As(i)*ys(i);
end

%------contribuicao do concreto

Mc = 0;
Nc = 0;

epsilontopo = epsilon0 + k*ytopo;
epsilonbase = epsilon0 + k*ybase;

if abs(epsilontopo - epsilonbase) < tol
    Nc = sigmac(epsilon0, epsilonc2, sigmacd, n)*A;
    Mc = sigmac(epsilon0, epsilonc2, sigmacd, n)*S;
else
    DI0 = pot_aux(epsilontopo,sigmacd,epsilonc2,n,0) - pot_aux(epsilonbase,sigmacd,epsilonc2,n,0);
    DI1 = pot_aux(epsilontopo,sigmacd,epsilonc2,n,1) - pot_aux(epsilonbase,sigmacd,epsilonc2,n,1);
    Nc = (b/k)*DI0;
    Mc = (b/k^2)*(DI1 - epsilon0*DI0);
end

%-------esforcos resistentes totais
Nr = Nc + Ns;
Mr = Mc + Ms;

%------plot

v = Nr/(sigmacd*A);
u = Mr/(sigmacd*A*h);
end