clear,clc
for n = 0:14
    disp(n);
    h0 = 2^(-n);
    nearest = RFD(h0); 
    N(n+1,1) = nearest;
    hold on
end
N

function nearest = RFD(h0)
eps = 1e-15;
%设置误差界
syms x;
syms h;
x0 = 1.2;
f(x) = sin(x);
N(h) = (f(x0+h)-f(x0))/h;
k0 = 1;
d = double(abs(N(h0)-N(h0/2)));
fx = double(N(h0));
labels(1,1) = 1;
labels(1,2) = abs(fx - cos(1.2));
for k0 = 2: 100
    if d<=eps || abs(fx - cos(1.2))<=eps
        break;
    else
        N(h) = 2*N(h/2)-N(h);
        d = double(abs(N(h0)-N(h0/2)));
        fx = double(N(h0));
        labels(k0,1) = k0;
        labels(k0,2) = abs(fx - cos(1.2));
        labels(k0,3) = fx;
    end
end
[Y,I] = min(labels,[],1);
nearest = labels(I(1,2),3);
name1 = ['h0 =',num2str(h0)];
semilogy(labels(:,1),labels(:,2),'DisplayName',name1);
% 记录横轴纵轴的数据画图
name2 = [' \leftarrow ',name1]; %w 的数字指向线
text(5,labels(5,2),name2);
xlabel('外推次数');
ylabel('精度');
legend
end


% h = 1;
% eps = 1e-15;
% %设置误差界
% %先假定k（外推次数）已定，每次h（步长）除以2直到结果精度小于误差界
% %k最大到20，最多迭代50次
% syms x;
% syms h;
% x0 = 1.2;
% f(x) = sin(x);
% N(h) = (f(x0+h)-f(x0))/h;
% for k0 = 1:20
%     h0 = 1;        
%     if k0 >= 2
%         for k = 2:k0
%             N(h) = N(h/2)-N(h);
%         end
%     end
%     fx = double(N(h0));
%     d = double(abs(N(h0)-N(h0/2)));
%     n = 2;
%     temp(1,1) = fx;
%     temp(1,2) = d;
%     while n<=50 
%         if d<=eps
%             break;
%         else
%             h0 = h0/2;
%             fx = double(N(h0));
%             d = double(abs(N(h0)-N(h0/2)));
%             temp(n,1) = fx;
%             temp(n,2) = d;
%             n = n+1;
%         end
%     end
%     [Y,I] = min(temp,[],1);
%     labels(k0,1) = k0;
%     labels(k0,2) = abs(temp(I(1,2),1) - cos(1.2));
%     labels(k0,3) = temp(I(1,2),1);
%     labels(k0,4) = log2(h0);
% end
% err(labels);
% labels
% 
% function err(labels)
% semilogy(labels(:,1),labels(:,2),'DisplayName','精度图 ');
% % 记录横轴纵轴的数据画图
% xlabel('外推次数');
% ylabel('精度');
% legend
% end
%     