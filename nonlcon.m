function [ g,geq ] = nonlcon(r)
[sigma,Q] = sol_TenBarTruss(r(1),r(2));
g(1) = max(sigma) - 250*10^6;
g(2) = -min(sigma) - 250*10^6;
g(3) = (Q(3)^2+Q(4)^2)^0.5 - 0.02;
geq = [];

