clear,clc
syms x;
syms y;
f(x,y) = x*exp(-4*x) - 4*y;
h = 2/1000;
%步长2/1000
y0 = 0;
k1 = f(0,0);
y1 = y0 + h*f(h/2,h/2 * k1);
k11 = f(h,h);
y2 = y1 + h*f(h+h/2,y1+h/2 * k11);
labels(1,1) = 0;
labels(1,2) = y0;
labels(2,1) = h;
labels(2,2) = y1;
labels(3,1) = h+h;
labels(3,2) = y2;
for k = 4:1001
    yk = labels(k-2,2) + h/3 *(7*f((k-2)*h,labels(k-1,2)) - 2*f((k-3)*h,labels(k-2,2))+ f((k-4)*h,labels(k-3,2)));
    yk = labels(k-2,2) + h/3 *(f((k-1)*h,yk) + 4*f((k-2)*h,labels(k-1,2))+ f((k-3)*h,labels(k-2,2)));
%     syms yk;
%     m = -yk + labels(k-2,2) + h/3 *(f((k-1)*h,yk) + 4*f((k-2)*h,labels(k-1,2))+ f((k-3)*h,labels(k-2,2)));
%     yk = solve(m == 0,yk);
    labels(k,1) = (k-1)*h;
    labels(k,2) = yk;
    disp(k);
end
fx(labels);

function fx(labels)
semilogy(labels(:,1),labels(:,2),'DisplayName','解函数');
% 记录横轴纵轴的数据画图
xlabel('x');
ylabel('y');
grid on;
legend
end
