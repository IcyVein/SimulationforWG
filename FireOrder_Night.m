function Order = FireOrder_Night(fleet)
%%  FireOrder_Night 计算夜战炮序 
 %  未完成，射程未考虑

%% 主程序
cont = length(fleet);
num  = cont;
for i = 1 : cont
    if isempty(fleet(i))
        num = num-1;
    end
end
for i = 1 : num
    Order(i) = i;
end
end