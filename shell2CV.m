function [attacker, target] = shell2CV(attacker, target, environment, stat, opFleet)
%%  �����ڻ�սcv��������
 %  [attacker, target] = DayPhaseCV(attacker, target, environment, stat)
 
 %  attacker = ������
 %  target = Ŀ��
 %  environment = ��������
 %  stat        = ��ǰ״̬���ҷ�����/�з�������
 
 %% ������
global fpLog;
global messenger;    
    if attacker.hp/attacker.maxHP < 0.5 % ������������
        messenger = [messenger, '�����ƣ�����'];
        fprintf(fpLog, '�����ڻ��� %s %s.\n', attacker.name, messenger);
        messenger = [];
        return;
    end
    % �ж����� %%���й�ʽ��Ҫȫ���޸�
    if rand() > getHitRateCV(attacker, target, environment, stat)
        messenger = [messenger, 'Miss'];
        fprintf(fpLog, '�����ڻ��� %s ���� %s %s.\n', attacker.name, target.name, messenger);
        messenger = [];
        target.missNum = target.missNum+1;% ���ݼ�¼
        return;
    end
    % �����˺�
    damage = DayPhasesFire_CV(attacker, target, environment, stat, opFleet);
    %�����˺�
    damage = fixDamage(damage, attacker, target, stat);
    targetHp0 = target.hp ;
    target.hp = target.hp - damage;
    if target.hp < 0
        target.hp = 0;
    end
    % ���ս����־
    attacker.hitNum = attacker.hitNum+1;% ���ݼ�¼
    if strfind(messenger, '����')
        attacker.critNum = attacker.critNum+1;% ���ݼ�¼
    end
    fprintf(fpLog, '�����ڻ��� %s ���� %s %s��� %d ���˺�(%d -> %d).\n', attacker.name, target.name, messenger, damage, targetHp0, target.hp);
    messenger = [];
