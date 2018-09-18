function damage = DayPhasesFire_CV(attacker,target,environment, stat, opFleet)
%%  DayPhasesFire_CV  ���������ڻ�ս�׶κ�ĸ���˺�
 %
 %  damage = DayPhasesFire_CV(attacker,target,environment, stat)
 %
 %  attcker     = ������
 %  target      = �н�
 %  environment = ��������
 %  stat        = ��ǰ״̬���ҷ�����/�з�������
 
%% ȱʡ���
    if nargin==1
        error('missing target and environment');
    end
    if nargin==2
        error('missing environment');
    end
%% ������
global messenger;
    baseAttackPower = baseCVDay1(attacker,target,environment, stat, opFleet);
     if stat == 1 % �ҷ�����
            aircraftCoef = 1+environment.airPower;
        else 
            aircraftCoef = 1-environment.airPower;
     end
     if 0
         aircraftPenetrate = 1.2;
     else
         aircraftPenetrate = 1;
     end
     
    if stat == 1 % �ҷ�����
        finalAttackPower = baseAttackPower*aircraftCoef*skillcoef(attacker)...
                          *getShipInjury(attacker)*(rand()*0.33+0.89);
    else
        finalAttackPower = baseAttackPower*aircraftCoef*skillcoef(attacker)...
                          *getShipInjury(attacker)*(rand()*0.33+0.89);
    end
    if rand < attacker.crit + target.opCrit
        finalAttackPower = finalAttackPower*1.5;
        messenger = [messenger, '���� '];
    end
    damage = finalAttackPower * (1- target.armor / (target.armor/2 + aircraftPenetrate*finalAttackPower) );
    damage = ceil(damage);
end

