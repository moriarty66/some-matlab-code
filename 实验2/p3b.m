clear,clc

syms x;
n = 2^6;
f(x) = sin(2*pi*x)*exp(cos(2*pi*x));
for k = 1:n
    Y(k) = f((k-1)/n);
end
syms y;
for j = 0 : n - 1 
    L(j+1) = ((-1)^j)/n * sin(n*pi*y) * cot(pi*(y-j/n));
end
P(y) = Y(1) * L(1);
for k = 2 : n
    P(y) = P(y) + Y(k) * L(k);
end
m = 999;
for ka = 1:m+1
    k = ka-1
    labels(ka,1) = k/m;
    labels(ka,2) = abs(P(k/m)-f(k/m));
end

er(labels);

function er(labels)
semilogy(labels(:,1),labels(:,2),'DisplayName','Lagrange误差图 ');
% 记录横轴纵轴的数据画图
xlabel('x');
ylabel('误差');
legend
end