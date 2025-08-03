function R = matRs(As,x,y,e0,kx,ky,epsilonyd,fyd)

R = zeros(3);

            for  i = 1:(length(y))

                epsilon_i = e0 + ky*(x(i)) - kx*(y(i));
                
                R(1,1) = R(1,1) + dsigmasi(epsilon_i, epsilonyd,fyd)*As(i);
                R(1,2) = R(1,2) - dsigmasi(epsilon_i, epsilonyd,fyd)*y(i)*As(i);
                R(1,3) = R(1,3) + dsigmasi(epsilon_i, epsilonyd,fyd)*x(i)*As(i);
                R(2,2) = R(2,2) + dsigmasi(epsilon_i, epsilonyd,fyd)*y(i)*y(i)*As(i);
                R(2,3) = R(2,3) - dsigmasi(epsilon_i, epsilonyd,fyd)*y(i)*x(i)*As(i);
                R(3,3) = R(3,3) + dsigmasi(epsilon_i, epsilonyd,fyd)*x(i)*x(i)*As(i);
                
            end

             R(2,1) = R(1,2);
             R(3,1) = R(1,3);
             R(3,2) = R(2,3);
        
         R = -R;     
            
 
end