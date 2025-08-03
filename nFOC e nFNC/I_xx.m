function I_xx = I_xx(x, y)

I_xx = 0;
for i = 1:length(x)-1
    a_i = x(i)*y(i+1) - x(i+1)*y(i);
    I_xx = I_xx + a_i*((y(i))^2 + y(i)*y(i+1) + (y(i+1))^2);
end

I_xx = I_xx/12;