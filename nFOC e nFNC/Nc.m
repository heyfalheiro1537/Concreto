function N  = Nc (sigmacd,e0,kx,ky,x,y,n,epsilonc2)

    if abs(ky) > 10^-10
        N = 0;
            
        for i = 1: length(y)-1
            epsilon_i = e0 + ky*(x(i)) - kx*(y(i));
            
            next_epsilon_i = e0 + ky*(x(i+1)) - kx*(y(i+1));

            N = N + (y(i+1)-y(i))*f(sigmacd,next_epsilon_i,epsilon_i,x(i+1),x(i),y(i+1),y(i),kx,ky,1,n,epsilonc2);

        end
            N = N/ky;
          
    end

    if abs(kx) > 10^-10
        
        N = 0;
            
        for i = 1: length(x)-1

            epsilon_i = e0 + ky*(x(i)) - kx*(y(i));

            next_epsilon_i = e0 + ky*(x(i+1)) - kx*(y(i+1));
            
            N = N + ( x(i+1)-x(i) )*f(sigmacd,next_epsilon_i,epsilon_i,x(i+1),x(i),y(i+1),y(i),kx,ky,1,n,epsilonc2);

        end
            N = N/kx;
    else 
      N = 0;

      for i = 1:length(x)-1
            
          N = N + sigma(sigmacd,e0)*(x(i)*y(i+1) - x(i+1)*y(i))/2;
            
      end
     
    
    end
