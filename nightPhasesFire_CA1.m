function damage = nightPhasesFire_CA1(attacker,target,environment, stat)
%%  nightPhasesFire_BB  ����ҹս�׶�CA���ڻ����˺�
 %
 %  damage = nightPhasesFire_BB(attacker,target,environment, stat)
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
    baseAttackPower = (attacker.firepower)+10;
    if stat == 1 % �ҷ�����
        finalAttackPower = baseAttackPower*environment.myForm.coefNight...
                          *getShipInjury(attacker)*(rand()*1.2+2.4);
    else
        finalAttackPower = baseAttackPower*environment.opForm.coefNight...
                          *getShipInjury(attacker)*(rand()*1.2+2.4);
    end
    if rand < attacker.crit + target.opCrit
        finalAttackPower = finalAttackPower*1.5;
        messenger = [messenger, '���� '];
    end
    damage = finalAttackPower * (1- target.armor / (target.armor/2 + (attacker.penetrate)*finalAttackPower) );
    damage = ceil(damage);
end
