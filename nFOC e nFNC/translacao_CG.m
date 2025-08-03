function [xc,yc,xs,ys] = translacao_CG(x_arestas, y_arestas, numero_arestas, x_s, y_s)

x_cg = S_y(x_arestas,y_arestas)/A_c(x_arestas,y_arestas);
y_cg = S_x(x_arestas,y_arestas)/A_c(x_arestas,y_arestas);

xc = x_arestas - x_cg;
yc = y_arestas - y_cg;

xs = x_s - x_cg;
ys = y_s - y_cg;



