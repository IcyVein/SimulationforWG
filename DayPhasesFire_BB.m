function damage = DayPhasesFire_BB(attacker,target,environment, stat)
%%  DayPhasesFire_BB  �����ڻ�ս�׶�ս�н����˺�
 %
 %  damage = DayPhasesFire_BB(attacker,target,environment, stat)
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
    baseAttackPower = (attacker.firepower)+5;
    critDamgMod = 1;
    critMod = 0;
    finalDamageMod = 1;
    if contains(attacker.skill, '�ؼ����') && contains(environment.hx, '����')
        finalDamageMod = 1.35;
    elseif contains(attacker.skill, '�ؼ����') && contains(environment.hx, 'T��')
        finalDamageMod = 1.7;
    end
        
    if contains(messenger, '��ʤ֮��')
        critMod = 0.2;
    end
    if rand < attacker.crit + critMod + target.opCrit
        critDamgMod = 1.5;
        messenger = [messenger, '���� '];
    end
    if stat == 1 % �ҷ�����
        finalAttackPower = baseAttackPower*environment.myCourse.coef*environment.myForm.coef...
                          *getShipInjury(attacker)*(rand()*0.33+0.89)*critDamgMod;
    else
        finalAttackPower = baseAttackPower*environment.opCourse.coef*environment.opForm.coef...
                          *getShipInjury(attacker)*(rand()*0.33+0.89)*critDamgMod;
    end

    damage = finalAttackPower * (1- target.armor / (target.armor/2 + attacker.penetrate*finalAttackPower) );
    damage = damage * finalDamageMod;
    damage = ceil(damage);
end