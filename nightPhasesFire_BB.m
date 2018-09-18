function damage = nightPhasesFire_BB(attacker,target,environment, stat)
%%  nightPhasesFire_BB  ����ҹս�׶�ս�н����˺�
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
    finalDamageMod = 1;
    if contains(attacker.skill, '�ؼ����') && contains(environment.hx, '����')
        finalDamageMod = 1.35;
    elseif contains(attacker.skill, '�ؼ����') && contains(environment.hx, 'T��')
        finalDamageMod = 1.7;
    end
    if stat == 1 % �ҷ�����
        finalAttackPower = baseAttackPower*environment.myForm.coefNight...
                          *getShipInjury(attacker)*(rand()*0.6+1.2);
    else
        finalAttackPower = baseAttackPower*environment.opForm.coefNight...
                          *getShipInjury(attacker)*(rand()*0.6+1.2);
    end
    if rand < attacker.crit + target.opCrit
        finalAttackPower = finalAttackPower*1.5;
        messenger = [messenger, '���� '];
    end
    damage = finalAttackPower * (1- target.armor / (target.armor/2 + attacker.penetrate*finalAttackPower) );
    damage = damage * finalDamageMod;
    damage = ceil(damage);
end
