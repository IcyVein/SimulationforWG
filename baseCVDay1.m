function baseAttackPower = baseCVDay1(attacker,target,environment, stat, opFleet)
%% ��ĸ�����ڻ�ս�����˺�����
 %
 % baseAttackPower = baseCVDay1(attacker,target,environment, stat, opFleet)
 %
 %  attcker     = ������
 %  target      = �н�
 %  environment = ��������
 %  stat        = ��ǰ״̬���ҷ�����/�з�������
 %  opFleet     = �з�����
 %
 %  ����δ����װ�������Կ�
 %% ������
baseAttackPower=attacker.firepower;
for i= 1 :length(attacker.hangar)
    if attacker.aircraft(i).count > 0 %%��i����ʣ��ɻ�
        if attacker.aircraft(i).type == 1%%��i��Ϊ��ը��
            baseAttackPower = baseAttackPower + 2 * attacker.aircraft(i).value;
        elseif attacker.aircraft(i).type == 2%%��i��Ϊ���׻�
            baseAttackPower = baseAttackPower + 1 * attacker.aircraft(i).value;
        else %%���Ϊս������������
            baseAttackPower = baseAttackPower;
        end
    end
end
baseAttackPower = baseAttackPower * calAA(target,opFleet)+35;
 