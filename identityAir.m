function id = identityAir(ship)
%%  ����Ƿ���ʣ��ɷŷɷɻ�
 %
 %  id = identityAir(ship)
 %      ship������
 
%% ������
id = 0 ;
for i = 1 : length(ship.hangar)
    if ship.aircraft(i).count > ship.aircraft(i).loss%�ж��Ƿ���ʣ��ɻ�
        if ship.aircraft(i).type == 1 || ship.aircraft(i).type == 2 %�ж��Ƿ�Ϊ��ը����1�������׻���2��
            id = 1;
            return
        end
    end
end