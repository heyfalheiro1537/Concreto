function I_yy = I_yy(x, y)

I_yy = 0;
for i = 1:length(x)-1
    a_i = x(i)*y(i+1) - x(i+1)*y(i);
    I_yy = I_yy + a_i*((x(i))^2 + x(i)*x(i+1) + (x(i+1))^2);
end

I_yy = I_yy/12;