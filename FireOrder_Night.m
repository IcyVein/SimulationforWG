function Order = FireOrder_Night(fleet)
%%  FireOrder_Night ����ҹս���� 
 %  δ��ɣ����δ����

%% ������
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