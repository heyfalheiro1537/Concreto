function S_x = S_x(x, y)

S_x = 0;
for i = 1:length(x) -1
    a_i = x(i)*y(i+1) - x(i+1)*y(i);
    S_x = S_x + a_i*(y(i) + y(i+1));
end

S_x = S_x/6;