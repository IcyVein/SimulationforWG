function coef = getShipInjury(attacker)
%%  getShipInjury  ���㴬��ϵ��
 %
 %  coef = getShipInjury(attacker)
 %
 %  attcker     = ��ǰ����
 %  coef        = ����ϵ��
 
%% ������
global messenger;
    if attacker.hp/attacker.maxHP>=0.5
     coef = 1;
    elseif attacker.hp/attacker.maxHP>=0.25
     coef = 0.6;
    else
     coef = 0.3;
    end
    if contains(messenger, '��ʤ֮��') && contains(messenger, '����')
        coef = 1;
    end
end