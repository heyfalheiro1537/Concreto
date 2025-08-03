function [Ns,Msx,Msy] = esforcos_aco(e0,kx,ky,x,y,As,fyd,epsilonyd)

  Ns = 0;
  Msx = 0;
  Msy =0;

    for i = 1:length(x)
        epsilon_i = e0 + ky*(x(i)) - kx*(y(i));

        Ns = Ns + sigmasi (epsilon_i, fyd, epsilonyd)*As(i);
        Msx = Msx - sigmasi(epsilon_i , fyd, epsilonyd)*As(i)*y(i);
        Msy  = Msy + sigmasi(epsilon_i , fyd, epsilonyd)*As(i)*x(i);
         
    end

end