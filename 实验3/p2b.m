clear,clc
err = 1;
m = 1;
while err>= 1e-15
    disp(m);
    err = intg(m);
    labels(m,1) = m;
    labels(m,2) = err;
    m = m+1;
end
errors(labels);

function err = intg(m)
syms x;
f(x) = exp(cos(x));
h = 2*pi/m;
T = 0;
for k = 1:m
    T = T + h/2*(f(-pi+k*h)+f(-pi+(k-1)*h));
end
ext = 7.954926521012845274513219665329394328161342771816638573400595955383360608164694666995137357228568774;
err = abs(ext - T);
end
function errors(labels)
semilogy(labels(:,1),labels(:,2),'DisplayName','精度图 ');
% 记录横轴纵轴的数据画图
xlabel('m');
ylabel('精度');
grid on;
legend
end