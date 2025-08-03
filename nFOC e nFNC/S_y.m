function S_y = S_y(x, y)

S_y = 0;
for i = 1:length(x) -1
    a_i = x(i)*y(i+1) - x(i+1)*y(i);
    S_y = S_y + a_i*(x(i) + x(i+1));
end

S_y = S_y/6;