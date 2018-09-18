function [attacker, target] = night(attacker, target, environment, stat)
%%  night ҹս�еĵ����ڻ�
 %  [attacker, target] = night(attacker, target, environment, stat)
 %
 %  attacker = ������
 %  target = Ŀ��
 %  environment = ��������
 %  stat        = ��ǰ״̬���ҷ�����/�з�������
 
%%  ������
global fpLog;
global messenger;
    if identityType(attacker,["CV","AV","CVL","AP"]) == 1
        fprintf(fpLog, 'ҹս�ڻ��� %s������ҹս�ڻ�.\n', attacker.name);
        messenger = [];
        return;
    end
    if attacker.hp/attacker.maxHP < 0.25 % �������Ѵ���
        messenger = [messenger, '�Ѵ��ƣ�����'];
        fprintf(fpLog, 'ҹս�ڻ��� %s %s.\n', attacker.name, messenger);
        messenger = [];
        return;
    end
    attacker.attackNum = attacker.attackNum+1;% ���ݼ�¼
    if rand() > getHitRate(attacker, target, environment, stat)
        messenger = [messenger, 'Miss'];
        fprintf(fpLog, 'ҹս�ڻ��� %s ���� %s %s.\n', attacker.name, target.name, messenger);
        messenger = [];
        target.missNum = target.missNum+1;% ���ݼ�¼
        return;
    end
    torpedoType = ["DD", "SS", "SC"];
    cruiserType = ["CA", "CL", "ClT", "CaV"];
    if identityType(attacker, torpedoType)
        damage = nightPhasesFire_DD(attacker, target, environment, stat);
    elseif identityType(attacker, cruiserType) && attacker.baseTorpedo == 0
        damage = nightPhasesFire_CA1(attacker, target, environment, stat);
    elseif identityType(attacker, cruiserType) && attacker.baseTorpedo ~= 0
        damage = nightPhasesFire_CA2(attacker, target, environment, stat);
    else
        damage = nightPhasesFire_BB(attacker, target, environment, stat);
    end
    damage = fixDamageNight(damage, attacker, target, stat);
    targetHp0 = target.hp ;
    target.hp = target.hp - damage;
    if target.hp < 0
        target.hp = 0;
    end
    attacker.hitNum = attacker.hitNum+1;% ���ݼ�¼
    if strfind(messenger, '����')
        attacker.critNum = attacker.critNum+1;% ���ݼ�¼
    end
    fprintf(fpLog, 'ҹս�ڻ��� %s ���� %s %s��� %d ���˺�(%d -> %d).\n', attacker.name, target.name, messenger, damage, targetHp0, target.hp);
    messenger = [];
end