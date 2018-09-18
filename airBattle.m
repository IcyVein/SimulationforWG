function [attacker, target] = airBattle(attacker, target, environment, stat, targetIndex)
%%  airBattle % ����ս���ι�����ʹ�ù�����������������ķɻ�����Ŀ�꣨TODO��
 %  [attacker, target] = airBattle(attacker, target, environment, stat, targetIndex)
 %
 %  attcker     = ������
 %  target      = �н�
 %  environment = ��������
 %  stat        = ��ǰ״̬���ҷ�����/�з�������
 %  targetIndex = ָ��������

%%  ������
global fpLog;
global messenger;
    if attacker.aircraft(targetIndex).type ~= 1 && attacker.aircraft(targetIndex).type ~= 2 % ���Ǻ�ը(����1) and ��������2��
        return;
    elseif attacker.aircraft(targetIndex).count <= 0 % ���޽��ػ�
        messenger = [messenger, num2str(targetIndex), '�Ż������޽��ػ�������'];
        fprintf(fpLog, '����ս�� %s %s.\n', attacker.name, messenger);
        messenger = [];
        return;
    end
    % ����ս���ѱ������ĺ�ĸ�ɻ��Ƿ�������˺���Ŀǰ�����������˺����ƴ���ϵ��(TODO)
%     if attacker.hp <= 0 % �������ѱ�����
%         messenger = [messenger, '�ѳ�û������'];
%         fprintf(fpLog, '����ս�� %s %s.\n', attacker.name, messenger);
%         messenger = [];
%         return;
%     end
    attacker.attackNum = attacker.attackNum+1;% ���ݼ�¼
    %count = min(floor(attacker.firepower/5)+3, attacker.aircraft(targetIndex).count); % �ŷ���
    count = SinPlAirNum(attacker,targetIndex);
    %%�������ֱ�ӵ���SinPlAirNum���� count = SinPlAirNum(attacker,targetIndex)
    
    % ������ջ�׹���ѱ�������Ŀ���޺����Կջ�׹
    if target.hp > 0
        loss = floor(rand(1) * target.AA * 0.618^(target.AANo-1) / 10); % AANO��¼�ý��ڼ���ӭ���ɻ�����ʼΪ1
        loss = min(loss, count);
        target.AANo = target.AANo + 1;
        attacker.aircraft(targetIndex).loss = attacker.aircraft(targetIndex).loss + loss; % ��¼����ս���ø��ӵ�����ʧ�������ƿջ�׹����õ���
    else
        loss = 0;
    end
    % �ж�����(����ս���й�ʽ�������ٶ�Ϊ�ڻ�ս����+�ƿ�Ȩ���С�TODO)
    if stat == 1
        hitRate = getHitRateCV(attacker, target, environment, stat)+environment.airPower;
        % �洫����
        hitRate = min(hitRate, 0.95);
        hitRate = max(hitRate, 0.05);
    else
        hitRate = getHitRate(attacker, target, environment, stat)-environment.airPower;
        % �洫����
        hitRate = min(hitRate, 0.95);
        hitRate = max(hitRate, 0.05);
    end
    if rand() > hitRate
        messenger = [messenger, 'Miss'];
        fprintf(fpLog, '����ս�� %s �� %d�Ż� ���� %s %s������׹ %d ��(%d -> %d)\n', ...
            attacker.name, targetIndex, target.name, messenger, ...
            loss, attacker.aircraft(targetIndex).count, ...
            attacker.aircraft(targetIndex).count - loss);
        messenger = [];
        target.missNum = target.missNum+1;% ���ݼ�¼
        attacker.aircraft(targetIndex).count = attacker.aircraft(targetIndex).count - loss; % ��¼����ս����ø��ӵ�ʣ��ɻ���
        return;
    end
    % �����˺�
    damage = AirBattleBomb_CV(attacker, target, environment, stat, targetIndex);
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
    fprintf(fpLog, '����ս�� %s �� %d�Ż� ���� %s %s��� %d ���˺�(%d -> %d)������׹ %d ��(%d -> %d)\n', ...
            attacker.name, targetIndex, target.name, messenger, damage, targetHp0, target.hp, ...
            attacker.aircraft(targetIndex).loss, attacker.aircraft(targetIndex).count, ...
            attacker.aircraft(targetIndex).count - attacker.aircraft(targetIndex).loss);
    messenger = [];
    attacker.aircraft(targetIndex).count = attacker.aircraft(targetIndex).count - loss; % ��¼����ս����ø��ӵ�ʣ��ɻ���
end



