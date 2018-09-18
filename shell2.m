function [attacker, target] = shell2(attacker, target, environment, stat, opFleet)
%%  shell2 �����ڻ��еĵ����ڻ�
 %  [attacker, target] = shell2(attacker, target, environment, stat)
 %
 %  attacker = ������
 %  target = Ŀ��
 %  environment = ��������
 %  stat        = ��ǰ״̬���ҷ�����/�з�������
 
%%  ������
global fpLog;
global messenger;
    if identity(attacker.range,['��','����']) ~= 1
        %messenger = [messenger, '��̲��㣬������'];
        fprintf(fpLog, '�����ڻ��� %s��̲��㣬����������ڻ�.\n', attacker.name);
        return;
    end
    if attacker.hp <= 0 % �������ѱ�����
        messenger = [messenger, '�ѳ�û������'];
        fprintf(fpLog, '�����ڻ��� %s %s.\n', attacker.name, messenger);
        messenger = [];
        return;
    end
    attacker.attackNum = attacker.attackNum+1;% ���ݼ�¼
    %% �ж��Ƿ�Ϊ�����ڻ�    
    if identityType(attacker,["CV","AV","CVL"]) == 1
        [attacker, target] = shell2CV(attacker, target, environment, stat, opFleet);
        return
    end
    %% �����ڻ�     
    if rand() > getHitRate(attacker, target, environment, stat)
        messenger = [messenger, 'Miss'];
        fprintf(fpLog, '�����ڻ��� %s ���� %s %s.\n', attacker.name, target.name, messenger);
        messenger = [];
        target.missNum = target.missNum+1;% ���ݼ�¼
        return;
    end
    damage = DayPhasesFire_BB(attacker, target, environment, stat);
    damage = fixDamage(damage, attacker, target, stat);
    targetHp0 = target.hp ;
    target.hp = target.hp - damage;
    if target.hp < 0
        target.hp = 0;
    end
    attacker.hitNum = attacker.hitNum+1;% ���ݼ�¼
    if strfind(messenger, '����')
        attacker.critNum = attacker.critNum+1;% ���ݼ�¼
    end
    fprintf(fpLog, '�����ڻ��� %s ���� %s %s��� %d ���˺�(%d -> %d)\n', attacker.name, target.name, messenger, damage, targetHp0, target.hp);
    messenger = [];
end