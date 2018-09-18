function num = SinPlAirNum(ship,k)
%%    SinPlAirNum ���㵥��ɻ��ŷ���
 %      single place aircraft number Funtion
 
 %      ship : ����
 %      k    : ��k��
 %      �������ŷ���
 
%% ������
k = floor(k);
if k>=5 || k<=0 
    num = 0;
    return
end
firepower = ship.firepower; %��ĸ����ֵ
aircraftnum = ship.aircraft(k).count;%��ĸ�ø�ʣ��ɻ���
num1 = floor(3+firepower/5); %�������ŷ���
num2 = aircraftnum; %ʵ�����ŷ���
num = min(num1,num2);%�����ɻ��ŷ���
if num <=0  %��֤��Ϊ������ȫ��
    num=0;
end
