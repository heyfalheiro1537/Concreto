function verificacao = verificacaoFNC_func(tipoc, tipos, b,h,ytopo, ybase,nc,ys,As,Nd,Md,gamac,gamas,Es,precisao,tolerancia)
    

[etac,sigmacd,epsilonc2,epsiloncu,n] = paramsConcreto(tipoc,gamac);
[fyd,epsilonyd] = paramsaco(tipos,Es,gamas);

A = b*h;
S = 0;



maxit = 1000;
epsilon0 = 0.0; %chute inicial de epsilon0
k = 0.0; %chute inicial da curvatura

f = 1;
Det = 1;

DADOS = [0 0 0 0 0 0 0 0 0 0 0 0];

cont = 1;

while (cont <= maxit && f >= precisao*(Nd^2+Md^2)^0.5 && abs(Det) >= tolerancia*(sigmacd^2)*b^2*h^4/12 )
    %Cálculo para a armadura;
    Ns = 0;
    Ms = 0;
    EAs = 0;
    ESs = 0;
    EIs = 0;

    for i=1:nc
        epsilonsi = epsilon0 +k*ys(i);
        Ns = Ns + sigmasi (epsilonsi, fyd, epsilonyd)*As(i);
        Ms = Ms + sigmasi(epsilonsi , fyd, epsilonyd)*As(i)*ys(i);
        EAs = EAs + dsigmasi(epsilonsi , epsilonyd, fyd)*As(i);
        ESs = ESs + dsigmasi(epsilonsi , epsilonyd, fyd)*As(i)*ys(i);
        EIs = EIs + dsigmasi(epsilonsi , epsilonyd, fyd)*As(i)*(ys(i)^2);
    end

    %Cálculo para o concreto
    epsilontopo = epsilon0 + k*ytopo;
    epsilonbase = epsilon0 + k*ybase;

    %Valores de I
    I0et = pot_aux (epsilontopo,sigmacd,epsilonc2,n,0);
    I0eb = pot_aux (epsilonbase,sigmacd,epsilonc2,n,0);
    I1et = pot_aux (epsilontopo,sigmacd,epsilonc2,n,1);
    I1eb = pot_aux (epsilonbase,sigmacd,epsilonc2,n,1);

    %Valores de J
    J0et = sigmac(epsilontopo, epsilonc2, sigmacd, n);
    J0eb = sigmac(epsilonbase, epsilonc2, sigmacd, n);
    J1et = sigmac(epsilontopo, epsilonc2, sigmacd, n)*(epsilontopo - epsilon0);
    J1eb = sigmac(epsilonbase, epsilonc2, sigmacd, n)*(epsilonbase - epsilon0);
    J2et = sigmac(epsilontopo, epsilonc2, sigmacd, n)*((epsilontopo - epsilon0)^2);
    J2eb = sigmac(epsilonbase, epsilonc2, sigmacd, n)*((epsilonbase - epsilon0)^2);

    %Calculando os valores de Nc e Mc
    if abs(k*h) < 10^(-5)
        Nc = sigmac(epsilon0,epsilonc2, sigmacd, n)*A;
        Mc = 0;
        EAc = dsigmac(epsilon0, epsilonc2, n, sigmacd)*b*h;
        ESc = 0;
        EIc = dsigmac(epsilon0, epsilonc2, n, sigmacd)*b*(h^3)/12;
    else 
        Nc = (b/k)*(I0et - I0eb);
        Mc = (b/k^2)*((I1et-I1eb) - epsilon0*(I0et-I0eb));
        EAc = (b/k)*(J0et-J0eb);
        ESc = (b/k^2)*((J1et - J1eb)-(I0et- I0eb));
        EIc = (b/k^3)*((J2et - J2eb) - 2*((I1et - I1eb) - epsilon0*(I0et-I0eb)));
    end

     %Cálculo dos esforços e rigidezes totais
     Nr = Nc + Ns;
     Mr = Mc + Ms;
     EA = EAs + EAc;
     ES = ESs + ESc;
     EI = EIs + EIc;

     Det = EA*EI - ((ES)^2);

     f = sqrt( (Nd- Nr)^2 + (Md - Mr)^2);

     DADOS = [DADOS;[cont epsilon0 k Nr Mr f EA ES EI Det epsilontopo epsilonbase]];

     if (abs(Det) > tolerancia*sigmacd^2*b^2*h^4/12)
         epsilon0 = epsilon0 + (1/Det)*( EI*( Nd-Nr )- ES*( Md- Mr ));
         k = k +(1/Det)*( -ES*( Nd - Nr) +EA*( Md - Mr ));
     end
    
     cont = cont +1 ;
end 

if (cont >= maxit || abs(Det) <= tolerancia*sigmacd^2*b^2*h^4/12)
    verificacao = [false epsilon0 k cont];
   
    return
end
%----------polos de ruina

%curv positiva
if epsilontopo >= epsilonbase
    if (epsilontopo <= epsiloncu && (epsilon0 + (ytopo - h*(epsiloncu-epsilonc2)/epsiloncu)*k) <= epsilonc2 && (epsilon0 + k*ys(1)) >= -10)
        elu = true;
    else
        elu = false;
    end

%curv negativa
else
    if (epsilonbase <= epsiloncu && (epsilon0 + (ybase + h*(epsiloncu-epsilonc2)/epsiloncu)*k) <= epsilonc2 && (epsilon0 + k*ys(nc)) >= -10)
        elu = true;
    else
        elu = false;
    end
end

verificacao = [elu epsilon0 k cont];
return
