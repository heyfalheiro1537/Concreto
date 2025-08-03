function [fyd,epsilonyd] = paramsaco(tipos,Es,gamas)

fyk = tipos*10;
fyd = fyk/gamas;

epsilonyd = 1000*fyd/Es;