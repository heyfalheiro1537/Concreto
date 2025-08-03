function M = Mcx(sigmacd,e0,kx,ky,x,y,n,epsilonc2)

    

     if abs(ky) > 10^-10
        M = 0;
            
        for i = 1: length(y)-1
            epsilon_i = e0 + ky*(x(i)) - kx*(y(i));
            
            next_epsilon_i = e0 + ky*(x(i+1)) - kx*(y(i+1));

            M = M + (y(i+1)-y(i))*f(sigmacd,next_epsilon_i,epsilon_i,x(i+1),x(i),y(i+1),y(i),kx,ky,2,n,epsilonc2);

        end
            M = -M/ky;
        return 
    end

    if abs(kx) > 10^-10
        
        M = 0;
            
        for i = 1: length(x)-1

            epsilon_i = e0 + ky*(x(i)) - kx*(y(i));

            next_epsilon_i = e0 + ky*(x(i+1)) - kx*(y(i+1));
            
            M = M + ( x(i+1)-x(i) )*f(sigmacd,next_epsilon_i,epsilon_i,x(i+1),x(i),y(i+1),y(i),kx,ky,3,n,epsilonc2);

        end
            M = -M/kx;
        return
    
    else
      M = 0;
      for i = 1:length(x)-1
            
          M = M + sigma(sigmacd,e0)*(y(i)+y(i+1))*(x(i)*y(i+1) - x(i+1)*y(i))/6;
            
      end
    
    end

end