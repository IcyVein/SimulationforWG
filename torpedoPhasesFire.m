function damage = torpedoPhasesFire(attacker,target,environment, stat)
%%  torpedoPhasesFire  ��������ս�׶ε��˺�
 %
 %  damage = torpedoPhasesFire(attacker,target,environment, stat)
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
    baseAttackPower = (attacker.torpedo)+5;
    if stat == 1 % �ҷ�����
        finalAttackPower = baseAttackPower*environment.myCourse.coef*environment.myForm.coefTorpedo...
                          *getShipInjury(attacker)*(rand()*0.33+0.89);
    else
        finalAttackPower = baseAttackPower*environment.opCourse.coef*environment.opForm.coefTorpedo...
                          *getShipInjury(attacker)*(rand()*0.33+0.89);
    end
    if rand < attacker.crit + target.opCrit
        finalAttackPower = finalAttackPower*1.5;
        messenger = [messenger, '���� '];
    end
    damage = finalAttackPower * (1- target.armor / (target.armor/2 + 1.0*finalAttackPower) );
    damage = ceil(damage);
end