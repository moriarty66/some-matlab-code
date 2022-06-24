function err(labels)
semilogy(labels(:,1),labels(:,2),'DisplayName','误差图 ');
% 记录横轴纵轴的数据画图
xlabel('x');
ylabel('误差');
legend
end

