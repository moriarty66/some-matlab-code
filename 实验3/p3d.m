f(x) = -1/16 * exp(-4*x) + 1/16 * 1/(4*x + 1);
yk = double(yk);
err = double(abs (yk-f(2)));
format long
err

for k = 1:1001
    er(k,1) = labels(k,1);
    er(k,2) = log(abs(labels(k,2) - f((k-1)*h)))/log(h);
end
erro(er);

function erro(labels)
loglog(labels(:,1),labels(:,2));
% 记录横轴纵轴的数据画图
xlabel('x');
ylabel('精度h的log');
grid on;
legend
end