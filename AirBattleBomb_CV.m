function damage = AirBattleBomb_CV(attacker, target, environment, stat, targetIndex)
%%  AirBattleBomb_CV % ����ս���ι�����ʹ�ù�����������������ķɻ�����Ŀ�꣨TODO��
 %  damage = AirBattleBomb_CV(attacker, target, environment, stat, targetIndex)
 %
 %  attcker     = ������

%%  ������
global messenger;
    count = attacker.aircraft(targetIndex).count - attacker.aircraft(targetIndex).loss; % ���β��빥���ɻ���
    % �����˺�
    baseAttackPower = 2 * log(count+1)*attacker.aircraft(targetIndex).value+25;
    if attacker.aircraft(targetIndex).type == 1 % �Ǻ�ը��
        if stat == 1 % �ҷ�����
            aircraftCoef = 1+environment.airPower;
        else 
            aircraftCoef = 1-environment.airPower;
        end
        aircraftPenetrate = attacker.penetrate + 0.4;
    else % �ǹ�����
        aircraftCoef = rand(1)/2+0.5;
        aircraftPenetrate = 2;
    end
    finalAttackPower = baseAttackPower * aircraftCoef * getShipInjury(attacker)*(rand()*0.33+0.89);
    if rand < attacker.crit + target.opCrit + attacker.luck/7.5/100 % 7.5��/1%��Ļ����
        finalAttackPower = finalAttackPower*1.5;
        messenger = [messenger, '���� '];
    end
    damage = finalAttackPower * (1- target.armor / (target.armor/2 + aircraftPenetrate*finalAttackPower) );
    damage = ceil(damage);
end