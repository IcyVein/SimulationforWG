function Order = FireOrder_Phase1(fleet)
%%  FireOrder_Phase1 ������������ 
 %  δ��ɣ���ͳһ�Ĺ�ʽô��   

%% ������
cont = length(fleet);
num  = cont;
Order = [];
for i = 1 : cont
    if isempty(fleet(i))
        num = num-1;
    end
    Order = [Order, fleet(i).order];
end
[B, Order] = sort(Order); % excel��洢��ӦΪ��Ӧ����������ת��Ϊ��������
if ~all(Order) % �Զ����������0����ʹ���Զ�������
    Order = [5 6 4 3 2 1];
    Order = Order(1:num);
end