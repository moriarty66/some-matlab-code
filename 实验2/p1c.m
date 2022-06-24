clear,clc

for k = 4:10
    n = 2^k;
    labels = CP(n);
    MAX(k-3,1)= n;
    [ma,index]=max(labels);
    m = log10(ma(1,2));
    MAX(k-3,2) = m;
end

maxerr(MAX);

function labels = CP(n)
syms x;
f(x) = sin(4*x^2) + sin(4*x)^2;
%从-1到1,且1阶导为0
%-1和1的边界值未知
h = 2/(n);
Y = zeros(n-1,1);
for k = 1:n-1
    Y(k,1) = (f(-1+(k+1)*h)-f(-1+(k)*h))/h - (f(-1+(k)*h)-f(-1+(k-1)*h))/h;
end
H = diag(repmat([4*h],1,n-1))+diag(repmat([h],1,n-2),1)+diag(repmat([h],1,n-2),-1);
M = H\(6*Y);
m0 = 3*((f(-1+h)-f(-1))/h - h*M(1,1)/6)/h;
mn = 6*((f(1)-f(1-h))/h - h*M(n-1,1)/3)/h;
COE = zeros(n,4);
COE(1,1) = f(-1);
COE(n,1) = f(1-h);
COE(1,2) = 0;
COE(n,2) = 0;
COE(1,3) = m0/2;
COE(n,3) = M(n-1,1)/2;
COE(1,4) = (M(1,1)-m0)/(6*h);
COE(n,4) = (mn-M(n-1,1))/(6*h);
for k = 2:n-1
    COE(k,1) = f(-1+(k-1)*h);
    COE(k,2) = (f(-1+(k)*h)-f(-1+(k-1)*h))/h - h*M(k-1,1)/2 - h/6 * (M(k,1)-M(k-1,1));
    COE(k,3) = M(k-1,1)/2;
    COE(k,4) = (M(k,1)-M(k-1,1))/(6*h);
end
d = 2/2000;
labels = zeros(2001,2);
for a = 1:2001
    m = -1+ (a-1)*d;
    labels(a,1) = m;
    k = floor((m+1)/h);
    if k<n
        fx = COE(k+1,1) + COE(k+1,2)*(m+1-h*k) + COE(k+1,3)*(m+1-h*k)^2 + COE(k+1,4)*(m+1-h*k)^3;
    else %在1点
        fx = f(1);
    end
    labels(a,2) = abs(sin(4*m^2) + sin(4*m)^2 - fx);
end
end


function maxerr(labels)
loglog(labels(:,1),labels(:,2),'DisplayName','最大误差（取log10） ');
% 记录横轴纵轴的数据画图
xlabel('n');
ylabel('log10(误差)');
grid on
end
   