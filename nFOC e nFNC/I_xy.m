function I_xy = I_xy(x, y)

I_xy = 0;
for i = 1:length(x)-1
    a_i = x(i)*y(i+1) - x(i+1)*y(i);
    I_xy = I_xy + a_i*(x(i)*y(i+1) + 2*(x(i)*y(i) + x(i+1)*y(i+1)) + x(i+1)*y(i));
end

I_xy = I_xy/24;