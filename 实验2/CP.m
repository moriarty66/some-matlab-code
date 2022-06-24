function labels = CP(n)
syms x;
f(x) = sin(4*x^2) + sin(4*x)^2;
%从-1到1,且1阶导边界为0
h = 2/n;
Y = zeros(n+1,1);
for k = 2:n
    Y(k,1) = (f(-1+k*h)-f(-1+(k-1)*h))/h - (f(-1+(k-1)*h)-f(-1+(k-2)*h))/h;
end
H = diag(repmat([4*h],1,n+1))+diag(repmat([h],1,n),1)+diag(repmat([h],1,n),-1);
H(1,1) = 2*h;
H(n+1,n+1) = 2*h;
M = H\(6*Y);
COE = zeros(n,4);
for k = 1:n
    COE(k,1) = f(-1+(k-1)*h);
    COE(k,2) = (f(-1+(k)*h)-f(-1+(k-1)*h))/h - h*M(k,1)/2 - h/6 * (M(k+1,1)-M(k,1));
    COE(k,3) = M(k,1)/2;
    COE(k,4) = (M(k+1,1)-M(k,1))/(6*h);
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
