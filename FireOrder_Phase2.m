function Order = FireOrder_Phase2(fleet)
%%  FireOrder_Phase1 ����������� 
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