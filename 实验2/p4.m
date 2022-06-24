clear,clc

X = [2.1;2.5;2.8;3.2];
Y = [0.6087;0.6849;0.7368;0.8111];
syms a;
syms b;
for k = 1:4
    Y1(k) = X(k)/(a + b*X(k));
end
L(a,b) = (Y(1) - Y1(1))^2;
for k = 2:4
    L(a,b) = L(a,b) + (Y(k) - Y1(k))^2;
end
La(a,b) = diff((L(a,b)),a);
Lb(a,b) = diff((L(a,b)),b);
eqns = [La(a,b)==0,Lb(a,b)==0];
[a0,b0] = solve(eqns,[a,b]);
a0 = vpa(a0);
b0 = vpa(b0);
a0 = min(a0);
b0 = min(b0);
syms x;
f(x) = x/(a0 + b0 * x);
for k = 1:4
    Y2(k) = abs(f(X(k))-Y(k)); %误差
end
norm2 = norm(Y2,2)

