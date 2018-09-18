function Order = FireOrder_Phase2(fleet)
%%  FireOrder_Phase1 计算次轮炮序 
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