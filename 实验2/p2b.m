clear,clc

for k = 2:7
    maxr = CHENew(2^k);
    labels(k-1,1) = 2^k;
    labels(k-1,2) = maxr;
end
err(labels);

function r = CHENew(n)
syms x;
f(x) = 1/(1+25*x^2);
X(1) = cos(0);
Y(1) = f(X(1));
for i = 2:n+1
    X(i) = cos((i-1)*pi/n);
    Y(i) = f(X(i));
end
F=zeros(n+1,n+1);
for k=1:n+1      
    F(k,1)=Y(k);
end
for k=2:n+1 
    for l=k:n+1
        F(l,k)=(F(l,k-1)-F(l-1,k-1))/(X(l)-X(l+1-k));  
    end
end
m = 1999;
for k = 1:m+1
    k
    labels(k,1) = -1+(k-1)/m;
    g = F(1,1);
    for j = 2:n+1
        P = 1;
        for l = 1:j-1
            P = P * (labels(k,1) - X(l));
        end
        g = F(j,j) * P + g;
    end
    labels(k,2) = abs(g - f(labels(k,1)));
end
r = max(labels(:,2));
end

function err(labels)
semilogy(labels(:,1),labels(:,2),'DisplayName','误差图 ');
% 记录横轴纵轴的数据画图
xlabel('n');
ylabel('最大误差');
legend
end
