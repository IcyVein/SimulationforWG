function finalDamage = fixDamageNight(damage, attacker, target, stat)
%%  fixDamageNight ҹս�׶�δ������������ұ���������Ѫ����
 %  finalDamage = fixDamageNight(damage, attacker, target, stat)
 %  attacker = ������
 %  target = Ŀ�꽢��
 %  damage = Ԥ���˺�
 %  finalDamage = ʵ���˺�
 %  stat        = ��ǰ״̬���ҷ�����/�з�������
 
%%  ������
global messenger;
    % δ��������
    if damage < 0
        if rand <0.5
            finalDamage = ceil( min(attacker.firepower+5, target.hp/10) );
            messenger = [messenger, 'δ�������� '];
        else
            finalDamage = 0;
            messenger = [messenger, 'δ����Miss '];
        end
    else
        finalDamage = damage;
    end
    
    % ��ұ���
    if stat == 2 % �з�Ϊ������ʱ
        if target.hp/target.maxHP > 0.25 && (target.hp - damage) < target.maxHP/4 % ���Ʊ���
            finalDamage = ceil( target.hp-target.maxHP/4 );
            messenger = [messenger, '���Ʊ��� '];
        elseif target.hp/target.maxHP <= 0.25 && target.hp > 1% ���Ʊ���
            finalDamage = 1;
            messenger = [messenger, '���Ʊ��� '];
        elseif target.hp/target.maxHP <= 0.25 && target.hp == 1% ��������
            finalDamage = 0;
            messenger = [messenger, '�������� '];
        end
    end
end
    


