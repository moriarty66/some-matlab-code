clear,clc
for k = 0:15
    h = 10^(-k);
    fx = fdiff(1.2,h);
    labels(k+1,1) = h;
    labels(k+1,2) = abs(fx-cos(1.2));
end
hchange(labels);

function fx = fdiff(x0,h)
syms x;
f(x) = sin(x);
fx = (f(x0+h)-f(x0))/h;
end

function hchange(labels)
loglog(labels(:,1),labels(:,2));
% 记录横轴纵轴的数据画图
xlabel('h');
ylabel('精度');
grid on;
legend
end
