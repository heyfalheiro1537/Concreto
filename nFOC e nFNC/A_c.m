function A_c = A_c(x, y)

A_c = 0;
for i = 1:(length(x)-1)
    a_i = x(i)*y(i+1) - x(i+1)*y(i);
    A_c = A_c + a_i;
end

A_c = A_c/2;