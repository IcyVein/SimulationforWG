function Order = FireOrder_Phase1(fleet)
%%  FireOrder_Phase1 计算首轮炮序 
 %  未完成，有统一的公式么？   

%% 主程序
cont = length(fleet);
num  = cont;
Order = [];
for i = 1 : cont
    if isempty(fleet(i))
        num = num-1;
    end
    Order = [Order, fleet(i).order];
end
[B, Order] = sort(Order); % excel里存储的应为对应舰船炮序，需转化为舰队炮序
if ~all(Order) % 自定义炮序存在0，不使用自定义炮序
    Order = [5 6 4 3 2 1];
    Order = Order(1:num);
end