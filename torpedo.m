function [attacker, target] = torpedo(attacker, target, environment, stat)
%%  night ����ս�еĵ����׻�
 %  [attacker, target] = torpedo(attacker, target, environment, stat)
 %
 %  attacker = ������
 %  target = Ŀ��
 %  environment = ��������
 %  stat        = ��ǰ״̬���ҷ�����/�з�������
 
%%  ������
global fpLog;
global messenger;
    if attacker.hp/attacker.maxHP < 0.25 % �������Ѵ���
        messenger = [messenger, '�Ѵ��ƣ�����'];
        fprintf(fpLog, '����ս�׻��� %s %s.\n', attacker.name, messenger);
        messenger = [];
        return;
    end
    attacker.attackNum = attacker.attackNum+1;% ���ݼ�¼
    if rand() > getHitRate(attacker, target, environment, stat)
        messenger = [messenger, 'Miss'];
        fprintf(fpLog, '����ս�׻��� %s ���� %s %s.\n', attacker.name, target.name, messenger);
        messenger = [];
        target.missNum = target.missNum+1;% ���ݼ�¼
        return;
    end
    damage = torpedoPhasesFire(attacker, target, environment, stat);
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
    fprintf(fpLog, '����ս�׻��� %s ���� %s %s��� %d ���˺�(%d -> %d).\n', attacker.name, target.name, messenger, damage, targetHp0, target.hp);
    messenger = [];
end