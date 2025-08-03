function verificacao = verificacaonFOC_func(tipoc, tipos, As, x,y,xs, ys, Nd,Mxd,Myd,tolerancia,gamac,gamas,Es)


[fyd,epsilonyd] = paramsaco(tipos,Es,gamas);
[etac,sigmacd,epsilonc2,epsiloncu,n] = paramsConcreto(tipoc,gamac);






%----------Verificacao

if (A_c(x,y) < 0) % Resolvendo o problema do sentido
    x= flip(x);
    y = flip(y);
end

numero_arestas = length(x)-1;
[x,y,xs,ys] = translacao_CG(x,y,numero_arestas,xs,ys);




%-----------



epsilon0 = 0.0; %chute inicial de epsilon0
kx = 0.0; %chute inicial da curvatura
ky = 0.0;

[Ns, Msx, Msy] = esforcos_aco(epsilon0,kx,ky,xs,ys,As,fyd,epsilonyd);

Nr = Nc(sigmacd,epsilon0,kx,ky,x,y) + Ns;
Mxr = Mcx(sigmacd,epsilon0,kx,ky,x,y) + Msx;
Myr = Mcy(sigmacd,epsilon0,kx,ky,x,y) + Msy;

J = matR(sigmacd,x,y,epsilon0,kx,ky,epsilonc2,n) + matRs(As,xs,ys,epsilon0,kx,ky, epsilonyd,fyd); 
f = sqrt( (Nd - Nr)^2 +  (Mxd - Mxr)^2 + (Myd - Myr)^2);

cont =1;
maxit = 1000;

while cont <= maxit && f >= tolerancia
    % Verifique a singularidade da matriz Jacobiana
    
    Det = det(J);

    if abs(Det) < tolerancia
        
        break;
    end
    
    % Calcular a inversa de J e atualizar as variáveis
    
    f_x = [Nd-Nr Mxd-Mxr Myd-Myr];

    auxiliar = inversor_matriz(J,f_x);
    epsilon0 = epsilon0 - auxiliar(1)/det(J);
    kx = kx - auxiliar(2)/det(J);
    ky = ky - auxiliar(3)/det(J);
    
    
    % Calcular novos resultados
    [Ns, Msx, Msy] = esforcos_aco(epsilon0, kx, ky, xs, ys, As, fyd, epsilonyd);

    Nr = Nc(sigmacd, epsilon0, kx, ky, x, y,n,epsilonc2) + Ns;
    Mxr = Mcx(sigmacd, epsilon0, kx, ky, x, y,n,epsilonc2) + Msx;
    Myr = Mcy(sigmacd, epsilon0, kx, ky, x, y,n,epsilonc2) + Msy;

    % Atualizar a matriz Jacobiana e a norma do vetor de resíduos
    J = matR(sigmacd,x,y,epsilon0,kx,ky,epsilonc2,n) + matRs(As, xs, ys, epsilon0, kx, ky, epsilonyd, fyd);
    f = sqrt((Nd - Nr)^2 + (Mxd - Mxr)^2 + (Myd - Myr)^2);
    
    % Incrementar o contador
    cont = cont + 1;
end
if (cont >= maxit || abs(det(J)) <= tolerancia)

    verificacao = [false epsilon0 ky kx cont];
    return
else 
   

end


% Verificação do ELU

e_arestas = zeros(1, length(x));
for i = 1:length(x)
    e_arestas(i) = epsilon0 + ky*x(i) - kx*y(i);
end
e_max = max(e_arestas);
e_min = min(e_arestas);
e_si = zeros(1, length(xs));

for j = 1:length(xs)
    e_si(j) = epsilon0 + ky*xs(j) - kx*ys(j) ;
end

e_s_min = min(e_si);

if (e_max <= epsiloncu && e_s_min >= -10 && e_max - (epsiloncu - epsilonc2)/epsiloncu*(e_max - e_min) <= epsilonc2)
    verificacao = [true epsilon0 ky kx cont];
else
    verificacao = [false epsilon0 ky kx cont];
end
