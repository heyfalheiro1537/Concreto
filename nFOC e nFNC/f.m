function f = f(sigmacd, next_epsilon, epsilon, next_x, x, next_y, y, kx, ky, m,n,epsilonc2)
    deltaepsilon = next_epsilon - epsilon;

    % Variáveis auxiliares
    g = y * next_epsilon - next_y * epsilon;
    h = x * next_epsilon - next_x * epsilon;

    delta_y = next_y - y;
    delta_x = next_x - x;

    I1 = I(sigmacd, epsilon, 1,n,epsilonc2);
    I2 = I(sigmacd, epsilon, 2,n,epsilonc2);
    
    deltaI1 = I(sigmacd, next_epsilon, 1,n,epsilonc2) - I(sigmacd, epsilon, 1,n,epsilonc2);
    deltaI2 = I(sigmacd, next_epsilon, 2,n,epsilonc2) - I(sigmacd, epsilon, 2,n,epsilonc2);
    deltaI3 = I(sigmacd, next_epsilon, 3,n,epsilonc2) - I(sigmacd, epsilon, 3,n,epsilonc2);
    
    deltaK1 = K(sigmacd, next_epsilon,1,n,epsilonc2) - K(sigmacd, epsilon,1,n,epsilonc2);

    deltaJ1 =  J(sigmacd, next_epsilon,1,n,epsilonc2) - J(sigmacd, epsilon,1,n,epsilonc2);
    deltaJ2 =  J(sigmacd, next_epsilon,2,n,epsilonc2) - J(sigmacd, epsilon,2,n,epsilonc2);

    % Definição das funções f1i até f11i
    if m == 1
        if abs(deltaepsilon) < 1e-10
            f = I1;
        else
            f = deltaI2 / deltaepsilon; 
        end
    elseif m == 2
        if abs(deltaepsilon) < 1e-10
            f = I1 * (next_y + y) / 2;
        else
            f = (g * deltaI2 + delta_y * deltaK1) / deltaepsilon^2; 
        end
    elseif m == 3

        if abs(deltaepsilon) < 1e-10
            f2 = I1 * (next_y + y) / 2;
        else
            f2 = (g * deltaI2 + delta_y * deltaK1) / deltaepsilon^2; 
        end

        if abs(deltaepsilon) < 1e-10
            f = f2 + I2 / kx;
        else
            f = f2 + deltaI3 / (kx * deltaepsilon);
        end
    elseif m == 4

        if abs(deltaepsilon) < 1e-10
            f = I1 * (next_x + x) / 2;
        else
            f = (h * deltaI2 + delta_x * deltaK1) / deltaepsilon^2;  
        end

    elseif m == 5
        if abs(deltaepsilon) < 1e-10
            f4 = I1 * (next_x + x) / 2;
        else
            f4 = (h * deltaI2 + delta_x * deltaK1) / deltaepsilon^2;  
        end
        
        if abs(deltaepsilon) < 1e-10
            f = f4 + I2 / ky;
        else
            f = f4 + deltaI3 / (ky * deltaepsilon);
        end
    elseif m ==6
        if abs(deltaepsilon) < 1e-10
            f = sigma(sigmacd,epsilon);
        else
             f = deltaI1/deltaepsilon;
        end

    elseif m ==7
        if abs(deltaepsilon) < 1e-10
            f = sigma(sigmacd,epsilon) * (next_y + y)/2;
        else
            f= (g*deltaI1 + delta_y*deltaJ1)/(deltaepsilon^2);
        end
    elseif m ==8   
       if abs(deltaepsilon) < 1e-10
            f = sigma(sigmacd,epsilon) * (next_x + x)/2;
        else
            f= (h*deltaI1 + delta_x*deltaJ1)/(deltaepsilon^2);
       end

    elseif m ==9
        if abs(deltaepsilon) < 1e-10
            f = sigma(sigmacd,epsilon) * (y^2 + next_y^2 + y*next_y)/3;
        else
            f= (g^2*deltaI1 + 2*g*delta_y*deltaJ1 + delta_y^2*deltaJ2)/deltaepsilon^3;
        end

    elseif m ==10
        if abs(deltaepsilon) < 1e-10
            f = sigma(sigmacd,epsilon)*(x*next_y + 2*(x*y+next_x*next_y) + next_x*y)/6;

        else
            f = (h*g*deltaI1 +(g*delta_x + h*delta_y)*deltaJ1 + delta_x*delta_y*deltaJ2)/deltaepsilon^3;
        end

 
    elseif m ==11    
        if abs(deltaepsilon) < 1e-10
            f = sigma(sigmacd,epsilon)*(x^2 + next_x^2 + x*next_x)/3;
        else
            f = (h^2*deltaI1 + 2*h*delta_x*deltaJ1 + delta_x^2*deltaJ2)/deltaepsilon^3;
        end
    end

end

