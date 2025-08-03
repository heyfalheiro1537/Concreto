function R = matR(sigmacd,x,y,e0,kx,ky,epsilonc2,n)

    R = zeros(3);

    if abs(ky) > 0
            R(1,3) = -Nc (sigmacd,e0,kx,ky,x,y,n,epsilonc2);
            R(2,3) = -Mcx(sigmacd,e0,kx,ky,x,y,n,epsilonc2);
            R(3,3) = -2*Mcy(sigmacd,e0,kx,ky,x,y,n,epsilonc2);


            for  i = 1:length(y)-1
                epsilon_i = e0 + ky*(x(i)) - kx*(y(i));
                 next_epsilon_i = e0 + ky*(x(i+1)) - kx*(y(i+1));
                R(1,1) = R(1,1) + (y(i+1)-y(i))*f(sigmacd, next_epsilon_i, epsilon_i, x(i+1), x(i), y(i+1), y(i), kx, ky, 6,n,epsilonc2);
                R(1,2) = R(1,2) - (y(i+1)-y(i))*f(sigmacd, next_epsilon_i, epsilon_i, x(i+1), x(i), y(i+1), y(i), kx, ky, 7,n,epsilonc2);
                R(1,3) = R(1,3) + (y(i+1)-y(i))*f(sigmacd, next_epsilon_i, epsilon_i, x(i+1), x(i), y(i+1), y(i), kx, ky, 8,n,epsilonc2);
                R(2,2) = R(2,2) + (y(i+1)-y(i))*f(sigmacd, next_epsilon_i, epsilon_i, x(i+1), x(i), y(i+1), y(i), kx, ky, 9,n,epsilonc2);
                R(2,3) = R(2,3) - (y(i+1)-y(i))*f(sigmacd, next_epsilon_i, epsilon_i, x(i+1), x(i), y(i+1), y(i), kx, ky, 10,n,epsilonc2);
                R(3,3) = R(3,3) + (y(i+1)-y(i))*f(sigmacd, next_epsilon_i, epsilon_i, x(i+1), x(i), y(i+1), y(i), kx, ky, 11,n,epsilonc2);
            end

             R(2,1) = R(1,2);
             R(3,1) = R(1,3);
             R(3,2) = R(2,3);
             
             R = -R/ky;

        return 
    end

    if abs(kx) > 0
            R(1,2) = -Nc (sigmacd,e0,kx,ky,x,y,n,epsilonc2);
            R(2,2) = -2*Mcx(sigmacd,e0,kx,ky,x,y,n,epsilonc2);
            R(2,3) = -Mcy(sigmacd,e0,kx,ky,x,y,n,epsilonc2);


            for  i = 1:length(x)-1
                epsilon_i = e0 + ky*(x(i)) - kx*(y(i));
                 next_epsilon_i = e0 + ky*(x(i+1)) - kx*(y(i+1));
                R(1,1) = R(1,1) + (x(i+1) - x(i))*f(sigmacd, next_epsilon_i, epsilon_i, x(i+1), x(i), y(i+1), y(i), kx, ky, 6,n,epsilonc2);
                R(1,2) = R(1,2) - (x(i+1) - x(i))*f(sigmacd, next_epsilon_i, epsilon_i, x(i+1), x(i), y(i+1), y(i), kx, ky, 7,n,epsilonc2);
                R(1,3) = R(1,3) + (x(i+1) - x(i))*f(sigmacd, next_epsilon_i, epsilon_i, x(i+1), x(i), y(i+1), y(i), kx, ky, 8,n,epsilonc2);
                R(2,2) = R(2,2) + (x(i+1) - x(i))*f(sigmacd, next_epsilon_i, epsilon_i, x(i+1), x(i), y(i+1), y(i), kx, ky, 9,n,epsilonc2);
                R(2,3) = R(2,3) - (x(i+1) - x(i))*f(sigmacd, next_epsilon_i, epsilon_i, x(i+1), x(i), y(i+1), y(i), kx, ky, 10,n,epsilonc2);
                R(3,3) = R(3,3) + (x(i+1) - x(i))*f(sigmacd, next_epsilon_i, epsilon_i, x(i+1), x(i), y(i+1), y(i), kx, ky, 11,n,epsilonc2);
            end

             R(2,1) = R(1,2);
             R(3,1) = R(1,3);
             R(3,2) = R(2,3);
             
             R = -R/kx;


        return
       
    end
     R(1,1) = A_c(x,y);
     R(1,2) = S_x(x,y);
     R(1,3) = S_y(x,y);
     R(2,2) = I_xx(x,y);
     R(2,3) = -I_xy(x,y);
     R(3,3) = I_yy(x,y);
     R(2,1) = R(1,2);
     R(3,1) = R(1,3);
     R(3,2) = R(2,3);
  
    R = -R * dsigmac(e0, epsilonc2, n, sigmacd);
end