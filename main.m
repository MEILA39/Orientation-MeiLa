%doc fmincon
x0 = [0.1;0.1];
A = [];
b = [];
Aeq = [];
beq = [];
ub = [0.5;0.5];
lb = [0.001;0.001];
options = optimset('display','off','Algorithm','sqp');
[radius,mass,exitflag] = fmincon(@(r)obj(r),x0,A,b,Aeq,beq,lb,ub,@(r)nonlcon(r),options);