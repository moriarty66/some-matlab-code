clear,clc
for i = 2:7
    disp(i);
    answer = Newton(2^i);
    a(i-1,1) = i;
    a(i-1,2) = answer;
end
semilogy(a(:,1),a(:,2),'DisplayName','NEWTON');
xlabel('取点个数: 2^i');
ylabel('误差');
legend;

function answer= Newton(n)
syms x;
f(x) = 1/(1+25*x.^2);
X(1) = 1;
Y(1) = f(X(1));
for i = 2:n+1
    X(i) = cos((i-1)*pi/n);
    Y(i) = f(X(i));
end
g=zeros(n+1,n+1);
% 对差商表第一列赋值
for k=1:n+1      
    g(k)=Y(k);
end
% 求差商表
for i=2:n+1       % 差商表从0阶开始；但是矩阵是从1维开始存储
    for k=i:n+1
        g(k,i)=(g(k,i-1)-g(k-1,i-1))/(X(k)-X(k+1-i));  
    end
end
%求插值多项式
test = -1:(2/1999):1;  %2000个等距点
for i = 1:2000
    p=0;
    for k=2:n+1
        t=1;
        for j=1:k-1
            t=t*(test(i)-X(j));     %
        end
        p=g(k,k)*t+p;
    end
    p=g(1,1)+p;
    m(i) = p;
end
error = abs(f(test) - m);
answer = max(error);
end
